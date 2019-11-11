Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D23C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 16:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB0A20679
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eb5NPFue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB0A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sVELeprq/KdDbV0SfwFXgKM72cOF+D0gKuXa39n92b4=; b=Eb5NPFuerhibWP
	6JTSXl9GigY78QN31fipR8+Ax5fEajr3cOaOM3nqZcvhKVlqBBorBZDVgdjfOMQ1SZo3xdJJP24dL
	A7bmUdsbso/K1hGsXcUPWXHuq5ubff8lAXRUxOCyTXm06Jn4PXgaa4CXly8xDSDyZAGCcu/rskUKE
	6Xl0pQR2JIl/Syljy3aAmInd7blRsTT3o/mMgmNE/b3T+FoIvLZvbWQjtUCrdvUMPnn6lpqz848Gr
	YFdUOFLkKyHQyqTdRk+693d8kR012VO9ddS2fC38a5R/KELaAT0E8jQzXBUxEddoVIBJJscatPY1M
	bMBZy40ro//qUB3p/1eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUCwC-0002sD-5R; Mon, 11 Nov 2019 16:53:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUCw9-0002rm-6g
 for linux-nvme@lists.infradead.org; Mon, 11 Nov 2019 16:53:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6586568B05; Mon, 11 Nov 2019 17:53:06 +0100 (CET)
Date: Mon, 11 Nov 2019 17:53:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values
 for each sensor
Message-ID: <20191111165306.GA19814@lst.de>
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_085309_393727_55B31A0B 
X-CRM114-Status: UNSURE (   9.26  )
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 10, 2019 at 11:17:46PM +0900, Akinobu Mita wrote:
> +static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
> +				long *temp)
> +{
> +	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> +	int status;
> +	int ret;
> +
> +	if (under)
> +		threshold |= NVME_TEMP_THRESH_TYPE_UNDER;
> +
> +	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> +				&status);
> +	if (!ret)
> +		*temp = ((status & NVME_TEMP_THRESH_MASK) - 273) * 1000;
> +
> +	return ret <= 0 ? ret : -EIO;

This looks a little obsfucated.  aI'd prefer something like:

	if (ret > 0)
		return -EIO;
	if (ret < 0)
		return ret;
	*temp = ((status & NVME_TEMP_THRESH_MASK) - 273) * 1000;
	return 0;

> +	return ret <= 0 ? ret : -EIO;

Similarly here, something like:

	if (ret > 0)
		return -EIO;
	return ret;

> +		err = nvme_get_temp_thresh(data->ctrl, channel, false, val);
> +		if (err)
> +			*val = (data->ctrl->wctemp - 273) * 1000;

Can we have a helper for this (x - 273) * 1000 conversion?  It is
repeated quite a bit over the code in this file.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
