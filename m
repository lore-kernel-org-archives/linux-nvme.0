Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3079AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:13:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E197A61050
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E197A61050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fJ6VqF/PANQKPctLZPVEMI+xU2oLtkQDGHiytKVfBLA=; b=XTPL715SCcCavI
	tk4+5q2waW/nqLZsP/G3MJ24hwZoBm60b3dmRf31amnKAVhcmBJ7NXMEhxTjOihxjONk3jZvrU6Bv
	UDcFs4xJ4ZJQNo2l73TGcooLSpsTuu3nRueBxX9CCYooJgmw4UnI6xS0zYE8jfhakyCqdhAyHvsGx
	rMaqgfOkiYgv/HQ1WKLF0Brxr/FfT1qmt1nqqmZBAxqWeCGRXEFk3MpYp05HqQV7j1K30iR4kPwI8
	tHg2tODVpgFHB4Htqu6612ZyWl0Fz/BTsVkee0CQndFKXDwVWU2KHaDWv23YY2CP9OJo8oNjppzVG
	KK3bSU3vvPjAkwRiY9AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maHae-00CrDx-Tl; Tue, 12 Oct 2021 13:13:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maHab-00CrD2-Ib
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 13:13:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0171F67373; Tue, 12 Oct 2021 15:13:02 +0200 (CEST)
Date: Tue, 12 Oct 2021 15:13:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, chaitanyak@nvidia.com
Subject: Re: [PATCH 1/2] nvmet: use macro definition for setting nmic value
Message-ID: <20211012131302.GA11805@lst.de>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923101744.4204-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_061305_775118_D3E41B6E 
X-CRM114-Status: UNSURE (   7.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.16.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
