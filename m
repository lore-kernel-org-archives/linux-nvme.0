Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DBC64E7B
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 15:57:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46328217A0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 15:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46328217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xuw9GgM3KXnCJ6+MYzhRoT19YQrvXNi9RxvgdlRytZo=; b=gK1S1fRp6NfEkxUxyz7UqTQtK
	TRroly5Hlw5E8iYHCrlnDA+OdS0m+XwbzKTTq9iXG1Bd9IOaK0Y4IpabzxOp2Z/2Uo5Xv/1W0PzQv
	EEbeNXMMyGCr/GS/WbHol4LWQ4RI4plz7pOEh+OLhBSESztyRkxH9Vrw2hL8T+DuwxN4vxK2zb2T0
	PL2rcpTCfCjqD0aHJ+zevVGZNqFVxSRWlwNi5ZCdsHWkXBte0+IqatAWA/qo5tPmbbBArl3SRyUj4
	gEmY+Yh14N35l3UgxMjMIA+zeCvv+RGq+kIut/l0jxHQdRP36qiUNkjGavQoYcquweKfb2A3jZ7Jm
	lPP2QQ3iw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkUVi-0006dh-Lc; Wed, 02 Dec 2020 15:57:42 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkUVd-0006ae-IV
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 15:57:41 +0000
Received: by mail-io1-xd2f.google.com with SMTP id j23so2413503iog.6
 for <linux-nvme@lists.infradead.org>; Wed, 02 Dec 2020 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EwUegCCtoiOqTe1WLKSG6GoeoAUOBpqMnMBopVd31OY=;
 b=UGvmlcyL3xZCL1YHN7IiOFmWmNcWCVYLeuhrb4G5XUMX7PxER6ke/+TeIIJReHdHto
 ppF0VQt7Hjf74qZQwhmQBcq6ngbvD9RqivH8w+vtrqQn1URXfu4nvq6TclF3lZftclNo
 Oybd1poZd4mpZspF1FW0v84RdbNfA38O9f29vqXHi+YplT+5eOciwrawljGN9O2ZZCfW
 tVx077PVhxumJmN8BKoWqByWpikUxJEH13XvbLdAQEZMwolvPtx1hlQTSeEOVQVh6/TT
 Wyq5Js7VRav2L7RlJ5cPjVyCqyvbSM3fzREG8Mbnro9B5uCknoe4eAP279UF7pS74GM3
 gRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EwUegCCtoiOqTe1WLKSG6GoeoAUOBpqMnMBopVd31OY=;
 b=NUTMu+L2cq1v6nvHpOpIPM+yA8lQlGz/mzMLXV7dHtLbHWQsmlWETOwy2uhfwzVV2K
 M2eLtWPQBQAnVsayFGvSsbfjZou+sj1yicJcwG+uY/EzadOnHXgv7VMhFeo3sQif1avu
 wxLR1jnvYcWZ5f0wvG2xV1XrYeuGGj/xVN0f2bqxREF+CtM6fVzI5T0EfFAxo7kZ72IQ
 GOo1x55as81YkP+C1K7J5c69mpzcrqxqViGyHWpDrYrR6i9r0vWyYOjIZEL/KbjmNc/c
 X3WRpxpRZkUa/MtB2l0mfsmwQcSoF+5QLFiOR45bzwKAcjCfKaT5bsM5rA/V6/U5gByF
 QBYw==
X-Gm-Message-State: AOAM53197d2SCv0a0JyKgf9hafz0hUy+HokEd+Wb5HjmXKfErZIoiJHX
 NwOG1KaCmUwwBBJc8/lFSr4sNDjKI3kjuw==
X-Google-Smtp-Source: ABdhPJyDnO9kCE403mrZkpxn7VBVAx3kwrYK+p5fJ/mss9JvuJJbMnlKq5O9HoHvb/189cEv+JzP3A==
X-Received: by 2002:a05:6602:2c8f:: with SMTP id
 i15mr2547840iow.66.1606924653601; 
 Wed, 02 Dec 2020 07:57:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id b12sm1272034ilc.21.2020.12.02.07.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Dec 2020 07:57:33 -0800 (PST)
Subject: Re: [GIT PULL] first round of nvme updates for 5.11
To: Christoph Hellwig <hch@infradead.org>
References: <20201202132549.GA2060796@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4cbeda1b-dbb1-1743-7843-1cb04891f00d@kernel.dk>
Date: Wed, 2 Dec 2020 08:57:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202132549.GA2060796@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_105737_797547_F11D3CA7 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/20 6:25 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.11-20201202

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
