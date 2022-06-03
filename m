Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EA3C43334
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jun 2022 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VC0LzuKJ5XQjIja3z3Yz8XpvcXzL31t7XXyftjJ1TEE=; b=GtydAIus3fBbPQJn5OtACbbTgG
	Tvv4Ijb5HKydKkbp9Ka/1bWExeZRPKUagcfMaK4dfvzrubUJx0hO+FNTn4CyRSXE4lcx3dAYwsIHh
	iPB5lUoJ28GKvtNTcDhHJnYPcw66GQGUACSwn1KKegXiV2lqJos/6GVme9Xdezs10v9ZsWVaI+izt
	NXppWFFNVHGaOY3+CikI7r7+lzsLgc5Jp060AO5ZoDuQ+tzTaa/XsqZ+Ol47AH/IgThYLuPSJwgp8
	31kGz418AsOp/Hjm/Tx5mmLFnVKAr5aB6T+WPUS0vVEVZeeZwEl538IlrEMxlf3zsD6HmH1Knw47i
	STt8AuaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nx5i3-007FoL-19; Fri, 03 Jun 2022 11:43:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nx5i0-007Fiy-EI
	for linux-nvme@lists.infradead.org; Fri, 03 Jun 2022 11:43:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9467568AFE; Fri,  3 Jun 2022 13:43:03 +0200 (CEST)
Date: Fri, 3 Jun 2022 13:43:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kamil Cukrowski <kamilcukrowski@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: bug report: one of /dev/nvme*n1 is not created on 5.18.1
 "globally duplicate IDs for nsid"
Message-ID: <20220603114303.GA14056@lst.de>
References: <c13a5461-72f2-5c94-4b4f-de71d98d1605@gmail.com> <4e9c21fd-7bcf-fe41-ee56-894369f34adc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9c21fd-7bcf-fe41-ee56-894369f34adc@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220603_044316_667673_EB95902A 
X-CRM114-Status: UNSURE (   8.83  )
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

Well, that commit just caught your disk ingoring the standard and
reporting non-unique identifiers, which are a big data loss risk.

Please send the output of lspci -nn so that we can add a quirk, and
please also contact the vendor to tell them that their device is broken
and/or leave a review to that affect on the website where you bought it
if possible.

