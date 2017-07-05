From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 5 Jul 2017 11:11:36 +0300
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <20170705075905.GB4076@linux-x5ow.site>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <20170705075905.GB4076@linux-x5ow.site>
Message-ID: <fcc21db2-c3fe-48d7-a33a-5eedac00c2bd@mellanox.com>



On 7/5/2017 10:59 AM, Johannes Thumshirn wrote:
> On Wed, Jun 28, 2017@03:44:40PM +0300, Max Gurtovoy wrote:
>> This patch performs sequential mapping between CPUs and queues.
>> In case the system has more CPUs than HWQs then there are still
>> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
>> and their siblings to the same HWQ.
>> This actually fixes a bug that found unmapped HWQs in a system with
>> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
>> running NVMEoF (opens upto maximum of 64 HWQs).
>
> Christoph/Sagi/Keith,
>
> any updates on this patch? Without it I' not able to run NVMf on a box with 44
> Cores and 88 Threads w/o adding -i 44 to the nvme connect statement.
>
> Thanks,
> 	Johannes
>

Hi Johannes,
this was merge already to the main tree (Jens add it to his pull request)

Cheers,
	Max.
