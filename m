From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 14 May 2018 09:58:32 -0500
Subject: [PATCH RFC 2/2] nvmet-rdma: Support 8K inline
In-Reply-To: <66d7c50e-3f11-cab5-7ff6-a15bb5a56a07@mellanox.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
 <d6a3324a813a3ac4a1b43bf82e91794f335c24a7.1525880285.git.swise@opengridcomputing.com>
 <66d7c50e-3f11-cab5-7ff6-a15bb5a56a07@mellanox.com>
Message-ID: <14fa274a-12d2-cfbe-9853-f678391a075c@opengridcomputing.com>



On 5/14/2018 5:16 AM, Max Gurtovoy wrote:
> Thanks Steve for running this.
> Me and Parav kinda put this task aside...
>

Hey Max,

> On 5/9/2018 5:34 PM, Steve Wise wrote:
>> Allow up to 2 pages of inline for NVMF WRITE operations.? This reduces
>> latency for 8K WRITEs by removing the need to issue a READ WR for IB,
>> or a REG_MR+READ WR chain for iWarp.
>>
>> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>> ---
>> ? drivers/nvme/target/rdma.c | 4 ++--
>> ? 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 52e0c5d..9e3f08a 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -33,9 +33,9 @@
>> ? #include "nvmet.h"
>> ? ? /*
>> - * We allow up to a page of inline data to go with the SQE
>> + * We allow up to 2 pages of inline data to go with the SQE
>> ?? */
>> -#define NVMET_RDMA_INLINE_DATA_SIZE??? PAGE_SIZE
>> +#define NVMET_RDMA_INLINE_DATA_SIZE??? (PAGE_SIZE << 1)
>
> Sometimes 8K != (PAGE_SIZE << 1).
> do we realy want to have this in PPC systems, for example, that
> PAGE_SIZE == 64K ?
> We might want to re-think on changing this to SZ_4K.
>

Yes, I agree.

Thanks,

Steve.
