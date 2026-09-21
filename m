Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9DBC982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ka8UYFubLO+5sv72IXG5mLm8Ypn9O0Je7nBCz/yK93I=; b=jkSdRERFEvOgFnPA0Ftl4+bAIJ
	j5il8RHbRKz/qwLz0Px4Mc2L9+3mal7hhPP84VU3O6rtIBgsjQfrDd0mMPFufZ23Bv+lKSKYod8hY
	C+XLngeaW6+jVyNCvpPPaJLrzvnf2s1FeVBkaSV3YrYhipEEFw+99Ciu7vhQPqCGzifKsuEtlV6Qv
	aX/hQk4uFAO1f05gew3PEv9GUhBUDEePpHZ6DyeYmnB7+wmwR20sP2GMlm0DX1XMLx205cpvzYf93
	O6WZ41rYboC0JWevQlqSQnOZgAgSLX/6sCDssIWEc8GMVvwIcAJ+FUAWHwio6R/IKoNIa/D4FBoWu
	nbtVgkVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZNK-00000001LGk-39DT;
	Mon, 21 Sep 2026 08:27:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZNH-00000001LG0-1bKR
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:27:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6308568B05; Mon, 21 Sep 2026 10:27:37 +0200 (CEST)
Date: Mon, 21 Sep 2026 10:27:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260921082736.GA20060@lst.de>
References: <20260902103202.GB8095@lst.de> <20260910045400.1201582-1-runyu.xiao@seu.edu.cn> <20260910045400.1201582-3-runyu.xiao@seu.edu.cn> <20260910052604.GC27133@lst.de> <20260921081745.15699-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921081745.15699-1-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_012743_567422_C16D2A76 
X-CRM114-Status: UNSURE (   9.74  )
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

On Mon, Sep 21, 2026 at 04:17:45PM +0800, Runyu Xiao wrote:
> I will send v4 in this thread.

Please always send new version in separate threads.


