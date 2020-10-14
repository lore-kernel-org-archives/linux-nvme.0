Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27F7C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 19:00:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0152920691
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 19:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qepvddba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0152920691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ix3zyMsiMqrCtdChQsmtf2CO2i8ZEh6k7MiuzebwN/E=; b=qepvddbaraS5s1PHoeh7RlTnf
	s/socrVm1gKwBhZ1CM1kMQyQwAnFRw6i61lRnZOKkgn7aMZ9WbB5F4TqmnE8THJk7eS5Zb/glsAt1
	I1WT9P+u0TvlQ5xqoekRoFqslunkz1Z1seb/N5mC5L/IPXgnmIbGSLmr0argL2vbLa3ekFLN3jMcK
	HcxoukaGLWbkdDy7iXRjgiV9+2MGPqjKX5y48j6xdP677/2BycAv7XL+c0n6QNjjyxfj4MltfveTQ
	zLEmU9uEuK/8eoNfddSU2wnyxrGPkqe00zqPmWEhtMXgrQBZM19b5Tw1avLY6lUPignuRYJswmLoY
	siRTWwtYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSm0w-0007in-T7; Wed, 14 Oct 2020 19:00:42 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSm0u-0007i1-BQ
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 19:00:41 +0000
Received: by mail-pg1-f193.google.com with SMTP id f5so233586pgb.1
 for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2020 12:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wLaTKq22Xjuu2qg4q0rGmB+fJwf3TTouQqQmSiOXGWs=;
 b=XIW/+49mR8r+ValwUSFaJEgjTgRBbA04S8AtowJ/uOz1CXApCpDH2iqpnW2bNnPYCc
 pRZRdGAKdtcyn4UA5ZFf+ztHVSwzTriqjIku8C6v3G6PHk6pLfTPCuOJDnSXY9i6UkC6
 H9b61IS9sWA+r5rYu5tophebt7TnqMDueIfZh5c5ReTYFwTiUexthDBPlw+3l69crD3D
 KXJvaA5ggOLoRvaenMKZbQIFtPwy9SDje8WOOGdG9fGRYq1e49CgHTJcFnF33NjVIoIS
 sUt7uF5570Kt8bD5yXEDltMNzxWIbFj06D5QlSwV3ahWZT74gRdUCqDE7+v0W3BFuD8Z
 lrYA==
X-Gm-Message-State: AOAM530Rt17j0/gV5iQwdYvEsT2A6MolLKhz9bRn+5vOsCIH0v9/hXKu
 V4Oyqjqu8rvCV8cmkv2sNu4pJd7yWoY=
X-Google-Smtp-Source: ABdhPJytz7RA9rGz/EMS5FD6O05JsFeMUv6tOrug+4pY+8qLp7HZuxvhl0dfqbzOSvBznRhpzM7tqA==
X-Received: by 2002:a62:e112:0:b029:152:b36e:b05d with SMTP id
 q18-20020a62e1120000b0290152b36eb05dmr661467pfh.3.1602702038655; 
 Wed, 14 Oct 2020 12:00:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7f9a:6575:dc66:60d9?
 ([2601:647:4802:9070:7f9a:6575:dc66:60d9])
 by smtp.gmail.com with ESMTPSA id 78sm323384pfz.211.2020.10.14.12.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:00:37 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet: fix uninitialized work for zero kato
To: Keith Busch <kbusch@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>
References: <20201014033650.953656-1-pizhenwei@bytedance.com>
 <20201014161048.GA1267726@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <517a0b11-5bd0-4d8e-da0e-e0e0a4109897@grimberg.me>
Date: Wed, 14 Oct 2020 12:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014161048.GA1267726@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201014_150040_410311_4E932AD2 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Fixes:
>> Don't run keep alive work with zero kato.
> 
> "Fixes" tags need to have a git commit id followed by the commit
> subject. I can't find any commit with that subject, though.

Fixes: 0d3b6a8d213a ("nvmet: Disable keep-alive timer when kato is 
cleared to 0h")

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
