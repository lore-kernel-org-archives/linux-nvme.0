Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A7FE67A85
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+diqLHAbCu0YIrK7BmkSHmFnH/39tPbeAFxeHFPEiPU=; b=hqlDmHvJSQBZadCLuvMFYqnacv
	VMnjWQtnwpXabdlmlmPye1MS+L3tiI/P7cMctlWJY+Xhw/sTb3TYlMWvaQ8JxD+4L1nnIs4qqcSjZ
	kGMcBlsyefCtUAIJ9rvi3gLnkTTTfHybWwQI9rtLG6RIqQAqWv8ygR0D+/SNRa29GNUF2yMMpVo86
	E207dfl0tOauP3csb4mk6y4XqjjzLHi/8tnwTCcSNTxMOD1MeWTa8oTgE3vlt5NjctGf/XpVERxcs
	yLf5P+v8PtT4FaAYbjn4zvFxjTeduEBbtzzWOHkd+eAtMBM66kM1PskQXY3+fCzCb8aqQbJ5vECIZ
	Ca88tcYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJwj-0000000EeaW-2zEK;
	Tue, 03 Mar 2026 07:13:33 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJwh-0000000EeaB-1FTv
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:13:32 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so39686365e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772522009; x=1773126809; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+diqLHAbCu0YIrK7BmkSHmFnH/39tPbeAFxeHFPEiPU=;
        b=HudELbu2vCiD3x0vuacY6rymM0E6INfBdTmqXKFNddlJV191KzN04jPiZTXSMe1OSo
         FqV/gwO/tZalq6G6dv2WoHeE4e3dmUoJZLAqUPPPFKqxby4KyONShpRwqYJqwcul53bL
         Nmdq+48rbfvmx+aRqxHWLWPBh+5HF/vZMRkxPGSZzhFvchQaaDs0/R5RjMHcxPlvdiWP
         F8m6hOxVnT6D1ex9zEbW8QKECuwT3V0LuLiH0C34yAbZpRzNW+ebZF8raRfuDFjiftrs
         N1mP1r7DsZavzwxM00+qIHPeZAcHR4tTWZzeA/fx2LqfzAuoItRZUlutByzJ+kZ0LaHf
         yS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522009; x=1773126809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+diqLHAbCu0YIrK7BmkSHmFnH/39tPbeAFxeHFPEiPU=;
        b=SWP6UEWk2eX1X/hDY9wBQbGCSz0zwMc4hJvLlv+yxvqcCOKS0S2uBlwOQu54tqzqql
         +TU1WkyRSzCScPdtHFcPJ9uM2YYhbXi78YS5+3i8exUqJF02nARBjQx0eDeNgNJR26Sz
         Ra2wYjIMm3pLhshH90S/oIPWXH3HUM9joUvjq+i9Ym3KpWBOcQ/RXE4AFbByoQhywSW5
         yB7WYNSqdKO/esgAEyasJ065TE1DVeBdNNB5eug9DkmqDVuE3slpde3nfs75TUrN8wUy
         DhtzOi0aKV7g2/gRQ8dkWzoM49VOxKGsYL6Wp3ORzwMuxYfspoVTCsDPTqQ2kV46nkUY
         1Ozw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2e82CXaXN1fm1ORidIChxz6YMgzhZc5pfe3gyBJ5Gi+BNVZErp7stZjFCynkdo3ljSUedpot9lD5@lists.infradead.org
X-Gm-Message-State: AOJu0YxxgJdcD0SK1EXDzDfKPJ+cl/h+yihivX6k6t052J+QJ4vx2wtm
	sibmKlSn1kiTHHPw0uFOzk9WTPUYIabgZoakILXm1GkTzDDeEkUHMsSENjM4RF/uPp4=
