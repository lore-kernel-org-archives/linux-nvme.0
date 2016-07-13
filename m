From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 13 Jul 2016 17:47:21 +0300
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <001f01d1dd12$c5fb8500$51f28f00$@opengridcomputing.com>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org> <577005C3.4000802@grimberg.me>
 <20160628084105.GA13533@lst.de>
 <005201d1d148$32c33740$9849a5c0$@opengridcomputing.com>
 <010501d1d216$86c0f0c0$9442d240$@opengridcomputing.com>
 <20160630063637.GB5191@lst.de>
 <002c01d1d2d5$777d9180$6678b480$@opengridcomputing.com>
 <57861339.7090705@grimberg.me> <578613C8.7030005@grimberg.me>
 <001f01d1dd12$c5fb8500$51f28f00$@opengridcomputing.com>
Message-ID: <57865479.1080707@grimberg.me>


> Double completion?  When the QP exits RTS with pending unsignaled SQ WRs, cxgb4
> doesn't know if those were actually completed by hardware, so they are completed
> with FLUSH_ERR status.  I _could_ change cxgb4 to just eat those, but I'm a
> little worried about breaking the iWARP Verbs semantics.  Perhaps I shouldn't
> be.  It does seem to be causing lots of pain...

What exactly breaks iWARP semantics here?

Think of a case where we posted unsignaled send, got a successful reply
from the peer, now we drain the qp, and the send which belongs to a
transaction that we already completed is flush with error. Does that
sound like a correct behavior?
