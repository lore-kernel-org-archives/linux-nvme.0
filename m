From: keith.busch@intel.com (Keith Busch)
Date: Sun, 26 May 2013 15:25:44 -0600 (MDT)
Subject: NVMe compatibility repository
Message-ID: <alpine.LRH.2.03.1305261505120.12919@localhost.localdom>

Hi everyone,

I created a new NVMe driver repository consisting of only the block
driver, matching maintainer's repository, but with preprocessor directives
to compile on older kernel releases. I and a few others have found this
useful, so I'm making this publicly available in the hope that others
find it useful too.

The repository exists here at:

http://git.infradead.org/users/kbusch/nvme-compatibility.git

The project should currently compile and run on releases back to 2.6.32
for various distributions. If there are other kernel versions or specific
vendor distributions anyone else adds, I will try my best to check future
patches against them as well.

Any patches destined for the upstream should go through the maintainer's
repo first and I'll regularly apply applicable patches here after they
are accepted.

For now, I believe we have the 'ok' to use this mailing list for patches
specific to the nvme-compatibility project if there is any interest in
submitting patches for back-porting.

Thanks,
Keith
