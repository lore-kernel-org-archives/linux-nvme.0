Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD689C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:10:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5A824670
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpFhyDIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5A824670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=roERJI3nwKpKLf4uUD6nfpkww+wxwbJ2aHVRJkBWM64=; b=MpFhyDIUeT1GOY
	de9ktzka8uD+k6yS52TwKJKl7DgTe2n6K6m8EUH8PLgZ1VVvJXWm3vx2O8C6gZ40p/Y7kldKm+aYo
	H47CO2Sv/MenSzfpJN+UzXapLxtrjRetTuKrLMcNd51VMNf2JiqPY8UayvQa4ZgsZIWDoZaGlTldV
	WH8lws0/eEGI4SPyiGtOkR93u/D/ra7Fho+JNgjID/krZ9K/USwAMWga400w9xs40VZOrW53MYhyp
	Wa+IN3My+DwCOIn3zTUFDrW1KJN3M21yVnWXqVcnKD/jTWbw8lFzUdEwx4+Yvi0ijZOsnRoIw5svL
	1DIobNbLIEgTQflu60rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Qzg-0008VX-Mr; Wed, 19 Feb 2020 15:10:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Qzd-0008V6-8c
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 15:10:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 681E068B20; Wed, 19 Feb 2020 16:10:27 +0100 (CET)
Date: Wed, 19 Feb 2020 16:10:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/2] nvme: expose hostid via sysfs for fabrics
 controllers
Message-ID: <20200219151027.GH17748@lst.de>
References: <20200208011354.20889-1-sagi@grimberg.me>
 <20200208011354.20889-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200208011354.20889-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_071029_460432_C20A0BE9 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 07, 2020 at 05:13:54PM -0800, Sagi Grimberg wrote:
> @@ -3293,6 +3304,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>  		return 0;
>  	if (a == &dev_attr_hostnqn.attr && (!ctrl->opts))
>  		return 0;
> +	if (a == &dev_attr_hostid.attr && (!ctrl->opts))
> +		return 0;

No need for the braces either.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
