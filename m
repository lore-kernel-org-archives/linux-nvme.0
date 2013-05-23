From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 23 May 2013 13:36:40 -0400
Subject: [PATCH v2] Return the result from user admin command IOCTL even
 in case of failure
In-Reply-To: <E821E2F372F08945977BD15EAE588D611A05EE87@MILMBXIP01.sdcorp.global.sandisk.com>
References: <E821E2F372F08945977BD15EAE588D611A05EE87@MILMBXIP01.sdcorp.global.sandisk.com>
Message-ID: <20130523173640.GY6057@linux.intel.com>

On Wed, May 22, 2013@10:34:49PM +0000, Chayan Biswas wrote:
> -       if (!status && copy_to_user(&ucmd->result, &cmd.result,
> +       if ((status >= 0) && copy_to_user(&ucmd->result, &cmd.result,

I just tried to apply this and the patch is corrupted.  It looks like your
mailer has changed the tabs to spaces.  This seems to be an unfortunately
common problem with Outlook / Exchange.  Since this one's a one-liner,
I'll fix it up by hand, but for larger patches, can you use a different
mailer?
