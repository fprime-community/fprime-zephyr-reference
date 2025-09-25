

def test_send_command(fprime_test_api):
    """Send a reboot command to reboot the system.
    """
    fprime_test_api.send_and_assert_command(fprime_test_api.get_mnemonic('Svc.FatalHandler') + '.' + 'RESTART', max_delay=0.500)

