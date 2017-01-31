From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 31 Jan 2017 19:57:54 +0100
Subject: [PATCH 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <20170131172630.GB12595@kroah.com>
 <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
Message-ID: <20170131185754.GA17684@kroah.com>

On Tue, Jan 31, 2017@10:35:44AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 31/01/17 10:26 AM, Greg Kroah-Hartman wrote:
> > That's one big patch to review, would you want to do that?
> 
> Sorry, will do.
> 
> > Can you break it up into smaller parts?  At least put the documentation
> > separately, right?
> 
> Ha, funny. Last time I sent a patch someone asked for the documentation
> to be in the same patch. But I can easily split this up.

Sorry, it was probably me :)

> > And don't dump a .txt file into Documentation/ anymore, people are
> > working to move to the newer format.
> 
> Fair. I wasn't sure where a good place to put it was. Any suggestions?

Why do you need this?  Wherever you put it, it should be built as part
of the online kernel documentation.  Who is the audience for this
documentation?

> > Also, please rebase against Linus's tree at the least, we can't go back
> > in time and apply this to the 4.9 kernel tree.
> 
> Will do.
> 
> > Why a .h file for a single .c file?
> 
> I wanted to keep the hardware defining structs and macros in a separate
> file for future expansion. This hardware is also capable of some NTB
> functions which may find it's way into the kernel in the future.

Do future stuff in the future, no need for that now, right?

Simple is best.

> > Also, why a whole new directory?
> 
> We didn't feel it fit in the pci director which was for standard pci
> stuff. We're more than open to other suggestions as to where this code
> belongs.

I'll leave that up to the PCI maintainer, but just a single .c file in a
subdir seems odd to me.

thanks,

greg k-h
