Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004BBC433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABD0214DB
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bTQV457Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABD0214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zjo5T1a7wKZtxOVh88+Ji7YQUSf5btRma20/LaV1bKo=; b=bTQV457QtJOu8Qblu8Pwt2yvS
	4dni8rYBCTOAF8YTBUYIHhRI03/CDuYFEItHcbvJruMTRlcXj+98/IQJqpHveEcaojQm1+vQb0h/+
	l/uFnNKavvnbqCAovIdAzXW8OypcUOaNd2Ok3uRBaf9rXhz6/jq7fMXQX15vmZPCTWH4PfjqgMMF0
	qJeytKEDVx3EuX5DPY3sVxu7PBO15ZeNCAjWGqvx9dKwRMpsf4dhaHEK9IMlqDfzr5ZIcCQOkjtgH
	ofgzaqhyeFWwoOXvlRf5wFiMLktMl4KdzjIrOlDwxNteTwBLYcTNlbP2wmlBr0x/7+HTh8dqXiOXs
	VmJq8neRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqnza-0008IK-NG; Thu, 02 Jul 2020 01:26:22 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqnzZ-0008Gp-8o
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 01:26:22 +0000
Received: by mail-wm1-f67.google.com with SMTP id f139so25756694wmf.5
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 18:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jPzt2dswdj0fiwbbcuV4sGMcNtPMuY6yxCS7oyA571g=;
 b=DXdOSv1V8a1lbyWhux27S4hZ9V+tAIi/+maAHgBjnPpWXwlbW7NByyuhfFbheuTiIn
 Ql693OvCuJhPz2R1Tlg45xWacZTOfWTMd5LHDpi3z/dx1c9a3r9qSDMpVEEu0nwQpjCH
 cUWxumTH/IiDPdYnTN++QeBxH1hZ1w4Qg4MndzpGkhK8+1oUmlYq1YQHW9/qCaSU90H3
 99+XPxkVnvy0u/OMjAARWkwIcMjwWKgK0fJasCyIpnry2w62XuEWSdt216zVlSoJe/iC
 2ivUqk8dtkHld1dFARavTvYFgHKIAdocvLUHm+3QCy80SdwHeK6ypB8Jxo1/NCxvwjoZ
 Do9A==
X-Gm-Message-State: AOAM533LVkLUe5bTU7r670woWS0gioyTjmRGxbj2nCaApzjqs7VktG5x
 QER6J4c9HCOoD/W7MCzqB6MR33l/
X-Google-Smtp-Source: ABdhPJwljPT+Gu50iKc+F9Qbk3nQy5Y4IJNEwrq9frjSPy9h/UCY58VlUs9efHvMcRRtZV8gC9cmUw==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr31038738wml.128.1593653178440; 
 Wed, 01 Jul 2020 18:26:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:18f8:9053:b0e3:60d4?
 ([2601:647:4802:9070:18f8:9053:b0e3:60d4])
 by smtp.gmail.com with ESMTPSA id n125sm9252785wme.30.2020.07.01.18.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 18:26:17 -0700 (PDT)
Subject: Re: [PATCH v5] nvme-fabrics: reject I/O to offline device
To: "Ewan D. Milne" <emilne@redhat.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <cde32cd53001412889cea1e1fe28e7f7@kioxia.com>
 <8ddc3564-494a-d32d-cf97-ce7d8174f91c@grimberg.me>
 <b44b1328494628e4e0fdbfb226a7ffffc9a139a8.camel@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <64fe71ec-6d06-0789-3dfb-4861d2621eb5@grimberg.me>
Date: Wed, 1 Jul 2020 18:26:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b44b1328494628e4e0fdbfb226a7ffffc9a139a8.camel@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_212621_363804_6AB1108D 
X-CRM114-Status: GOOD (  11.64  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I'm seeing an I/O hang followed by errors returned to userspace on
> NVMe/FC and NVMe multipath with the v4 patch.  It fails right away.
> This is with a test that does alternating link bouncing on the target.

Thanks for the input Ewan, I think that v5 removed the fast_io_fail
hunk, so maybe that'll be worth a shot.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
