Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D786DC83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBKOdxW28jmuDVPViy2Scq83g0cvOJ2w8ggLjiNpmFA=; b=0zR8WvI28caWbp1++I+vSPQkQJ
	Q/+tt3EYKONPeWoWWGuxqQY/GGZq6o7X1UshCywqWgG6IVCzpMl3lRNNAN3HKea6WC0mDt2cFVjL1
	MitimFN0pl5ClfHD64W/n8GQGgAzSZ+91H02aF8sZiy1+MMTxwd8NQQhB4I3UzkqzYUm/Y5i8rOj4
	SKNeEyw1WSL1etq6/cs9y2KF2bmINyQZXU/ymJWasBAV+AybIOzWKy7KmGoTiA+0kmbB9voAVaCkq
	2WY7uhlyhL1diwvkRuKM6XU8nS8zS69J/RHHQB3TgIvJ+AsX4VJrMcCJq5eAkIl+dZ4tKoUcPRfkx
	hezhunPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6Ui-00000001QWJ-1xlP;
	Tue, 22 Jul 2025 06:28:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6Ug-00000001QV2-0jgm
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 06:28:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0586768BFE; Tue, 22 Jul 2025 08:28:49 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:28:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 1/2] nvme: add capability to connect to an
 administrative controller
Message-ID: <20250722062849.GB15013@lst.de>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com> <20250721173700.4153098-2-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721173700.4153098-2-kamaljit.singh1@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_232854_347438_9070182A 
X-CRM114-Status: UNSURE (   8.12  )
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

added to nvme-6.17.


