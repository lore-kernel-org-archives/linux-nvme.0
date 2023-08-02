Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1599C001DF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Aug 2023 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WW89qBsenix3hMNy6AhdkpCD+couddHWqEREz1jnueo=; b=23vi162XrHkLKj5DFcBD4T6DsJ
	Aso5QWa2Aspx4EvfejLzrSdDZ4VFwD5J5cAbcX0XOaAdzlwVTmMR7dRzHZubBm7sjuvHl6t5uTzja
	pwvIYcrmH9W0RM+ZUXOPoZ8is7TCPvad68TorED0tKtSDq/MLQump1rF7OlDxuWoqsfWP0254lodh
	1UBPcEJMBiyQEqZ7kpou1KBBTY1OshjFUZEh2/d2zI6QEYChASf7x94E+1ek59achSJrgVfP60N0g
	aYdxifaxOX1LWVqklHVBbaFHx4YuG6BzjXWPp0E/nvyVCVYci4gVbHaKYBPaQ6fREa8epwaFecakd
	MnEJvmdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAYG-004rOb-2D;
	Wed, 02 Aug 2023 12:02:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAYE-004rO3-1E
	for linux-nvme@lists.infradead.org;
	Wed, 02 Aug 2023 12:02:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0124F68AA6; Wed,  2 Aug 2023 14:01:59 +0200 (CEST)
Date: Wed, 2 Aug 2023 14:01:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, alan.adamson@oracle.com
Subject: Re: [PATCH V6 1/1] nvme: allow passthru cmd error logging
Message-ID: <20230802120158.GA30301@lst.de>
References: <20230629011713.28554-1-kch@nvidia.com> <20230629011713.28554-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629011713.28554-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_050202_585634_EBD43202 
X-CRM114-Status: GOOD (  12.61  )
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

> +
> +	if (ctrl->passthru_log_err)
> +		return sysfs_emit(buf, "on\n");
> +
> +	return sysfs_emit(buf, "off\n");

	return  sysfs_emit(buf, ctrl->passthru_log_err ? "on" : "off");

> +}
> +
> +static ssize_t nvme_passthru_err_log_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int passthru_enable, err;
> +
> +	err = kstrtoint(buf, 10, &passthru_enable);
> +	if (err)
> +		return -EINVAL;
> +
> +	switch (passthru_enable) {
> +	case true:
> +	case false:
> +		ctrl->passthru_log_err = passthru_enable;
> +		break;
> +	default:
> +		pr_err("invlid value %d for admin error logging [on:1 off:0]\n",
> +			passthru_enable);
> +		break;
> +	}
> +	return count;

This should use kstrtobool.

Also I thik the flag feels a bit too sparse.  Why not
something like passthru_err_log_enabled that explains what it does?

