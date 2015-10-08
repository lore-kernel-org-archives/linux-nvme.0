From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Oct 2015 00:46:16 -0700
Subject: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
In-Reply-To: <20151008011609.GA25163@wfg-t540p.sh.intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
Message-ID: <20151008074616.GA16089@infradead.org>

Hi Fengguang,

I think this proactive testing does a little more harm than good in
it's current form.  While offering testing for patches that aren't in
git trees and or by people that don't even have a git tree that the
build bots known about does seem useful, blindly doing it for every
patch against something that most likely isn't the right base seems
counter intertuitive.  We'll probaby need some annotation in the O/n
mail that asks for a test and sets a base tree to actually make it
useful.  With those few tweaks it should be really useful!

Maybe we should have a discussion about this at kernel summit?


On Thu, Oct 08, 2015@09:16:09AM +0800, Fengguang Wu wrote:
> And of course linux-kernel. More lists could be added in future.
> 
> Thanks,
> Fengguang
---end quoted text---