X-Gm-Gg: ATEYQzzSDG3iPFM2tzIU8t/sJlJhhb8HnaYRLJ2A5Um40bIv/kLJU3gf9PPEpr5+uls
	rdCShji4DbzD9gAP6eN/5Y48SWcukLdwz61gWpv/G+hB96bAO8wm0IYuSGypR2Go7rTei5HpK0F
	7kN0MH9DsaGLUeMLq2H7Rlmkxd+fl1dr4lmrSbodJkgnbCq727DLASWEp4EWV/9FQSTZV65RRUV
	mms3QEF7Wsb8ZtR9lFEEeb0nk9DbprFkaqJKXOfSorahbKnFG/DsQjGVGmsnwozUqT/UC3RyO+Y
	GPOuJRA8ofBYjmJPjuDBy96Q9q620AL32TMCvDYJtCmcK1NFvT54d8eBv7KggvBCnlEALlK7844
	W8Flg+TOKWtOSg9KGfjOcy2GL50vjiEBa+nb6KbVvmV/iDU0iSVt4UB9A4v6MDTFsmqJE3yaOlc
	0Fk2ZQN53kD3zF7BoXjVrJPGzYFDfYI6Q3oYInHGmWq4BEFvKIZPmgHFjNgBHNX1wcmg==
X-Received: by 2002:a05:600c:4592:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-483c9bc03b1mr291390865e9.13.1772522009331;
        Mon, 02 Mar 2026 23:13:29 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48512628e2asm22510605e9.1.2026.03.02.23.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 23:13:28 -0800 (PST)
Message-ID: <0809867c-796a-4bf1-a868-7ec64504723d@suse.com>
Date: Tue, 3 Mar 2026 08:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] scsi-multipath: introduce scsi_device head
 structure
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-4-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_231331_392128_6B0DCEA2 
X-CRM114-Status: GOOD (  30.06  )
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

On 2/25/26 16:36, John Garry wrote:
> Introduce a scsi_device head structure - scsi_mpath_head - to manage
> multipathing for a scsi_device. This is similar to nvme_ns_head structure.
> 
> There is no reference in scsi_mpath_head to any disk, as this would be
> mananged by the scsi_disk driver.
> 
> A list of scsi_mpath_head structures is managed to lookup for matching
> multipathed scsi_device's. Matching is done through the scsi_device
> unique id.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_multipath.c | 147 ++++++++++++++++++++++++++++++++++
>   drivers/scsi/scsi_sysfs.c     |   3 +
>   include/scsi/scsi_multipath.h |  29 +++++++
>   3 files changed, 179 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 04e0bad3d9204..49316269fad8e 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -16,6 +16,10 @@
>   bool scsi_multipath;
>   static bool scsi_multipath_always;
>   
> +static LIST_HEAD(scsi_mpath_heads_list);
> +static DEFINE_MUTEX(scsi_mpath_heads_lock);
> +static DEFINE_IDA(scsi_multipath_dev_ida);
> +
>   static int multipath_param_set(const char *val, const struct kernel_param *kp)
>   {
>   	int ret;
> @@ -99,6 +103,73 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
>   	return 0;
>   }
>   
> +struct mpath_head_template smpdt_pr = {
> +};
> +
> +static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head;
> +	int ret;
> +
> +	scsi_mpath_head = kzalloc(sizeof(*scsi_mpath_head), GFP_KERNEL);
> +	if (!scsi_mpath_head)
> +		return NULL;
> +
> +	ida_init(&scsi_mpath_head->ida);
> +	mutex_init(&scsi_mpath_head->lock);
> +
> +	scsi_mpath_head->mpath_head = mpath_alloc_head();
> +	if (IS_ERR(scsi_mpath_head->mpath_head))
> +		goto out_free;
> +	scsi_mpath_head->mpath_head->mpdt = &smpdt_pr;

mpdt?
What's that supposed to mean?
Seems to be like a persistent reservation thing, so why don't
you introduce it together with PR suppoer?

> +	scsi_mpath_head->mpath_head->drvdata = scsi_mpath_head;
> +
> +	scsi_mpath_head->index = ida_alloc(&scsi_multipath_dev_ida, GFP_KERNEL);
> +	if (scsi_mpath_head->index < 0)
> +		goto out_put_head;
> +
> +	device_initialize(&scsi_mpath_head->dev);
> +	ret = dev_set_name(&scsi_mpath_head->dev, "%d", scsi_mpath_head->index);

Huh? The name is just the number? So we will have a device
/sys/devices/virtual/1 ?

The sysfs registration looks decidedly odd.
I guess we should add a scsi multipath class to sort the devices under.

