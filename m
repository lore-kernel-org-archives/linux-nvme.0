From: james.smart@broadcom.com (James Smart)
Date: Sun, 29 Oct 2017 21:43:46 -0700
Subject: [PATCH 1/2] nvme_fc: fix localport resume using stale values
In-Reply-To: <4640f307-5d61-838b-62d4-c8310ff4bd3b@grimberg.me>
References: <20171027172805.13495-1-jsmart2021@gmail.com>
 <20171027172805.13495-2-jsmart2021@gmail.com>
 <4640f307-5d61-838b-62d4-c8310ff4bd3b@grimberg.me>
Message-ID: <3d7cff5b-5e23-b9be-33c2-474b6393f184@broadcom.com>

On 10/29/2017 5:28 AM, Sagi Grimberg wrote:
>
>> The localport resume was not updating the lldd ops structure. If the
>> lldd is unloaded and reloaded, the ops pointers will differ.
>
> Question, why is the lport kept around if the lldd unloaded?

It's kept around due to ref counting of the attached rports and 
controllers who have not timed out and torn down.? The fact that the 
lldd could be unloaded is an artifact of supporting the reg/unreg and 
the fact that the transport doesn't care what the driver does after the 
unreg is done, and the re-reg only cares that it's done quickly enough 
that there are still references so the device and it can revive the old 
structures.? The reg/unreg/re-reg support is mainly there to support the 
lldd performing an adapter reset for some type of error recovery (could 
come from the SCSI stack requesting it for error escalation). Thus the 
lldd can reset the adapter, perform it's normal init steps again an 
re-reg the lport and rports, and the controllers resume under their 
ctlr_loss_tmo/dev_loss_tmo timers and consumers of the nvme devices are 
not affected other than a short pause.

-- james
