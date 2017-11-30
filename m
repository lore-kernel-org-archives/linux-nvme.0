From: james.smart@broadcom.com (James Smart)
Date: Thu, 30 Nov 2017 08:44:56 -0800
Subject: [PATCH v2] nvme-fc: don't require user to enter host_traddr
In-Reply-To: <20171130151210.8168-1-jthumshirn@suse.de>
References: <20171130151210.8168-1-jthumshirn@suse.de>
Message-ID: <f9b1eb5d-df4d-08fe-90da-5548bc1b6039@broadcom.com>

On 11/30/2017 7:12 AM, Johannes Thumshirn wrote:
> One major usability difference between NVMf RDMA and FC is resolving
> the default host transport address in RDMA. This is perfectly doable
> in FC as well, as we already have all possible lport <-> rport
> combinations pre-populated so we can pick the first lport that has a
> connection to our desired rport per default or optionally use the user
> supplied lport if we have one.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Cc: James Smart <james.smart at broadcom.com>

This is unnecessary and can create weird configurations. It assumes 
connections are manually created. The weirdness is: a) an admin has to 
know there are multiple paths in order to connect them and be 
intelligent on how to get the complex name strings and try to know what 
connections are already in existence;? b) if a users has a connectivity 
loss beyond dev_loss_tmo or ctlr_loss_tmo such that the controller is 
terminated, they must manually issue the connec commands again; and c) 
those un-knowledgeable users will unknowingly find that their multiple 
paths aren't connected and the system will gang up on the host adapter 
detected on the system with connectivity. All things unexpected and not 
what occurs with FC and SCSI and which will result in system support calls.

If the system uses the FC auto-connect scripts things will be properly 
connected across all paths connected to the subsystem - automatically, 
including resume after an extended connectivity loss - and the system 
will behave just like FC does with SCSI.

I see no reason to add this patch.? Please move away from manual 
configuration.

-- james
