Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A713C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 05:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192DA61376
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 05:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192DA61376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:To:From:
	References:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KG4fEvuazMySOW83Zo85LXi5J+HmRArS3SUXIffZyiU=; b=zwhzp6Vw1UVk8TKeCXOmHZP3m6
	EFYINYBNAkLm3uAKg1QjSlpnM+vgSxbaEC+SFp5vUzeoTQnbgoirlBfBCr9RNbyai+eoaPyUB7oqD
	7abx2lfOvlymgrJx9f6JcbmDeSv9uKnQlf4A9+6ao+zNUg4yg9MxzcrNzRSKcnnPuWy+a2kQJWn5a
	CFJOyUNQ+k6JhlVilSbch6MPGbXe2HTlZkBLxNJXjR76ErY/+k5Lbh5Pxb2ga+80B1zqxHZ5NDZE6
	wPN6FrklRGH3fymcqz+6We8qGXjUzgt0O9LihtdurbBREvieevdUKIECzC0oWtoRsR+7mHJZ5x4bC
	EvhYqQRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loJqW-001xh2-3D; Wed, 02 Jun 2021 05:55:16 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loJqR-001xgd-H7
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 05:55:13 +0000
Received: by mail-ed1-x530.google.com with SMTP id y7so1475026eda.2
 for <linux-nvme@lists.infradead.org>; Tue, 01 Jun 2021 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:references:from:to:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=rX2oDo4CESx+NAPK6z2VxyHWorIyqGD+rbIgNSiUBBk=;
 b=Jbj73M5xUER6wRiZ+RAayGrOeKRjqWoHLksPGueQVvFtQ36r/wF2VKD0p+DvVEqNRW
 BaWfSuRlBqlAAvciR/8iY1FJx1LySV1NgFj4QfPgU4jSyLtzYtjtOj5W0vE3KaJhyk9G
 QW7efw4jCuSPGerMEegSbFyefWvGA3aQydN5WvIXO3656NV+67l4pnHkFL8Qtt1uyOIQ
 rTiwWP31qWrVXLg3D91a3sZu6qiR5m+g333zLyiJLEHzzrIoQerIxg2NqcjK9jWHeHy0
 /Q3nVMN3ADnCWl4+3sleYlZYEMJWY1oCmj3Y1crp7bq0qPSAxaMGN1ceZkgS3qUpZULm
 xsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:references:from:to:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rX2oDo4CESx+NAPK6z2VxyHWorIyqGD+rbIgNSiUBBk=;
 b=FRC5DM+BG/ABbaPvWK1mXx8Z4pzv63ASLHCa6j0DxBMb2HTExxLM4aJfN1NBfw1MKs
 a3jaSD6Xy5nu1id5+NiKS4eAKj6y6QGrv+Ty/eIS4xwSDdBlgb8MRdWhFc2tUo7Pyd3i
 7qJiaBwpOl6DrmuqHDMSlvRjJy6w9lgc0dOyD9XLebHbq9PuPBqSmpFODegdYNcyBq2R
 bvvlDf6vzt5L2N+U9LMHbPh58bsO6kBn/7TigivyPzkgTnLyHkqEvgIgZ3bV8IA7w2I1
 18hiO1DnCiFne7Df+KNHFRZJ6XmebMRWnL2gwBqiB0kX8N86zo8bJr50fDA3nA9HFrC9
 XzQw==
X-Gm-Message-State: AOAM531K9xZe63y6kylg+s2xbD6qYjUJQa4svUGShs0pq4qJA9C9qWeY
 vbbQSIB6SAV0nVRv3nB//jymNCRjbXA=
X-Google-Smtp-Source: ABdhPJy55R5PzWIedM+DA+PuEwsfIynUhKrhEKGO5adIRIDzofr7tezCUXFRn1kxSO4KomJeOVemWw==
X-Received: by 2002:a05:6402:44:: with SMTP id
 f4mr36928082edu.364.1622613309125; 
 Tue, 01 Jun 2021 22:55:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::ed5b? ([2a02:908:1984:a6c0::ed5b])
 by smtp.gmail.com with ESMTPSA id kx3sm7906664ejc.44.2021.06.01.22.55.08
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 22:55:08 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Improvements to StorageD3Enable
References: <20210528160120.9299-1-mario.limonciello@amd.com>
From: Julian Sikorski <belegdol@gmail.com>
To: linux-nvme@lists.infradead.org
Message-ID: <46e8a6a1-4dd3-9aa6-4131-6b7eaff44b64@gmail.com>
Date: Wed, 2 Jun 2021 07:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528160120.9299-1-mario.limonciello@amd.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_225511_624373_122746A0 
X-CRM114-Status: GOOD (  25.30  )
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

Am 28.05.21 um 18:01 schrieb Mario Limonciello:
> A number of AMD based OEM systems have problems coming out of s2idle,
> which is rooted in that the NVME device power is cut off during s2idle.
> 
> That alone is not a bug - the architecture used on Cezanne, Renoir and
> Picasso expects this.
> 
> Many of these systems do include the StorageD3Enable property, but it is
> located in the PCI device itself not in a root port sibling like on Intel.
> 
> Intel confirmed that this during pre-production it was placed there, and
> actually for production using the PCI device itself is sufficient.
> 
> During the course of discussions on the merits of different approaches it
> was mentioned that although originally introduced for NVME devices, the
> Microsoft specification makes allusions to non-PCI based ACPI storage
> devices as well, so a proposal was created to move this into the ACPI
> subsystem.
> 
> If at a later time different firmware solutions decide to advertise this
> functionality, it may make sense to move out of acpi into a more generic
> location.  However both AMD's and Intel's solutions for s2idle also rely
> upon calling other ACPI drivers and adopting another solution will require
> coming up with alternatives for those as well.
> 
> Mario Limonciello (2):
>    nvme: Look for StorageD3Enable on companion ACPI device instead
>    acpi: Move check for _DSD StorageD3Enable property to acpi
> 
>   drivers/acpi/device_pm.c | 24 +++++++++++++++++++
>   drivers/nvme/host/pci.c  | 50 +---------------------------------------
>   include/linux/acpi.h     |  5 ++++
>   3 files changed, 30 insertions(+), 49 deletions(-)
> 
Are these patches meant to replace the blanket Renoir simple suspend patch?
https://gitlab.com/belegdol/kernel-ark/-/commit/a83315923e87a169ceb6c839a84ee0455868218f
I can test it on an Asus Zenbook 14 UM425IA if needed, you should be 
also be able to get a considerable amount of feedback from 
https://gitlab.freedesktop.org/drm/amd/-/issues/1230

Best regards,
Julian

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
