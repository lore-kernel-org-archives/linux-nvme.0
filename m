From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 21 Feb 2017 11:37:53 -0700
Subject: [PATCH] switchtec: cleanup cdev init
In-Reply-To: <2cd5df88-c018-3e76-fd08-483fec374932@deltatee.com>
References: <20170210145124.GA24594@kroah.com>
 <1486749440-24309-1-git-send-email-logang@deltatee.com>
 <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
 <CAA9_cmfbJEPhCj_Ukav841zW5P=uYkTir4jFRTKyOvzHmJNmVg@mail.gmail.com>
 <2cd5df88-c018-3e76-fd08-483fec374932@deltatee.com>
Message-ID: <20170221183753.GB13138@obsidianresearch.com>

On Sun, Feb 19, 2017@09:22:35PM -0700, Logan Gunthorpe wrote:

> Really, in any situation where there's a cdev and a device in the same
> structure, the life cycles of the two become linked but their reference
> counts are not and that is the problem here.

Yes, the cdev must hold a kref on the containing struct otherwise
userspace can trigger a use after free. This cannot be fixed with an
approach inside the open/release function either as the cdev core code
itself relies on the memory to exist.

I've suggested something like this before:

https://lkml.org/lkml/2015/7/8/1066

So I hope this will make it in, it is a step in the right direction.

If it does, would you make another patch to go further? I think
cdev_init should take enough arguments to hold the enclosing kref, API
wise there should be no API to init a cdev without the caller
specifying the enclosing struct's kref. That is the only way we will
stamp this bug-class out.

Eg look at kernel/time/posix-clock.c, it is wrong in the same way as
well - the kref_put in posix_clock_release is not enough to make it
work, clk->cdev is referenced after posix_clock_release returns by the
cdev core so this has a use-after-free.

Jason
