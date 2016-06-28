From: hch@infradead.org ('Christoph Hellwig')
Date: Tue, 28 Jun 2016 01:50:11 -0700
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <014601d1d07e$e9196f70$bb4c4e50$@opengridcomputing.com>
References: <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <005f01d1c8a1$5a229240$0e67b6c0$@opengridcomputing.com>
 <007801d1c8a2$d6056530$82102f90$@opengridcomputing.com>
 <CAF1ivSZNJhOtORceAfk9Ym9SPpYOGQ4q0KOD8eEuy0ovU2Eefw@mail.gmail.com>
 <57668896.7090308@grimberg.me>
 <006e01d1cbc7$d0d9cc40$728d64c0$@opengridcomputing.com>
 <002201d1cc8b$e3f66030$abe32090$@opengridcomputing.com>
 <014601d1d07e$e9196f70$bb4c4e50$@opengridcomputing.com>
Message-ID: <20160628085011.GA7680@infradead.org>

On Mon, Jun 27, 2016@09:19:26AM -0500, Steve Wise wrote:
> It appears this OOM issue is resolved in linux-4.7-rc5.  Does it make sense to
> publish a rebased nvmf-all?  

I'd rather get everything into Jens' tree...

Either way - I suspect the fix you need is this one:

http://git.kernel.dk/cgit/linux-block/commit/block/blk-lib.c?h=for-linus&id=05bd92dddc595d74ea645e793c1f3bd4b1fc251a

but that won't be in the for-next tree either.
