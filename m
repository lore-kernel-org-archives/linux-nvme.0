Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A07C48BCD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C955C613B9
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C955C613B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hOUVh/p/SRbMuzZS06xfLFImBDMRMcdZGFxTctKVcFM=; b=rBUxdwokVD4aBw
	MfDRsEqfRv8cMr6A+GX9Lh+4q/OptbXufyrQgkaOmCY02Co+GBALnKNQxlFN7HSg5Lg2ZDbZgMw4h
	dlyNJp4FvqTiDpIN2y3PI1ODdW/uJ/FkywPHTUVuXAPKrkK9P0sU3+aGoy02Kwl9C5PkvJjX9VY7m
	KAhSFWTpqFJFpiXzkOZ3Y512crW5eyIX59theRPg/7TipdXVF3tEwMP4y38p3qRAj6CsGnGm7cOwK
	Hn4tu8Beydz22y/RdIkUyVQ2ggGUTEt7gyrWDjOIOIo3NAnNOMU1Za0VUXxkdyl5JT/9gUnDK5vE7
	UI6VlTTAP+/RQYpl9dBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqyDl-00Dzd2-PS; Wed, 09 Jun 2021 13:26:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqxoF-00DsC5-KO
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 12:59:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B24C668AFE; Wed,  9 Jun 2021 14:59:48 +0200 (CEST)
Date: Wed, 9 Jun 2021 14:59:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH RESEND 1/2] nvme-fc: add a helper to check ctrl sgl support
Message-ID: <20210609125948.GB1837@lst.de>
References: <20210608191037.44251-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608191037.44251-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_055951_862951_64550C4F 
X-CRM114-Status: GOOD (  11.36  )
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

On Tue, Jun 08, 2021 at 12:10:36PM -0700, Chaitanya Kulkarni wrote:
> +static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
> +{
> +	if (!(ctrl->sgls & ((1 << 0) | (1 << 1))))
> +		return true;
> +
> +	return false;
> +}

Please move this into a separate patch as it isn't FC-related.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
