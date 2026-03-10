Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F6FD2D83
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1929U+2B2jsF7SJZ2DGFfE2DUFLxK1sQO/tNgjnO0w=; b=ZAKflNtl9PByzRAdtswvVm3OPZ
	8XtwMunyVew0QW6hgq97Vo14c2nuy7M2tNKFwoIXmUnSWSTvORkWdWcLvZ/BrMaFxa0qUYb0tUlFy
	PwiDlEO4DO2TWczZ1DClhT2kuc7Cfs3gCFoyMSnxzqAkcKw71zZ5eoyqgtH+H8crQRbbB/id85zWp
	MeQF37U1Gb2hlqGGFDHp2mEdYunrkHSYzTFnQPInwgpwWMp71cGP8LNVjgW/rmWri6zANiodcE9yh
	yHEHusMwE1naonD9YIS8foUzrVY1YTzYI9gxAaBaSs2yEeTb1UzWfYTSXA1Z5dqfZo6f3PgZ1XE/N
	dVQcAR3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxDw-00000009bk1-1YQG;
	Tue, 10 Mar 2026 13:34:12 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxDu-00000009biu-1G7D
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 13:34:11 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso14264695e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773149648; x=1773754448; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1929U+2B2jsF7SJZ2DGFfE2DUFLxK1sQO/tNgjnO0w=;
        b=TI3SQyc0jryqDqCIXayofHNokQqmYOfMyy9ETENh2zbXVc7KT7HAB5VCtcPexsAU5G
         89exFErkFNR0D+2P+ROyD0dA14wxfgz5cIgxHLcPhM4fs/YWGfhrUfRPhwkfdsx41aWg
         eY4s/8vZjnLLAGfwV87VAFm572K3z2j11eIMyQSBxxlySUG0kzH5/1tF2cfxpDw8FpNP
         3liSx7ZkVNsTjw5FakdjI4h99x9hGCi6oODnWQY3OdcssXa3nw5yWr3tJ5Oaax7segA7
         JvpW+EBaNhYKder/XpM3pK31Rep7hx+H+iepge4P2tjJF3b8I1NZJBN2kAkUFxc1/qIX
         wEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149648; x=1773754448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1929U+2B2jsF7SJZ2DGFfE2DUFLxK1sQO/tNgjnO0w=;
        b=Giu99V2EG/ZVE6OPqRnK7ARqNrXTlFzsBA1KeP/4jY4ccizk/NvATLQ7fLlxFfvjrg
         rNWLle6zJzi/Ooe2UXRrBH30fRQXRUs5gIohPuwVp1vBS5IDRegdGg7HNNnJmX80u5e7
         iS381mv8d83HdJEMTt10CugcgWvtJ5rT5oKeZivNJcy6uwREnBALNePI0dpIt8Vjo5if
         UfEPJfgDNg6KtDW3dcbsI2lgBso7Xl6byefwTeAuipmEZ85YgwCIEmHstESUYcqGQFft
         6HVACfGAujvvoQN2Zmjg2zVV9lq0w7wYjtX45ICNxIhtizOErZCbmbsh+ApY0LuTUhnk
         fUbw==
X-Forwarded-Encrypted: i=1; AJvYcCVYHFOfE10HPQkgi+F8WTk4mwvrDtvUAYsD0aBQOxT2ic8Dp3+aNvNfWHUmwzQaH9LOu7GbKYBkEXt8@lists.infradead.org
X-Gm-Message-State: AOJu0YweiBtmEL6Xo4H6KgmG7TYMgym4A2QRlpxM4HPogU8HunSn228p
	2hGTHtsjZipEX5KMipgF5jVjH5iP7o0VWmC1bgtfI+gtGKuVylM5fR/ahFmyNhD1Sn8=
X-Gm-Gg: ATEYQzx7iA1eJP8Vm5RR1clmZ68C25wA7hmV9BT+EZVbq0Xn8/713BvL/5aA4aO2m7j
	Ac9R3ZeF7ekTfB18JwOUVqjcRhS1D0HAU08aPW3RGpb2t85OGteeXAi51aiVxjpLo610ReSjuUI
	NG3JN4dgHzVi5GuXuS6b5KCuP/x79dymGfzbcjFfIoseLvQjV+VENRp10IUL+FWKSMiC9FbSRC2
	zoS4pC+6IEWS/AsY5RFu4LcNbJsfFCr+3J4L17KfLD4uP3G/QMd3S8OzZG2ob9d58u80+kPqHbN
	Gi6Sv9fT66qlUT6Xmo5K8YBPO7SUMm5JfMcrBNxWcjYGTG0ch6Xr7ub2/UmZpHZl1+XN5ijM4Ix
	srvfPZQghg4lUZKXyFP3wDwrAFEFCIi3OTDd1f1YYjBD0b9vwX9SHY45GJLRJ1Bv2jyad0kPKa/
	NNDdB0QKLNNyvnMX1YJvXh7uX8f4LH+eemmbygSIVx9bTCmCaVOLgyMYW6
