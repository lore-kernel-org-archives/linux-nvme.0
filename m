From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 Feb 2017 16:12:41 -0500
Subject: Linux 4.9.8 + NVMe CiB Issue
In-Reply-To: <CAHkw+LcMtBp_xC6YdR-c=P-feZJvukNtkeEWueJ_y9wkAg2hUA@mail.gmail.com>
References: <CAHkw+LcMtBp_xC6YdR-c=P-feZJvukNtkeEWueJ_y9wkAg2hUA@mail.gmail.com>
Message-ID: <20170215211240.GA23472@localhost.localdomain>

On Wed, Feb 15, 2017@02:27:13PM -0500, Marc Smith wrote:
> Hi,
> 
> I'm testing with a Supermicro SSG-2028R-DN2R40L NVMe CiB
> (cluster-in-a-box) solution. The performance is amazing so far, but I
> experienced an issue during a performance test while using the fio
> tool.
> 
> Linux 4.9.8
> fio 2.14
> 
> We have just (8) NVMe drives in the "enclosure", and it contains two
> server nodes, but right now we're just testing from one of the nodes.
> 
> This is the command we ran:
> fio --bs=4k --direct=1 --rw=randread --ioengine=libaio --iodepth=12
> --numjobs=16 --name=/dev/nvme0n1 --name=/dev/nvme1n1
> --name=/dev/nvme2n1 --name=/dev/nvme3n1 --name=/dev/nvme4n1
> --name=/dev/nvme5n1 --name=/dev/nvme6n1 --name=/dev/nvme7n1
> 
> After a few seconds, noticed the performance numbers started dropping,
> and started flaking out. This is what we saw in the kernel logs:

It looks like your controller stopped posting completions to commands.

There is some excessive kernel spamming going on here, though, but that
fix is already staged for 4.11 inclusion here:

  http://git.infradead.org/nvme.git/commitdiff/7bf7d778620d83f14fcd92d0938fb97c7d78bf19?hp=9a69b0ed6257ae5e71c99bf21ce53f98c558476a

As to why the driver was triggered to abort IO in the first place, that
appears to be the device not posting completions on time. As far as I
can tell, blk-mq's timeout handling won't mistakenly time out a command
on the initial abort, and the default 30 second timeout should be more
than enough for your workload.

There does appear to be a small window where blk-mq can miss a completion,
though: blk-mq's timeout handler sets the REQ_ATOM_COMPLETE flag
while running the timeout handler, which blocks a natural completion
from occuring while set. So if a real completion did occur, then that
completion is lost, which will force the subseqent timeout handler to
issue a controller reset.

But I don't think that's what's happening here. You are getting time
outs on admin commands as well, so that really looks like your
controller just stopped responding.

> --snip--
> [70961.868655] nvme nvme0: I/O 1009 QID 1 timeout, aborting
> [70961.868666] nvme nvme0: I/O 1010 QID 1 timeout, aborting
> [70961.868670] nvme nvme0: I/O 1011 QID 1 timeout, aborting
> [70961.868673] nvme nvme0: I/O 1013 QID 1 timeout, aborting
> [70992.073974] nvme nvme0: I/O 1009 QID 1 timeout, reset controller
> [71022.727229] nvme nvme0: I/O 237 QID 0 timeout, reset controller
