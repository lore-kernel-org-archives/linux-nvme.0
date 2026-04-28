Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598C3FF886D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQbRomZKqoJTdTsalGJa/J/YyLVCrNRan//PMV7Z2cw=; b=rdpl5/z93cjGgDiiysTbJ6omFB
	h+he6OsWoeBd10cIEXDATpsZtNnKmWZ58oRRKN7vDso5uIRc8DEBUs/aZ9LsFODY4x1JQnAloa7dE
	eAiY8pd1bpALDeIHA9FazZhqRoIo6pd1pfG9nOCCwCh8RgzqpYbhgs8eB8A4bCJY+29XTJUGGCtfx
	EDt8gm3WnlZ/OyxXsNASXeCEopSjIObDNykDH8J5taAawplzyNhX/HaSoKapTlxSWP7kx3BznAo21
	LbwxiQctiZOgta/Qce+rsfLIqjOtmTfQJKaSLRtbvCgTK9sQVRB4UmHoVUZLgYsTbiWnMB7K+MvlV
	Bih7VD1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHm9Z-000000020w4-0xZj;
	Tue, 28 Apr 2026 17:23:21 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHm9V-000000020vX-3XvH
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 17:23:19 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso10405712a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2026 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777396996; x=1778001796; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQbRomZKqoJTdTsalGJa/J/YyLVCrNRan//PMV7Z2cw=;
        b=DTljKpKHBkJAbfaRmGmUdQgAUfLBcdcZKb4clmOmH5j0gEL3VPyyUNkg1rukEhlCKX
         ysjPao7SCgxbF1UMZvWEoAAEuZoxJp8n6vgJ21ybetVdHSQcuDZgKokGXfNSI05MOsCY
         HIYo5/+0SgTBFfNRlSdYMq3xEoXA7/KGftXL9F7xsQEJGge4iY0yagfFdUMe+WG5kHSL
         IBdRtIi3U4I/ZaT3FZ+NOYwU55rZM2hiygvxmGXAXvAJn7h73+eg2171eUqrW2aTxnOO
         r+JCJPyYxFRHNjHu3EHG7hyKrkWJB+rbLDK8Eauc+DrXH5e6rkNDQDJAnNjiF70HHR3S
         Ww1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396996; x=1778001796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQbRomZKqoJTdTsalGJa/J/YyLVCrNRan//PMV7Z2cw=;
        b=IQusm9XqUmh6BsuZyzgDbD1ojWmhbjO2wN5kD8pXUVSF6tZnpKdQHsdzdi6a+xh+z+
         DxUGNHwPGGFLZhSx8BHwI0U9SByBH+T5WbJWVkbT1ZleTHgaUZ82gZj5BLa9wjK51wLo
         tyGa8/xaX8SaYGxKALlsz3u0ok2onCXdEUqD9V8TpNm8Z/Wjo3Tb4ZqGOtF7ctNtBe2k
         P3WCyokRrxgP4531/d06hL8r29cu0wTRlx0j7P7vtYii/XVAd/q/NbiEYUeaba0SbvQ9
         0KOSLcXrLYG8bqI+FiDNQ9u3dDMOLMp53jSBG/QekikzVsD6o6PXnL29OXd5qCWjVqzb
         mwFA==
X-Forwarded-Encrypted: i=1; AFNElJ8CRCQD6IJ/oArivhKvmnMeuFXwwJ9Ih63GYFH+SfwrwXEqJrA403naZ0pQll7ASAFXKViKqTuwB2Iq@lists.infradead.org
X-Gm-Message-State: AOJu0Yycl7KuO+daJKb507a0FjppHcHrqabN7JM8+TNclrgkFga7ng50
	IQY4bO6Jrbirbevhvimkw1uCecMvyjoG8jrkJpgspcFVRAm2ILF7gpQRXGF8XStH3HQw1RsDS/M
	/pLps
X-Gm-Gg: AeBDiesBMPjlvXTLKcrX02OyEAsSKikflSzXu6P/RFgzwaBjEQ+M8Y88RP2fo8FCQ34
	39/Ga2KP8Szxy2mDygHCuD1BMtSD7cJyBKXDUcdloKOwMCHbnnPpU9WwP2R8dD6/CDgbfuYrlgB
	6Kk9H4sUkDxUK85wQAX/UEGpQJl1CSn086RvQ9fAtd+Y2o1Rkcnk+7rX6O7M2t1eJcNgG7GCeZ8
	vtLff3aHR/aE4FxqCqeVhwhR+2mObmOmCQnxcm82GukNPKjiOB/qMqXJRVOhGj2grlpQ+PkUrGs
	qhWlQcywgebRcXE01JPwA9/xx2s1fojc1XHBnhrEtJFUYLdTmjFDFViy530Cl6wgccGPu+0xCq6
	nTcCVO+Lxp+NT+sWZK2PposmWRXumEpig2yg42sspLw82CLUlTwCdddiZPBfw8uWmVf/vUMDLu9
	2Ebi7fFCd1ZWn3P7jiJbU9eWJfJYR3DFTXGZHG/qxWuohjGy11tSOYu6M=
X-Received: by 2002:a17:90b:3510:b0:35f:b5df:463 with SMTP id 98e67ed59e1d1-364920a5111mr4098526a91.14.1777396995926;
        Tue, 28 Apr 2026 10:23:15 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-364a018187esm220173a91.8.2026.04.28.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:23:15 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:23:10 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, chaitanyak@nvidia.com,
	hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <20260428172310.GE2686-mkhalfella@purestorage.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-5-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_102317_928484_F6FEE497 
X-CRM114-Status: GOOD (  18.27  )
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

On Fri 2026-04-10 09:39:20 +0200, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values on a
> per controller basis with nvme I/O queues.
> Add an io_timeout attribute to nvme so that different nvme controllers
> which may have different timeout requirements can have custom
> I/O timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 000c29bd1f1f..1e6a0eecb30e 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -664,6 +664,52 @@ static ssize_t nvme_admin_timeout_store(struct device *dev,
>  static DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR,
>  	nvme_admin_timeout_show, nvme_admin_timeout_store);
>  
> +static ssize_t nvme_io_timeout_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(ctrl->io_timeout));
> +}
> +
> +static ssize_t nvme_io_timeout_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvme_ns *ns;
> +	u32 timeout;
> +	int err;
> +
> +	/*
> +	 * Wait until the controller reaches the LIVE state
> +	 * to be sure that connect_q is properly initialized.
> +	 */
> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
> +		return -EBUSY;
> +
> +	err = kstrtou32(buf, 10, &timeout);
> +	if (err || !timeout)
> +		return -EINVAL;
> +
> +	/* Take the namespaces_lock to avoid racing against nvme_alloc_ns() */
> +	mutex_lock(&ctrl->namespaces_lock);
> +
> +	ctrl->io_timeout = msecs_to_jiffies(timeout);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
> +
> +	if (ctrl->connect_q)
> +		blk_queue_rq_timeout(ctrl->connect_q, ctrl->io_timeout);
> +
> +	mutex_unlock(&ctrl->namespaces_lock);

ctrl->namespaces_lock is not needed to set timeout for ctrl->connect_q.
Maybe move mutex_unlock() up just after iterating on namespaces?

