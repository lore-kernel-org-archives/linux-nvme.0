Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE2C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C441420734
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JILd1Ysi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C441420734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=JILd1Ysig3UiGs69reN5MfBBt
	qp5FAv6TmGD0+gW+H5V1mfcXNzNz5Kumh24akejPjkVD11qyljtxJ9rVQjSIY22Uy2jcnptcrLcBN
	fIJX/9OJY6c/maCoi9qvLypVIhRwC8SPtFluzecIhkClCV5Ytm8zLlblezQphm/bR3DZvax1s0mxd
	XUAVyG2qgW0cr0x/YGCwKqW4Xb2io3Te0+2zdCMmxRMOojavwkWDqhLz1gZSJ5PCEUFqyOTo8qc2d
	o7Ko4YrU5fbkGLkdE+Ca7yau+AFNaIh//WzRaUMGN0a2xf9onBXZbGaTEYyF2MzERQUSl8R61//NZ
	OnV2QK6iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgabc-0000OL-9e; Wed, 03 Jun 2020 21:07:24 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgabZ-0000LV-Jb
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 21:07:22 +0000
Received: by mail-pf1-f195.google.com with SMTP id x207so2347762pfc.5
 for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2020 14:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=CGm5d3XLpIuiTsI4uDO0iIQYwg9+WEvSiMJy2pLbnyLEJVrF9gromMNTFsOm9y5yd0
 muEpz0mL3lL5UMLhOU2pdBn9tFFZzz6OTevd12NG4b1OZ4F76ZazqHUuC4waww/k05zH
 fLBOrcSQyQGJ2L38gbXO0wfUA/pNWM2EwfGT6An80s1r41HxEkcCyHwmW8Gr40MLqhBS
 RCp1/glKssHzuzMmw25BvRNI44/SMqq6MxXSgAb/7B3qpFxn9nqcRYeczoonM/lP6EDO
 HGZFyKCTL3T+P0irS4a2TeziwLVuPLpuMDCqZxdaCvKtr5ZhwcmJVVBKWOtdCrYqziJk
 Vjcw==
X-Gm-Message-State: AOAM531KHu5lGgKrR+Ox03h2EMlJP4kGa7zYtnOBffn1pwA0BrOZzlwi
 5Wy33gMSxXDUROsESroiCoo=
X-Google-Smtp-Source: ABdhPJw8VyCZwcGdKIMZhPlJ7LGazqIc1xm8CaMm+NWC4AUVTf9Pp83ruW5twUH8GnMBcFFcY/RsGw==
X-Received: by 2002:a63:5307:: with SMTP id h7mr1281357pgb.28.1591218440936;
 Wed, 03 Jun 2020 14:07:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff?
 ([2601:647:4802:9070:5409:1488:6d95:bdff])
 by smtp.gmail.com with ESMTPSA id n4sm58380pjt.48.2020.06.03.14.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 14:07:20 -0700 (PDT)
Subject: Re: [PATCH 2/4] nvme-core: use u16 type for ctrl->sqsize
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
 <20200602024114.5153-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1be3d81f-9b45-9a77-756f-a6c6cbee4bb5@grimberg.me>
Date: Wed, 3 Jun 2020 14:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602024114.5153-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_140721_642998_54FD74AA 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
