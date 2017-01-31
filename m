From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 31 Jan 2017 12:04:27 -0700
Subject: [PATCH 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <20170131185754.GA17684@kroah.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <20170131172630.GB12595@kroah.com>
 <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
 <20170131185754.GA17684@kroah.com>
Message-ID: <e4802fb9-2b24-0c12-ca02-d33bd3ccb5dc@deltatee.com>



On 31/01/17 11:57 AM, Greg Kroah-Hartman wrote:
> Sorry, it was probably me :)

Nope, it was Christoph Hellwig. I don't mind changing it. It's just hard
to know what's expected all the time.

> Why do you need this?  Wherever you put it, it should be built as part
> of the online kernel documentation.  Who is the audience for this
> documentation?

Well usually documenting how to use the device is a good thing. Is it
not? The audience would be people wanting to make use of the userspace
interface. Though in fairness, the vast majority of people should use
our library. I also thought it would be useful to reviewers to more
quickly understand the interface we are creating. If maintainers want us
to leave it out, we can, but that seems like an odd request.

> Do future stuff in the future, no need for that now, right?
> 
> Simple is best.

Ok, I can push it all into the C file for v2.

> I'll leave that up to the PCI maintainer, but just a single .c file in a
> subdir seems odd to me.

Thanks,

Logan
