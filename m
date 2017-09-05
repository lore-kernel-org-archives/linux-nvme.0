From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 5 Sep 2017 21:56:59 +0900
Subject: [PATCH 1/2] nvme-pci: avoid arrary index out of bounds in retry
 HMB allocation
In-Reply-To: <20170904200317.GA16423@lst.de>
References: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
 <1504538610-15670-2-git-send-email-akinobu.mita@gmail.com>
 <20170904200317.GA16423@lst.de>
Message-ID: <CAC5umyhk0VmBqg9GfD8FHf_LqMPNckof_xgX2sgKpX0-z5vJtg@mail.gmail.com>

2017-09-05 5:03 GMT+09:00 Christoph Hellwig <hch at lst.de>:
> Hmm.  I think I did a clear beginners mistake in that code in
> mixing up two loops.  Can you try the version below that just
> adds a new function to separate the loops (and also gets rid of
> the weird early fail heuristic):

I tested the patch and it works fine. (this patch isn't applied cleanly
to v4.13, but the conflict was resolved easily)
