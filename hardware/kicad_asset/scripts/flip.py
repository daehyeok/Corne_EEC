# Flip left keyboard to generate right keyboard base design.
import pcbnew
import os

def flip(pcb_board, new_board_path=""):
    layer_dict = {}
    zero = pcbnew.VECTOR2I(pcbnew.wxPoint(0,0))
    for i in range(pcbnew.PCBNEW_LAYER_ID_START,
                   pcbnew.PCBNEW_LAYER_ID_START + pcbnew.PCB_LAYER_ID_COUNT):
        layer_dict[pcbnew.BOARD_GetStandardLayerName(i)] = i

    for fp in pcb_board.GetFootprints():
        prev_position = fp.GetPosition() + zero
        prev_orientation = fp.GetOrientationDegrees()
        flip_left_right = False
        ref = fp.GetReference().strip()

        # components_flip_horizon=["SW3", "SW4", "SW20", "SW21", "SW22", "SW28", "J1"]
        # if ref in components_flip_horizon:
        #     flip_left_right = True
            
        fp.Flip(prev_position, flip_left_right)
        fp.Move(prev_position - fp.GetPosition())

        if prev_orientation != 0:
            fp.SetOrientationDegrees(-prev_orientation)

        fp.SetLocked(True)


    for track in pcb_board.GetTracks():
        start = track.GetStart() + zero
        end = track.GetEnd() + zero
        track.Flip(track.GetPosition(), True)
        track.SetStart(start)
        track.SetEndX(end.x)
        track.SetEndY(end.y)

    if(new_board_path != ""):
        pcbnew.SaveBoard(new_board_path, pcb_board)

# After update Kicad7 on Mac, Run script from cli not wokring well.
# write copy_pcb_from_left to copy&paste on Kicad's python shell.
def copy_and_flip_from_left():
    project_root = os.getenv("KIPRJMOD")
    left_pcb_file = os.path.join(project_root, "keyboard_left.kicad_pcb")
    right_pcb_file = os.path.join(project_root, "keyboard_rigt.kicad_pcb")
    import shutil
    shutil.copyfile(left_pcb_file, right_pcb_file)

    pcbnew.Refresh()
    board = pcbnew.GetBoard()
    flip(board)
    pcbnew.Refresh()


if __name__ == "__main__":
    file_dir = os.path.dirname(__file__)
    left_pcb_path = os.path.abspath(f"{file_dir}/../../keyboard/keyboard_left.kicad_pcb")
    right_pcb_path = os.path.abspath(f"{file_dir}/../../keyboard/keyboard_right.kicad_pcb")

    left_pcb_board = pcbnew.LoadBoard(left_pcb_path)
    flip(left_pcb_board, right_pcb_path)
