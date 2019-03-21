From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:22 -0700
Subject: [RFC] optimize nvme single segment I/O
Message-ID: <20190321231037.25104-1-hch@lst.de>

Hi all,

with all the discussion on small I/O performance lately I thought
it was time off to dust my old idea to optimize this path a bit
by avoiding to build a scatterlist.  I've only done very basic
testing because I've been a bit busy, but I thought it might be
worthwhile to get it out for feedback.
