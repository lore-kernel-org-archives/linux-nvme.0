From: ychen@greenliant.com (Yung-Chin Chen)
Date: Thu, 3 Apr 2014 15:55:25 -0700
Subject: [PATCH] NVMe: Increase shutdown complete time
In-Reply-To: <alpine.WNT.2.00.1403311755300.4656@DMCLERAN-MOBL.amr.corp.intel.com>
References: <1396283044-31926-1-git-send-email-keith.busch@intel.com>
 <alpine.WNT.2.00.1403311256420.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <49158E750348AA499168FD41D8898360626A03D9@FMSMSX105.amr.corp.intel.com>
 <alpine.WNT.2.00.1403311755300.4656@DMCLERAN-MOBL.amr.corp.intel.com>
Message-ID: <90064137F935C142B4B98BA318BB81A301DA530C@GREEN-CLEX.greenliant.com>

Hi, all:

Another issue we encountered is I/O timeout. I believe it is set to 5
seconds in the current  driver. When the system has a lot of queues,
each queue has a lot of entries, and each entry is a large size request,
it is very easy to exceed this number during benchmarking.  Take an
example, if an NVMe card supports 64 queues, 1K entries per queue and
1MB per request, there are about 64GB data ahead of a request when it is
put to the queue. The timer starts to tick. If the card can process
4GB/s, it still takes 16 seconds to process earlier requests. As a
result, the request will receive a timeout (EIO5) from the driver. I
understand in real application this is unlikely to happen. But it is not
uncommon during benchmarking.

Why do we choose 5 seconds? Are we able to make this parameter
configurable? Thanks.

Yung-Chin Chen
Greenliant Systems

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On
Behalf Of Dan McLeran
Sent: Monday, March 31, 2014 4:57 PM
To: Robles, Raymond C
Cc: Busch, Keith; linux-nvme at lists.infradead.org; Mcleran, Daniel
Subject: RE: [PATCH] NVMe: Increase shutdown complete time

CAP.TO is defined as the worst case time the driver should wait for the
controller to come ready. Not sure it can be used for shutdown as well.
If so, then we should just read that value and use it as we do in
nvme_wait_ready.

On Mon, 31 Mar 2014, Robles, Raymond C wrote:

> You're probably fine waiting anywhere up to CAP.TO.
>
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On 
> Behalf Of Dan McLeran
> Sent: Monday, March 31, 2014 11:57 AM
> To: Busch, Keith
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Increase shutdown complete time
>
> Seems reasonable to me.
>
> On Mon, 31 Mar 2014, Keith Busch wrote:
>
>> The spec doesn't have a recommendation for shutdown beyond "that the 
>> host wait a minimum of one second for the shutdown operations to 
>> complete", so we need to choose an arbitrarily value so we don't wait

>> forever but high enough to prevent unsafe shutdowns. Some h/w vendors

>> say the previous two seconds is not long enough at some capacities.
>> Twenty seconds ought to be enough for anybody, right?
>>
>> Signed-off-by: Keith Busch <keith.busch at intel.com>
>> ---
>> drivers/block/nvme-core.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c 
>> index 625259d..103da93 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -1352,7 +1352,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev
*dev)
>> 	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) |
NVME_CC_SHN_NORMAL;
>> 	writel(cc, &dev->bar->cc);
>>
>> -	timeout = 2 * HZ + jiffies;
>> +	timeout = 20 * HZ + jiffies;
>> 	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
>>
NVME_CSTS_SHST_CMPLT) {
>> 		msleep(100);
>> --
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
