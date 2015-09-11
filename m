From: stefanha@gmail.com (Stefan Hajnoczi)
Date: Fri, 11 Sep 2015 08:48:08 +0100
Subject: [RFC PATCH 0/2] virtio nvme
In-Reply-To: <1441906098.18716.21.camel@ssi>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
 <CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
 <1441906098.18716.21.camel@ssi>
Message-ID: <CAJSP0QXbjY5kbz0jTJSDyo=Zh9B+DRZorTY0m3bRC8yhJT=Nvw@mail.gmail.com>

On Thu, Sep 10, 2015@6:28 PM, Ming Lin <mlin@kernel.org> wrote:
> On Thu, 2015-09-10@15:38 +0100, Stefan Hajnoczi wrote:
>> On Thu, Sep 10, 2015@6:48 AM, Ming Lin <mlin@kernel.org> wrote:
>> > These 2 patches added virtio-nvme to kernel and qemu,
>> > basically modified from virtio-blk and nvme code.
>> >
>> > As title said, request for your comments.
>> >
>> > Play it in Qemu with:
>> > -drive file=disk.img,format=raw,if=none,id=D22 \
>> > -device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4
>> >
>> > The goal is to have a full NVMe stack from VM guest(virtio-nvme)
>> > to host(vhost_nvme) to LIO NVMe-over-fabrics target.
>>
>> Why is a virtio-nvme guest device needed?  I guess there must either
>> be NVMe-only features that you want to pass through, or you think the
>> performance will be significantly better than virtio-blk/virtio-scsi?
>
> It simply passes through NVMe commands.

I understand that.  My question is why the guest needs to send NVMe commands?

If the virtio_nvme.ko guest driver only sends read/write/flush then
there's no advantage over virtio-blk.

There must be something you are trying to achieve which is not
possible with virtio-blk or virtio-scsi.  What is that?

Stefan
