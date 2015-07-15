From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 Jul 2015 20:26:14 +0000 (UTC)
Subject: virtio nvme
In-Reply-To: <CAF1ivSYpP-RbAmJbusB_-zGGSjj26f82ro8Sgy6OK3nF=Q0eog@mail.gmail.com>
References: <CAF1ivSYFfA__tX06bkMf_=mQKF0A4Ezu35WCwUuEB=z93YJv+A@mail.gmail.com>
 <CAF1ivSYpP-RbAmJbusB_-zGGSjj26f82ro8Sgy6OK3nF=Q0eog@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1507152022070.15930@localhost.lm.intel.com>

On Wed, 15 Jul 2015, Ming Lin wrote:
> On Tue, Jul 14, 2015@10:58 AM, Ming Lin <mlin@kernel.org> wrote:
>> Hi,
>>
>> I heard LIO target for NVMe is under development.
>> I wonder if virtio-nvme(similar as virtio-scsi) make sense?
>>
>> For example,
>> http://www.minggr.net/wp-content/uploads/2015/07/virtio_nvme.png
>
> Hi Keith,
>
> Is virtio-nvme probably a valuable thing to to?

Hi Ming,

You're looking for a qemu NVMe device? There is an emulated one there
already, but it's just called 'nvme' and a guest machine can use it
with the mainline linux nvme driver.
