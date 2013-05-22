From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Wed, 22 May 2013 21:12:24 +0000
Subject: [PATCH 2/2] Return the result from user admin command IOCTL
 even in case of failureX
In-Reply-To: <20130522202341.GX6057@linux.intel.com>
References: <E821E2F372F08945977BD15EAE588D61097C57F2@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.LRH.2.03.1303011459080.456@localhost.localdom>
 <20130522202341.GX6057@linux.intel.com>
Message-ID: <E821E2F372F08945977BD15EAE588D611A05DE48@MILMBXIP01.sdcorp.global.sandisk.com>

I am going to resubmit the patch today.

Thanks,
Chayan

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy at linux.intel.com]
> Sent: Wednesday, May 22, 2013 1:24 PM
> To: Keith Busch
> Cc: Chayan Biswas; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH 2/2] Return the result from user admin command IOCTL
> even in case of failureX
>
> On Fri, Mar 01, 2013@03:05:06PM -0700, Keith Busch wrote:
> > On Thu, 28 Feb 2013, Chayan Biswas wrote:
> > >-       if (!status && copy_to_user(&ucmd->result, &cmd.result,
> > >-
> sizeof(cmd.result)))
> > >+       if (copy_to_user(&ucmd->result, &cmd.result,
> sizeof(cmd.result)))
> > >               status = -EFAULT;
> >
> > I think you want to change this to a check for 'status >= 0' before
> > copying the result to the user since a status < 0 means the command was
> > not completed by the controller (successfully or otherwise) and you'd
> > be copying uninitialized data to the user in that case.
>
> Going back through my old patches ... Chayan, do you want to make the
> change Keith suggested and resubmit?  Or do you think he's wrong?


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
