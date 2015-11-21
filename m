From: pbonzini@redhat.com (Paolo Bonzini)
Date: Sat, 21 Nov 2015 14:11:49 +0100
Subject: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
 target
In-Reply-To: <1447978868-17138-1-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
Message-ID: <56506D95.70101@redhat.com>



On 20/11/2015 01:20, Ming Lin wrote:
> One improvment could be to use google's NVMe vendor extension that
> I send in another thread, aslo here:
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext
> 
> Qemu side:
> http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=vhost-nvme.0
> Kernel side also here:
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=vhost-nvme.0

How much do you get with vhost-nvme plus vendor extension, compared to
190 MB/s for QEMU?

Note that in all likelihood, QEMU can actually do better than 190 MB/s,
and gain more parallelism too, by moving the processing of the
ioeventfds to a separate thread.  This is similar to
hw/block/dataplane/virtio-blk.c.

It's actually pretty easy to do.  Even though
hw/block/dataplane/virtio-blk.c is still using some old APIs, all memory
access in QEMU is now thread-safe.  I have pending patches for 2.6 that
cut that file down to a mere 200 lines of code, NVMe would probably be
about the same.

Paolo
