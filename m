From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 12 May 2019 07:24:59 +0900
Subject: [PATCH RFC 2/4] nvme-status: Introduce nvme status module to map
 errno
In-Reply-To: <SN6PR04MB452726893B1EC5E52D347B3F860D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190511193713.29516-1-minwoo.im.dev@gmail.com>
 <20190511193713.29516-3-minwoo.im.dev@gmail.com>
 <SN6PR04MB452726893B1EC5E52D347B3F860D0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <5bcca563-73c9-a588-d656-9b612aedad20@gmail.com>


>> +	if (sct == NVME_SCT_GENERIC) {
>> +		switch (status) {
>> +		case NVME_SC_INVALID_OPCODE:
>> +		case NVME_SC_INVALID_FIELD:
>> +		case NVME_SC_INVALID_NS:
>> +		case NVME_SC_SGL_INVALID_LAST:
>> +		case NVME_SC_SGL_INVALID_COUNT:
>> +		case NVME_SC_SGL_INVALID_DATA:
>> +		case NVME_SC_SGL_INVALID_METADATA:
>> +		case NVME_SC_SGL_INVALID_TYPE:
>> +		case NVME_SC_SGL_INVALID_OFFSET:
>> +		case NVME_SC_SGL_INVALID_SUBTYPE:
>> +			return EINVAL;
>> +		case NVME_SC_CMDID_CONFLICT:
>> +			return EADDRINUSE;
>> +		case NVME_SC_DATA_XFER_ERROR:
>> +		case NVME_SC_INTERNAL:
>> +		case NVME_SC_SANITIZE_FAILED:
>> +			return EIO;
>> +		case NVME_SC_POWER_LOSS:
>> +		case NVME_SC_ABORT_REQ:
>> +		case NVME_SC_ABORT_QUEUE:
>> +		case NVME_SC_FUSED_FAIL:
>> +		case NVME_SC_FUSED_MISSING:
>> +			return EWOULDBLOCK;
>> +		case NVME_SC_CMD_SEQ_ERROR:
>> +			return EILSEQ;
>> +		case NVME_SC_SANITIZE_IN_PROGRESS:
>> +			return EINPROGRESS;
>> +		case NVME_SC_NS_WRITE_PROTECTED:
>> +		case NVME_SC_NS_NOT_READY:
>> +		case NVME_SC_RESERVATION_CONFLICT:
>> +			return EACCES;
>> +		case NVME_SC_LBA_RANGE:
>> +			return EREMOTEIO;
>> +		case NVME_SC_CAP_EXCEEDED:
>> +			return ENOSPC;
>> +		}
> 
> Please move above switch to the small helper inline function
> 
> nvme_status_code_generic().

I would like to have it indicating "errno" concept in the function name. 
  I'll make them like:
   nvme_generic_status_to_errno()
   nvme_cmd_specific_status_to_errno()
   nvme_fabrics_status_to_errno()
