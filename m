Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD94C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 05:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qQHwKiGMT38Q3X0R5RDhdq4t7FgY0sGXl64Sqvj3Yo0=; b=r/VJEmMXksgxJVfKy07k7Qkwg9
	gv94GLt4hSK5qcxjMYnE8rhph5NE0nq1z3UF9xlIpdBOtdV4EE0T6ZdscXHWZodDCDFwZrOhhiCun
	HMJ15lxZQuBtyH34OF0YwIPgJ932GIrRP6hyYL+cQkGCMspuIsFgTVPYZ6ZVl39LrOCgwT/piMuqR
	e7KeybVr27UBRS9igmJW9zCskPLfkmVL67eASj25km+124WPz/j448aBFAOh+U1OIEbxXL4mTHyF1
	LTP5T4Ku6h3R+8XE9fKUnmJ9bbKPSkM7yJS17LFV4Z3nAZuBOh1MZq9D2s1J/VQlN8cli0X8MmqKR
	ni5qq0SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4ok-0000000E5eY-1kDS;
	Wed, 14 May 2025 05:38:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4oh-0000000E5du-0eJX
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 05:38:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAB5F68AA6; Wed, 14 May 2025 07:38:02 +0200 (CEST)
Date: Wed, 14 May 2025 07:38:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: ilya guterman <amfernusus@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 025e:f1ac
Message-ID: <20250514053802.GA24939@lst.de>
References: <20250510102130.14710-1-amfernusus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510102130.14710-1-amfernusus@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_223807_330079_F334CB43 
X-CRM114-Status: GOOD (  11.60  )
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

On Sat, May 10, 2025 at 07:21:30PM +0900, ilya guterman wrote:
> From: Ilya Guterman <amfernusus@gmail.com>
> 
> This commit adds NVME_QUIRK_NO_DEEPEST_PS for
> device [126f:2262], which belongs to device SOLIDIGM P44 Pro SSDPFKKW020X7
> 
> The device frequently have trouble exiting the deepest power state (5),
> resulting in the entire disk unresponsive.

Does this happen in more than one host system?


