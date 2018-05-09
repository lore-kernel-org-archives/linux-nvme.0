From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 9 May 2018 14:28:03 -0500
Subject: [PATCH RFC 1/2] nvme-rdma: Support 8K inline
In-Reply-To: <VI1PR0502MB3008DEBA0C8DBC99E829D1B6D1990@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
 <1609e345042f2801f92e8831e8c83b688fad07eb.1525880285.git.swise@opengridcomputing.com>
 <VI1PR0502MB3008DEBA0C8DBC99E829D1B6D1990@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <3c5ec87b-0bb0-1347-de8d-9362585967b4@opengridcomputing.com>



On 5/9/2018 11:55 AM, Parav Pandit wrote:
> Hi Steve,
>
>> -----Original Message-----
>> From: linux-rdma-owner at vger.kernel.org [mailto:linux-rdma-
>> owner at vger.kernel.org] On Behalf Of Steve Wise
>> Sent: Wednesday, May 09, 2018 9:31 AM
>> To: axboe at fb.com; hch at lst.de; keith.busch at intel.com; sagi at grimberg.me;
>> linux-nvme at lists.infradead.org
>> Cc: linux-rdma at vger.kernel.org
>> Subject: [PATCH RFC 1/2] nvme-rdma: Support 8K inline
>>
>> Allow up to 2 pages of inline for NVMF WRITE operations.  This reduces latency
>> for 8K WRITEs by removing the need to issue a READ WR for IB, or a
>> REG_MR+READ WR chain for iWarp.
>>
>> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>> ---
>>  drivers/nvme/host/rdma.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c index
>> 1eb4438..9b8af98 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -40,7 +40,7 @@
>>
>>  #define NVME_RDMA_MAX_SEGMENTS		256
>>
>> -#define NVME_RDMA_MAX_INLINE_SEGMENTS	1
>> +#define NVME_RDMA_MAX_INLINE_SEGMENTS	2
>>
> I wrote this patch back in Feb 2017 but didn't spend time on V2 to address comments from Sagi, Christoph.
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008057.html
> Thanks for taking this forward.
> This is helpful for certain db workload who have 8K typical data size too.

Hey Parav,

I thought I'd remembered something similar previously. :)? Let me see if
I can address the previous comments, going forward.? They are:

- why just 1 or 2 pages vs more?
- dynamic allocation of nvme-rdma resources based on the target's
advertised ioccsz.

And I see you posted the nvmet-rdma patch here, which allows up to 16KB
inline:

http://lists.infradead.org/pipermail/linux-nvme/2017-February/008064.html

And I think the comments needing resolution are:

- make it a configfs option
- adjust the qp depth some if the inline depth is bigger to try and keep
the overall memory footprint reasonable
- avoid high-order allocations - maybe per-core SRQ could be helpful

So the question is, do we have agreement on the way forward?? Sagi and
Christoph, I appreciate any feedback on this.? I'd like to get this
featured merged.??

Thanks,

Steve.
