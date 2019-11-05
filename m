Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A37DC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:59:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B11217F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QrSPzYED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B11217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MxlYLpVbH6tY21evewRD5eGk84v0bKbZLVbiRhcFEoM=; b=QrSPzYED5Yh8Nm
	PzdbMYQ0pv1SvXDSZJVrKTcE40TZRAysn8LC4deQzwEXeaaYm81j8dyO0Iyb8/XP8lFg0yW5fpBHT
	VTD1oyKFammuXDhgmAMm7Ip6CS7ftZIevDvEUnHMNOHEueC1HVOthex6q4vCmfxk6UdbL0CIyAov3
	WYLzPq7qtEwJUoojB8hZU4dXPM+BaTmPWIDN8gsAx+lGAOwPp/dMCxevkfYbRaWpCtzEbePXjNHAK
	HkqUIqJQ/uoa5Hv01/kfPV1msBi46tJo/gq3pYiewbRLxttiLy5EMwNpYEf7RPBesZulq1DyK4LXD
	zcv4F4WUqtSaVQ2AvKLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS37G-0007TF-74; Tue, 05 Nov 2019 17:59:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS37D-0007Ss-Hy
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 17:59:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 97C4E68AFE; Tue,  5 Nov 2019 18:59:37 +0100 (CET)
Date: Tue, 5 Nov 2019 18:59:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 08/15] nvmet: Add metadata characteristics for a namespace
Message-ID: <20191105175937.GF18972@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-10-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105162026.183901-10-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_095939_743784_52BBD27E 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 05, 2019 at 06:20:19PM +0200, Max Gurtovoy wrote:
> +	ns->prot_type = 0;
> +	bi = bdev_get_integrity(ns->bdev);
> +	if (bi) {
> +		ns->ms = bi->tuple_size;
> +		if (bi->profile == &t10_pi_type1_crc) {
> +			ns->prot_type = NVME_NS_DPS_PI_TYPE1;
> +		} else if (bi->profile == &t10_pi_type3_crc) {
> +			ns->prot_type = NVME_NS_DPS_PI_TYPE3;
> +		} else {
> +			pr_err("block device %s: unsupported metadata type\n",
> +			       ns->device_path);
> +			return -EINVAL;
> +		}
> +	} else {
> +		ns->ms = 0;
> +	}

I don't think we should report these fields unless the transport
actually supports metadata and PI.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
