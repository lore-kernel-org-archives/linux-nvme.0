From: mlin@kernel.org (Ming Lin)
Date: Wed, 15 Jul 2015 13:43:49 -0700
Subject: virtio nvme
In-Reply-To: <alpine.LNX.2.00.1507152022070.15930@localhost.lm.intel.com>
References: <CAF1ivSYFfA__tX06bkMf_=mQKF0A4Ezu35WCwUuEB=z93YJv+A@mail.gmail.com>
 <CAF1ivSYpP-RbAmJbusB_-zGGSjj26f82ro8Sgy6OK3nF=Q0eog@mail.gmail.com>
 <alpine.LNX.2.00.1507152022070.15930@localhost.lm.intel.com>
Message-ID: <CAF1ivSaUdyF8Y9eJDvJwckEUN5yht2mCcozuw4PXCWSRfX-z_g@mail.gmail.com>

On Wed, Jul 15, 2015@1:26 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, 15 Jul 2015, Ming Lin wrote:
>>
>> On Tue, Jul 14, 2015@10:58 AM, Ming Lin <mlin@kernel.org> wrote:
>>>
>>> Hi,
>>>
>>> I heard LIO target for NVMe is under development.
>>> I wonder if virtio-nvme(similar as virtio-scsi) make sense?
>>>
>>> For example,
>>> http://www.minggr.net/wp-content/uploads/2015/07/virtio_nvme.png
>>
>>
>> Hi Keith,
>>
>> Is virtio-nvme probably a valuable thing to to?
>
>
> Hi Ming,
>
> You're looking for a qemu NVMe device? There is an emulated one there
> already, but it's just called 'nvme' and a guest machine can use it
> with the mainline linux nvme driver.

No.

I'm thinking of implementing things similar as virtio-scsi/vhost-scsi for guest
to use host's nvme device more efficiently, as this picture shows:
http://www.minggr.net/wp-content/uploads/2015/07/virtio_nvme.png

For host's device: /dev/nvme0n1,
I know we can use LIO target's IBLOCK to export it, then guest to access it via
virtio-scsi/vhost-scsi. Guest will see, for example, /dev/sda

Is this use case, guest actually speaks scsi protocol.

I'm thinking is there any benefit for guest to speak nvme protocol directly?
Probably also improve guest's performance to access host's nvme device.

And I assume LIO NVMe target will be available in the near future.

Thanks.
