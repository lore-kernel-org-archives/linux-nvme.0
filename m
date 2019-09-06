Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A0C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:40:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BAA214E0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wb72IpuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BAA214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Wb72IpuPZqOTp1DB8EqmpEw6I
	YnBOlzNP4mU5zOB/BNoZdxNKICDID5N2uWOSiSEjw5sgqfn0L7Zkb7Hese2FctBPitTy/zQZa9h9v
	bfYuaUIJORwqZarGMroCnvpRDHVrC0BWoSDuXkUMXWvtvNCtrV8+hEli1J5iofqqFnSUaC5N6JPy8
	nhYzvC/RkWsAFOkPfv1YEdvJIqTlHYF03nrxrMkvnrPL9XI+3kUpI6+ke41I031ZnOEdZ1LD27XbW
	yKJI9l/Iyt8ivbArIAbsZmP23hy/5wR1ACxKU6D6P4pkcVc4fgLtFcVRjWb9gLfZ0Xl+dWzQBriGW
	nZm+LMvcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Nph-0006PA-Or; Fri, 06 Sep 2019 23:40:01 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Npf-0006JN-2p
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:40:00 +0000
Received: by mail-oi1-f196.google.com with SMTP id b80so6403293oii.7
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=hVqjHbSbnNG4mIBBpXq3TkBxLmahfuntoXHEqk2LH8MpnRdOAK/29ZFxn1wCi7yW7r
 HSUXx/QmDpTm/fgJxCdszsgCsvcyIPvcAzk30MF95S2j4M0M6HxOo9qR+oLryDnNTpsP
 iaqV8ziopTzzVSsj4gpY/1e2FsJM3oFfguMxgxSbzL0+9gfySwj370Y+8B0gqN6WfoNG
 8DjaOXzCf0yXQ3TCwoCr1akZOinxzFB4TVak3Z6lwz736oVAIu61tJr7o0ziEqKGqmUj
 PioI9DBtGIaeZuWppA+rrXsb0PX2ikBShj0yPZ6vBCTbyf05B9IdzKgCgSZAxYQOuKKE
 8M5w==
X-Gm-Message-State: APjAAAXaZy3aeqeBNwlYfg3L3urC6jziARL+JQTx4sOGZMn5g0NDjhy2
 vUzKajf0BFMuHuGgVPoFgV8=
X-Google-Smtp-Source: APXvYqxEU689XOtYDKDRF9cRaK4h05GjP3FBRAs0hA+fbfVVxP9MW+gEKrw2JkiUuQKfDpJCZ51mGQ==
X-Received: by 2002:aca:50ca:: with SMTP id e193mr9618385oib.110.1567813198428; 
 Fri, 06 Sep 2019 16:39:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id v2sm2202856oic.49.2019.09.06.16.39.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:39:57 -0700 (PDT)
Subject: Re: [PATCH v8 10/13] nvmet-configfs: introduce passthru configfs
 interface
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-11-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7ac28537-d8e0-5263-b10e-ff9b708d6313@grimberg.me>
Date: Fri, 6 Sep 2019 16:39:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-11-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_163959_120675_8E98972F 
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
