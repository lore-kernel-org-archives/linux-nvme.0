Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA0C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 19:24:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EC6208E4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 19:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T2uLRBYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EC6208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=T2uLRBYfScFast+IPQqF2x1rX
	AZNm/vU+Xs3MLLGNFiwTIjVu2UOuYbNq53sPUH0XZkz8lMRAIRNvWdQURmD2rxN6OXsSjnBR0RZsd
	Sf1jUpGWsHi0tsMeL5daTYnyfyhCunzd9ggJ/OTqTVIVIVH4FbIc0pb2R9q7/+FqMHEubpzPSaRiS
	3hqVxp2mclFAPSXUScxtcEHDJezmOW7/WBVYBT8mpY+UoiViVPd/UbRY+1t3m9eMmxPfPJkaydit1
	G0ahSVG8aDnFjWK7sMtW09wFtvf4nM1zPPa4L1Kwyt84Oj468RaYXm48Ymz7z5hxCFUrhk8r8WpuG
	Y163CO0ZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHu5A-0000wL-98; Mon, 14 Sep 2020 19:24:08 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHu57-0000w0-Rt
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 19:24:06 +0000
Received: by mail-pj1-f67.google.com with SMTP id gf14so383700pjb.5
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 12:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=L0YXBdG/DjpahSLkYJSvcQXYK7NPcDJ2J6S3+YCzmqD9isFpjN6ESjB/OS9lWoaYFP
 FLpWrwZRd8Henla8N4nqciqxFJNTepOHCIKkcIeDVBafRZHZ8wcI9IN14hswZup6LtU3
 d5l3vy943K36SXOmzKJLhIHnnPqdi/+aAP7yW0ZkW/mGrhmuAXlaalF+KXnKoGfJqZOs
 KNb+GsVXF8NDYeeE4GrRZpyQl3knaV3gEdlelq+npuVCX88CWaAilU8R4MnGRgv5mg5m
 pR4p3yIKvd6iFa3FiTCu0ajvccwka9PKPjHrxteiOyPWWFLP/tKpoomCao4iAivZ++vq
 G3rg==
X-Gm-Message-State: AOAM5302HNBKjZoTeBOTqGuu7UVWT/x7GDHJaPZx+433LpnEQMZYVvDq
 2rx1xIf4zVB9DG7r8G0386s=
X-Google-Smtp-Source: ABdhPJyddSjog0goVGlIWPNpsvrBy94cg1B7x5SN1ImNplM7Z38gjz26vYzZEuGzRbr7X3Jw2f/UHQ==
X-Received: by 2002:a17:90a:e391:: with SMTP id
 b17mr780389pjz.127.1600111443016; 
 Mon, 14 Sep 2020 12:24:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4418:ad86:982e:2b02?
 ([2601:647:4802:9070:4418:ad86:982e:2b02])
 by smtp.gmail.com with ESMTPSA id m25sm10776090pfa.32.2020.09.14.12.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 12:24:02 -0700 (PDT)
Subject: Re: [PATCH] nvme: tcp: fix kconfig dependency warning when !CRYPTO
To: Necip Fazil Yildiran <fazilyildiran@gmail.com>
References: <20200914150120.449602-1-fazilyildiran@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <52431216-658d-1909-e460-0e15c766ee07@grimberg.me>
Date: Mon, 14 Sep 2020 12:24:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914150120.449602-1-fazilyildiran@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_152405_944512_B53648D9 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: paul@pgazz.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, minwoo.im.dev@gmail.com,
 kbusch@kernel.org, jeho@cs.utexas.edu, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
