From: guanjunxiong@huawei.com (guanjunxiong)
Date: Thu, 30 Mar 2017 16:05:23 +0800
Subject: [PATCH] nvme: make nvme error status codes converted to errno
 detailed
In-Reply-To: <8bf05c27-b44d-906d-2c79-0e31db9ac0c3@grimberg.me>
References: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
 <8bf05c27-b44d-906d-2c79-0e31db9ac0c3@grimberg.me>
Message-ID: <6aefb9a2-2cd3-63d5-d36f-3dcb4f8fd707@huawei.com>

>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -255,7 +255,37 @@ static inline int nvme_error_status(u16 status)
>>      case NVME_SC_SUCCESS:
>>          return 0;
>>      case NVME_SC_CAP_EXCEEDED:
>> +    case NVME_SC_NS_INSUFFICENT_CAP:
>>          return -ENOSPC;
>
> why is this ENOSPC?

In the NVMe Spec,  Namespace Insufficient Capacity (NVME_SC_NS_INSUFFICENT_CAP) means
that creating the namespace requires more free space than is currently available. However
ENOSPC means no space is left on the device.
If there is a little free space on the device,NVME_SC_NS_INSUFFICENT_CAP will be returned.
Your question is reasonble, so I will categorize NVME_SC_NS_INSUFFICENT_CAP into default EIO.


>> +    case NVME_SC_INVALID_OPCODE:
>> +    case NVME_SC_INVALID_FIELD:
>> +    case NVME_SC_INVALID_NS:
>> +    case NVME_SC_SGL_INVALID_LAST:
>> +    case NVME_SC_SGL_INVALID_COUNT:
>> +    case NVME_SC_SGL_INVALID_DATA:
>> +    case NVME_SC_SGL_INVALID_METADATA:
>> +    case NVME_SC_SGL_INVALID_TYPE:
>> +    case NVME_SC_SGL_INVALID_OFFSET:
>> +    case NVME_SC_SGL_INVALID_SUBTYPE:
>> +    case NVME_SC_CQ_INVALID:
>> +    case NVME_SC_QID_INVALID:
>> +    case NVME_SC_QUEUE_SIZE:
>> +    case NVME_SC_FIRMWARE_SLOT:
>> +    case NVME_SC_FIRMWARE_IMAGE:
>> +    case NVME_SC_INVALID_VECTOR:
>> +    case NVME_SC_INVALID_LOG_PAGE:
>> +    case NVME_SC_INVALID_FORMAT:
>> +    case NVME_SC_CTRL_LIST_INVALID:
> case NVME_SC_BAD_ATTRIBUTES:
> case NVME_SC_INVALID_PI:
> case NVME_SC_CONNECT_FORMAT:
> case NVME_SC_CONNECT_INVALID_PARAM:
> case NVME_SC_CONNECT_INVALID_HOST:
>
>> +        return -EINVAL;

> Maybe we can add also some fabrics status codes?

Nice. In addition, because the value of some fabrics status codes are the same as
the value of the PCIe status code, such as:
	/*
	 * I/O Command Set Specific - NVM commands:
	 */
	NVME_SC_BAD_ATTRIBUTES		= 0x180,
	NVME_SC_INVALID_PI		= 0x181,
	NVME_SC_READ_ONLY		= 0x182,

	/*
	 * I/O Command Set Specific - Fabrics commands:
	 */
	NVME_SC_CONNECT_FORMAT		= 0x180,
	NVME_SC_CONNECT_CTRL_BUSY	= 0x181,
	NVME_SC_CONNECT_INVALID_PARAM	= 0x182,

more consideration needs to be taken into the nvme_error_status(u16 status)
function. Therefore , funct nvme_error_status(u16 status) need to accept one more
parameter to distinguish the duplicated value of  the status codes above. Here is
the new prototype of nvme_error_status function:
	static inline int nvme_error_status(u16 status, bool is_fabrics_cmd);

If command in the request is fabrics command, then is_fabrics_cmd is set to true.
Or else set to false


> It'll also be useful if we can log the specific error (as a human
> readable string).
>

Nice advice. The nvme_status_to_string() function in the nvme-cli will be reused for this.

Thanks.


On 2017/3/30 1:39, Sagi Grimberg wrote:
> 
> 
> On 29/03/17 13:08, Guan Junxiong wrote:
>> From: Junxiong Guan <guanjunxiong at huawei.com>
>>
>> For more detailed information about nvme error status when ending
>> blk_mq request,some of nvme error status codes can be categorized into
>> different errnos explicitly. For example, NVME_SC_ACCESS_DENIED and
>> NVME_SC_CONNECT_CTRL_BUSY can be converted to EACCESS and EBUSY repec-
>> tively.This patch makes conversion from those nvme error status to errno
>> detailed.
> 
> This makes sense to me, see comments below.
> 
>> ---
>>  drivers/nvme/host/nvme.h | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index a3da1e90b99d..be699ca38cc8 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -255,7 +255,37 @@ static inline int nvme_error_status(u16 status)
>>      case NVME_SC_SUCCESS:
>>          return 0;
>>      case NVME_SC_CAP_EXCEEDED:
>> +    case NVME_SC_NS_INSUFFICENT_CAP:
>>          return -ENOSPC;
> 
> why is this ENOSPC?
> 
> Maybe we can add also some fabrics status codes?
> 
>> +    case NVME_SC_READ_ONLY:
>> +    case NVME_SC_ACCESS_DENIED:
>> +        return -EACCES;
>> +    case NVME_SC_LBA_RANGE:
>> +        return -EFAULT;
>> +    case NVME_SC_CONNECT_CTRL_BUSY:
> case NVME_SC_CONNECT_CTRL_BUSY:
> 
>> +        return -EBUSY;
> 
> 
> 
>> +    case NVME_SC_INVALID_OPCODE:
>> +    case NVME_SC_INVALID_FIELD:
>> +    case NVME_SC_INVALID_NS:
>> +    case NVME_SC_SGL_INVALID_LAST:
>> +    case NVME_SC_SGL_INVALID_COUNT:
>> +    case NVME_SC_SGL_INVALID_DATA:
>> +    case NVME_SC_SGL_INVALID_METADATA:
>> +    case NVME_SC_SGL_INVALID_TYPE:
>> +    case NVME_SC_SGL_INVALID_OFFSET:
>> +    case NVME_SC_SGL_INVALID_SUBTYPE:
>> +    case NVME_SC_CQ_INVALID:
>> +    case NVME_SC_QID_INVALID:
>> +    case NVME_SC_QUEUE_SIZE:
>> +    case NVME_SC_FIRMWARE_SLOT:
>> +    case NVME_SC_FIRMWARE_IMAGE:
>> +    case NVME_SC_INVALID_VECTOR:
>> +    case NVME_SC_INVALID_LOG_PAGE:
>> +    case NVME_SC_INVALID_FORMAT:
>> +    case NVME_SC_CTRL_LIST_INVALID:
> case NVME_SC_BAD_ATTRIBUTES:
> case NVME_SC_INVALID_PI:
> case NVME_SC_CONNECT_FORMAT:
> case NVME_SC_CONNECT_INVALID_PARAM:
> case NVME_SC_CONNECT_INVALID_HOST:
> 
>> +        return -EINVAL;
>> +    case NVME_SC_CMD_SEQ_ERROR:
>> +        return -EPROTO;
>>      default:
>>          return -EIO;
>>      }
>>
> 
> It'll also be useful if we can log the specific error (as a human
> readable string).
> 
> .
> 