> +	if (ret) {
> +		put_device(&scsi_mpath_head->dev);
> +		goto out_free_ida;
> +	}
> +
> +	return scsi_mpath_head;
> +
> +out_free_ida:
> +	ida_free(&scsi_multipath_dev_ida, scsi_mpath_head->index);
> +out_put_head:
> +	mpath_put_head(scsi_mpath_head->mpath_head);
> +out_free:
> +	kfree(scsi_mpath_head);
> +	return NULL;
> +}
> +
> +static struct scsi_mpath_head *scsi_mpath_find_head(
> +			struct scsi_mpath_device *scsi_mpath_dev)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head;
> +	int ret;
> +
> +	mutex_lock(&scsi_mpath_heads_lock);
> +	list_for_each_entry(scsi_mpath_head, &scsi_mpath_heads_list, entry) {
> +		ret = scsi_mpath_get_head(scsi_mpath_head);
> +		if (ret)
> +			continue;
> +		if (strncmp(scsi_mpath_head->wwid,
> +			scsi_mpath_dev->device_id_str,
> +			SCSI_MPATH_DEVICE_ID_LEN) == 0) {
> +
> +			mutex_unlock(&scsi_mpath_heads_lock);
> +			return scsi_mpath_head;
> +		}
> +		scsi_mpath_put_head(scsi_mpath_head);
> +	}
> +
> +	return NULL;
> +}
> +
>   static void scsi_multipath_sdev_uninit(struct scsi_device *sdev)
>   {
>   	kfree(sdev->scsi_mpath_dev);
> @@ -107,6 +178,7 @@ static void scsi_multipath_sdev_uninit(struct scsi_device *sdev)
>   
>   int scsi_mpath_dev_alloc(struct scsi_device *sdev)
>   {
> +	struct scsi_mpath_head *scsi_mpath_head;
>   	int ret;
>   
>   	if (!scsi_multipath)
> @@ -127,13 +199,75 @@ int scsi_mpath_dev_alloc(struct scsi_device *sdev)
>   		goto out_uninit;
>   	}
>   
> +	scsi_mpath_head = scsi_mpath_find_head(sdev->scsi_mpath_dev);
> +	if (scsi_mpath_head)
> +		goto found;
> +	/* scsi_mpath_disks_list lock held */
> +	scsi_mpath_head = scsi_mpath_alloc_head();
> +	if (!scsi_mpath_head)
> +		goto out_uninit;
> +
> +	strcpy(scsi_mpath_head->wwid, sdev->scsi_mpath_dev->device_id_str);
> +

Do we have a sysfs attribute for this?

> +	ret = device_add(&scsi_mpath_head->dev);
> +	if (ret)
> +		goto out_put_head;
> +
> +	list_add_tail(&scsi_mpath_head->entry, &scsi_mpath_heads_list);
> +
> +	mutex_unlock(&scsi_mpath_heads_lock);
> +	sdev->scsi_mpath_dev->scsi_mpath_head = scsi_mpath_head;
> +
> +found:
> +	sdev->scsi_mpath_dev->index = ida_alloc(&scsi_mpath_head->ida, GFP_KERNEL);
> +	if (sdev->scsi_mpath_dev->index < 0) {
> +		ret = sdev->scsi_mpath_dev->index;
> +		goto out_put_head;
> +	}
> +
> +	mutex_lock(&scsi_mpath_head->lock);
> +	scsi_mpath_head->dev_count++;
> +	mutex_unlock(&scsi_mpath_head->lock);
> +
> +	sdev->scsi_mpath_dev->scsi_mpath_head = scsi_mpath_head;
>   	return 0;
>   
> +out_put_head:
> +	scsi_mpath_put_head(scsi_mpath_head);
>   out_uninit:
> +	mutex_unlock(&scsi_mpath_heads_lock);
>   	scsi_multipath_sdev_uninit(sdev);
>   	return ret;
>   }
>   
> +static void scsi_mpath_remove_head(struct scsi_mpath_device *scsi_mpath_dev)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head =
> +			scsi_mpath_dev->scsi_mpath_head;
> +	bool last_path = false;
> +
> +	mutex_lock(&scsi_mpath_head->lock);
> +	scsi_mpath_head->dev_count--;
> +	if (scsi_mpath_head->dev_count == 0)
> +		last_path = true;
> +	mutex_unlock(&scsi_mpath_head->lock);
> +
> +	if (last_path)
> +		device_del(&scsi_mpath_head->dev);
> +
> +	scsi_mpath_dev->scsi_mpath_head = NULL;
> +	scsi_mpath_put_head(scsi_mpath_head);
> +}
> +
> +void scsi_mpath_remove_device(struct scsi_mpath_device *scsi_mpath_dev)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head = scsi_mpath_dev->scsi_mpath_head;
> +
> +	ida_free(&scsi_mpath_head->ida, scsi_mpath_dev->index);
> +
> +	scsi_mpath_remove_head(scsi_mpath_dev);
> +}
> +
>   void scsi_mpath_dev_release(struct scsi_device *sdev)
>   {
>   	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
> @@ -142,8 +276,21 @@ void scsi_mpath_dev_release(struct scsi_device *sdev)
>   		return;
>   
>   	scsi_multipath_sdev_uninit(sdev);
> +}
> +
> +int scsi_mpath_get_head(struct scsi_mpath_head *scsi_mpath_head)
> +{
> +	if (!get_device(&scsi_mpath_head->dev))
> +		return -ENXIO;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(scsi_mpath_get_head);
>   
> +void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head)
> +{
> +	put_device(&scsi_mpath_head->dev);
>   }
> +EXPORT_SYMBOL_GPL(scsi_mpath_put_head);
>   
>   int __init scsi_multipath_init(void)
>   {
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 0d69e27600a7a..287a683e89ae5 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1447,6 +1447,9 @@ void __scsi_remove_device(struct scsi_device *sdev)
>   	} else
>   		put_device(&sdev->sdev_dev);
>   
> +	if (sdev->scsi_mpath_dev)
> +		scsi_mpath_remove_device(sdev->scsi_mpath_dev);
> +
>   	/*
>   	 * Stop accepting new requests and wait until all queuecommand() and
>   	 * scsi_run_queue() invocations have finished before tearing down the
> diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
> index ca00ea10cd5db..38953b05a44dc 100644
> --- a/include/scsi/scsi_multipath.h
> +++ b/include/scsi/scsi_multipath.h
> @@ -19,9 +19,22 @@
>   #ifdef CONFIG_SCSI_MULTIPATH
>   #define SCSI_MPATH_DEVICE_ID_LEN 40
>   
> +struct scsi_mpath_head {
> +	char			wwid[SCSI_MPATH_DEVICE_ID_LEN];

Don't name it WWID. That's an ATA thing. Make it vpd_id.

> +	struct list_head	entry;
> +	int			dev_count;
> +	struct ida		ida;
> +	struct mutex		lock;
> +	struct mpath_head	*mpath_head;
> +	struct device		dev;
> +	int			index;
> +};
> +
>   struct scsi_mpath_device {
>   	struct mpath_device	mpath_device;
>   	struct scsi_device 	*sdev;
> +	int			index;
> +	struct scsi_mpath_head	*scsi_mpath_head;
>   
>   	char			device_id_str[SCSI_MPATH_DEVICE_ID_LEN];
>   };
> @@ -32,8 +45,13 @@ int scsi_mpath_dev_alloc(struct scsi_device *sdev);
>   void scsi_mpath_dev_release(struct scsi_device *sdev);
>   int scsi_multipath_init(void);
>   void scsi_multipath_exit(void);
> +void scsi_mpath_remove_device(struct scsi_mpath_device *scsi_mpath_dev);
> +int scsi_mpath_get_head(struct scsi_mpath_head *);
> +void scsi_mpath_put_head(struct scsi_mpath_head *);
>   #else /* CONFIG_SCSI_MULTIPATH */
>   
> +struct scsi_mpath_head {
> +};
>   struct scsi_mpath_device {
>   };
>   
> @@ -51,5 +69,16 @@ static inline int scsi_multipath_init(void)
>   static inline void scsi_multipath_exit(void)
>   {
>   }
> +static inline void scsi_mpath_remove_device(struct scsi_mpath_device
> +					*scsi_mpath_dev)
> +{
> +}
> +static inline int scsi_mpath_get_head(struct scsi_mpath_head *)
> +{
> +	return 0;
> +}
> +static inline void scsi_mpath_put_head(struct scsi_mpath_head *)
> +{
> +}
>   #endif /* CONFIG_SCSI_MULTIPATH */
>   #endif /* _SCSI_SCSI_MULTIPATH_H */

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

