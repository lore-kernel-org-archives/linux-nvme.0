Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EDFC83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 07:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=DVNfkCmyODaH9ObpodBcKnJhhJ
	kCIh5JbczOi9UXbfcbq2C2G74rZ9cgB/tOoAKlSd5wKb5unVi+Q8PYKz8fkVJOCODtCb90L5KQeZz
	UfzrUTA1B9++MG6WU5MA0YbBRvGx/4TihYhUlDl7eog3k4OAOCbS6xF1hBUtsmaNqsz8UJnd+FNFk
	55/56Z+JY+XPLGgG5yEgK9aJ//DJ9oesskCQZcPc/fQ4U4U8zR3mmimG49gZ2IC2N/0rk8hkwhtCe
	/OpIGM8n6ObLWTJi9d5Evcie18MMEPrpTtpG/C2dK5NlUyVWEVB8D1stm8QQw2Ja65ISVFczTQ86v
	dqplg79Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaSJ-00000004P7Q-21Fb;
	Tue, 15 Jul 2025 07:52:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaPy-00000004Ok5-0AGO
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 07:49:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0D5968AA6; Tue, 15 Jul 2025 09:49:32 +0200 (CEST)
Date: Tue, 15 Jul 2025 09:49:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	lengchao@huawei.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH] nvme: fix misaccounting of nvme-mpath inflight IO
Message-ID: <20250715074932.GA20468@lst.de>
References: <20250715012812.1135331-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012812.1135331-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_004938_217505_CC4702C6 
X-CRM114-Status: UNSURE (   7.99  )
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

applied to nvme-6.16.


