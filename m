From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Fri, 12 Jan 2018 22:25:53 +0000
Subject: nvme-fc unregister remote port
Message-ID: <0F0B1C8F-68EA-49B4-A8A6-E9787D8A94CB@cavium.com>

During the unregister remote process, we stop all the q?s, kill the IO (including AEN?s) and try and send a disconnect to the target via a LS request.  But, that request fails since __nvme_fc_send_ls_req first checks to ensure the remote port is ONLINE.  It won?t be since the unregister_remoteport sets the state to DELETED.

The disconnect never goes to the target to make an orderly shutdown/cleanup.  The target will eventually figure it out when the keep alive?s stop coming.  But it seams we should do an orderly shutdown when we can.
