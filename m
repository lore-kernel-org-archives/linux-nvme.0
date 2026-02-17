Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC62CE9A03B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWbt3NBDeDF8pubBSHIXkgWJUeNO3GyIrjyfIcixYl4=; b=dICUqsYyRGmnSadKzcswZ6ePSK
	EW63Fv3VnUB+7gTeyVHKvIaKv+ubMvGtnoUgfuH8ZXIbVBrjTFN+MnYcGU+l+o1kYPIT3jS3D1dLe
	SBiVythuCCh/3YHmq+n5gJOpZ3ME9Qu7xwzOYwkoirFxWi3PY7YU/RyQGLSb8VWYYQ+DtmNOik8FW
	KVbNtjA2ejzqp4j+pZlQW/Na72nOktAIvhbhQxnb55SK4mXAIEm+7j9F+zgGAV3UMav4BrG8Z6WsA
	7nGpC8l9oiWjnAMazFgRXV9knrCNmv7pIr3vPeOrgQjxeg+xQi3Har+GlGBnGYkaB2k5skpSNEWwc
	koBQobVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRVK-00000008qVP-09y0;
	Tue, 17 Feb 2026 20:17:06 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRVI-00000008qUz-0e9K
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 20:17:05 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-12721cd256bso5678276c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 12:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771359423; x=1771964223; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWbt3NBDeDF8pubBSHIXkgWJUeNO3GyIrjyfIcixYl4=;
        b=GWchqDSRXPiS+KqkyCgGJ5plBbT+bH9dk+JJnhB7t7KHUmslnfyHX8lxHj1xVvMzFF
         GeSo7mbKXEBUS7po5KUQRtTpiX+X+R63IsMonSNAqWanQuVKw0MCL3kCA+TIA53Qv0w6
         n83q0RY2XyyouGs5tqINnZpB1DdQPtvZf7bp254IQ1cGtfJ4kgP6qRt8obnJi5XH1dD6
         W1219KcZ9RCNRYfHNgOTTCMnE53krSia0xM1UpLrxYaJxgR8dSg1vMtAIH98wCsupa6R
         Y9iagerKSu7WlFAmG15C8TJN+LllvvNgcg206KNvB4DAQNHqtWxwjBl6B6zAVjqz/AMi
         x1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359423; x=1771964223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWbt3NBDeDF8pubBSHIXkgWJUeNO3GyIrjyfIcixYl4=;
        b=myY6di0bSyo7Fhpx1i61MS4FfYFbulMFgP+wBy3A29L0Z4PwoOIAUEAsMnl5rKpIjM
         r5zUg505CzFctuoyAW/xYtXs0tuOLAmonrqvV8zVR6CvNYtuAr1+hMQBvxW/ClD27J2y
         Tgk92tM9k3ZD7Idvbb83iwvO1WY+RGJ4K7FHBKZTKCnNeIJLCk8Mt4SpthN9iMrLzNBF
         /vfVSiQSZTnKbERlo5fF/nK9KTYswmfUNDxV3lI6YFaueflHwPIFsH38uMTXBECMyvxC
         f8KbqKueBSZNqMzkkoDlXQfvOJqNpQVyu/7WwQAeJJWwJ7tFEAEydFDsTiwB3T6h7yxT
         9j+A==
X-Forwarded-Encrypted: i=1; AJvYcCWgq3ZBoDYdH70w8QhWpicqPaBd74PAv+L5pL9iGTs6iBBFwr8Sg2FsTTKlsmXtEZpVF56YBF3MKhqL@lists.infradead.org
X-Gm-Message-State: AOJu0YwIVeUSsmo7bO4V9SrPkVZRjLzJqjqdwPDrWZoaVR3c+gfeVQtE
	EHZXpN9SiVtwTb4TsojEFaZ44cKCIhO28umS8hmwk2rhJMYalgDJLL9rhFle9LADz78=
X-Gm-Gg: AZuq6aIH67Qt24didlBaHy9WFlAHBkloObm8UiGulxDf07ZfwGfo1l9l4rm5Ykab56n
	iHoTQRhKtHwRcreI6v6Q8PVqZ2Uyz1gaQyqR9CGMDNNt7H0TWyjj7bcb4uBmXM+iLc2eIUfRX7/
	xXE4+u+5Dl3W7zgnhNdLiYR/qZi1HhH/Sx0nIhX4411rtIXBa/8UHIfEMWO2Dy/oBDP+ZOI+ZF0
	nzXXJtnSByK9UiqTUi8soF3c8+nHeLOHxlz1ZHxHA0Fy4w0PeobXFCJmz3LEi7yd0yeaLsFKB5Q
	VOypmSZGKbIKpRYAv9u0P8Ez+8sBJ8D+SIiRrgQJpCKXXsboO73Pe4jDRSlhCDCXaaP2vYGFMA/
	cnrjVoZXnkBi2h2kv3q0mwQpylyLt8/IJw6d8DsKfbIHSPfsWzj9GIDOH4jBqUUVpiBG4KCFxym
	EPLgca0TZTivEWTjI/PLI2mg58UlAeG0kCGi1SUKyHBqw=
X-Received: by 2002:a05:7022:251f:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-12741bd6599mr5735459c88.37.1771359422938;
        Tue, 17 Feb 2026 12:17:02 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12742b62455sm18436484c88.1.2026.02.17.12.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:17:02 -0800 (PST)
Date: Tue, 17 Feb 2026 12:17:01 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin
 timeout per nvme controller
Message-ID: <20260217201701.GH3435530-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-3-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_121704_191722_A620A3D9 
X-CRM114-Status: GOOD (  19.06  )
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

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>

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

