Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E7C10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 06:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7E220578
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 06:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SktBbZvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7E220578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=67ffU2u7v5qz1eJksE6yeMSBnqSdlvO0JyZros2+D0o=; b=SktBbZvH3UUsdJ/8ESHl3BzCk
	lkzEEs4pUUuxr5p+ELMBVZFLCgLTLGFnPtIML41phhzx9ly4FMyurjjm2/0NshD5a+NAnE42HG9IK
	S490oozZmLIxsoMhVQ6oMLyCLjOrrcPhCN/vZhW046rwGNpHpbq3VHHMeWtpSFvPa5Ld349u+lKTD
	7gTgQK3RB0GDEOZ6CVXvP3SYfJ+hWSCeAEW+W9O0RJD0Fpvvs4qBF4jPbGXi509Kpe3D+SjKZTUFh
	Uur6CUeEMmRFkiQ55uzU4q9+Ya7qdy/1mMj7/0PET1Im969x5r1FOORzgf7O/sXnjKvnGsJjJo9AA
	rvzZ9h7hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCHbG-0002FT-Te; Thu, 12 Mar 2020 06:45:46 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCHbE-0002E1-5J
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 06:45:45 +0000
Received: by mail-pg1-f196.google.com with SMTP id a32so1711150pga.4
 for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2020 23:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GNA+Q2QuREp4VI8fH8c2ZIzaMlRFL0on7PPkAjzW/oM=;
 b=FaInuy3l1f8LDkrUST6HsdgKNbasmOZHUh35dyFDsRNySgoLkQTwTR+B/NkSrb1luK
 wQLw1Vk4Gjz1L8+ik0o0I07eXh0LZJs9Wb2UBRoEelopz4+uksAtd66SW5YcQLaqeRBk
 JDdZQUJizpmBFYKlCFda+hzKEeRTyt/BQdUgijQ5E5LFYp2naelKoULEAHEvfhLJOHA4
 08lxSf0uC47rbECyZpvI4uPt6Dz9sMoPHwIXTdk575dWX7q7+dvEJgR25cZfx414ucwb
 dMiXg2jNXRjFbJJBML/Iqx2zQ6N6y/PoYJk319dxQsifsZE+JPGvUi3p5U67wyuQ6nbz
 Qmow==
X-Gm-Message-State: ANhLgQ0pDpb2yQf9SEaru46XHGlbhuoNpOLEsxHXKeKKbR0rm9UkLHw4
 t5/60I+IFmoMaycYUXxReltOYOuY
X-Google-Smtp-Source: ADFU+vuB7Um7yylNn7EhUevoiQ/y3hKdAhROdSvi7VCtGZ1TnZl1to07yZmU05LmZwb3bGy3P4QRDA==
X-Received: by 2002:a63:1608:: with SMTP id w8mr6419758pgl.235.1583995543338; 
 Wed, 11 Mar 2020 23:45:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c47a:8519:9343:83b8?
 ([2601:647:4802:9070:c47a:8519:9343:83b8])
 by smtp.gmail.com with ESMTPSA id q12sm53287829pfh.158.2020.03.11.23.45.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 23:45:42 -0700 (PDT)
Subject: Re: [PATCH 4/4] nvme: Fix controller use after free at create_ctrl
 callback
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-5-git-send-email-israelr@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8d294ef5-ca01-4458-441c-b987a173d39c@grimberg.me>
Date: Wed, 11 Mar 2020 23:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583938849-5787-5-git-send-email-israelr@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_234544_214400_1CEBB047 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c0d9b19..7976955 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3224,6 +3224,10 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   
> +	/* Can't delete non-created controllers */
> +	if (!ctrl->created)
> +		return -EBUSY;
> +

Not ideal that core checks attribute that fabrics is setting. Maybe
move this to nvme_start_ctrl?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
