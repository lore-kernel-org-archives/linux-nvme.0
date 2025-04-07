Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349E6C369A3
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VekJvv91Xn89OqaaPJht/UZYhCwaukglsApzU0pAbcQ=; b=XJalHzeV3zIlCJ9XGnm1rFa7Cm
	ZN3S5r21crGvTqtyR/DCVmlUnQv/lhyzFY8yQQZw56GzgzCKPDJa23rRz2eQW6NxGchfi4nv7h2U5
	4FxY+aPRxBJrX3zg8xTedbLNwJzr5ymTQowN4i+A6Hu3u+pXmeeXoNLlIKijwTVd/UgchVo5lATZS
	jukA3DuNJ31wdMOmYI7joVPEgBBftcCeVoFfxj0nrM4TX1+ThpTUbI+PxdjaLpZKPl1h/uL9YnefA
	IBxTdoYh7GXkvu5EmrkYUQaCw51o0neRX6QHIfr2hNBMO0rmHdNYs4cGBeYaVmvUn/ehQrEhKwv6C
	tez5Kwhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pKP-00000001BJp-0RuR;
	Mon, 07 Apr 2025 16:28:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nWZ-00000000kHl-2N4C
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:32:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57BBD68AFE; Mon,  7 Apr 2025 16:32:27 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:32:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvme: missed AENs during scanning
Message-ID: <20250407143226.GA12066@lst.de>
References: <20250403071930.52154-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403071930.52154-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_073231_740301_953E4AF4 
X-CRM114-Status: UNSURE (   8.89  )
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

Thanks, I've applied this to nvme-6.15 with minor edits to the commit
messages, mostly base on what Keith suggested.


