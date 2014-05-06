From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Tue, 6 May 2014 15:29:05 +0000
Subject: [PATCHv2] NVMe: Use last bytes of f/w rev SCSI Inquiry
In-Reply-To: <1398808347-9839-1-git-send-email-keith.busch@intel.com>
References: <1398808347-9839-1-git-send-email-keith.busch@intel.com>
Message-ID: <1399390114.4085.1.camel@omniknight.lm.intel.com>

On Tue, 2014-04-29@15:52 -0600, Keith Busch wrote:
> After skipping right-padded spaces, use the last four bytes of the
> firmware revision when reporting the Inquiry Product Revision. These
> are generally more indicative to what is running.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

Looks good!

Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>
