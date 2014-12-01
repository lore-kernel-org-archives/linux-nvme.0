From: keith.busch@intel.com (Keith Busch)
Date: Mon, 1 Dec 2014 15:45:58 +0000 (UTC)
Subject: [PATCH v2] nvme-user: Minor enhancement and fixes
In-Reply-To: <1417182636-2990-1-git-send-email-s.chawdhary@samsung.com>
References: <1417182636-2990-1-git-send-email-s.chawdhary@samsung.com>
Message-ID: <alpine.LNX.2.00.1412011529540.4225@localhost.lm.intel.com>

On Fri, 28 Nov 2014, Swati C wrote:
> Addressing comments from -
> [PATCH] nvme-user: Minor enhancement and fixes
> (http://lists.infradead.org/pipermail/linux-nvme/2014-November/001214.html)
>
> Minor enhancements to nvme_format_ns.c
> 	- Make Metadata Settings a user settable value.
> 	- Support for Secure Erase Settings.
>
> Signed-off-by: Swati C <s.chawdhary at samsung.com>

Thanks, applied.

On a side note, some people asked if I could take the example programs
here and turn it into something more useful with just one program to
run all nvme instead of a bunch of stand-alone programs. I took a stab
at it:

http://git.infradead.org/users/kbusch/linux-nvme-cli.git

It's still a work in progress, but just linking here in case others
have ideas or find it useful too.
