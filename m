Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC32C5ACAE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 17:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0D22053B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CA697CB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D22053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=CA697CB/xW3VdasA6qNrqBiEW
	YhyiXkVbxFvNJcj6ycnk64wkv54Y0xY2Gf22TEWMcr6t9Lv4yq5SYgGBs1Eu0nAQpesINLgz2815+
	O4UgnuO1NIE5GXhbGydoiL+R6JcMispuJ8/JiW0oIMB3aelgA6N1iJAgZ+lXmK0iR/XXu/wHcXy2x
	5IKOPXlQqrFZNO4GQgqIwdY19kKWxb7gFu+72VvUzWi7NEfTEaASmmPqzOhO7FfnIeEU1a+5q0RkB
	+ZfOlSCPCH2tBc8qCrXMb7wetzwIQNeoWZ0HwDsFCuBc+DgKcnYBHwofvpnPuT0TnQXHLD/zKJt58
	P7QVcFvwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i86H4-0004nl-3h; Wed, 11 Sep 2019 17:19:22 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i86Gz-0004mv-Vl
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 17:19:19 +0000
Received: by mail-oi1-f195.google.com with SMTP id z6so9255880oix.9
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 10:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Qi+xwlK59l/ezpJyqwWvIQCukwDje5FkhClYm2jXfZdNR/VLpMAjWPYLEIMMT+75dC
 q6koD0pfWbRXMV6ARBfgKmZ1L87Uqc9qZF01VJSBX3eKtxSltJcY4hinTPKQU07oGjqg
 pK79EZQ9XoP5GmNFqYMt0ijWyb5PRQ51eijLBhtgtsxSlmmtzgu9QjgGUsgQEW3BPVKA
 pKceXL1vcYmV2C+lnugVpN5rRWO2dhjk/+kuDKOT1MC9uaFGoFiudcqllmDmY+s93q36
 n2icF3SGU4kNltvkfw6loOGZk+Mn3gk4d2LaXeq12DBMBgBxy/UiIcXu/DU6U8VcAJKF
 KRUg==
X-Gm-Message-State: APjAAAXPNfmmezU52GAF+7TPiI+QbRyDwBeaE59x3jPdntLA+8YRTeIq
 s1YJD9J9jUVarDtnCNdehvInnQfk
X-Google-Smtp-Source: APXvYqyXdUt23tgPQin40lxwUV+EKeatQGhs0ErHQZEAGbpfUnvyS+B+QJgGXG2sgbFG5xYLgOPwRQ==
X-Received: by 2002:aca:574c:: with SMTP id l73mr5397367oib.47.1568222353181; 
 Wed, 11 Sep 2019 10:19:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t18sm8721368otd.60.2019.09.11.10.19.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 10:19:12 -0700 (PDT)
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To: Gabriel C <nix.or.die@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <335f6d13-e61b-c683-6589-cc8b097a9e57@grimberg.me>
Date: Wed, 11 Sep 2019 10:19:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_101918_023866_CADB7C23 
X-CRM114-Status: UNSURE (   9.17  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
