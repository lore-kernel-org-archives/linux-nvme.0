Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CFCA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 14:13:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1421E20874
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LPNjvJ2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1421E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7wiMm1C77eyLYT0DPPEnlnFXwvG6MXP3KQpvixJCF5g=; b=LPNjvJ2gIYJqwX
	K3n2znzuuBJUxs1fnBcA1z/PyUy9BCXKJE/BNDpO2j+0fgfch8x/pxOLN0D746nt23O1NzUnisf89
	z+V0ePjy1OhKMUgr0pxDzHhtHz8HjGhhe0Dao0uCdEB5Fiqez6uIES6S44YyfWU9U5RZvvkovVlUA
	5VoPxadsoT2HN/ZglO929T/8anj4RkkGNXjdo4GgcCn+2qssbE/UiYATtRlZKqZg+VyRYh2ilmMgh
	hkRwx2kNXn4DZvP+vyDa79QMA/4XYNR8VVMqcICPiRv3FHQflSKm3YV1jqe03KzZFpIIqgD6CTzSH
	uViFdeq4buUcn6EA42DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPoib-0007Xr-MC; Wed, 30 Oct 2019 14:13:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPoiZ-0007X1-2w
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 14:13:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 35A1568B05; Wed, 30 Oct 2019 15:12:56 +0100 (CET)
Date: Wed, 30 Oct 2019 15:12:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191030141256.GB14252@lst.de>
References: <20191029223214.18889-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191029223214.18889-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_071259_274456_2DD7E920 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 29, 2019 at 03:32:14PM -0700, Guenter Roeck wrote:
> This patch adds support to read NVME temperatures from the kernel using the
> hwmon API and adds temperature zones for NVME drives. The thermal subsystem
> can use this information to set thermal policies, and userspace can access
> it using libsensors and/or the "sensors" command.

Except in all upper case or all lower case identifier the speling should
always be "NVMe".  Thi also happens a few more places like in the Kconfig
text.

> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> +{
> +	return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			    &data->log, sizeof(data->log), 0);
> +}
> +
> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct nvme_hwmon_data *data = dev_get_drvdata(dev);
> +	struct nvme_smart_log *log = &data->log;
> +	int err;
> +	int temp;
> +
> +	err = nvme_hwmon_get_smart_log(data);
> +	if (err)
> +		return err < 0 ? err : -EPROTO;

I think the handling of positive errnos fits better into
nvme_hwmon_get_smart_log.  Also EIO sounds like a better error for
generic NVMe level errors.

> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		*val = (data->ctrl->wctemp - 273) * 1000;
> +		break;
> +	case hwmon_temp_crit:
> +		*val = (data->ctrl->cctemp - 273) * 1000;
> +		break;
> +	case hwmon_temp_input:
> +		if (!channel)
> +			temp = le16_to_cpup((__le16 *)log->temperature);

This needs to use get_unaligned_le16, otherwise you'll run into problems
on architectures that don't support unaligned loads.

> +static const struct hwmon_ops nvme_hwmon_ops = {
> +	.is_visible = nvme_hwmon_is_visible,
> +	.read = nvme_hwmon_read,
> +	.read_string = nvme_hwmon_read_string,
> +};
> +
> +static const struct hwmon_chip_info nvme_hwmon_chip_info = {
> +	.ops = &nvme_hwmon_ops,
> +	.info = nvme_hwmon_info,
> +};

Please use tabs to align all the = in an ops structure.

> +#if IS_ENABLED(CONFIG_NVME_HWMON)

No real need to use IS_ENABLED here, a plain ifdef should do it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
