From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 11:17:43 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170616062012.GB6592@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-7-hch@lst.de>
 <d1fe0701-6667-512e-59af-f2339ca1e52d@grimberg.me>
 <20170616062012.GB6592@lst.de>
Message-ID: <1b0b110d-02fa-5c59-001d-6e04e6445fa1@grimberg.me>


>>>    +static int nvme_ns_link_siblings(struct nvme_ns *ns, struct nvme_id_ns
>>> *id,
>>> +		struct nvme_ns *cur)
>>> +{
>>
>> The fact that this can also not link sibling makes me think that
>> the name is a bit confusing. I'm wandering if it would be a good
>> idea to split the id check (and comparison) and the actual link
>> itself?
> 
> I though up that, but the ugliness is that we have three possible
> outcomes:  link up (success), not link up (success) or not link up (error),
> which would be a bit ugly.  But I could probably do it by using -errno, 0
> and 1 as return values.

To me, the code would look better if we split the logic.

Something like:


	list_for_each_entry(cur, &ctrl->namespaces, list) {
		if (nvme_ns_is_sibling(ns, id, cur)) {
			err = nvme_ns_link_sibling(ns, cur);
			if (err)
				break;
		}
	}
