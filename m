From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 22 Sep 2016 11:27:48 -0700
Subject: nvme-cli: Plea for help to document fabrics commands
Message-ID: <1474568868.15303.22.camel@linux.intel.com>

With NVMe-over-Fabrics being merged into the existing NVMe code base,
contributions were also made to nvme-cli to enable fabrics features in
the tool. However, documentation (specifically man pages) are lacking
for fabrics features in nvme-cli, which doesn't bode well as the tool
has maintained very good documentation for all the other
commands/features that already exist for NVMe.

I would like to propose a divide-and-conquer strategy to get new man
pages added for the fabrics features to get it up to par with the rest
of the tool.

I'll volunteer to take on "discover".

I believe that leaves "connect-all", "connect", and "disconnect" still
to be documented (unless I missed something...Christoph or Ming) for
other people to conquer?

Thanks,
Jay
