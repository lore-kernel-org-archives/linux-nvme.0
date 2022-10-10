Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B139CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQrbLXI+C5PxPpRTHu/QuKE1L6V6wD06mSYCJHIvy3U=; b=L0Y/cTgmBpiA68zhhU7mLl3603
	zh+JoxWBYypHNuSfUXVWGyC6EhNzJfY89fPI7Pa+HxSSNI9eWC7nP0icTwmhIx4s0PhzjhaVADyhE
	Nj3Rhpl5A8t3Pl99xM1DA81KFGw+guRyw7iXdBsYrxjwDXbUKnhdjC0f2Mg9ZWwEBDTdlG2GG4VQ4
	fd+hVAO1VvBGwz8/7Dx8knG6IbwciPChoA1xvDhXH8Usxl4OlmCcYqJSqHuahCd+qSEf+XRX5dJqu
	lLlCzc+SuDqUNXBerKuEJZlYyBzkw3SY94eNQtNZm++kTLwUaEKc5JLPYMkWYhWL/+PJCrJKZ7SQv
	W2LPJUOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoAW-0000uY-9B; Mon, 10 Oct 2022 08:29:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoAT-0000sl-El
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:29:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C02F768AA6; Mon, 10 Oct 2022 10:29:41 +0200 (CEST)
Date: Mon, 10 Oct 2022 10:29:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Jonathan Nicklin <jnicklin@blockbridge.com>
Subject: Re: [PATCH 1/2] nvme-tcp: fix possible hang caused during ctrl
 deletion
Message-ID: <20221010082941.GA24401@lst.de>
References: <20220928062326.45119-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928062326.45119-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_012945_650968_0FA263FA 
X-CRM114-Status: UNSURE (   9.45  )
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

Thanks, applied to nvme-6.1.

