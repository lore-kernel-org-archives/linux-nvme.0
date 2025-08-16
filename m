Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5525CA0EE6
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Aug 2025 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:To:References:Cc:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=17xGCAOYPaXnnoQHmlg6SyfhhHnDFJ6cUvyz6KfIIP0=; b=JqsNwpqdFe9GqVk5GEz8aBW20d
	AvhljcGF1w5CskF7Yzsb2hrvVYsAzAkOy6StBr26K+9e1v8OwSGxuNMF68W6yAVyohNaBqCx62jif
	XlpbLvCY9kTpJ0BoWQYszfamsSEtKuYHAiXpol0Sfyt7Cuj13z4juGKAN0YbjDSsCupFi6oqaxrI6
	v4T8PS7mSHxevz0ME/q6fMl91KrOiVI14OKo6yX/4rTS+wG9HIdzKspfpPvqSZvzgybI7Qmjqb3Fm
	FVTeENoWUepDbSVP267+VJauS83U+2au/0dBUC/1XIgXxRftcXTY1xYDUFL+e//zfPmtELYYwXH9p
	zu8n8Elw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unKVZ-000000050q8-2npC;
	Sat, 16 Aug 2025 17:15:57 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unKVW-000000050po-3EwX
	for linux-nvme@lists.infradead.org;
	Sat, 16 Aug 2025 17:15:56 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3b9d41d6e34so179864f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 16 Aug 2025 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755364553; x=1755969353; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:to:content-language
         :references:cc:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17xGCAOYPaXnnoQHmlg6SyfhhHnDFJ6cUvyz6KfIIP0=;
        b=a51tSXjNp1WZ+3PvZrMXhjOmkRKkcCU5JfM0pJziFe7zWmuooVrZa9c8uuzqeHoeO+
         Hys/lcvB7Zuqim70GDLjMC5o1vdn6NJJvENOSBy8fvv2YJ9jSPyhXskf2o0lbvn1tUGf
         fGaXA7TZireDT87YU96XyB95lZnp+KuJQTkbt8gGVA05fgahxFIRHORCGDG88hK9+bd0
         3F0DlQj6jcDOMgGdYSQyM7vPtu4fgG7CnC1htnlAp8kV651kHElnsB+x6CAe0Ughcf/Q
         dbbn/5I+l2c8M5rQT4r4ifubdRmzEC1RMPXsheTOYgMb36pVWHWng+rOolYu0PN99Cnn
         HtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364553; x=1755969353;
        h=content-transfer-encoding:in-reply-to:from:to:content-language
         :references:cc:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17xGCAOYPaXnnoQHmlg6SyfhhHnDFJ6cUvyz6KfIIP0=;
        b=q57L6UuW7hrEA0II8EHERE4J1MBX3sa0UXU0llRywlOsj+Mh/BQ2wvVMMrLAnysqG1
         FJw/Abk4DfMnV68w5jaW6YIOvKHxNu65OUGRGF+i1jgkeSDGjJ3bR3aWM7lWcOI5T143
         LRLSa+tdKJWQABCI2QNL5KIYsRkLy5Gn0PbIxNtHooGJruEdc31f3RwiBZ0AIWMr3auN
         HOGeSforDcQWFKravy0rpVcUTKnpCrTeiZDNtDcdJcr29g78su89rJIrpPS2lghU88fO
         mBv5Ov4iDUvRe86rDSLPAtsHI/QuTeyeC1pY+AMvTjI6nL+lB2qlGOJoUlknRAaFN5Jq
         OBWA==
X-Forwarded-Encrypted: i=1; AJvYcCWfv+hLtwplYyvC3oEoxZdFH/KnHkIr2nOTT8O2TvrgRC4ycTPS/AbHVjqtZPCRuaacIqkHsMp3sWIV@lists.infradead.org
X-Gm-Message-State: AOJu0YyEur0UDDBcDeWsEiGDnw6xPJJKaA3nz/A9Cd4F84HPCqUEy1ve
	EVO0f2Xwab41fQXJxjm/iv4IXBk0Vrgfi4EEsB8oH4crXn1wugpYwqY=
