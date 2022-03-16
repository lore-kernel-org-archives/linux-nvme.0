Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33268C43219
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c1VpxAD5BxQ4g5Y2hByq3usXGP0zPuhZODbqSyYNEzk=; b=2rIme6qLYo8fBhgPUhA/NxJEOs
	YC6kux4pppiG3CEUtA5XioE91b/uqcNersN5skZhM2ntM/Ey3Ot/wObDFCQWehJyxbQFLXycPKjZi
	lILg5j727YJ9aHyHwukTbtRw0PHO9+54g0842wSXJZMLTMPetL7HtSc3z8wUVP05D54gK3S1e07dr
	WF0Qq4FZGmxOSXV3knFdLutgouexudFPReNrKw6S7RiQWVhqkxjeY5NeW1jIRHKzCYfg8vp8b6fuI
	BGZXEQeYoi450qD7kc8pIv6AxTusfEJEur/Yh12UfVQ0rvkmFBf+K+s7SIGc0gCkOXg6AbS3P6j2a
	q85sdDAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUVL2-00DSAc-Uz; Wed, 16 Mar 2022 15:13:25 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUVJm-00DRfx-QM
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 15:12:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6CA60B81BFD;
 Wed, 16 Mar 2022 15:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8899C340E9;
 Wed, 16 Mar 2022 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647443524;
 bh=c1VpxAD5BxQ4g5Y2hByq3usXGP0zPuhZODbqSyYNEzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aM0hylhT7WQCfDcsMI58i1fDRDM7qIwe5T5xHTJemYIl+ZKeiFVLcDinSMvcHeBiI
 hQdHk8eX8M0LpZpSvCGwaOvoS2exkB28LOJXGNI1jHVfTRM4AoQJ5RItvqF3H8RLll
 dn7N2Tv/dZ3saqPfleEG9wYEEnPXst/sEJ3hNMPlNWF1oMl/W10ABi7fqPedYv8lDt
 pRYt4Fj99PMnBNEKzsLYFqGa6sK1ruIyvgJCrpVAHRB+TaApgWoUNftxjfYj4G9zrY
 JAyvIQM2JADzguceirGuPoLYo1OwBUAD9/z1nNAEvQs3INF7bVIpWr7o/ta+RZh3sg
 bX1LuISGuV2yg==
Date: Wed, 16 Mar 2022 09:12:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: warn about shared namespaces without
 CONFIG_NVME_MULTIPATH
Message-ID: <YjH+QnUZCDtM/iq9@C02CK6Q3MD6M>
References: <20220315145141.2586124-1-hch@lst.de>
 <YjCvfMplVsxKk3yd@C02CK6Q3MD6M> <20220315154043.GA15386@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315154043.GA15386@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_081207_040565_D6088F92 
X-CRM114-Status: UNSURE (   8.11  )
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

BTW, I don't think the legacy multipath should be supported going forward, so
I'm okay with deprecating it:

Acked-by: Keith Busch <kbusch@kernel.org>

