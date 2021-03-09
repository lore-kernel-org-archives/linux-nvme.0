Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAA4C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:09:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9D865238
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9D865238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MoIfjGhBA7Hg3IjwGnJ01B/UOAeuJcyGnoBGX0/GRHU=; b=jA1JSX82AufvS965LaUneoBMC
	64X0rIjr0S6Dzte+af5UU4UJg9wI9suOBY371qwWhdZ384qQuvCj7hx2hpAb/SFdHwHAxr3ISf6jp
	d55nCS40Sjl0EO30KdQfhfH5Na/6OSg1Fbeq0qys4Wfb+CsD6lk2GDPNJjY4JAClx/JC/eCGTOr2I
	Tfs35MKPy7McSSlC05IcnHbIfvTawTPkmXS03I3hSWLzz3LxhQqoDnUr01RTV3r7UNL0UD0nbfWvZ
	7q6sh+FjU79mwSzqGA1mBlhJ79kmiNYxCohihjIUywCBHT/NgGcLAHVu0YPJ4u7nX65CCML2PqnD+
	hlM+Zf5pQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZIr-004B3W-Pw; Tue, 09 Mar 2021 10:09:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZIl-004B39-NW
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 10:09:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C288B68B02; Tue,  9 Mar 2021 11:09:18 +0100 (CET)
Date: Tue, 9 Mar 2021 11:09:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 james.smart@broadcom.com, sagi@grimberg.me
Subject: Re: [PATCH V2 2/8] nvme-core: split init identify into helper
Message-ID: <20210309100918.GB7372@lst.de>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
 <20210301020611.18669-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210301020611.18669-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_100919_986915_68E4E100 
X-CRM114-Status: GOOD (  12.74  )
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

I've applied this as-is for now, but here is something that I think we
should fix up:

>  	if (ctrl->apst_enabled && !prev_apst_enabled)
>  		dev_pm_qos_expose_latency_tolerance(ctrl->device);
>  	else if (!ctrl->apst_enabled && prev_apst_enabled)
>  		dev_pm_qos_hide_latency_tolerance(ctrl->device);

I don't think this belongs into init_identify, as it has nothing to do
with the identify data.

> +	ret = nvme_init_identify(ctrl);
> +	if (ret)
> +		return ret;
> +
>  	ret = nvme_configure_apst(ctrl);
>  	if (ret < 0)
>  		return ret;

OTOH it would make a whole lot sense in nvme_configure_apst.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
