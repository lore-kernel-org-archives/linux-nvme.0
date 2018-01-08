From: hare@suse.com (Hannes Reinecke)
Date: Mon, 8 Jan 2018 11:09:03 +0100
Subject: [PATCH 1/5] nvme: Add more command status translation
In-Reply-To: <20180108095512.GC4673@lst.de>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-2-keith.busch@intel.com> <20180108095512.GC4673@lst.de>
Message-ID: <2beb72a9-8502-fec8-8892-208cbb0967ac@suse.com>

On 01/08/2018 10:55 AM, Christoph Hellwig wrote:
> On Thu, Jan 04, 2018@03:46:19PM -0700, Keith Busch wrote:
>> This adds more NVMe status code translations to blk_status_t values,
>> and captures all the current status codes NVMe multipath uses.
>>
>> Signed-off-by: Keith Busch <keith.busch at intel.com>
>> ---
>>  drivers/nvme/host/core.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2a69d735efbc..f1cf1f6c5b28 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -156,14 +156,20 @@ static blk_status_t nvme_error_status(struct request *req)
>>  	case NVME_SC_SUCCESS:
>>  		return BLK_STS_OK;
>>  	case NVME_SC_CAP_EXCEEDED:
>> +	case NVME_SC_LBA_RANGE:
>>  		return BLK_STS_NOSPC;
> 
> lba range isn't really enospc.  It is returned when the lba in
> the command is outside the logical size of the namespace.
> 
Isn't that distinction pretty academic?
The entire block-to-POSIX error mapping is pretty much ad-hoc anyway...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
