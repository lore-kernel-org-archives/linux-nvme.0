From: bdeyal@gmail.com (Eyal BenDavid)
Date: Mon, 7 May 2018 19:14:49 +0300
Subject: BLKZEROOUT ioctl and WriteZero opcode
In-Reply-To: <20180507151442.GC20686@localhost.localdomain>
References: <CAPrnrPDEdOFKxuZNQo_BhY8Nf2MfcB=DgbzDEDV7JHx5_+-gnQ@mail.gmail.com>
 <20180504200556.GA20686@localhost.localdomain>
 <CAPrnrPA9nSSghkHnSRKdxE=+qBEZZ3Rg1c3KcxZhpEwh19EYNQ@mail.gmail.com>
 <20180507151442.GC20686@localhost.localdomain>
Message-ID: <CAPrnrPAmX_CMZEkmZeq0KVgQWCy20DbXQiTbDKGbvSPY0UUcVw@mail.gmail.com>

Thanks!


On Mon, May 7, 2018@6:14 PM, Keith Busch <keith.busch@linux.intel.com> wrote:
> On Mon, May 07, 2018@03:17:56PM +0300, Eyal BenDavid wrote:
>> Thanks Keith,
>>
>> So:
>> BLKZEROOUT is not implemented by NVME passthru + Write Zeroes (for now).
>> BLKZEROOUT Is implemented by DSM provided the device guarantees 0's
>> are returned after "Unmap"
>> In order to to zero out a range, NVMe passthru with Write Zeroes
>> opcode must be used.
>>
>> Is it correct?
>
> Yes, that is correct.
