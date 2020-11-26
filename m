Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89619C56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:56:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC63420674
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2VSFeiAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC63420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mSpucCM8ky8unES3c9dcUtAkGtpIhyjpgF+ZZ8SEiDw=; b=2VSFeiAd+Hy5KlFwHBl0CtD01
	dotP3YA/MHtjGrhzPnVn51RU/5pPTEikf2MSdap2Ve9HzxY1BTXJKCUkwJCwMTRSNHosYr+YQkPp0
	IH8yX8aBLgqB7fnUvF4iwRmX/Kjr0EhaIuCjLv1fGSsZwU3QcFuUlOLPGLOhQMMQW34Z2z5SJ1m3E
	FvUFxtrrIkYTZ9Dq1K3DkbZE/iIU5rrjgi550Uout5LS2M3sCbvA9osceSyG/fR+ucBur4FQrXVku
	3soy1pG2MaCAT04EAHYpuOOC+q7jchw24TANtHmr6e9qhGVPkyqNTUrAwZw3DwhBI0FQ0/zUOGsqr
	C2+mvBYtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki6W7-0002VM-Jk; Thu, 26 Nov 2020 01:56:15 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki6W4-0002UX-UY
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:56:13 +0000
Received: by mail-wm1-f50.google.com with SMTP id p19so2685623wmg.0
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=odxJZkqlu+siLH35++w5DMnsk0gK01M6OWAnAvclPbU=;
 b=WjjtS8Tiyzuwslyb27ZnfgZp28OKUUpWCRP6ADAgTedkQhOizT7Z6BLPcc5laYiJlC
 HW0uOQoGlRsIsNFC0feDqOAlPK1MINhclIolKWTzN0FX9G3XdtSBY3lCVZSgtfkxHvZD
 LFUyYYQp0GjNOIcafX/CVPvN3wrgZUOnm7AKq+3dpUGgUJHoPzdS737BE9g3obmwilnk
 MCPkGtiATTR0zlnf2yTAsTfq/Enhq3LuhWfGvGhKgoqBpruaUpgl9uQpbeeF03TCkXVZ
 zuLHJMu7pgTZz57BQvHfXOwl4/lK6qykIunZIaJksBO8Y5yM4RXNIVzEpPp9eh6pfn9L
 aVfA==
X-Gm-Message-State: AOAM531vQNUArpMB2T75BjAYWxSItT2Jic9KEKLIiHdgHzWSqeDSmF09
 oSje7HXgai/MH347ET1fqOo=
X-Google-Smtp-Source: ABdhPJxXWmJuvec6mk3P/KkwLj/pqihqCmmCzizaENswXsxgTfdzrxGSmHOx7BG8Uv0aXdQVpeyOBQ==
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr559324wmf.108.1606355771812; 
 Wed, 25 Nov 2020 17:56:11 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e57:3445:eb42:2ba5?
 ([2601:647:4802:9070:5e57:3445:eb42:2ba5])
 by smtp.gmail.com with ESMTPSA id f19sm6263318wml.21.2020.11.25.17.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 17:56:11 -0800 (PST)
Subject: Re: [PATCH v11] nvme-fabrics: reject I/O to offline device
To: Chao Leng <lengchao@huawei.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
 <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
Date: Wed, 25 Nov 2020 17:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_205613_089446_F1286DFB 
X-CRM114-Status: GOOD (  12.09  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Ewan D. Milne" <emilne@redhat.com>, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Looks good. It might be better to add fast_io_fail_tmo to nvme_dev_attrs
> so that it can be viewed and modified dynamically.

I thought it was added, I recall asking this in the past...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
