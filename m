Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1844C87FCC
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYdG/uECLIsbELjbV3B3O27SvBUZrxfluB7h9TXZK5c=; b=Ge6J1ARHGoiKLlY8QtmskAPMuT
	60yLGqY/u7fV7i1NHqL+SvqgdIzOpfzEQDAedKVIk+gU3U+45tSFlStPhe7hAngFngKVl8w4geCu8
	4nrOgYGaQOOBqdcWDb2+AVZH6516ZlDoyEIPCivb5+0yT09j9enOY3Weu7g1tjTWoQNKABoH3ueDE
	f7wFUZk2r0pupxJ1fy03D4rglWuPRZN8cbaOH5bGgKoLdHcZqKdVGEPl2Mi0sq/b8lQRoHEMsWu2B
	VGOtVIcPP4sWUHTGMFidwzhKhy5UiKWwg3d8vDXPiUUBMRN0nsW63UmmKC7z6NzWjAjw+TGIK65gJ
	JGQ6DWRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUPh-00000003rT2-3zDL;
	Thu, 31 Jul 2025 14:37:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhTxs-00000003mj4-2y1G
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 14:09:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AA3268CFE; Thu, 31 Jul 2025 16:08:48 +0200 (CEST)
Date: Thu, 31 Jul 2025 16:08:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: Re: [PATCH v2] nvme: Fix typos
Message-ID: <20250731140848.GA32550@lst.de>
References: <20250730204353.3383702-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730204353.3383702-1-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_070900_885925_EE0DB933 
X-CRM114-Status: UNSURE (   9.98  )
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

Thanks, I've added the patch and already sent it on to Jens with
the current nvme pull request.


