From: jim@thebergstens.com (James R. Bergsten)
Date: Fri, 5 Dec 2014 08:48:50 -0800
Subject: [PATCH v2] nvme-user: Minor enhancement and fixes
In-Reply-To: <37D709DA9AEECD448AE8DD01BDD193F7ED8E2D@NTXBOIMBX02.micron.com>
References: <1417182636-2990-1-git-send-email-s.chawdhary@samsung.com>
 <alpine.LNX.2.00.1412011529540.4225@localhost.lm.intel.com>
 <37D709DA9AEECD448AE8DD01BDD193F7ED8E2D@NTXBOIMBX02.micron.com>
Message-ID: <35e501d010ab$5c5068d0$14f13a70$@thebergstens.com>

Were it me, I'd start over.  Power cycle, use the VS tool, then use whatever
Linux-dist-standard GUI thingy you have to do a FILESYSTEM format and then a
mount on /dev/nvme0n1.  That ought to work.

Good luck.
Jim B.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Zakaria Abushima (zabushima)
Sent: Friday, December 5, 2014 8:41 AM
To: Keith Busch; Swati C
Cc: linux-nvme at lists.infradead.org
Subject: RE: [PATCH v2] nvme-user: Minor enhancement and fixes

Hi Keith and Swati,

I have used my vendor specific tool to create namespace and managed to
create it,

It doesn't appear in GUI as a file system where I can save things in but in
/dev/ it lists nvme0 and nvme0n1

So I thought I might need to format it ? then I have used your tool
nvme-format-ns and formatted the namespace ?

Nothing success and says icotl interrupted.

and then I thought that I might need to mount it ? I used linux built-in
mount function as following:- mount /dev/nvme0n1

Since then the nvme0 and nvme0n1 disappeared and when I call lspci -v I
noticed slight change, which is the " module driver in use nvme0" line has
disappeared ? when it use to appear ? 

Any idear or help

Thanks a in advance.

Zakaria.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: 01 December 2014 15:46
To: Swati C
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH v2] nvme-user: Minor enhancement and fixes

On Fri, 28 Nov 2014, Swati C wrote:
> Addressing comments from -
> [PATCH] nvme-user: Minor enhancement and fixes 
> (http://lists.infradead.org/pipermail/linux-nvme/2014-November/001214.
> html)
>
> Minor enhancements to nvme_format_ns.c
> 	- Make Metadata Settings a user settable value.
> 	- Support for Secure Erase Settings.
>
> Signed-off-by: Swati C <s.chawdhary at samsung.com>

Thanks, applied.

On a side note, some people asked if I could take the example programs here
and turn it into something more useful with just one program to run all nvme
instead of a bunch of stand-alone programs. I took a stab at it:

http://git.infradead.org/users/kbusch/linux-nvme-cli.git

It's still a work in progress, but just linking here in case others have
ideas or find it useful too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
