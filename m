From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Jun 2017 10:15:50 +0300
Subject: [PATCH v4 5/8] nvme: get list of namespace descriptors
In-Reply-To: <20170605053825.GE19480@lst.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-6-jthumshirn@suse.de> <20170605053825.GE19480@lst.de>
Message-ID: <c3f4931f-8266-ac43-4d34-ba479d3d52f5@grimberg.me>



On 05/06/17 08:38, Christoph Hellwig wrote:
>> +			}
>> +			len = NVME_NIDT_UUID_LEN;
>> +			memcpy(ns->uuid, data + pos + sizeof(*cur), len);
>> +			break;
>> +		default:
>> +			dev_warn(ns->ctrl->dev,
>> +				 "Invalid Namespace Identification Descriptor Type: %d\n",
>> +				 cur->nidt);
>> +			return;
> 
> Please drop the warning and return, the spec says hosts should ignore
> unknown types.  This is important to future proof for new types that
> could be added.

Also, please stay consistent with the rest of the driver by logging the
correct device prefix using ctrl->device and not ctrl->dev.

(if we have some ctrl->dev left-overs, can you also send a patch to fix?)
