From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Nov 2018 16:35:44 +0100
Subject: multipath-tools: add ANA support for NVMe device
In-Reply-To: <d8c35b13-ee5a-e4ee-847a-2bacf788825a@suse.de>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <d8c35b13-ee5a-e4ee-847a-2bacf788825a@suse.de>
Message-ID: <20181114153544.GA28758@lst.de>

On Wed, Nov 14, 2018@08:24:05AM +0100, Hannes Reinecke wrote:
> My argument here is that _ANA_ support should not be tied to the NVME 
> native multipathing at all.

It should.  Because nvme driver multipathing is the only sanctioned
way to use it.  All other ways aren't supported and might break at
any time.

> So personally I don't see why the 'raw' ANA support (parsing log pages, 
> figuring out path states etc) needs to be tied in with native NVMe 
> multipathing. _Especially_ not as my patch really is trivial.

And not actually usable for anything..  They only thing you do is to
increase the code size for embedded nvme users that don't need any
multipathing.
