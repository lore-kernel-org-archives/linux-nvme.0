Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1CBC10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQFmCHLMIgWVxB1HpQhajEmkkJLQvCYk4LOMMAE8EWQ=; b=yyt/owYksT9zOocJ9pzWeAFJtR
	6N10P1H2fZwSbSSw5MlWQE3eH2WsD+sMklgW1JuSNhTOZYkc6zvXr16QMfSZeQcH6NYqqqKaAzbKR
	s+xz0mWLBqVx8KzHfIHJJZJwcteii7OtvFZv0eFmw5paPElSh7dOsvf3eNAWPvQgzIFGcr5X48Odt
	URwfKaG6af3vQ1lWfXZRWoAs0brFeb/7XEAjZLEHEvLtlvUXkWVffNuNIV2ea3vkBnjD+ACowGZs5
	tSayAKJQrOi/cguwmbuFwK7eHtbzsNiQC3sqzFGTtP+x2WqK4yiIy0BaYPs7sZA2IIBUr8T0oYail
	gk3/HP1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3x8n-00000007Cl4-2g3N;
	Mon, 06 May 2024 12:08:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3x8i-00000007CjN-23vs
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 12:08:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EFA868AFE; Mon,  6 May 2024 14:08:09 +0200 (CEST)
Date: Mon, 6 May 2024 14:08:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: make nvmet_wq unbound
Message-ID: <20240506120808.GA30005@lst.de>
References: <20240505103951.52413-1-sagi@grimberg.me> <20240506053308.GA5030@lst.de> <d15da519-2c81-42bb-8f60-89da4650f7a9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15da519-2c81-42bb-8f60-89da4650f7a9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_050816_695177_E8CD91CF 
X-CRM114-Status: GOOD (  13.09  )
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

On Mon, May 06, 2024 at 10:50:02AM +0300, Sagi Grimberg wrote:
> It doesn't have any better justification. I never really saw any other 
> justification
> to add WQ_SYSFS to a (usually unbound) workqueue, than simply have 
> visibility
> or ability to control it.
>
> What makes you think this is not harmless and useful?

Because now we have to deal with users setting more or less insane
parameters on the workqueue.


