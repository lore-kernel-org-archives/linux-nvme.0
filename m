From: dmonakhov@openvz.org (Dmitry Monakhov)
Date: Mon, 08 Feb 2016 12:00:22 +0300
Subject: [LSF/MM ATTEND] ext4, DAX pmem/fsync
Message-ID: <87lh6vwp95.fsf@openvz.org>



I would like to attend LSF/MM 2016 to participate in discussions around
the optimization of the block and MM for low latency NVM technologies.
Primary target of interests is to improving DAX performance for general
purpose FS.
While working on LightVM project (approach lighter that traditional VM, but more
secure that containers) we found that existing DAX infrastructure is too
far from optimum:
0) DAX msync/fsync patch-set is has a lot in TODO list
1) DAX implementation has number of significant SMP scalability issues.

I would like to attend LSF/MM this year. I believe I could contribute to the
following discussions:

*  Block & Filesystem interface from Steven Whitehouse
http://www.spinics.net/lists/linux-fsdevel/msg93552.html

* Persistent memory: pmem as storage device vs pmem as memory from Dan Williams
https://lists.01.org/pipermail/linux-nvdimm/2016-February/004331.html

* Persistent Memory Error Handling from Jeff Moyer:
http://www.spinics.net/lists/linux-mm/msg100560.html

* FS block allocator modification for SMR Zoned Block Devices

* EXT4-mini sumit
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160208/74eaf1a4/attachment-0001.sig>
