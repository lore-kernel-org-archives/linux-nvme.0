From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Thu, 18 Jan 2018 16:23:47 +0000
Subject: nvme-fc unregister remote port
In-Reply-To: <bf30c864-30b5-8333-add8-df3483b318a0@broadcom.com>
References: <0F0B1C8F-68EA-49B4-A8A6-E9787D8A94CB@cavium.com>
 <1d5a271d-3622-8b5d-08fc-9ab344a7933c@broadcom.com>
 <47091667-53B5-4F7D-B244-D3A1A1C6D629@cavium.com>
 <bf30c864-30b5-8333-add8-df3483b318a0@broadcom.com>
Message-ID: <DEF9BB33-529B-48BC-928B-313E7B536F26@cavium.com>

During the unload I am allowing the transport to cleanup before I logout.  I don?t want to start tearing
down internally and return IO?s with errors to the transport and have it start error recovery
since it doesn?t know what is going on.

On 1/18/18, 8:18 AM, "James Smart" <james.smart@broadcom.com> wrote:

    On 1/18/2018 7:54 AM, Trapp, Darren wrote:
    > 	If you're concerned about driver unload or reset paths - where the
    >         target is present up to that point, I guess it could be better behaved.
    >      	I don't know that it's mandatory as initiator and target have to manage
    >      	the surprise removal cases.
    >
    > Looking at your proposed text for in T11-2017-00419-v001.pdf it will be mandatory:
    >
    > An initiator NVMe_Port shall perform the following steps to terminate an NVMeoFC association:
    >         1) transmit an ABTS-LS (see 11.3) for all open Exchanges for the NVMeoFC association being
    >         terminated, except for a Disconnect NVMe_LS Exchange.
    >         2) transmit a Disconnect NVMe_LS request to the corresponding target NVMe_Port unless there
    >         is no valid login with the associated NVMe_Port. The Disconnect NVMe_LS request, if
    >         transmitted, shall contain an Association Identifier descriptor with the Association Identifier of
    >         the NVMeoFC association being terminated.
    
    True - but: does deregister mean the target is not there thus the login 
    is gone ?   Even with unload, you will be logging out - at what point 
    did the logout occur ?
    
    I'll look into whether we can do something to be a bit more graceful for 
    the controlled shutdown flows where login can be delayed.
    
    -- james
    
    
    
