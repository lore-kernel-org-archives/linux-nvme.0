From: thomas.tai@oracle.com (Thomas Tai)
Date: Mon, 29 Jan 2018 13:37:50 -0500
Subject: [PATCH v2 1/1] nvme: Add fault injection feature
In-Reply-To: <e3a91c4c-b63e-24a2-63f1-d873fbc63e9c@grimberg.me>
References: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
 <1516825390-3324-2-git-send-email-thomas.tai@oracle.com>
 <e3a91c4c-b63e-24a2-63f1-d873fbc63e9c@grimberg.me>
Message-ID: <0d8c597e-53dc-507c-6678-9802aede179a@oracle.com>



On 2018-01-29 01:34 PM, Sagi Grimberg wrote:
> 
>> +void nvme_should_fail(struct request *req)
>> +{
>> +??? struct gendisk *disk = req->rq_disk;
>> +??? struct nvme_ns *ns = NULL;
>> +
>> +??? /*
>> +???? * make sure this request is coming from a valid namespace
>> +???? */
>> +??? if (!disk)
>> +??????? return;
>> +
>> +??? ns = disk->private_data;
>> +??? if (ns && should_fail(&ns->fault_inject.attr, 1))
>> +??????? /* inject the error status, do not retry */
>> +??????? nvme_req(req)->status =??? NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> 
> I think it can be useful to control the status code (and DNR) as stuff
> like request retries and multipathing take it into account..

Hi Sagi,
Thank you for your suggestion. I will add an options in the debugfs to 
control the status code and the DNR setting.

Thanks,
Thomas
