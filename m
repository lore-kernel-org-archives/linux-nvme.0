From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Aug 2018 15:44:57 +0000
Subject: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
In-Reply-To: <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
Message-ID: <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>

On Tue, 2018-08-14@17:39 +0200, Hannes Reinecke wrote:
> While I have considered having nvme_nvm_register_sysfs() returning a
> pointer I would then have to remove the 'static' declaration from the
> nvm_dev_attr_group_12/20.
> Which I didn't really like, either.

Hmm ... I don't see why the static declaration would have to be removed from
nvm_dev_attr_group_12/20 if nvme_nvm_register_sysfs() would return a pointer?
Am I perhaps missing something?

Thanks,

Bart.
