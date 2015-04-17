From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Apr 2015 20:13:54 +0200
Subject: [PATCH] nvme: consolidate synchronous command submission helpers
In-Reply-To: <alpine.LNX.2.00.1504171803090.32385@localhost.lm.intel.com>
References: <1429293033-4353-1-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1504171803090.32385@localhost.lm.intel.com>
Message-ID: <20150417181354.GA20456@lst.de>

On Fri, Apr 17, 2015@06:12:19PM +0000, Keith Busch wrote:
>> int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
>> @@ -1189,7 +1162,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
>> 	c.features.fid = cpu_to_le32(fid);
>> 	c.features.dword11 = cpu_to_le32(dword11);
>>
>> -	return nvme_submit_admin_cmd(dev, &c, result);
>> +	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL);
>> }
>
> Probably a copy-paste error, but setting the result field to NULL means
> initialization won't obtain the proper i/o queue count. The same thing
> was done in the nvme_get_features().

Oops.  I actually did run into that problem during testing, but for some
reason still sent the old version. I'll resend the proper one ASAP..
