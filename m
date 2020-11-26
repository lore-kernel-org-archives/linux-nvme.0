Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C8C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:27:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E4921534
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUyNLbO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E4921534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KKxbBWPo0Q39b+ctCe6t/7QSVvO2iSDKTou+Uw1ERzM=; b=EUyNLbO5zzpbyuA9zYM86S4yy
	1DW0si6p7PXVORSqvbCNo1FKwh+ozBDWznPA/EUtc3YHEHKF1cMC/k2nkWZnbycJa97h56xMYzpbo
	ybNtgMnvdmxSmTsPyswKBhL7IIXt4t5T4nXdxkSG2jX1DPaDOu78+kIXlDxR0taVMp4lGQcd2vOOx
	J6n03DwU4UHB3FUIyC/XgzWLEm8JnmY41dDNb8QdCRAOSEVZVB/ntFpWmH5xQtSm1MueU99t0K6BP
	/VxKdPcTuuS82ZFgBY40z16jGsEauUVCELHrn/z0tzFltYJKw/lOufD7FgaMvsHNGVmmlJrX+lFlt
	4OyO4gMuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki642-0008PU-ML; Thu, 26 Nov 2020 01:27:14 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki63z-0008P0-Jo
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:27:12 +0000
Received: by mail-wm1-f65.google.com with SMTP id 1so551054wme.3
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+YL3ENn2rZ4J/3v4ILxH0gAmJsmEcwULuDnSQIjvmZs=;
 b=fk3hI62LaDJvJyIqDngyiO+KNTPR0fpCDx5cmLOeQacxGmQqtDidh0Ok8h1F+tc4ZM
 5Q29jr2yo61Z0jZ5U+3EiCEUqK8deg7c3B4YilStXwS/AvoBsue1/gPEgUrP7hIgy85x
 OGK8D0DlZuSvE+Ru1ivZkzqlqnVY4+C3PsUFzGLvEru04sJdqXXezwnZMdm6sJjeXjP2
 Of1ETkWzAHiM9uqDajVjAIZ1SgZ45YY/54ZeDIoGwRsQgQaoFzMMg4t2KvSm6GptvHII
 cFLeOMVSa/sDMstO90ldvolcCkeA+FJ1nnTUwvHltDrUloDpjX1TriGBtKccOavZCJ4l
 bgdQ==
X-Gm-Message-State: AOAM532TQKV93mif5eNXndOtmtmioE0lk91Qc0oYrL8GMIqG9zvWMoct
 dTkXPz4KdpvObq6KKV5kTo0=
X-Google-Smtp-Source: ABdhPJzpOLiujGVEVKr7pnpjw5IglsRZtTW0XvwCOpT9W6Iu0t96NF/hFYkkSdXn1hKzuHz+5ye/9w==
X-Received: by 2002:a1c:e042:: with SMTP id x63mr494298wmg.68.1606354030470;
 Wed, 25 Nov 2020 17:27:10 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e57:3445:eb42:2ba5?
 ([2601:647:4802:9070:5e57:3445:eb42:2ba5])
 by smtp.gmail.com with ESMTPSA id g25sm6206620wmk.5.2020.11.25.17.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 17:27:09 -0800 (PST)
Subject: Re: [PATCH 2/7] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
To: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 Erik.Smith@dell.com, Douglas.Farley@dell.com, liuw@vmware.com
References: <20201119142107.17429-1-smalin@marvell.com>
 <20201119142107.17429-3-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6ccea1c2-383c-e542-dfb9-d3c81a163f07@grimberg.me>
Date: Wed, 25 Nov 2020 17:27:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119142107.17429-3-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_202711_675278_15271C94 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: aelior@marvell.com, agershberg@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, dbalandin@marvell.com, malin1024@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This looks reasonable...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
