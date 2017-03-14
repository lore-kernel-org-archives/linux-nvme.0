From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 14 Mar 2017 21:21:59 +0000
Subject: [PATCH rfc 04/10] block: Add a non-selective polling interface
In-Reply-To: <b8124df3-bd09-2eb2-9899-3c9195605510@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-5-git-send-email-sagi@grimberg.me>
 <1489076712.2597.1.camel@sandisk.com>
 <b8124df3-bd09-2eb2-9899-3c9195605510@grimberg.me>
Message-ID: <1489526506.2676.13.camel@sandisk.com>

On Mon, 2017-03-13@10:15 +0200, Sagi Grimberg wrote:
> > Additionally, I think making the hardware context an argument of this function
> > instead of using blk_mq_map_queue(q, smp_processor_id()) would make this
> > function much more versatile.
> 
> What do you mean? remember that the callers interface to the device is
> a request queue, it doesn't even know if its a blk-mq device. Can you
> explain in more details what you would like to see?

Have you considered to make the CPU ID an argument instead of using the
smp_processor_id() result?

Bart.
