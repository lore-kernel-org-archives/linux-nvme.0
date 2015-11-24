From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 24 Nov 2015 11:51:14 +0100
Subject: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
 target
In-Reply-To: <1448350074.6696.3.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
 <56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
 <56531F5F.3050709@redhat.com> <1448350074.6696.3.camel@hasee>
Message-ID: <56544122.3010300@redhat.com>



On 24/11/2015 08:27, Ming Lin wrote:
> handle_notify (qemu/hw/block/dataplane/virtio-blk.c:126)
> aio_dispatch (qemu/aio-posix.c:329)
> aio_poll (qemu/aio-posix.c:474)
> iothread_run (qemu/iothread.c:45)
> start_thread (pthread_create.c:312)
> /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)
> 
> I think I'll have a "nvme_dev_notify" similar as "handle_notify"
> 
> static void nvme_dev_notify(EventNotifier *e)
> {
>     ....
> }
> 
> But then how can I know this notify is for cq or sq?

virtio-blk has a single queue, so it has a single EventNotifier.  Your
code using multiple EventNotifiers is fine, you can use
aio_set_event_notifier multiple times on the same iothread.

Paolo
