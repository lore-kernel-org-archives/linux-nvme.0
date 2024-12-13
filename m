Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA06E7717F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQxvmEUgXrwAKMWrAonApaB7y5BQSPsVlUDftZx2Owk=; b=nbbNn/lAbN2bZ+cR3bNWxOCVfH
	1z3AK7YQ/CqehnTqAFkTJ/8o3cX3eodV/+j1jXEm32EnSASZX0sfOgpRaThTs0x6kKLPC1Xsg6KT3
	VOWA/JfRcW63EV/r6ojAU1CcZYjvPeLAZlpN3CW9/gc2Y3aZLF5Q0xlHQCJtvFvREP6OWfrnWFV2g
	33V5x53S2CYjoivdSjzC2xJ81lwFcooSkKGz/VUQfxRy9xOf0LEUhnIwm0GJ0NXoNbdBgAe5aYkl2
	caJELCzcsoH8olGEMe+3nevJrs9X6bPmvW1+VlC/xICYeGBXPS3vpjKNBXtuxv/0YwNJmpVKJDO3p
	rHQDEbrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMEqS-00000005Fzo-2Mp1;
	Fri, 13 Dec 2024 23:13:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMEqP-00000005Fyw-3JtS
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 23:13:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DAF22A42DDA;
	Fri, 13 Dec 2024 23:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B7C4CED0;
	Fri, 13 Dec 2024 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734131592;
	bh=JQxvmEUgXrwAKMWrAonApaB7y5BQSPsVlUDftZx2Owk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ihrum0oKrzBW9qhSPPgoEYoAoVyktdOQ2rIfa3KLB2Vd/a4tYnUt2SsKoiJvEPHMt
	 9pMGYDnfX92jmmaIXMEJ8VWHVGLT5RAAmEBZZwl6ghGwjK1lDqKw2ER7kUpBfxHiRC
	 Z+WT8JkEeXreNS+qdvs5ZhrXuXGQCVLv0uM104UG8ryGnE6ZL1Yp2G6sHzq2R7gct8
	 RJy4el0Rvp53gZ21vAcPT2VOaR6rZVuxxUNcqNOhUlNguMEq/kjxfY6b6OWcZfRP9c
	 QLuzIXc6XgE7KZJefVvTdJV42vjbLf91pgCvbj9sw4+FpFNRMT4OWmDF0VDJJ2Uvbj
	 m0NyOWvZARsbA==
Date: Fri, 13 Dec 2024 15:13:11 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH] nvmet: propagate npwg and awupf topology
Message-ID: <Z1y_h9GacN9YDXat@bombadil.infradead.org>
References: <20241212033148.4008110-1-mcgrof@kernel.org>
 <20241212055250.GA4825@lst.de>
 <280f8dec-f202-4004-86e8-d3165bf02047@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280f8dec-f202-4004-86e8-d3165bf02047@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_151313_888609_C0B060C1 
X-CRM114-Status: UNSURE (   6.25  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2024 at 11:25:29AM +0000, John Garry wrote:
> I still need to check them ...

We can punt atomics later then.

 Luis