X-Received: by 2002:a05:600c:8b86:b0:485:3473:d4a1 with SMTP id 5b1f17b1804b1-4853473d6dcmr153991525e9.34.1773149648155;
        Tue, 10 Mar 2026 06:34:08 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9ccsm35566642f8f.19.2026.03.10.06.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:34:07 -0700 (PDT)
Message-ID: <fa7061d7-20f1-43e8-af65-2afb02e428f9@suse.com>
Date: Tue, 10 Mar 2026 14:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] scsi: scsi-multipath: Issue a periodic TUR per path
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 axboe@fb.com, linux-scsi@vger.kernel.org, michael.christie@oracle.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com
References: <20260310114925.1222263-1-john.g.garry@oracle.com>
 <20260310114925.1222263-8-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260310114925.1222263-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_063410_368860_C3DEF88A 
X-CRM114-Status: GOOD (  24.94  )
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

On 3/10/26 12:49, John Garry wrote:
> To allow the initiator know of any ALUA configuration changes, issue a
> periodic TUR.
> 
> multipathd does something similar for dm-multipath in terms of issuing
> a periodic read per path.
> 
> The purpose of the TUR is that the target can update UA info in the TUR
> response and the INI can handle it, but currently we don't for SCSI
> multipath.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_multipath.c | 36 +++++++++++++++++++++++++++++++++++
>   include/scsi/scsi_multipath.h |  1 +
>   2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 0c34b1151f5bf..2b916c7af4bd7 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -4,6 +4,7 @@
>    *
>    */
>   
> +#include <linux/kthread.h>
>   #include <scsi/scsi_alua.h>
>   #include <scsi/scsi_cmnd.h>
>   #include <scsi/scsi_driver.h>
> @@ -124,6 +125,7 @@ static void scsi_mpath_head_release(struct device *dev)
>   		container_of(dev, struct scsi_mpath_head, dev);
>   	struct mpath_head *mpath_head = scsi_mpath_head->mpath_head;
>   
> +	WARN_ON_ONCE(kthread_stop(scsi_mpath_head->kua));
>   	scsi_mpath_delete_head(scsi_mpath_head);
>   	bioset_exit(&scsi_mpath_head->bio_pool);
>   	ida_free(&scsi_multipath_dev_ida, scsi_mpath_head->index);
> @@ -514,6 +516,29 @@ struct mpath_head_template smpdt_pr = {
>   	.device_groups = mpath_device_groups,
>   };
>   
> +static void scsi_mpath_cb_ua_thread(struct mpath_device *mpath_device)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =
> +			to_scsi_mpath_device(mpath_device);
> +
> +	if (alua_tur(scsi_mpath_dev->sdev))
> +		sdev_printk(KERN_NOTICE, scsi_mpath_dev->sdev,
> +			    "%s: No target port descriptors found\n",
> +			    __func__);
> +}
> +
> +static int scsi_mpath_ua_thread(void *data)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head = data;
> +
> +	while (!kthread_should_stop()) {
> +		mpath_call_for_all_devices(scsi_mpath_head->mpath_head,
> +			scsi_mpath_cb_ua_thread);
> +		msleep(5000);
> +	}
> +	return 0;
> +}
> +
>   static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
>   {
>   	struct scsi_mpath_head *scsi_mpath_head;
> @@ -548,6 +573,17 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
>   		goto out_free_ida;
>   	}
>   
> +	scsi_mpath_head->kua = kthread_create(scsi_mpath_ua_thread,
> +			scsi_mpath_head, "scsi-multipath-kua-%d",
> +			scsi_mpath_head->index);
> +	if (IS_ERR(scsi_mpath_head->kua)) {
> +		put_device(&scsi_mpath_head->dev);
> +		goto out_free_ida;
> +	}
> +
> +	set_user_nice(scsi_mpath_head->kua, 10);
> +	wake_up_process(scsi_mpath_head->kua);
> +
>   	return scsi_mpath_head;
>   
>   out_free_ida:
> diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
> index 7c7ee2fb7def7..d30f2c41e17de 100644
> --- a/include/scsi/scsi_multipath.h
> +++ b/include/scsi/scsi_multipath.h
> @@ -30,6 +30,7 @@ struct scsi_mpath_head {
>   	struct mpath_head	*mpath_head;
>   	struct device		dev;
>   	int			index;
> +	struct task_struct	*kua;
>   };
>   
>   struct scsi_mpath_device {

Please, don't. We should _not_ go into the business of doing TUR path 
checkers.
Path checkers turned out to be a major issue for multipathing, and
are mostly pointless for things like FC where you get reliable
path information via RSCNs.
Additionally I would advocate for scsi-multipath to be a _simple_
implementation, restricting to the most common scenarios. Namely
implicit ALUA only and reliable fabric notifications.
If you have anything else, fine, use dm-multipath.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

