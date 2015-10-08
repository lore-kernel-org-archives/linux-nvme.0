From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Oct 2015 15:47:31 +0000 (UTC)
Subject: [PATCH 1/8] NVMe: Reference count open namespaces
In-Reply-To: <56168F18.5070207@dev.mellanox.co.il>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
 <1443879587-23553-2-git-send-email-hch@lst.de>
 <56168F18.5070207@dev.mellanox.co.il>
Message-ID: <alpine.LNX.2.00.1510081546370.27742@localhost.lm.intel.com>

On Thu, 8 Oct 2015, Sagi Grimberg wrote:
> On 10/3/2015 4:39 PM, Christoph Hellwig wrote:
>> +	else if (!kref_get_unless_zero(&ns->dev->kref)) {
>> +		kref_put(&ns->kref, nvme_free_ns);
>
> Is this calling nvme_free_ns with dev_list_lock taken?

Yeah, patch 2/8 in this series fixes it. I should have squashed those two.
