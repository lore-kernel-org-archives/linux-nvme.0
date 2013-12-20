From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Dec 2013 12:41:08 -0700 (MST)
Subject: [PATCH] NVMe: Use error handling on failed sync commands
In-Reply-To: <20131220184710.GB4945@linux.intel.com>
References: <1387563249-27871-1-git-send-email-keith.busch@intel.com>
 <20131220184710.GB4945@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1312201217060.4958@AMR>

On Fri, 20 Dec 2013, Matthew Wilcox wrote:
> On Fri, Dec 20, 2013@11:14:09AM -0700, Keith Busch wrote:
>> Sync commands schedule an internal timeout to cancel rather than using
>> the nvme timeout handler kthread. We should still try to recover so
>> moving the check for cancelled commands after the error handling.
>
>>  		if (timeout && !time_after(now, info[cmdid].timeout))
>>  			continue;
>> -		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
>> -			continue;
>>  		if (timeout && nvmeq->dev->initialized) {
>>  			nvme_abort_cmd(cmdid, nvmeq);
>>  			continue;
>>  		}
>> +		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
>> +			continue;
>>  		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
>>  								nvmeq->qid);
>>  		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
>
> I'm confused by this patch.  Won't it cause us to send abort commands
> repeatedly for commands IDs that have already been cancelled, but haven't
> yet been completed as cancelled?

It appears so, but 'nvme_abort_cmd' aborts only once then resets the
controller if the command still isn't returned. The drive is not polled
for timeouts when the reset handler is running so it won't timeout
again, and the command is forced cancelled during reset with cancel_ios()
'timeout' set to false.

'sync_command' is the only place an IO can be cancelled while the
device being polled for timeouts. I think we want to try recovering the
unresponsive controller even if the sync timeout already cancelled.

Without this patch, a failed sync command just leaks a cmdid until the
controller is reset some other way.
