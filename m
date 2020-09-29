Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6BC4727F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:52:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A8C20789
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tJVuhfvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A8C20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BbjNCY1iNJrKEhM9ti2+Rv2CQQ1mtA2PDQRjiT8sh2U=; b=tJVuhfvl7+1KHKiiIh1y+Lefc
	5e9gDB1hD4m4ZiBl2+jwQR8DZ/0TfYIrtY02PT1F2eNH0x5IBjKvX1qHMDth4fTCTIBi3vX7gj7M0
	4vcWbVfIqxQJV3M1qEwYHITYbdiB0xKqfO49lErStfHl/ImzMZk2fYnsDXMu4bpUlQCnwRd+hyCGL
	Ji/Kdhck+7VCWfR3ynpUTxYt0jKMDsLDDmXC6Y6qHLlHPF9D9XhE9h1sr28gfYUXVgQKINKNvr4eH
	f5JsDW0dCSvy5Nzbd65V/q+sLYxNkm8Pbg8p4sHqU4Qay/nIFB/91ogQcyq/esQKkZptENikH8oaK
	LO7yagZqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBNN-0002js-69; Tue, 29 Sep 2020 08:52:45 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBNL-0002il-8d
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:52:44 +0000
Received: by mail-pj1-f65.google.com with SMTP id j19so1130427pjl.4
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uF2BPJ3bVUmw0yBmvv+89qOrEYCxTswsdxcK42fahlE=;
 b=ZRCw6QEfAnDg3+ncsfK1Jub8IR2udPl8kjQLxRe5RU4ZnLQrSwtcWdcx5SFcKHqiCi
 J5G64+duFVJCbonPytl/OrPTjBZN0gJ5z696AuxUDYGA32scFg+k1sQo0+V/K+bmGmOi
 ui75gP6Kj00f3oCKxgcIwM0nGUlPAC99iiqco+SmV7l2lYZk31PBGJp1oiZk5YtnCfjW
 t3Y6rplmYavxiFzFqHWukZQViUqpPDUIo45vib87tAzWPL5YthTzr5zd+e1JGskdb2xw
 3XJAUZ8dPWs8OKS4iDwITKGS6NcjCqUW1iC40DjT2WgkMGoYcOlFRw5ssfv5jtFYgOq1
 p8hw==
X-Gm-Message-State: AOAM530b1LkwDohLkN32ujVAeKt3Yq6Ol6qc2iPwgslNaGrdiMoJ4J8Z
 8jZv1Jfrrf2AjYZAxsewS80z6llqZCs=
X-Google-Smtp-Source: ABdhPJyAEXbpKs3lOgU8fYNUA13TsYCbCmUgoR5FfiVihtEY51rNdNl+Os6FzdUhSgK2np6ocsyljg==
X-Received: by 2002:a17:90a:156:: with SMTP id
 z22mr3020027pje.140.1601369562409; 
 Tue, 29 Sep 2020 01:52:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id d20sm3862680pjv.39.2020.09.29.01.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:52:41 -0700 (PDT)
Subject: Re: [PATCH 12/20] nvme: remove the 0 lba_shift check in
 nvme_update_ns_info
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-13-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b565768e-9ef3-8d57-bd25-f8f16f434d2a@grimberg.me>
Date: Tue, 29 Sep 2020 01:52:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-13-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_045243_344437_FD5F1BE1 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> We can't reach this code if Identify Namespace failed.

Technically it'd be more accurate if you write we "We can no longer
reach.." as this used to be the case, but otherwise looks good.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
