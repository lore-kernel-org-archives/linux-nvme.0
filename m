Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD42C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vd//EGDcpMm/BxLwJt0esCXimPX2NSIOOeKqRDVyVCw=; b=OGDHnn7E5LkKeej/2yJxT4i8ro
	XOAFmlttbtYpb77mqBAIE+axDObcyQ5FEmdXvGbszZ1naLvss6L/7OdMuEZAQA2KbZBb4KsAcrs6x
	DNao2XSQ9g4N6jfl/qclN2UOyfRO8dQ97D2mm6kTD2LOtcyx5iZVcDm7KzRNaIM+fUUYSM5nce4Lx
	uyqO20hvTlGY7q7JMfuF1KBdI5KaXGIDgZwW+cPSky85GiIpJzp6Yf8vsA639V0rF54XsF7Wcesjz
	AATAQAjDsHExZRGd0bpTV19GX+ms7TtT5ikOF2UTygTB+3xFBTnwlZSac6tT83Q5J0S1vtk3xBjMA
	hD/5hAqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx5Mc-00DXHC-8u; Tue, 14 Dec 2021 10:48:54 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx5MY-00DX3B-Vu
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 10:48:52 +0000
Received: by mail-wm1-f43.google.com with SMTP id p18so13890357wmq.5
 for <linux-nvme@lists.infradead.org>; Tue, 14 Dec 2021 02:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vd//EGDcpMm/BxLwJt0esCXimPX2NSIOOeKqRDVyVCw=;
 b=lLdRuHpoIgypV/dXczfdwJ052en0cGcriZ+94sq3qArSbIy2j0i25QJZXEynEr2G8k
 i+Wir1UC+U/alGru8rcVekglXTBW9x9g0SQZFtLFfYHKIU7YuGt/1/dNjePWvtcuARlc
 MmtRieycfu1Nu9N8PnSZCaqMK+RQHUFZ8kyPTMkTK47MrkynZEkwTbIhmpg9eM4v0REZ
 992fKG93Qlc3JbjPaeoTrFa3Ls/VryvY/9V8AgHV2oa3sCvc0QiCljfFABLToOxabs3i
 h8DaYE5eYUF1BQGGUq7ZGQQRaPyBEBFqH+HCU/I29/Ij20GBtinxgqiLA76uO5rsxfFU
 OLgQ==
X-Gm-Message-State: AOAM533OrwuSqN0JKlD0Laqp9LhWs/Nr4bWspgvNFq/cb3VBsTHo2UZ1
 UOaA2oqiAAot7pBD5HgoNjs=
X-Google-Smtp-Source: ABdhPJwcRiB/mtvAdkqZzwYMSZTX1U7yRaGl/hbdC3v5mlmNc0Pw1jNodZu+U9b2+jfVd71H0kMPVQ==
X-Received: by 2002:a05:600c:34d6:: with SMTP id
 d22mr46331703wmq.111.1639478919690; 
 Tue, 14 Dec 2021 02:48:39 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id v8sm13062754wrd.84.2021.12.14.02.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 02:48:39 -0800 (PST)
Subject: Re: [PATCH] nvme: increment request genctr on completion
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20211213170847.4161474-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cfcf953c-5ebc-d59b-fc37-a02c5dafe7e4@grimberg.me>
Date: Tue, 14 Dec 2021 12:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213170847.4161474-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211214_024851_077800_BA2BF04C 
X-CRM114-Status: GOOD (  12.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The nvme request generation counter is intended to catch duplicate
> completions. Incrementing the counter on submission means duplicates can
> only be caught if the request tag is reallocated and dispatched prior to
> the driver observing the corrupted CQE. Incrementing on completion
> removes this window, making it possible to detect duplicate completions
> in consecutive entries.

OK, It just occurred to me that blk_mq_tag_to_rq will still return the
request after it was completed as tags->rqs[x] is not cleared when
ending the request.

So this looks good.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

