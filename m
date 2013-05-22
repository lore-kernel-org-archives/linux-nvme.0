From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 22 May 2013 16:23:41 -0400
Subject: [PATCH 2/2] Return the result from user admin command IOCTL even
 in case of failureX
In-Reply-To: <alpine.LRH.2.03.1303011459080.456@localhost.localdom>
References: <E821E2F372F08945977BD15EAE588D61097C57F2@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.LRH.2.03.1303011459080.456@localhost.localdom>
Message-ID: <20130522202341.GX6057@linux.intel.com>

On Fri, Mar 01, 2013@03:05:06PM -0700, Keith Busch wrote:
> On Thu, 28 Feb 2013, Chayan Biswas wrote:
> >-       if (!status && copy_to_user(&ucmd->result, &cmd.result,
> >-                                                       sizeof(cmd.result)))
> >+       if (copy_to_user(&ucmd->result, &cmd.result, sizeof(cmd.result)))
> >               status = -EFAULT;
> 
> I think you want to change this to a check for 'status >= 0' before
> copying the result to the user since a status < 0 means the command was
> not completed by the controller (successfully or otherwise) and you'd
> be copying uninitialized data to the user in that case.

Going back through my old patches ... Chayan, do you want to make the
change Keith suggested and resubmit?  Or do you think he's wrong?
