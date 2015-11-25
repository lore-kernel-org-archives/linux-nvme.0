From: mlin@kernel.org (Ming Lin)
Date: Wed, 25 Nov 2015 10:51:22 -0800
Subject: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
 target
In-Reply-To: <56559B36.90406@redhat.com>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
 <56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
 <56531F5F.3050709@redhat.com> <1448350074.6696.3.camel@hasee>
 <56544122.3010300@redhat.com> <1448393115.2925.2.camel@ssi>
 <56559B36.90406@redhat.com>
Message-ID: <1448477482.6540.3.camel@ssi>

On Wed, 2015-11-25@12:27 +0100, Paolo Bonzini wrote:
> Do you still have a blk_set_aio_context somewhere?  I'm losing track of
> the changes.

No.

> 
> In any case, I think using a separate I/O thread is a bit premature,
> except for benchmarking.  In the meanwhile I think the best option is to
> post a two-patch series with the vendor extension and the ioeventfd
> respectively.

I'll post.

BTW, I'm not sure about qemu upstream policy.
Do I need to first make the kernel side patch upstream?
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext

I think the kernel side patch will take a bit longer time to upstream.

> 
> Paolo
