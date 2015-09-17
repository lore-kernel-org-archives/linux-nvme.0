From: mlin@kernel.org (Ming Lin)
Date: Thu, 17 Sep 2015 11:18:06 -0700
Subject: [RFC PATCH 0/2] virtio nvme
In-Reply-To: <1442470241.23132.77.camel@haakon3.risingtidesystems.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
 <CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
 <1441906098.18716.21.camel@ssi>
 <1442470241.23132.77.camel@haakon3.risingtidesystems.com>
Message-ID: <CAF1ivSaOZwjg3OEdj+miXsWwbpf-Y-tmN7wmjZooxTPDQ5r9tg@mail.gmail.com>

On Wed, Sep 16, 2015 at 11:10 PM, Nicholas A. Bellinger
<nab@linux-iscsi.org> wrote:
> Hi Ming & Co,

Hi Nic,

>
> On Thu, 2015-09-10@10:28 -0700, Ming Lin wrote:
>> On Thu, 2015-09-10@15:38 +0100, Stefan Hajnoczi wrote:
>> > On Thu, Sep 10, 2015@6:48 AM, Ming Lin <mlin@kernel.org> wrote:
>> > > These 2 patches added virtio-nvme to kernel and qemu,
>> > > basically modified from virtio-blk and nvme code.
>> > >
>> > > As title said, request for your comments.
>
> <SNIP>
>
>> >
>> > At first glance it seems like the virtio_nvme guest driver is just
>> > another block driver like virtio_blk, so I'm not clear why a
>> > virtio-nvme device makes sense.
>>
>> I think the future "LIO NVMe target" only speaks NVMe protocol.
>>
>> Nick(CCed), could you correct me if I'm wrong?
>>
>> For SCSI stack, we have:
>> virtio-scsi(guest)
>> tcm_vhost(or vhost_scsi, host)
>> LIO-scsi-target
>>
>> For NVMe stack, we'll have similar components:
>> virtio-nvme(guest)
>> vhost_nvme(host)
>> LIO-NVMe-target
>>
>
> I think it's more interesting to consider a 'vhost style' driver that
> can be used with unmodified nvme host OS drivers.
>
> Dr. Hannes (CC'ed) had done something like this for megasas a few years
> back using specialized QEMU emulation + eventfd based LIO fabric driver,
> and got it working with Linux + MSFT guests.

Are the patches already in qemu upstream and LIO upstream?

I found you played it in 2010. Is it?
[QEMU-KVM]: Megasas + TCM_Loop + SG_IO into Windows XP guests
https://groups.google.com/forum/#!topic/linux-iscsi-target-dev/3hdaI6H3X0A

>
> Doing something similar for nvme would (potentially) be on par with
> current virtio-scsi+vhost-scsi small-block performance for scsi-mq
> guests, without the extra burden of a new command set specific virtio
> driver.
