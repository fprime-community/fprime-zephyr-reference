def test_send_command(fprime_test_api):
    """Test that commands may be sent

    Tests command send, dispatch, and receipt using send_and_assert command with a pair of NO-OP commands.
    """
    fprime_test_api.send_and_assert_command("ReferenceDeployment.cmdDisp.CMD_NO_OP", max_delay=1)
    assert fprime_test_api.get_command_test_history().size() == 1