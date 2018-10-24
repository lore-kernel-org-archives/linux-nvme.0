From: bdeyal@gmail.com (Eyal BenDavid)
Date: Wed, 24 Oct 2018 19:10:10 +0300
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
In-Reply-To: <20181019171713.GA25247@localhost.localdomain>
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
 <20181019171713.GA25247@localhost.localdomain>
Message-ID: <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>

The patched version fails to build on Fedora 28 (gcc 8.1.1) due to a warning.

Here is the message:

cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99
-DLIBUUID -DNVME_VERSION='"1.6.96.g352d"' -c wdc-nvme.c
wdc-nvme.c: In function ?wdc_crash_dump?:
wdc-nvme.c:1151:3: error: ?strncpy? output truncated before
terminating nul copying 11 bytes from a string of the same length
[-Werror=stringop-truncation]
   strncpy(dump_type, "_pfail_dump", 11);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wdc-nvme.c:1153:3: error: ?strncpy? output truncated before
terminating nul copying 11 bytes from a string of the same length
[-Werror=stringop-truncation]
   strncpy(dump_type, "_crash_dump", 11);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile:46: wdc-nvme.o] Error 1
On Fri, Oct 19, 2018@8:21 PM Keith Busch <keith.busch@linux.intel.com> wrote:
>
> On Thu, Oct 18, 2018@09:06:53PM +0000, Dong Ho wrote:
> > ---
> > This patch implements the function to retreive a WDC device's pfail crash dump.
>
> Thanks, both applied.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
