From: snitzer@redhat.com (Mike Snitzer)
Date: Wed, 14 Nov 2018 11:16:45 -0500
Subject: multipath-tools: add ANA support for NVMe device
In-Reply-To: <20181114153544.GA28758@lst.de>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <d8c35b13-ee5a-e4ee-847a-2bacf788825a@suse.de>
 <20181114153544.GA28758@lst.de>
Message-ID: <20181114161645.GA18207@redhat.com>

On Wed, Nov 14 2018 at 10:35am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Nov 14, 2018@08:24:05AM +0100, Hannes Reinecke wrote:
> > My argument here is that _ANA_ support should not be tied to the NVME 
> > native multipathing at all.
> 
> It should.  Because nvme driver multipathing is the only sanctioned
> way to use it.  All other ways aren't supported and might break at
> any time.

Quite a few of us who are multipath-tools oriented would like the proper
separation rather than your more pragmatic isolated approach.  And we'd
fix it if it broke in the future.

> > So personally I don't see why the 'raw' ANA support (parsing log pages, 
> > figuring out path states etc) needs to be tied in with native NVMe 
> > multipathing. _Especially_ not as my patch really is trivial.
> 
> And not actually usable for anything..  They only thing you do is to
> increase the code size for embedded nvme users that don't need any
> multipathing.

Isn't that why CONFIG_NVME_MULTIPATH exists?  Embedded nvme users
wouldn't set that.
