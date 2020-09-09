Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB909C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 20:52:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69ABC20768
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 20:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TSntz3WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ABC20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=TSntz3WLTx2QoNS7wb7Kqhb7d
	1vI/mlyMEvWYkIZWC/jYgA5Rf3cCLvua6Rnw53Yw6UbYzK9bNGpRwasiJvaXvblc3MrR+LiVoX11n
	iuwbIyeMJIOqlMaAE4u1uO19vyTYGr8P4sPiS4jZ9WnxntpZG3NoSmVBxX3QDHEDigpqBx1IQpTBV
	XzYmTXR0D4iBb6ige2fRtEmHSumkc2+GzSVaQ7g1GAk82RfJLLS++/JkbNKhI06MHm7LEqloE2Bhm
	8Vdf62r1rcFAgJIce5Cp5IlYwx9mw4/YeWo8l1SDzWe/mYasVfVJFytZh0B6/nLwhLLISoWmLEZoo
	imgS3LUBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG74r-0001iq-QW; Wed, 09 Sep 2020 20:52:25 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG74o-0001i4-V7
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 20:52:24 +0000
Received: by mail-pj1-f67.google.com with SMTP id kk9so1951806pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2020 13:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=sXWmVzE6EcBN2YR2QEXhAY+nl0FPwirblpjFNmE23y/R028Bc+Jm9ym9GWCJtd3/Cz
 hmo5XhfV8sylufyjkGzkj3rqOdO76VUrOyy7+ydSMFhzOq8iNI9Jk2/BKDM6EfWeOQEV
 454zmFGz4C/YY590t3KN3hj/0DA9fLvl6OEYiQRvIp7YqKj4tzOFDL1dy5isf7SAi7Uy
 o3Bhvlw0bPwVbNvtaED3Mc+6yeODwZykKFERXUTb+uRjSd0MuB4IniwEKu9SRwS/3QNH
 dwjVEVz0BME7AZRr8IlZUDPmZmMYElu86PbQ1HD/BZJRKwaTGdDbR/DPb5DEk+PKG7qx
 ny4A==
X-Gm-Message-State: AOAM530TkfQ3BLiCacZI7Z0ZWtyYkHz5rNNetBMOplFOWrz3tTDp5KrF
 I61d3Z5IiK/jycvJcGUnsDF4OkTsDlk=
X-Google-Smtp-Source: ABdhPJzxMAC76x8jC5I8Tb0iJy0v72TtcaSQpk/1lFpsgtSXHaOV80l2VVenbSITY6WG+/77OZNKLw==
X-Received: by 2002:a17:90b:1b50:: with SMTP id
 nv16mr2310785pjb.153.1599684739838; 
 Wed, 09 Sep 2020 13:52:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5905:3209:6aa:d817?
 ([2601:647:4802:9070:5905:3209:6aa:d817])
 by smtp.gmail.com with ESMTPSA id b18sm3011822pgk.36.2020.09.09.13.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 13:52:19 -0700 (PDT)
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200909203324.3356679-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d5fbaed9-c586-522a-ed0d-a52c688268b2@grimberg.me>
Date: Wed, 9 Sep 2020 13:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909203324.3356679-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_165223_014616_30E84196 
X-CRM114-Status: UNSURE (   9.58  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
