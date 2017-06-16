From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 11:58:37 +0200
Subject: [PATCH v6 00/10] Implement NVMe Namespace Descriptor
 Identification
In-Reply-To: <905ed2e6-1c1c-f3a3-5391-66e42fb61861@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170615163141.GA27307@lst.de>
 <bab953e9-7026-5833-9f65-1ef8b90433d7@suse.de>
 <20170616094056.GA12465@lst.de>
 <905ed2e6-1c1c-f3a3-5391-66e42fb61861@suse.de>
Message-ID: <20170616095837.GA14217@lst.de>

On Fri, Jun 16, 2017@11:48:32AM +0200, Johannes Thumshirn wrote:
> On 06/16/2017 11:40 AM, Christoph Hellwig wrote:
> > On Fri, Jun 16, 2017@10:20:04AM +0200, Johannes Thumshirn wrote:
> >> Strange, as I tested with nvme-loop all the time...
> > 
> > Yeah, it's actually there, but for some reason find on sysfs
> > behaves strange:
> > 
> > root at testvm:~# find /sys -name uuid
> > root at testvm:~# cat /sys/class/nvme/nvme2/nvme2n1/uuid 
> > 6665a65b-f42f-469b-800e-a047238649eb
> 
> Wasn't there something that find on sysfs isn't reliable?

Looks like it.  Which is a pitty.

> Anyways, my shock's gone now.

Heh.  Now we just need the nvme-cli patches to verify it independently :)
