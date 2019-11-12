Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F9C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:48:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41222084E
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bkVl9FwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41222084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wrD7+NLs+G3R2pVcinz/RbFsvB6BrWC363XICfYQdSY=; b=bkVl9FwMUL2icdPKrteEz3nHv
	//3Q/p1wwzG1CuwTr8gP6RJG/yYj6lcJrJ4XqagUB98sMMk1sdL3xLRSWuE7LjDLiYpnZv1MclmRJ
	ZW3Tsv0aWtzsvhrCiPqMcXLjHZ6/Dohq/AbDKlh3P9Zmu4avbqoaRygL4Jz/8pOEEBGz+z8aJbj0N
	u2TehQxPWlpdQxerQM+ArjBFHGPOp7RaSkeSbW+fHJ0xer/mb1ArX5SuTH4qeog+sYO949pUhMbE5
	WGrPTsh8YoJJjetmbt/R4k+1e85JWowI1w0XRtiPQC9gW58ebdJRdoiU3o0EjsMm7XfPnlmf4BhXD
	ZPKd1XLdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUaHK-0005yB-Sp; Tue, 12 Nov 2019 17:48:34 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUaHI-0005xq-JU
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 17:48:33 +0000
Received: by mail-oi1-f193.google.com with SMTP id n14so15558530oie.13
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 09:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oi4Aos9JCm3QuSJmaF08TIGDH76xf5i+Q/h3VCCUfqo=;
 b=Q4DZWP0N/1wx68O+dQnlpc2HqLifMYGuPVzfdOVkVK3WM1djIEIYCgTuvlpBeOh81T
 ThHPbeZvFHf+K//I1vYWnRtA5JsJMIFSpqRZ7v/Ggv7sRO/0xxfcSkOSfb93zQAQOLdT
 jNUyQa+IB5JhVY9uPic2YCG3zSQfq64qWmVyjhl68bV9BSnrY1YM87+nUw2TbXmTxusD
 Y7AFr+8XTHPPra+tPDJMhSsvPoNL1VBHd34imfJiOIOt8NE6Kt/FIyV7GLO5cbRdr71Z
 LlC3tlsG4IaJcjf6OJWTY9zUIAVzZS0nAb4i919oebIyaZ6KurhwBABclMtpI7nwyH0q
 fKVg==
X-Gm-Message-State: APjAAAW9eznfbcdrTl9zGlj1MYqmJbG+ucTlJG0r8zB7+THaK5MBuubK
 WAF6P27wARQ1//VHoQrT7sgL/jtQ
X-Google-Smtp-Source: APXvYqyBIkeU2MZlA46Jn56f3VI91ixiGfUkFcRlvEuAsOcDi7EWuDThbHvRm4tAzCG4JhuNN2coJw==
X-Received: by 2002:a05:6808:8d3:: with SMTP id
 k19mr95357oij.171.1573580911127; 
 Tue, 12 Nov 2019 09:48:31 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id e193sm6278762oib.53.2019.11.12.09.48.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:48:30 -0800 (PST)
Subject: Re: [PATCH 01/15] nvme-fabrics: allow user enabling metadata/T10-PI
 support
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-3-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2057d0f3-98d6-e660-f24b-657e771aa9d4@grimberg.me>
Date: Tue, 12 Nov 2019 09:48:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105162026.183901-3-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_094832_639229_3847B820 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: israelr@mellanox.com, oren@mellanox.com, idanb@mellanox.com,
 vladimirk@mellanox.com, shlomin@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Israel Rukshin <israelr@mellanox.com>
> 
> Preparation for adding metadata (T10-PI) over fabric support. This will
> allow end-to-end protection information passthrough and validation for
> NVMe over Fabric.

I think that this patch needs to come after the host supports PI.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
