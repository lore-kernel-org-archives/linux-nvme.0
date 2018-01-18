From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Thu, 18 Jan 2018 15:54:26 +0000
Subject: nvme-fc unregister remote port
In-Reply-To: <1d5a271d-3622-8b5d-08fc-9ab344a7933c@broadcom.com>
References: <0F0B1C8F-68EA-49B4-A8A6-E9787D8A94CB@cavium.com>
 <1d5a271d-3622-8b5d-08fc-9ab344a7933c@broadcom.com>
Message-ID: <47091667-53B5-4F7D-B244-D3A1A1C6D629@cavium.com>

	If you're concerned about driver unload or reset paths - where the 
       target is present up to that point, I guess it could be better behaved. 
    	I don't know that it's mandatory as initiator and target have to manage 
    	the surprise removal cases.

Looking at your proposed text for in T11-2017-00419-v001.pdf it will be mandatory:

An initiator NVMe_Port shall perform the following steps to terminate an NVMeoFC association:
       1) transmit an ABTS-LS (see 11.3) for all open Exchanges for the NVMeoFC association being
       terminated, except for a Disconnect NVMe_LS Exchange.
       2) transmit a Disconnect NVMe_LS request to the corresponding target NVMe_Port unless there
       is no valid login with the associated NVMe_Port. The Disconnect NVMe_LS request, if
       transmitted, shall contain an Association Identifier descriptor with the Association Identifier of
       the NVMeoFC association being terminated.


On 1/12/18, 3:23 PM, "James Smart" <james.smart@broadcom.com> wrote:

    On 1/12/2018 2:25 PM, Trapp, Darren wrote:
    > During the unregister remote process, we stop all the q?s, kill the IO (including AEN?s) and try and send a disconnect to the target via a LS request.  But, that request fails since __nvme_fc_send_ls_req first checks to ensure the remote port is ONLINE.  It won?t be since the unregister_remoteport sets the state to DELETED.
    >
    > The disconnect never goes to the target to make an orderly shutdown/cleanup.  The target will eventually figure it out when the keep alive?s stop coming.  But it seams we should do an orderly shutdown when we can.
    
    Well - it depends on why you are unregistering. In most cases, the 
    driver is calling unregister as it has logged out of the port - so 
    there's nothing there to send the disconnect to.
    
    If you're concerned about driver unload or reset paths - where the 
    target is present up to that point, I guess it could be better behaved. 
    I don't know that it's mandatory as initiator and target have to manage 
    the surprise removal cases.
    
    If that's what you're looking for, we could look into adding a flag to 
    unregister, or perhaps a slightly different method if we want to keep 
    interface compatibility - to have the transport delete the controllers 
    before acting on the unregister.
    
    -- james
    
