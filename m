From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 10:24:00 +0200
Subject: [PATCH 08/14] nvmet: implement the changed namespaces log
In-Reply-To: <20180529081631.mct6zjk54xjl4d6p@linux-x5ow.site>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
 <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>
 <20180529081712.GD1416@lst.de>
 <20180529081631.mct6zjk54xjl4d6p@linux-x5ow.site>
Message-ID: <20180529082400.GA1631@lst.de>

On Tue, May 29, 2018@10:16:31AM +0200, Johannes Thumshirn wrote:
> The "full rescan" part was what I couldn't read out of the spec.

The spec part is: something changed (AEN + some content in the log page)
+ too much changed (all-f first entry).  The rest is host policy, but
except for the full scan I can't think of anything else useful.
