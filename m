From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Mar 2015 16:36:50 +0000 (UTC)
Subject: [PATCHv3] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <20150324162301.GN4003@linux.intel.com>
References: <1427118493-29227-1-git-send-email-sunad.s@samsung.com>
 <20150324162301.GN4003@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1503241628000.32385@localhost.lm.intel.com>

On Tue, 24 Mar 2015, Matthew Wilcox wrote:
> On Mon, Mar 23, 2015@07:18:13PM +0530, Sunad Bhandary S wrote:
>> +	case WRITE_LONG:
>> +		retcode = nvme_trans_write_long(ns, hdr, cmd);
>> +		break;
>> +	case SERVICE_ACTION_OUT_16:
>> +		if (IS_WRITE_LONG_16(cmd))
>> +			retcode = nvme_trans_write_long(ns, hdr, cmd);
>> +		else
>> +			goto out;
>> +		break;
>>  	default:
>>   out:
>
> Umm, why not simply:
>
> 	case SERVICE_ACTION_OUT_16:
> 		if (IS_WRITE_LONG_16(cmd))
> 			retcode = nvme_trans_write_long(ns, hdr, cmd);
> 		break;

We need to jump to a case that sets the sense data for the IllReq Check
Condition.

Actually I'm not sure why there are a bunch of:

 	case foobar:
 		retcode = nvme_trans_foobar();
 		break;

Rather than just:

 	case foobar:
 		return nvme_trans_foobar();

It make the whole thing cleaner and allow breaking out to an error
handler at the end of the function.

Anyhow, it's on my list to clean up this up since we are blk-mq now and
can leverage REQ_BLOCK_TYPE_PC to do all the boiler plate user space
copying, among other things. We can reduce the nvme-scsi.c file size
by half.
