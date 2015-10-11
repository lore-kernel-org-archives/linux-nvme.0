From: lkp@intel.com (Fengguang Wu)
Date: Sun, 11 Oct 2015 22:19:17 +0800
Subject: testing email patches
In-Reply-To: <20151008074616.GA16089@infradead.org>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
 <20151008074616.GA16089@infradead.org>
Message-ID: <20151011141917.GB17528@wfg-t540p.sh.intel.com>

Hi Christoph,

On Thu, Oct 08, 2015@12:46:16AM -0700, Christoph Hellwig wrote:
> Hi Fengguang,
> 
> I think this proactive testing does a little more harm than good in
> it's current form.  While offering testing for patches that aren't in
> git trees and or by people that don't even have a git tree that the
> build bots known about does seem useful, blindly doing it for every
> patch against something that most likely isn't the right base seems
> counter intertuitive.  We'll probaby need some annotation in the O/n
> mail that asks for a test and sets a base tree to actually make it
> useful.  With those few tweaks it should be really useful!
> 
> Maybe we should have a discussion about this at kernel summit?

Yes that may be a good topic for gathering feedbacks and ideas for
improving this useful but messy testing feature.

The best option could be to define a way to annotate the base tree's
branch/commit of a patchset and possibly automate the annotation in
the git/quilt email clients. Currently git does generate

        index c933675..a2aa0cd

for each diff files, however I find it far from enough -- there are
~50000 files in the kernel tree, knowing hash numbers for the typical
1-100 files a patchset may touch is pretty helpless in narrowing down
the search space of possible base trees.

It may also be useful to specify whether or not a patchset needs such
kind of testing. That'd be an easier task -- the robot can detect some
magic words in the email and take action accordingly. And it can auto
skip testing in some cases -- for example, Peter Zijlstra offered a
good point to skip testing patches without "Signed-off-by:" in a "Re:"
email. The patches already tested as git tree commits in the 500+ git
trees the 0day robot monitors will be auto skipped, too.

Also we could test against both mainline and linux-next -- an
excellent suggestion from Dan Carpenter, which is just implemented,
thanks!

Not knowing the exact base tree leads to inherent messiness, and the
possible solutions/workarounds are

1) annotations to tell the base tree (best option)
2) annotations & heuristics to skip tests
3) guess the suitable tree the maintainer would apply patches to
4) test on mainline & linux-next to filter out unstable build errors

(3) is kind of dirty work and enlightenments from subsystem
maintainers are highly welcome -- typically the suggestions can be
offered when you find a bug report to be unsuitable.

As for now I'm trying to teach 0day robot to apply patches to the
matching subsystem's "for-next" branch based on information in the
MAINTAINERS file. 

Thanks,
Fengguang

> On Thu, Oct 08, 2015@09:16:09AM +0800, Fengguang Wu wrote:
> > And of course linux-kernel. More lists could be added in future.
> > 
> > Thanks,
> > Fengguang
> ---end quoted text---
> _______________________________________________
> kbuild-all mailing list
> kbuild-all at lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
