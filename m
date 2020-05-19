Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE67C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:57:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12184206C3
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SPUVdKPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12184206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=SPUVdKPlJJKJbj6nla9rlIeMW
	G3FibMZv+J3D8Yyuzl8t+ztJvLJk334phQh5P5AfU2Xw2BTHL9xfynWd/2dzhAcEOAAtZEbBQG1UQ
	zddOefmZ6yjUX1uR6dErK64g0bX0s/fCokbTg5kQtHgfhiIKn7JiqivVl4nU2UPikVc0HOWAN3fZy
	hYYRKNosFzn6mcKDy5DicJ1xZJH8lm2xsi6ivwvMfDk7V8FgHE5ucWWiXP9TZylV8Dx31jKTJ8nGi
	kqDRji6qFYlkIkBKYZLK1+mwCB13e35nWXgHkXlxlSCLs8XCK/THWmB6DwQDINR+0B0V9rjdNcyN+
	pmFs0+XCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jay41-0007Uj-B8; Tue, 19 May 2020 08:57:29 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jay3z-0007UQ-56
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:57:28 +0000
Received: by mail-pl1-f176.google.com with SMTP id w19so3550486ply.11
 for <linux-nvme@lists.infradead.org>; Tue, 19 May 2020 01:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=bw4bebCDte6t6jRY1ANyeRMBLZ0UkRXQpgyabjls5Imc/Phs20lNT+NauR3VvAYxBe
 pq++AaQbosK65qxvNPq/tjZ5G4+AuAndfFX1cbHIOFHyVjMCy++v4JN01vVLyjgKq3WF
 QWYDWqpr4PRIWrYdbVpSet9jzlg8A3RYqXDH9UwQ+zRs0SoyVEBQrdUBaiXu34Z1hXNc
 DoYl7pHyQR9BKn4e5ddh7cxyAYSUcnNsJbjzPj85kKzzqFELErlgc05rrr/ZRho7xaNY
 x1c2fFvGKlrRz5+MB3v0BO423JcWZPar9kEJazUf8mtlQHiS2cByrQQqU9Z19xUY87pf
 LTVA==
X-Gm-Message-State: AOAM531EnO/E1WXZkLfaSMlrblAlzFt3r85aC/8wYFF2OMubwgRoCvcU
 1j7TyyQWdCs5K1hOPHFLEfKoiZAKiOI=
X-Google-Smtp-Source: ABdhPJxIXnRGn0WHAJkMtM19EojVD4VQskn4O5uPNZ+GdSktoqEgE/pJOQg4D4U2t4ut+VxTzFuVIQ==
X-Received: by 2002:a17:90a:6d90:: with SMTP id
 a16mr3923560pjk.138.1589878645925; 
 Tue, 19 May 2020 01:57:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:507e:6065:a37d:f691?
 ([2601:647:4802:9070:507e:6065:a37d:f691])
 by smtp.gmail.com with ESMTPSA id a196sm10699796pfd.184.2020.05.19.01.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 01:57:25 -0700 (PDT)
Subject: Re: [PATCH V4 2/4] nvmet: generate AEN for ns revalidate size change
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
References: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
 <20200519080630.3500-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a1e6335c-f9f8-c671-040b-cf96c6ad4ecb@grimberg.me>
Date: Tue, 19 May 2020 01:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519080630.3500-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_015727_192951_CBB96B1D 
X-CRM114-Status: UNSURE (   8.46  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
