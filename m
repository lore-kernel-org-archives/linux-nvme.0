From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 23 Oct 2017 19:34:36 +0000
Subject: NVMe-CLI intel-nvme.c RHEL 6.9 Compile Errors
In-Reply-To: <20171023192758.GF30713@localhost.localdomain>
References: <MWHPR04MB102554E84EE6D1CC8ADBF47EEA460@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20171023154844.bzg5crhusqehxrho@sbauer-Z170X-UD5>
 <20171023192758.GF30713@localhost.localdomain>
Message-ID: <MWHPR04MB10256C932AEB9B69D077F417EA460@MWHPR04MB1025.namprd04.prod.outlook.com>

Thanks Keith.  Just verified on my Rhel 6.9 machine - no more compile errors.  


Jeff Lien

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Monday, October 23, 2017 2:28 PM
To: Scott Bauer
Cc: Jeffrey Lien; linux-nvme at lists.infradead.org; David Darrington
Subject: Re: NVMe-CLI intel-nvme.c RHEL 6.9 Compile Errors

On Mon, Oct 23, 2017@09:48:45AM -0600, Scott Bauer wrote:
> On Mon, Oct 23, 2017@03:43:36PM +0000, Jeffrey Lien wrote:
> > Keith,
> > We noticed these compile errors when trying to build the latest version of the NVME CLI on RHEL 6.9 and SLES 11.4:
> > [ddtest at gfox3-rh69 nvme-cli-kb]$ make NVME_VERSION = 1.4 cc 
> > -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c argconfig.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c suffix.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c parser.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c nvme-print.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c nvme-ioctl.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c nvme-lightnvm.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c fabrics.c cc -D_GNU_SOURCE 
> > -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c json.c cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ 
> > -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c plugin.c 
> > cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 
> > -DNVME_VERSION='"1.4"' -c intel-nvme.c
> > cc1: warnings being treated as errors
> > intel-nvme.c: In function \u2018get_internal_log\u2019:
> > intel-nvme.c:782: error: dereferencing pointer \u2018ehdr\u2019 does 
> > break strict-aliasing rules
> > intel-nvme.c:785: error: dereferencing pointer \u2018ehdr\u2019 does 
> > break strict-aliasing rules
> > intel-nvme.c:741: note: initialized from here
> > intel-nvme.c:643: error: \u2018ad\u2019 may be used uninitialized in 
> > this function
> > intel-nvme.c:645: error: \u2018ehdr\u2019 may be used uninitialized 
> > in this function
> > make: *** [intel-nvme.o] Error 1
> > 
> 
> If you need to build it right now while I fix it you can add -fno-strict-aliasing.
> 
> As for the actual error, I think the c-spec allows for a char type to 
> be aliased to any other type without invoking undefiened behavior. 
> I'll try and find that in the spec to verify. What GCC version does RHEL 6.9 have?

Some kind of weird casting rules. Should be fixed now.
