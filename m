From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 13 Jan 2016 18:06:13 +0200
Subject: [LSF/MM ATTEND][LSF/MM TOPIC] Multipath redesign
In-Reply-To: <20160113154243.GA2563@redhat.com>
References: <56961493.5010901@suse.de> <56962BDB.4080509@dev.mellanox.co.il>
 <20160113154243.GA2563@redhat.com>
Message-ID: <569675F5.8070501@dev.mellanox.co.il>


> This sounds like you aren't actually using blk-mq for the top-level DM
> multipath queue.

Hmm. I turned on /sys/module/dm_mod/parameters/use_blk_mq and indeed
saw a significant performance improvement. Anything else I was missing?

> And your findings contradicts what I heard from Keith
> Busch when I developed request-based DM's blk-mq support, from commit
> bfebd1cdb497 ("dm: add full blk-mq support to request-based DM"):
>
>       "Just providing a performance update. All my fio tests are getting
>        roughly equal performance whether accessed through the raw block
>        device or the multipath device mapper (~470k IOPS). I could only push
>        ~20% of the raw iops through dm before this conversion, so this latest
>        tree is looking really solid from a performance standpoint."

I too see ~500K IOPs, but my nvme can push ~1500K IOPs...
Its a simple nvme loopback [1] backed by null_blk.

[1]:
http://lists.infradead.org/pipermail/linux-nvme/2015-November/003001.html
http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-loop.2
