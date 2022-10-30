Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D402FA3742
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EPnA/hq2EBkoehhwQO0BFN5Ap7Flc7aM1N6yawhBN8=; b=WDFgDn0eEEgK8BoVw5VPWp4mK0
	ybHgt0J8M/CcPhpTw0U4nW4c3ucKa1/ANLgIroWKxpZz0q3/EvZK+v0xNM/kWV33Lvk5M0CrA0QN/
	hkjXB7U9Omq95BLkXlECgGIXoxl36nB2OlnoqHAJVOqSYzsPu7VTuaP/8oiS2D1AwuI8i9LGtNtTo
	2AVi+EOPEQkfyCLvW927Sjok0/DzW2U1uyGTSd5Kv1OTqFqOznbL+BX5KjDabJjVj/UB57YhgVA3F
	CFTxKQAKcJEKDlrtERdeknMA0DEULJS7iZhPCXoJvq7YW4liK3QJE90iivUI+i61Ei/a1nZlRJSEi
	p0eTjgwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3ZX-00E8fl-QH; Sun, 30 Oct 2022 08:21:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3ZV-00E8eO-0D
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:21:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52D9768AA6; Sun, 30 Oct 2022 09:21:30 +0100 (CET)
Date: Sun, 30 Oct 2022 09:21:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jinlong Chen <nickyc975@zju.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 3/3] block: hide back blk_freeze_queue_start
 and export its blk-mq alias
Message-ID: <20221030082130.GA4930@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn> <20221030074010.GD4131@lst.de> <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_012133_209438_DC64DCBE 
X-CRM114-Status: GOOD (  11.04  )
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

On Sun, Oct 30, 2022 at 04:19:49PM +0800, Jinlong Chen wrote:
> I agree that the freezing stuff (maybe also the quiescing stuff) should
> move out of the mq namespace. If now is not the proper time, I'll leave
> them alone. I'll resend patch 1 alone without the comment.

The quiesce actually is entirely blk-mq specific, which just have some
careless callers.

