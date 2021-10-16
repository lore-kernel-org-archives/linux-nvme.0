Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44266C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 04:39:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFF161222
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 04:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAFF161222
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uoEOJozFMTwPfN3ROb2K+8+hoDUMk3oTYfjAP0RGx60=; b=OOL+KmvXE3FdaayXYhZS8hWEhy
	zFlMKMtXT2TMjQS5hr8lKSAm0WFhRLyXcMcoF135fhL8/bpCrqJdpmli37ikt6AQC149rjOXi6rgJ
	RshEuJBUXrHzVr7KM2czu8MHvI/BvpRf4R6+dbLV722sEm33ngzuLgevKfQW7DrUKF5FCgbwFfIXK
	X287hk/Abq890AHAcfFPa7G4b3Im6cC+6BaYOOkDnusQjTjhLUjpQ5neofwCtTbtjRqTgp+kDpsee
	Pu64giqEsBgg9ZJteNymIaOAXEVeIkfyzg6U4XN5aTmLUC+LzKWCRsTDSahLmXw898A9bxdptidfU
	B/nhsuGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbbTo-009jnh-0W; Sat, 16 Oct 2021 04:39:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbbTl-009jnA-8l
 for linux-nvme@lists.infradead.org; Sat, 16 Oct 2021 04:39:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BBF1E68BEB; Sat, 16 Oct 2021 06:39:26 +0200 (CEST)
Date: Sat, 16 Oct 2021 06:39:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCH] nvme: rename 'subtype' attribute to 'subsystype'
Message-ID: <20211016043926.GA27339@lst.de>
References: <20211014092734.138079-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014092734.138079-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_213929_475343_DEA48C55 
X-CRM114-Status: UNSURE (   7.71  )
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

folded into the original patch.

