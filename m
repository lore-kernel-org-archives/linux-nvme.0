From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 19 Feb 2017 13:43:23 -0800
Subject: [PATCH] switchtec: cleanup cdev init
In-Reply-To: <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
References: <20170210145124.GA24594@kroah.com>
 <1486749440-24309-1-git-send-email-logang@deltatee.com>
 <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
Message-ID: <CAA9_cmfbJEPhCj_Ukav841zW5P=uYkTir4jFRTKyOvzHmJNmVg@mail.gmail.com>

On Sat, Feb 18, 2017@12:22 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hi,
>
> Please don't apply this patch and instead apply the switchtec driver as
> we submitted in v2. As per the discussion in [1], not using the cdev's
> kobj parent results in incorrect reference counting and a possible use
> of the cdev after its containing structure is freed.

Is this race present for all file operations? I've only seen it with
mmap() and late faults. So if these other drivers do not support mmap
it's not clear they can trigger the failure.
