Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F23C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AMiodWnV+q9FbUvDamuRdgF+gV
	9L+iv+HeeOyOfwm1hulOhvUFiQ3sa2P4D4YQqzEgTmbe2EV1+K6sgjJodfOJrd1NUHjhNmSsOEcZc
	YwaDw6u1EItHJLwu7IdLZVuUxN84b1ddnpkRVvOdZzp7uZH+Q+bTEhb2MpDrq1UxhnbhQoynm8weT
	RDRfTXrEyerWZG2CcXOhGXMCpNM8GEgjpVcqb4nzeu97qMOD5n69uMv8P4dKQ7Dp/tUQHPp9bcnVL
	L7gSHiqn9QDrZxgi3BfaquLqbfZ+j2KPxVM1npTmaXAtfoTe51NuID2genSqVkK1DpNOJIQB49Pkd
	t9QqfHWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TDN-00000006vsI-20Q2;
	Wed, 09 Apr 2025 11:03:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2T8b-00000006v9M-3MBq
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:58:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BE7968C4E; Wed,  9 Apr 2025 12:58:29 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:58:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] nvmet-fcloop: swap list_add_tail arguments
Message-ID: <20250409105828.GA5785@lst.de>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org> <20250408-nvmet-fcloop-part-one-v1-1-382ec97ab7eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-1-382ec97ab7eb@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_035833_978038_ADC4C180 
X-CRM114-Status: GOOD (  10.58  )
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


