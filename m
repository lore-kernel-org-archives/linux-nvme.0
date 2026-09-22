Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CACC982FF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6udlaVha/mEfMWD3+/SNvpOjIVH8c/UGyrEsbyGN8w=; b=qkjwAZeJWX6VeHQbh3Rb4dJhSU
	dbqOWgC+dvS524pehakposGBpm3Uz1d9vVHNo3fAhi0arcldmRSIzILeP4BvqNm8YLw9Rek0ZDbhi
	6ERbR8L0gn4QLg/Uchx1C9umlz0e1NnhkcpID1SXeBv9SgmbnG/qTkktpOUsIUbp2jgmMtscGEa5w
	md0sDGn5bLUEIgrXZSeBVgz8307TESjNKaZkYAsEvL/lfRvhxXlQTWpLNM6nHeaD2M2s+IqLwYS4n
	uNCwgt3yyUD81qPmrj1uJz29Kz10zPImPNVsTviKbiuQq9Nd+200di3fJ8jL5S1EaU8dobGqablo3
	GSQDeERA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90ZC-00000005WsW-152r;
	Tue, 22 Sep 2026 13:29:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90ZA-00000005Wrl-0qOd
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:29:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 717B468BFE; Tue, 22 Sep 2026 15:29:44 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:29:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 3/3] nvmet: avoid recursive configfs open for
 passthru
Message-ID: <20260922132944.GC31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-4-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921090559.41364-4-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_062948_385553_9C8272A8 
X-CRM114-Status: GOOD (  10.62  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Didn't you also have patches for drivers/target/ that should use
the new helper?

