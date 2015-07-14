From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 14 Jul 2015 11:25:49 -0700
Subject: Partitions and end-to-end protection
In-Reply-To: <20150714181511.GA3779@infradead.org>
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org>
 <CAA9_cmfqrFKeaxhBynXTdAogSqLVKw8=mFmmqKKaxSQSj6tCAg@mail.gmail.com>
 <20150714181511.GA3779@infradead.org>
Message-ID: <CAPcyv4h1oFNDQogWW7RwxvkQCeCf-q0-jGds3e1=o-vC6_bj-w@mail.gmail.com>

On Tue, Jul 14, 2015@11:15 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jul 14, 2015@11:13:18AM -0700, Dan Williams wrote:
>> We got bit by this in the nvdimm enabling as well, it is mostly hidden
>> by the fact that sd triggers revalidate_disk() by default.
>
> But that's just revalidate_disk, which shouldn't be require but isn't
> too mad.  blkdev_reread_part and the setup work for it is a totally
> different league.

Agreed, something is wrong if we need to do bdget() in the driver.
