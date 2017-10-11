From: james.smart@broadcom.com (James Smart)
Date: Wed, 11 Oct 2017 07:52:13 -0700
Subject: [PATCH v2 7/7] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <88124a13-30d4-8906-f9c7-6c00d6d7ee31@grimberg.me>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-8-jsmart2021@gmail.com>
 <88124a13-30d4-8906-f9c7-6c00d6d7ee31@grimberg.me>
Message-ID: <68b78559-e75a-7c2d-a588-c6063954d16a@broadcom.com>

On 10/11/2017 3:29 AM, Sagi Grimberg wrote:
> OK, I think I finally understand the existence of the two tmos.
> But may I ask, what happens if we only have ctrl_loss_tmo support?
>
> If I understand correctly, it would behave exactly as expected as the
> controller will periodically attempt reconnect until ctrl_loss_tmo fires
> and then it is deleted. With dev_loss_tmo, once the lower between
> ctrl_loss_tmo and dev_loss_tmo expires, the controller is deleted.
> If my understanding is correct, this just adds a level of confusion
> to setup procedure doesn't it?

agree with your statements. And no, it doesn't add confusion. You are 
ignoring the whole history coming from the SCSI side that is expected 
and well-known. If anything, adding the per-controller ctrl_loss_tmo 
that has different values, making fc-nvme behave differently than scsi 
on the same port (running scsi and fc concurrently perhaps), is what 
adds confusion.

-- james
