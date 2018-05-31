From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Thu, 31 May 2018 09:36:58 -0700
Subject: [PATCH 06/12] nvmet: implement the changed namespaces log
In-Reply-To: <20180531162514.GA30839@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-7-hch@lst.de>
 <0c4cc53d-1c28-0bf5-d454-df6c9ef9335b@intel.com>
 <20180531162514.GA30839@lst.de>
Message-ID: <9d27c145-b5b8-efe0-1308-c962be4add80@intel.com>

On 05/31/2018 09:25 AM, Christoph Hellwig wrote:
> On Wed, May 30, 2018@10:33:49AM -0700, Daniel Verkamp wrote:
>> Minor nitpick here: if ctrlr->nr_changed_ns is exactly
>> NVME_MAX_CHANGED_NAMESPACES and the new nsid is already in the list,
>> this will skip down to the 0xffffffff case below, even though it could
>> have just left the list as-is.
>>
>> I don't know if this is a problem in practice; reporting 0xffffffff is
>> probably always safe, since the host will presumably treat that as
>> "rescan everything".
> 
> It probably doesn't matter, but it turns doing this propely actually
> looks cleaner as well:
> 
> ---
> From d4baf4068220a90ecf67309d01ece5d0aadd952e Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch at lst.de>
> Date: Fri, 25 May 2018 17:16:09 +0200
> Subject: nvmet: implement the changed namespaces log

Agreed, this version looks good to me:
Reviewed-by: Daniel Verkamp <daniel.verkamp at intel.com>

Thanks,
-- Daniel
