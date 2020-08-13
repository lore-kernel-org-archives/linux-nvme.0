Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D4CC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 11:02:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7D420885
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 11:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KR3iVwFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7D420885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VAhWOWxBeWfKDz7IyxRXy3jvl61YCbjf6vkbiqHYp0g=; b=KR3iVwFPAl+g6Ad8W3uCd/1v4
	R0gWv/hYFe71y8sw408D0ylDNljLzhEJcEpY5yZT00EPZEYT27M3qcH4B5wloOgtCHXrMj+p9Z5M5
	iF76wYad4wOqhYC7b0ISCvnLIks2B0U2I/Lb8zLkd0ij+K7KpbqG2oKldB+h2VXEIRMt2CrBAiavu
	ps8i03/Hoo8aLkXHbcuUsUOHBptXBCCvS/cS+4t1plwVTFRPeDNrVl+EvjYndOp8HmMvecGlsFyGc
	SfnX98seLtqAUC2by6KFMtuqeWtyYBoF8Q45QKmdC/kc3s2PGdfZ/x0FHw/yAsVYfwgLBO1sDN7yy
	sMEx9qtUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6B0W-0008QJ-1l; Thu, 13 Aug 2020 11:02:52 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6B0S-0008Oj-Q7
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 11:02:50 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 9BF02BCB56C4161DE76E;
 Thu, 13 Aug 2020 12:02:34 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.159) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 13 Aug
 2020 12:02:34 +0100
Subject: nvme crash - Re: linux-next: Tree for Aug 13
To: linux-nvme <linux-nvme@lists.infradead.org>
References: <20200813165846.27887669@canb.auug.org.au>
From: John Garry <john.garry@huawei.com>
Message-ID: <454c65b1-872a-a48c-662d-690044662772@huawei.com>
Date: Thu, 13 Aug 2020 12:00:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200813165846.27887669@canb.auug.org.au>
Content-Language: en-US
X-Originating-IP: [10.210.169.159]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_070248_959951_0A1EBC7E 
X-CRM114-Status: GOOD (  27.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 13/08/2020 07:58, Stephen Rothwell wrote:
> Hi all,

Hi guys,

I have experienced this this crash below on linux-next for the last few 
days on my arm64 system. Linus' master branch today also has it.

root@ubuntu:/home/john# insmod nvme.ko
[148.254564] nvme 0000:81:00.0: Adding to iommu group 21
[148.260973] nvme nvme0: pci function 0000:81:00.0
root@ubuntu:/home/john# [148.272996] Unable to handle kernel NULL 
pointer dereference at virtual address 0000000000000010
[148.281784] Mem abort info:
[148.284584] ESR = 0x96000004
[148.287641] EC = 0x25: DABT (current EL), IL = 32 bits
[148.292950] SET = 0, FnV = 0
[148.295998] EA = 0, S1PTW = 0
[148.299126] Data abort info:
[148.302003] ISV = 0, ISS = 0x00000004
[148.305832] CM = 0, WnR = 0
[148.308794] user pgtable: 4k pages, 48-bit VAs, pgdp=00000a27bf3c9000
[148.315229] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
[148.322016] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[148.327577] Modules linked in: nvme nvme_core
[148.331927] CPU: 56 PID: 256 Comm: kworker/u195:0 Not tainted 
5.8.0-next-20200812 #27
[148.339744] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 
- V1.16.01 03/15/2019
[148.348260] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[148.353822] pstate: 80c00009 (Nzcv daif +PAN +UAO BTYPE=--)
[148.359390] pc : __sg_alloc_table_from_pages+0xec/0x238
[148.364604] lr : __sg_alloc_table_from_pages+0xc8/0x238
[148.369815] sp : ffff800013ccbad0
[148.373116] x29: ffff800013ccbad0 x28: ffff0a27b3d380a8
[148.378417] x27: 0000000000000000 x26: 0000000000002dc2
[148.383718] x25: 0000000000000dc0 x24: 0000000000000000
[148.389019] x23: 0000000000000000 x22: ffff800013ccbbe8
[148.394320] x21: 0000000000000010 x20: 0000000000000000
[148.399621] x19: 00000000fffff000 x18: ffffffffffffffff
[148.404922] x17: 00000000000000c0 x16: fffffe289eaf6380
[148.410223] x15: ffff800011b59948 x14: ffff002bc8fe98f8
[148.415523] x13: ff00000000000000 x12: ffff8000114ca000
[148.420824] x11: 0000000000000000 x10: ffffffffffffffff
[148.426124] x9 : ffffffffffffffc0 x8 : ffff0a27b5f9b6a0
[148.431425] x7 : 0000000000000000 x6 : 0000000000000001
[148.436726] x5 : ffff0a27b5f9b680 x4 : 0000000000000000
[148.442027] x3 : ffff0a27b5f9b680 x2 : 0000000000000000
[148.447328] x1 : 0000000000000001 x0 : 0000000000000000
[148.452629] Call trace:
[148.455065]__sg_alloc_table_from_pages+0xec/0x238
[148.459931]sg_alloc_table_from_pages+0x18/0x28
[148.464541]iommu_dma_alloc+0x474/0x678
[148.468455]dma_alloc_attrs+0xd8/0xf0
[148.472193]nvme_alloc_queue+0x114/0x160 [nvme]
[148.476798]nvme_reset_work+0xb34/0x14b4 [nvme]
[148.481407]process_one_work+0x1e8/0x360
[148.485405]worker_thread+0x44/0x478
[148.489055]kthread+0x150/0x158
[148.492273]ret_from_fork+0x10/0x34
[148.495838] Code: f94002c3 6b01017f 540007c2 11000486 (f8645aa5)
[148.501921] ---[ end trace 89bb2b72d59bf925 ]---

Anything to worry about? I guess not since we're in the merge window, 
but mentioning just in case ...

Thanks,
john

> 
> News: The merge window has opened, so please do not add any v5.10
> related material to your linux-next included branches until after the
> merge window closes again.
> 
> Changes since 20200812:
> 
> My fixes tree contains:
> 
>    73c7adb54169 ("device_cgroup: Fix RCU list debugging warning")
> 
> Linus' tree produces a WARNING in my qemu testing (see
> https://lore.kernel.org/lkml/20200813164654.061dbbd3@canb.auug.org.au/).
> 
> Non-merge commits (relative to Linus' tree): 946
>   1083 files changed, 28405 insertions(+), 9953 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig and htmldocs. And finally, a simple boot test
> of the powerpc pseries_le_defconfig kernel in qemu (with and without
> kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 327 trees (counting Linus' and 85 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
