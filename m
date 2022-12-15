Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5366AC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQ/eYZ6882Gk1ZdIwinew4uPUskAxjeG0smvjv7xve4=; b=u5J/GNoHrpZmvQo82pHdzyYy48
	iGge2Nrrl5qLnaxKcjfMMNvAJyRFKSKRCaGKc+SaCAsW9lG/1SnsGF9Hsmt/lNtnQAURsRXswe9zQ
	DZGxhongLtb6ib/vuQQfnaNjtJUXiupfaFsB6/9dXdI6YCnD+1L65jcHgHM+6gAjSELfRwa35fA5g
	GZr9dzJuWzawYYCvf/glBnuuOmeXKFnns/mjXzDV1nkLsi3ez324Ae0/cD8KNFPB8Pg5RPi0YvEbe
	i9cnX7FZxitZgU8R5WFeuUOTKduqA3RIx1pbcvaYWlD3W5D2HRpbsjkQqrMEoqqWd0LLPNoznk7fu
	VMkbfszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5jRz-007cB9-5C; Thu, 15 Dec 2022 08:18:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5jRv-007c6d-VT
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 08:18:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5EEEC68AA6; Thu, 15 Dec 2022 09:18:29 +0100 (CET)
Date: Thu, 15 Dec 2022 09:18:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: don't allow unprivileged passthrough of
 commands that have effects
Message-ID: <20221215081829.GA3816@lst.de>
References: <20221214161347.764071-1-hch@lst.de> <CGME20221214161926epcas5p49ec1cfa4cdc583b00bf6b8b066eb1964@epcas5p4.samsung.com> <20221214161347.764071-10-hch@lst.de> <20221215071405.GA27656@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215071405.GA27656@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_001840_196427_FCEDA219 
X-CRM114-Status: GOOD (  12.38  )
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

On Thu, Dec 15, 2022 at 12:44:05PM +0530, Kanchan Joshi wrote:
> So even for operation that do not alter anything (e.g. nvme_cmd_read)
> nvme_is_write will return false, but nvme_command_effects will return
> true and we will ask for FMODE_WRITE. Is that intentional?
>
> I think doing "nvme_command_effects(ctrl, ns, opcode) & 
> ~NVME_CMD_EFFECTS_CSUPP"
> is better to avoid that?

Take a look at patch 6.

