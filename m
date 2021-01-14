Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CABEC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:12:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FEB23436
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FEB23436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZZMAvV2YPFEhzc2afVVc7ROl5NdMQYspElny+cvqs7Q=; b=IuNtyKPS4KN/0shOTV9YaoiDQ
	t/50PEeS0U0PdPkaJvpYwLkzbGfM41Q+l1cWLMKR39uQ5bRSYH+pWOKXhk8HfJMETVyIaUlU16eou
	GGCEjhQqJUi0dtW6J9737Y/Z+E7qBmW+Ic/OQUwPqV1B3Rub2DqIy0TIDYq3PhfUIFWwe7s1XUuJi
	QvBjrXRpSZNyYaHAU1VVMajsI1MdkIKhcRR5bOg4ysHpaDi9yqFqwy8PsxYPUc+0LD1vfpOBEOGMk
	9asky0whLlimbGCji+dAFB2v3hcod6/DsSq9cxJoXH4GFS7bPHg0c0sdRL7o2Fd2LFYlIe/X/wRf2
	rS7F81gEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09uj-0003qF-QN; Thu, 14 Jan 2021 21:12:17 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09ui-0003pV-7r
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:12:16 +0000
Received: by mail-pj1-f47.google.com with SMTP id b5so3939734pjk.2
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KnuVfAtOhdDd6AxaYoEOIcC/sU9umgi7dsrz5SmYIBw=;
 b=m3PrhEeyGlL//WI+JOaR3dGJI73Cbqgfahmv9AN4ucftSz6UDCqukSQd7ZXlrHUhgS
 hHcU5vnlM94f5IsiyhZKQk7wugQGUjYbu7BkBTUxWOJ7qfm4dhZ5TD1ulPUb6ums0Giu
 R4wObiqMOU+3zD2JX4A2pJ8MlSH+/1AXLs88fopBL5llQWqS49fGX8ByCUpAKEaompjV
 ggc26CXsVzwTh69NwkkglXk9HKoc/unG2EDZ5WnZe9Jeh0q/GN09FiS5pOoTTMsIvwIx
 X3z97cJ9gKN3eIJDcZCNqQ4CKsNJyOsDoa4E7sOpgyhNG9HE2W3FIMOkRVQLuzfNfw87
 8KQQ==
X-Gm-Message-State: AOAM531hCaWecFtIDmfSsJl8RyRvsGpJPpaCQZ91ExohG6ZOmdIRtC4+
 4/WQmR90irbfaMXAEIL1veg=
X-Google-Smtp-Source: ABdhPJwZJlvkimLI1d2p17QKL8ZCDYpTVMShchpNXn5Gt6p4au9Yw+SbensmpNflMH69IK4N20RCAQ==
X-Received: by 2002:a17:902:724b:b029:de:229a:47f1 with SMTP id
 c11-20020a170902724bb02900de229a47f1mr9427653pll.10.1610658735092; 
 Thu, 14 Jan 2021 13:12:15 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14?
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id h1sm6745432pgj.59.2021.01.14.13.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 13:12:13 -0800 (PST)
Subject: Re: fabrics connect cmd with a non-zero reserved value
To: "Engel, Amit" <Amit.Engel@Dell.com>, Christoph Hellwig <hch@infradead.org>
References: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
 <6e271be1-088b-5a23-0eec-23578f707c28@grimberg.me>
 <69465d48-5a63-5c49-50aa-39c4f921ed4a@grimberg.me>
 <20210114173546.GA1872345@infradead.org>
 <SN6PR1901MB202982AC06FA1A12157B9837EEA80@SN6PR1901MB2029.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f957564e-bb63-5c00-f2cc-65b562c930ac@grimberg.me>
Date: Thu, 14 Jan 2021 13:12:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN6PR1901MB202982AC06FA1A12157B9837EEA80@SN6PR1901MB2029.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161216_305261_380B2E35 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Since the data is coming in the form of an sgl, the reserved bits that the spec defines are not really reserved.
> I would expect that the spec will not mark the second byte of connect cmd as reserved
> (These reserved bits are not cleared to 0h)

I tend to agree, connect payload can and does come in a form of SGL, so
it appears that PSDT is required also for connect...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
