From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 08:20:12 +0200
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <d1fe0701-6667-512e-59af-f2339ca1e52d@grimberg.me>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-7-hch@lst.de>
 <d1fe0701-6667-512e-59af-f2339ca1e52d@grimberg.me>
Message-ID: <20170616062012.GB6592@lst.de>

On Thu, Jun 15, 2017@07:49:50PM +0300, Sagi Grimberg wrote:
>>   +static int nvme_ns_link_siblings(struct nvme_ns *ns, struct nvme_id_ns 
>> *id,
>> +		struct nvme_ns *cur)
>> +{
>
> The fact that this can also not link sibling makes me think that
> the name is a bit confusing. I'm wandering if it would be a good
> idea to split the id check (and comparison) and the actual link
> itself?

I though up that, but the ugliness is that we have three possible
outcomes:  link up (success), not link up (success) or not link up (error),
which would be a bit ugly.  But I could probably do it by using -errno, 0
and 1 as return values.
