From: hch@lst.de ('Christoph Hellwig')
Date: Tue, 27 Sep 2016 00:29:06 +0200
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <20160926151242.GA16873@lst.de>
References: <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
 <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
 <020001d20f70$9998fde0$cccaf9a0$@opengridcomputing.com>
 <02c001d20f93$e6a88a60$b3f99f20$@opengridcomputing.com>
 <20160916110412.GC5476@lst.de>
 <8fc2cefe-76b6-b0a3-12af-701833c286f7@grimberg.me>
 <02db01d2128b$e9244c70$bb6ce550$@opengridcomputing.com>
 <02c601d2144d$ff453a50$fdcfaef0$@opengridcomputing.com>
 <cea94562-b0d6-fbc0-998d-9597b8969998@grimberg.me>
 <20160926151242.GA16873@lst.de>
Message-ID: <20160926222906.GA28881@lst.de>

Steve,

can you retest with the "Introduce blk_quiesce_queue() and blk_resume_queue()"
series from Bart applied?
