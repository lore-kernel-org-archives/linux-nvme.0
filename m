From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Apr 2017 10:20:59 +0300
Subject: [PATCH v2 3/4] nvme: enable SG gaps support
In-Reply-To: <20170421064427.GB6095@lst.de>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492098977-5231-4-git-send-email-maxg@mellanox.com>
 <2bd673ee-8455-32b7-1bad-34fa9eebb076@grimberg.me>
 <20170421064427.GB6095@lst.de>
Message-ID: <9ff1a2e8-f84f-c772-e294-2339eee8e37d@grimberg.me>

Christoph,

> All our block I/O must be cache line aligned, so dword aligned SGLs
> should not be an issue.  And for PRPs or MRs we'll always use the
> host page size.

Where is that constraint coming from? Is that new? Back when I wrote
GAP support in rdma I tested a single byte alignment via vectored
direct IO and it seemed to be going through...

I also just tested Bart's unaligned test [1] on scsi_debug and it seems
to go through as well (alignment and length are 4)...

[1]:
https://github.com/bvanassche/srp-test/blob/master/discontiguous-io/discontiguous-io.cpp
