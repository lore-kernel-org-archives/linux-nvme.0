From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Mon, 15 Feb 2016 09:45:13 +0200
Subject: 4.5-rc iser issues
In-Reply-To: <CACVXFVOBjT43CkzfG1gRz1A27BQRSJ2qKOZ91oU16ZbzUh7ejQ@mail.gmail.com>
References: <20160214074119.GA24558@infradead.org>
 <56C04294.3090701@dev.mellanox.co.il> <56C05000.1040001@dev.mellanox.co.il>
 <56C066AF.6050901@dev.mellanox.co.il> <56C088EA.1050901@dev.mellanox.co.il>
 <20160214152223.GA5323@infradead.org>
 <CACVXFVNAkf5+XFyf2JkcfeEPO2sv9bqHMR+N+=kKFzrtXpFEnA@mail.gmail.com>
 <56C0AB84.9040004@dev.mellanox.co.il>
 <CACVXFVOBjT43CkzfG1gRz1A27BQRSJ2qKOZ91oU16ZbzUh7ejQ@mail.gmail.com>
Message-ID: <56C18209.7090903@dev.mellanox.co.il>


> I can reproduce the issue now, and it is easy to trigger it via your test
> code on scsi device, but a bit difficult to get it on null_blk.
>
> Turns out it is a block core issue, and it is in bio_will_gap() which gets
> the last bvec via 'bi_io_vec[prev->bi_vcnt - 1]' directly.  I have posted
> out one patchset for fixing the issue:
>
> http://marc.info/?l=linux-kernel&m=145551975429092&w=2

Thanks Ming!

I'll give it a shot...
