Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03264E9A02C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSfN3079EmZ7CVKyj1oQtbEtdlDUlR/DZAlXym1FbBk=; b=3osMJ9ChgT/HHThbgspzWa3afO
	9787Z6LyJebFbGQHyAsdp+jCb3l/p1TnVWe9Fb6hcQ0nLoQ7C1Wzea+F9UyPdqfxnHrht508eUVmm
	hqh3pTKHIwM5yOGiP5DJ8KIygIUgVOu4F89iiIPOfHn0QV4BUBywQgJ4GijD0YvE7TTRIROHVu8q1
	h2JEoAtRbagGhMUOr7C3aODRJBAJKVHckN1CFyC5Cla3IhImyTzN7mOLG9xKLwG5HZWRVxzLrP1P8
	vYRwGmf3+pJ+L/ic1jnO09+FwRyhw9ojE++Jl6Tmt+Rb2J3Dkwud3gvVj2UvSWP+cFubVVk5TR3OX
	aQLxA0+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vslqj-0000000ACMZ-0osj;
	Wed, 18 Feb 2026 18:00:33 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vslqd-0000000ACLe-14lP
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 18:00:28 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1271257ae53so16148c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771437626; x=1772042426; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSfN3079EmZ7CVKyj1oQtbEtdlDUlR/DZAlXym1FbBk=;
        b=UYWDO55Ga+yagYFG7JSH0eNe9W/iBbrIRys1cnKUpHlaaum3sE/6HSuM9M1HiXqPlH
         IIUH4vTN9ampwUAPNGc7QS8W/btFdMny903na0/zc2elZOTdODdw6Z+LphUqpbse/zWY
         5OsoyTQwtgly9g6L3YcYbrEQVwVaa8dpIpLHIfsWKKr1e7OdgvaS0fH2Z1k9znQEyeFv
         Fm15RSvT5nxuP2a8VwjsCKAyG8W5KMpKMsfIytWMKBeA/K6+f2uzi8llqr4X0pI5eG2W
         s4hz1jje0NDKilXV0ZM8TOGj0KGvcAVdjJVd3pgNR4CEvv98VP2PGwHdMq6ySBhQjUMn
         snlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437626; x=1772042426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSfN3079EmZ7CVKyj1oQtbEtdlDUlR/DZAlXym1FbBk=;
        b=fRw2Dbfm7vMzcCU8kJiIlxmSz6Zme4HgFECnFXGXbo8dflJzzck5y50Agk3iD19j+X
         TiqgE2fsgldoomHkc5u88k2bNZqAFHFKurVqyeZhopBH4KlxM5GiXnXU/D66/I4yd9Zp
         sVtvXkLSppS/lomZ3xVDLH49sd0Q/LNSmT7DA3XLcs+F1YyG62EupKOOGKK7M9DmEwlZ
         m0pPDL+qLWTV2Q7n5IXkIECql7fyR0N3HheveHQy6pCZc8HvPy6A3zVMUvQoSMsgfMV4
         4+FfAfzFB4JAdlSY/I1i8QdBX+5NpCpfCHFE1v3txgviMRQfSm4VlyIX2JFAEmdPqY1z
         vo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+zz8bNryd/tueqHOPhNzxJYBmao9JBrhht+k9PQBGS274UHI2H6+K+UBO33tbuyM2itYE1zkJyIwp@lists.infradead.org
X-Gm-Message-State: AOJu0Yxrfy28coz5JVKVBdAQFFal+n/4NNW5JQjJJHNVFJOJpUd2oXTq
	c3NUDZTKaCjBTbaKDJfVkCcoIRfK2i3HTqcwTRnGhYEIcACtkV2ZW7bicNY5PtvVN1Q=
X-Gm-Gg: AZuq6aKE4w/ggjg+MEYSgylaLCxgZnGwky141BzMmLcfvt1ljvymKq8y1WHHsgbhnhh
	o07anKTSR7ZTaHZDzC+werW+o5jNYFG7LeS0Ow7nAZ5atZXQ9gSip0dQq67uRb5jWb80HLp1RkC
	i3MB1aHlD/VUSIgwGyAZdsfDPPX9v0nGKd8ZBlAciIgTiQOQUXeAdAw+QuYpQAE9FXbrRVxvS4K
	PCjBOSDaokJ4DZY7cPE8zLRMofVufThWXTIBR56rqoPFqkXiM6b677B0KVainQDSosatJFgnuCJ
	9diwlOwrvudDcv+MOVQ/VjfDNoIIu4equS5LDKUUuHmj66UfeO080KH2KztkwWMdsE907TSQkZz
	Ru0D25MAC+4XFkzdDtq+6JR1iwFzPgXY7L1l6vSKkK2GWjTF8V1Kbu/lKFxRH4fMxzOQ9ZTXUgQ
	s/pNhxOQUCLu9lPizP47cLyUmDy/o=
X-Received: by 2002:a05:7022:49c:b0:127:35af:143c with SMTP id a92af1059eb24-12759a75a8emr1104293c88.37.1771437625586;
        Wed, 18 Feb 2026 10:00:25 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb66addcsm19057912eec.24.2026.02.18.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:00:25 -0800 (PST)
Date: Wed, 18 Feb 2026 10:00:24 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin
 timeout per nvme controller
Message-ID: <20260218180024.GM2392949-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-3-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_100027_306526_C1498384 
X-CRM114-Status: GOOD (  18.62  )
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

On Thu 2026-02-12 13:09:48 +0100, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values
> on a per controller basis with nvme admin queues.
> Add an admin_timeout attribute to nvme so that different
> nvme controllers which may have different timeout
> requirements can have custom admin timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..149cd1ab3b3d 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -601,6 +601,36 @@ static ssize_t dctype_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(dctype);
>  
> +static ssize_t nvme_admin_timeout_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n",
> +				jiffies_to_msecs(ctrl->admin_q->rq_timeout));
> +}
> +
> +static ssize_t nvme_admin_timeout_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	u32 timeout;
> +	int err;
> +
> +	err = kstrtou32(buf, 10, &timeout);
> +	if (err || !timeout)
> +		return -EINVAL;
> +
> +	blk_queue_rq_timeout(ctrl->admin_q, msecs_to_jiffies(timeout));
> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_admin_timeout =  \
> +	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
> +	nvme_admin_timeout_show, nvme_admin_timeout_store);
> +

Do we want similar attribute to ctrl->fabrics_q?

>  #ifdef CONFIG_NVME_HOST_AUTH
>  static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -742,6 +772,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_kato.attr,
>  	&dev_attr_cntrltype.attr,
>  	&dev_attr_dctype.attr,
> +	&dev_attr_admin_timeout.attr,
>  #ifdef CONFIG_NVME_HOST_AUTH
>  	&dev_attr_dhchap_secret.attr,
>  	&dev_attr_dhchap_ctrl_secret.attr,
> -- 
> 2.53.0
> 
> 
> 

