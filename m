From: learner.study@gmail.com (Learner Study)
Date: Thu, 24 Apr 2014 10:03:30 -0700
Subject: Cmd - comp write
In-Reply-To: <20140424135805.GA5886@linux.intel.com>
References: <7212DDF9-6821-4D7E-BD4D-655031AD03F7@gmail.com>
 <20140424135805.GA5886@linux.intel.com>
Message-ID: <CAP8+hKW_GcTMv=ifM_D5ifhnV5cRo8dba3Uc4KzYHDtvXvxpWA@mail.gmail.com>

Thanks. So its not really used to optimize SSD write operation
per-se...correct? Its only used for locking purpose mainly. I'm not
too familiar with the upper application layers...is "locking" a very
common operation used in storage work? I would think so - for eg. to
coordinate writes to namespaces and its accesses, this could be
used...is that understanding correct?

Thanks!
PS: Apologize if this is not the right forum, but would appreciate any
insights from experts..

On Thu, Apr 24, 2014@6:58 AM, Matthew Wilcox <willy@linux.intel.com> wrote:
> On Wed, Apr 23, 2014@08:37:39PM -0700, Learner wrote:
>> Hello
>>
>> How frequently is Fused command - compare-write used?
>> Is it for avoiding writes for SSDs if thee is no change? Ie read and compare the block to be written and don't write if there is no change..
>
> Compare-and-Write is a building block for an (unspecified, advisory)
> locking protocol.  If two entities wish to gain exclusive access to a
> range of LBAs, they can agree on a block to use as their lock, and agree
> on a bit-pattern to be found in that block to indicate 'unlocked'.
>
> If anyone is using it, they're doing so through ioctls; there's no way
> to submit a BIO that maps to a compare-and-write.
