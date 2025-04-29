Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A2BC3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZjMxrhZX3PqZC48WDq0iIbfVoV5QzA01VRsQ1C30T8=; b=luT4aJ2Cm2LyMs1ZFaEyzYMdm5
	BdkcV6wXWh3KQ7w5jsdYaguE6b89ZalhrDZQ6u65W/Fm1P5cFrBXd26lzS7pz7DMeZKbJT3vKHyUV
	9m1DJTuXxW3ZOr/nrMVq68RsSQWFfUVhnPJs+wHo++zbC8IxhNxAcynz2hWdKx33VK0J38CKBe7xo
	UCBelUdm8X9AaCeY1ktFIqoTuX6cAmLN9kibQK+iDc0khiUGWyP076miJOmj6AqaYQEOXtSDSHBaV
	/9cYGjCnTn4+GfUMCzeyymOYiUk5AaDIttMS/nse8tBGceCFWjqBKfcF0O8m8M6+rMzuQ3oaFmgmV
	cHHB1Acw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9mh1-0000000A4vT-1067;
	Tue, 29 Apr 2025 15:16:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kip-00000009juo-416C
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 13:10:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A172668AA6; Tue, 29 Apr 2025 15:10:00 +0200 (CEST)
Date: Tue, 29 Apr 2025 15:10:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	linux-kernel@vger.kernel.org, hedgehog-002@163.com,
	rugk+github@posteo.de, sean.anderson@linux.dev,
	wangyuli@uniontech.com, zhanjun@uniontech.com,
	niecheng1@uniontech.com, wentaoguan@vip.qq.com
Subject: Re: [PATCH] drivers/nvme: Add quirks for WDC Blue SN550 15b7:5009
Message-ID: <20250429131000.GC13970@lst.de>
References: <20250424024010.308175-1-guanwentao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424024010.308175-1-guanwentao@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_061004_129321_214258F5 
X-CRM114-Status: UNSURE (   7.37  )
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

Thanks,

added to nvme-6.15.


