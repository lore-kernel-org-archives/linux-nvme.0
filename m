From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 27 Jun 2016 09:19:26 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <002201d1cc8b$e3f66030$abe32090$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <005f01d1c8a1$5a229240$0e67b6c0$@opengridcomputing.com>
 <007801d1c8a2$d6056530$82102f90$@opengridcomputing.com>
 <CAF1ivSZNJhOtORceAfk9Ym9SPpYOGQ4q0KOD8eEuy0ovU2Eefw@mail.gmail.com>
 <57668896.7090308@grimberg.me>
 <006e01d1cbc7$d0d9cc40$728d64c0$@opengridcomputing.com>
 <002201d1cc8b$e3f66030$abe32090$@opengridcomputing.com>
Message-ID: <014601d1d07e$e9196f70$bb4c4e50$@opengridcomputing.com>

> > Yoichi has hit what is apparently the same OOM bug:
> >
> > Kernel panic - not syncing: Out of memory and no killable processes...
> >
> > He hit it with NVMF on the host, _and_ with NVME/PCI with a local SSD.
> > This is all with using nvmf-all.3 + Christoph's fix for the target queue
> > deletion crash
> > (http://lists.infradead.org/pipermail/linux-nvme/2016-June/005075.html).
> >
> 
> Yoichi can reproduce this with linux-4.7-rc4, so the issue isn't related to
the
> nvme/nvmf changes in nvmf-all.3.  Also, I have been unable to reproduce it so
> far on my setup.  But Yoichi can reproduce it readily.
> 

Hey Christoph,  

It appears this OOM issue is resolved in linux-4.7-rc5.  Does it make sense to
publish a rebased nvmf-all?  

Thanks,

Steve.
