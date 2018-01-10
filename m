From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 10 Jan 2018 14:39:35 -0500
Subject: [PATCH] nvme: initialize hostid uuid in nvmf_host_default to
 not leak kernel memory
In-Reply-To: <20180109164252.GD15154@localhost.localdomain>
References: <20180109152043.30422-1-jthumshirn@suse.de>
 <20180109164252.GD15154@localhost.localdomain>
Message-ID: <1515613175.3913.105.camel@localhost.localdomain>

On Tue, 2018-01-09@09:42 -0700, Keith Busch wrote:
> 
> Thanks for the report and the fix. It'd still be good to use the kzalloc
> variant in addition to this.

Yes, thanks.  Good point.

kmalloc() is used elsewhere as well, so maybe another patch?

-Ewan