X-Gm-Gg: ASbGncvtDdvxe7r1tV0W25D48qfAyMoYDwF8Beg/921vEsAEm22vzcCAUlb66o15HwC
	hHPHn8IKQOLY2O3nHMUYziAxSR3kLsaS2Gfk1zc0IcajvEifflhRLp4Jockrpioup1PgbWhf/jT
	MVKXgBHTj9AhGuMCBvjNskKQfGuJG1rM4I1T6K4A5UbkJ2Zn7+56D1gHlM2wuJBhVdDeKlkGsOo
	GKq1ta8ir/aGuquaAGjjI03e5UBA7AhWyEm8YhVpcmfvQD1jZeHlLvtIqA5oiYj1HYhpTnGlK/O
	P3qXZZIuVQ/PGGDEcz3kolABibDkwNF0SAkpQXiHReqhhSrunhAV9rK42RaHg7jBHWSaaffTHQd
	gwrIsL6g9ZYam3kVj6hIqmb8WgF3Cq/KMS0zKMyLRpFvu3gfYnk3dPZnR9MDU
X-Google-Smtp-Source: AGHT+IHd/4fzeAVJN3EXLt7ZlstRloPqKelylWmj3/Y+2tnuaQjwHYDO4ph7lm/aJohEgv2+8c04Dg==
X-Received: by 2002:a05:600c:8116:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-45a2314999amr19516375e9.3.1755364552681;
        Sat, 16 Aug 2025 10:15:52 -0700 (PDT)
Received: from localhost (67.red-80-39-24.staticip.rima-tde.net. [80.39.24.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321a54sm61127145e9.18.2025.08.16.10.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:15:52 -0700 (PDT)
Message-ID: <7ccfba05-ec5a-4a42-a1ea-5254e7b7d97f@gmail.com>
Date: Sat, 16 Aug 2025 19:15:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-cli: nvmf-autoconnect: udev-rule: add a file for new
 arrays
Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>,
 Vasuki Manikarnike <vasuki.manikarnike@hpe.com>,
 Martin George <marting@netapp.com>,
 NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
 Zou Ming <zouming.zouming@huawei.com>, Li Xiaokeng <lixiaokeng@huawei.com>,
 Randy Jennings <randyj@purestorage.com>, Thomas Song
 <tsong@purestorage.com>, Jyoti Rani <jrani@purestorage.com>,
 Brian Bunker <brian@purestorage.com>, Uday Shankar
 <ushankar@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marco Patalano <mpatalan@redhat.com>,
 "Ewan D. Milne" <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 Simon Schricker <sschricker@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Daniel Wagner <wagi@monom.org>, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 NVME-ML <linux-nvme@lists.infradead.org>,
 SCSI-ML <linux-scsi@vger.kernel.org>
References: <20250815202133.51160-1-xose.vazquez@gmail.com>
Content-Language: en-US, en-GB, es-ES
To: DM_DEVEL-ML <dm-devel@lists.linux.dev>
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <20250815202133.51160-1-xose.vazquez@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250816_101554_812139_E4B7F8C3 
X-CRM114-Status: UNSURE (   7.42  )
X-CRM114-Notice: Please train this message.
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

On 8/15/25 10:21 PM, Xose Vazquez Perez wrote:

> And it is unnecessary to set ctrl_loss_tmo to -1 for NVMe/TCP devices,
> because it is the default.

Totally wrong. I misread the code:

$ grep NVMF_DEF_CTRL_LOSS_TMO drivers/nvme/host/fabrics.c
     int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;

$ grep ^#define drivers/nvme/host/fabrics.h
#define _NVME_FABRICS_H 1
#define NVMF_MIN_QUEUE_SIZE     16
#define NVMF_MAX_QUEUE_SIZE     1024
#define NVMF_DEF_QUEUE_SIZE     128
#define NVMF_DEF_RECONNECT_DELAY        10
#define NVMF_DEF_CTRL_LOSS_TMO          600   <---
#define NVMF_DEF_FAIL_FAST_TMO          -1

It's 10 minutes.

