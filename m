From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 5 Dec 2017 05:31:30 +0900
Subject: [PATCH] nvme-pci: remove an unnecessary initialization in HMB code
In-Reply-To: <CAA7jztfv_LtBKVnEzr8HV078Q=1tvEk1TSs=+yMVBaJkzDNAgQ@mail.gmail.com>
References: <1512419034-5857-1-git-send-email-minwoo.im.dev@gmail.com>
 <CAA7jztfv_LtBKVnEzr8HV078Q=1tvEk1TSs=+yMVBaJkzDNAgQ@mail.gmail.com>
Message-ID: <CAA7jztcdp+Umx9rgJGk3QdG64mOr4i8_MeL=8+NCqLzTSmvNCQ@mail.gmail.com>

On Tue, Dec 5, 2017@5:26 AM, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> On Tue, Dec 5, 2017@5:23 AM, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
>> The local variable __size__ will be set a bit later in a for-loop.
>> Remove the explicit initialization at the beginning of this function.
>>
>> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
>> ---
>>  drivers/nvme/host/pci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index f5800c3..35331fa 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1770,7 +1770,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
>>         dma_addr_t descs_dma;
>>         int i = 0;
>>         void **bufs;
>> -       u64 size = 0, tmp;
>> +       u64 size, tmp;
>>
>>         tmp = (preferred + chunk_size - 1);
>>         do_div(tmp, chunk_size);
>> @@ -1853,7 +1853,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>>         u64 preferred = (u64)dev->ctrl.hmpre * 4096;
>>         u64 min = (u64)dev->ctrl.hmmin * 4096;
>>         u32 enable_bits = NVME_HOST_MEM_ENABLE;
>> -       int ret = 0;
>> +       int ret;
>>
>>         preferred = min(preferred, max);
>>         if (min > max) {
>> --
>> 2.7.4
>>
>
> Please ignore this mail. Sorry for making confusions.
>
>
> Thanks,

Hi Christoph,

I think you have alraedy picked it up.
I'll not make any improper patch(format, description, etc) from now on.

Thanks to you for picking it up.
