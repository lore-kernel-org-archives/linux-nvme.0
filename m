Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DCC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 17:49:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06F86108D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 17:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06F86108D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SxhuXYnyAuF/anB2AD+5YI/7Ef1wboCjc/0xSyID8KE=; b=ps+9SucwDwDhfvDOYT5lu44/p
	GExIjYhzOR/NCgi9iZdNYXl/tqpJBVL6mdooaAcv3kgFCQbNtYxZwO5j3dvi9NP4xQCTQL2nrMcHA
	GEllbrfJBhGD4qaxzARHr3OcHSRl/Z//n8aR/uOyaLGJZbqqZkvdHx0BRn3/7ZEs40NxaBQaNR2LW
	W8YAVZ2qapzAJXwSth733fBt0QBIK/7Wq4q5QaKquo/i++N+mNr8PzYZzbmk7BPgBO/5x7tg/4IQM
	AlSAHMisnBcL8EhlwGQxhmFpp+bU1PsCl2UtBAlm6dzGDGY8Ts9bu5G5ydWJTk6NFjNUUaVPvlB0E
	tSLWCwJXA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihMx-00Fj53-9a; Mon, 17 May 2021 17:49:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihMv-00Fj4o-2G
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 17:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Ve7qSM1tPYa7r31OMJsi5OnT6ng0pOsRz1ee+lBkju0=; b=hmFEyudpkJvvLIIPSIRaQp+umo
 UqimMB6NFduwL0srWJVFa7WX7fxpfyrvislkkW76Tc2rbPZJlaVL6RlnbCyIf4rCc+DDYp2sKP9Rj
 JYHWbLpkpzD1/OKkqBDavsD2MxEd4wRy6sV9axY60E0u75U0++1VoNAB7XWK37oUzDrqF+vZTU4gb
 l6wGYITTrUKNuZajppqYoZHIcYYCyfJYkjxrtM44TVoxR2JTVQwLrPyWBnREnvnQwIPr68AHu9oVL
 niV2i+IjprgwypPqefExsJgbBO4Qpeyaxg1DZuOr7JNsJ9b/252m7Go9iMcyYmhbYs65gfjLqGYPX
 ShxPvqJA==;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihMp-00E1xx-60
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 17:49:27 +0000
Received: by mail-pl1-f171.google.com with SMTP id b21so3615721plz.0
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 10:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ve7qSM1tPYa7r31OMJsi5OnT6ng0pOsRz1ee+lBkju0=;
 b=SQPN80LIhltNgNalGaJutoGApkH2thmqO1ZDkmRGp1oGspuWLVE/vB1TNNBKaZYaVN
 LiHmFImSsTFItJWXY83nqvMpT9M+f/eIzDV/BB6lEB48ssGsU4caW2rPKnlwcFo5nCJK
 sV8+CEJ+O8DodgU8l0CvilTh4wwl5VlxQq4tAzV3MONkHm4M7FuIAaTkqftbbzzyY/al
 ith7kbTgzXulbQv2XcNE39fWL3DTUfcrchEG4ed1LQUgL3NY3kn0GFDS/bMwEwtTZg2Y
 7jfo0bwYQSw13WA+uf/QfV1toC8arRf25V2CJ2r5ycY30zAgF8SDmoo/kfJJYq022+iQ
 Xdtw==
X-Gm-Message-State: AOAM532CJui8TrmqQbV7TwqxKdKnbo8HXv/qOlPSJHa5ke+hQCMotQ4K
 btXYmWVY/XWLEWloohp3S4LazuEjAUg=
X-Google-Smtp-Source: ABdhPJwsx2TC8SY2JSf+BlSomstIFMxjWzr1TASam1XjY8jijQOHpU3qpp76LYp0RvOXd/NfWltE4w==
X-Received: by 2002:a17:902:d643:b029:ef:62cd:eeed with SMTP id
 y3-20020a170902d643b02900ef62cdeeedmr1276786plh.42.1621273761216; 
 Mon, 17 May 2021 10:49:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id z12sm3920943pfk.45.2021.05.17.10.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 10:49:20 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
Date: Mon, 17 May 2021 10:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517083215.105604-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_104923_263181_1525DA8E 
X-CRM114-Status: GOOD (  24.86  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When fast_io_fail_tmo is set I/O will be aborted while recovery is
> still ongoing. This causes MD to set the namespace to failed, and
> no futher I/O will be submitted to that namespace.
> 
> However, once the recovery succeeds and the namespace becomes
> operational again the NVMe subsystem doesn't send a notification,
> so MD cannot automatically reinstate operation and requires
> manual interaction.
> 
> This patch will send a KOBJ_CHANGE uevent per multipathed namespace
> once the underlying controller transitions to LIVE, allowing an automatic
> MD reassembly with these udev rules:
> 
> /etc/udev/rules.d/65-md-auto-re-add.rules:
> SUBSYSTEM!="block", GOTO="md_end"
> 
> ACTION!="change", GOTO="md_end"
> ENV{ID_FS_TYPE}!="linux_raid_member", GOTO="md_end"
> PROGRAM="/sbin/md_raid_auto_readd.sh $devnode"
> LABEL="md_end"
> 
> /sbin/md_raid_auto_readd.sh:
> 
> MDADM=/sbin/mdadm
> DEVNAME=$1
> 
> export $(${MDADM} --examine --export ${DEVNAME})
> 
> if [ -z "${MD_UUID}" ]; then
>      exit 1
> fi
> 
> UUID_LINK=$(readlink /dev/disk/by-id/md-uuid-${MD_UUID})
> MD_DEVNAME=${UUID_LINK##*/}
> export $(${MDADM} --detail --export /dev/${MD_DEVNAME})
> if [ -z "${MD_METADATA}" ] ; then
>      exit 1
> fi
> if [ $(cat /sys/block/${MD_DEVNAME}/md/degraded) != 1 ]; then
>      echo "${MD_DEVNAME}: array not degraded, nothing to do"
>      exit 0
> fi
> MD_STATE=$(cat /sys/block/${MD_DEVNAME}/md/array_state)
> if [ ${MD_STATE} != "clean" ] ; then
>      echo "${MD_DEVNAME}: array state ${MD_STATE}, cannot re-add"
>      exit 1
> fi
> MD_VARNAME="MD_DEVICE_dev_${DEVNAME##*/}_ROLE"
> if [ ${!MD_VARNAME} = "spare" ] ; then
>      ${MDADM} --manage /dev/${MD_DEVNAME} --re-add ${DEVNAME}
> fi

Is this auto-readd stuff going to util-linux?

> 
> Changes to v2:
> - Add udev rules example to description
> Changes to v1:
> - use disk_uevent() as suggested by hch

This belongs after the '---' separator..

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/multipath.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0551796517e6..ecc99bd5f8ad 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -100,8 +100,11 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		if (ns->head->disk)
> -			kblockd_schedule_work(&ns->head->requeue_work);
> +		if (!ns->head->disk)
> +			continue;
> +		kblockd_schedule_work(&ns->head->requeue_work);
> +		if (ctrl->state == NVME_CTRL_LIVE)
> +			disk_uevent(ns->head->disk, KOBJ_CHANGE);
>   	}

I asked this on v1, is this only needed for mpath devices?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
