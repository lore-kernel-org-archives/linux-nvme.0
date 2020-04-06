Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A23C2BA17
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 17:04:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833E921974
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DbxjhTrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833E921974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=DbxjhTrxGHIoV3CLfp/y0Lamb
	CfrNbJg3QjZcQg3FGQBOfoFEZNM727NCQJ4/9Aq4cTSnA83sPV4BpVaP11NuRWE9hcIdSBEFL087U
	QjwG5Xe4OTG375l9FftA81HpqYlwq4d3LzXPpME0SN6Cb7MKPo1MmTCOlV0onuygAhSDMVoQhuJaz
	n2ReqYkJNZcNfMxzE+xJW/4HCitiAA3pbTheaBGpIMuwffjUF/mQmnzO1k+DaWcig1Nkdf7i1oSrI
	vKjpv7t3OMPABeiSLRXlAFXSGfo40I4p7jDO6dkD558mT+Tn7syqQBppdHq+lwOB25W5Gj3f5ils0
	tM8wbvfpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLVB1-0006PI-Gr; Mon, 06 Apr 2020 17:04:47 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLVAy-0006Oe-PO
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 17:04:45 +0000
Received: by mail-pl1-f194.google.com with SMTP id t4so21809plq.12
 for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2020 10:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Qw6NUvjmSe4YgyjHgaRd5M38ryfvV3vbg6RH6++OvE3/qBxnNh9eERV8cerUk3y0m3
 J6JPVBLCGiAbY1RHTTPZHYvXSvLWt7pAZcw2SNKc3/J8mlAnSswJNRvsG3uNXd0vn32M
 RQhP8n+Qg3GQTX3PGbOtUYSKL9Ltm7m4ZEAAaH2CAW6ZHwq7Pe1Sk3DjYoRjtFChijuX
 NQeee7TEH81k4qkQS5ZlgmoKlYtGJTe+nvWgBBAg1UGJT2vZo7GbBQJmhdanolVMMV5b
 0eLrE5NJFDAW5MmbKrD0U0xhqK4ErNWOQBPwFlMOjcx/sz4RuVVdObxaZ0AE83CFoRhC
 hmCg==
X-Gm-Message-State: AGi0PuavNn4sf/NtFkZIlUW3PPSnSg/ZQ2w1r4LZyiAwA+b/WZ3B4hLw
 S3pQqNH4Vw43XlD/kRd5c9yV18aN
X-Google-Smtp-Source: APiQypJDbH3eMyhU4Wj9uCvUoVvGUVjt/TkVRqYSeoEJX7GuFATqgEEm9uj0WrPSrypWmqHvRJ2MGg==
X-Received: by 2002:a17:90a:cc10:: with SMTP id
 b16mr148126pju.29.1586192683091; 
 Mon, 06 Apr 2020 10:04:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e891:e4b7:ccee:cfaa?
 ([2601:647:4802:9070:e891:e4b7:ccee:cfaa])
 by smtp.gmail.com with ESMTPSA id w127sm11988500pfw.218.2020.04.06.10.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 10:04:42 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: factor out a nvme_ns_remove_by_nsid helper
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200406121352.1151026-1-hch@lst.de>
 <20200406121352.1151026-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f3baa34-ec67-8632-e331-1c470221343a@grimberg.me>
Date: Mon, 6 Apr 2020 10:04:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406121352.1151026-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_100444_817780_A2BA19B3 
X-CRM114-Status: UNSURE (   8.95  )
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
