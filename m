From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Mon, 16 Apr 2018 11:21:18 +0200
Subject: [PATCH] nvme: allow lightnvm to have visibility over AER events
In-Reply-To: <4b476a76-dccb-7d90-fa79-7e8c425d4f1a@grimberg.me>
References: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>
 <1523619780-10882-2-git-send-email-javier@cnexlabs.com>
 <20180413165801.GF6424@localhost.localdomain>
 <28761F08-1AB9-41FD-BFE2-BBC9779432DA@javigon.com>
 <4b476a76-dccb-7d90-fa79-7e8c425d4f1a@grimberg.me>
Message-ID: <4DFFDFD9-DC47-47BA-B20E-3DC403167572@javigon.com>

> On 16 Apr 2018,@11.16, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> Javier,
> 
>>> We currently do have some logic in the core to say which events are
>>> sent to user space for handling and others that are handled internally.
>>> There's currently just two events with kernel specifc handling:
>>> namespace inventory change, and firmware activation.
>>> 
>>> The example in your patch looks like one of the scenarios envisioned
>>> to be handled by a udev rule. Is that not going to work for you here?
>>> 
>>> If you do have an event that needs special handling, I think you'd want
>>> to filter that out of the user space notification and invoke the kernel
>>> callback specific to it your event.
>> Can I plug a udev rule to an in-kernel driver? A concrete example of the
>> events we will handle is pblk having to remap data from a chunk that is
>> becoming unreliable.
> 
> You can plug user-space action and kernel interface for it. It looks
> pretty stateless..
> 

Ok. I'll look into it. Thanks.

> Does pblk expose a char device? I think that user-space can issue
> the log page and then pass the information to the kernel..
> 

Not yet. But we can have a generic handle in user-space to send the get
log page, then we can easily expose one.

> Given that I do see also that nvmet would be a potential consumer for
> AER, maybe user-space would be a good place to handle all this...

Great.

Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180416/1c052cdd/attachment.sig>
