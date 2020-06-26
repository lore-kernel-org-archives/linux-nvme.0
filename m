Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A7C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF8F20EDD
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dh9Grutr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="eff8vhG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF8F20EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5wO9LCFQXLjES4m5MHyYfhdPg+x6p83jN/1XsrnXoW8=; b=Dh9GrutrhBxFO7Ma9ByHt+uI8
	2CIbq1mTIwFY5vrwxKt/2Yn6zA/OuH4yNJKOTsxUXKxEXXUfc4Mf+bcCTGGYyyT0KzUvtWBKAv/wt
	HMIvJn8AeQeme0YqTkAv4D5k8SBpfcwKq1xU6doZjPt0zHg7AAdhHVyT2CbovwC97y79G9XOp3QMw
	KTAyAUJpRChf67On7VwpLcZzNG2k6N+VNXsPno3KVFdyj924jXpTbGtQzQ3Y8mQrrLd3e78iO4TQx
	Qxmb9mfrAA+9L/cpPVpucMQDrK6ITGpq5Xz17kSQFOvsiT7eTL1XECx5T5Quhb4DLZpOE3SoVdqTA
	rQWUKNY6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolGa-00022a-Fk; Fri, 26 Jun 2020 10:07:28 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolCn-0000OW-Nz
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:03:53 +0000
Received: by mail-ej1-x641.google.com with SMTP id l12so8753890ejn.10
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b9fA6cDuLKUl6r1JDk9GTL32fQwgnX5oPJIohbeJ4ew=;
 b=eff8vhG3tzimaUuyj2AvlVKfej3ITvGf2noj+At1SLQDM9K2Ej3gVxysb1vhjJ7GvI
 8ECtUApYQSdvfXIRNzZpB5Jc1/8FCluk/miHneqdOlM64FOLW/Yt9mEHxDgh++QUt1I2
 mXoJqtk47YMelP1z5ffnR5sl0w2qNzFikCWltgyKg3vEVEI7adMjfzxAzuawpSGnHbbI
 9r396j4HqTJ52i2CD54x5hdkNWieZIW9SmNqdWao/29h37QXOoDk9gj4fgDfFNzHjWKK
 9X/qLgkclR46IMS8wvbfzJcoN1UgmYHg7D7tdxeiwd2TDfmkIgdcsWi11bg62Lvd6l9f
 crgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b9fA6cDuLKUl6r1JDk9GTL32fQwgnX5oPJIohbeJ4ew=;
 b=QUxb2NHf4LDC9BLC5BywdwcQ54dS2WbQkpbf9+GlaekgqBwm5Hkh08Io/8i3WfbrqZ
 DgFhzK5ddrvIGiv7ijJS8tknTxW8yxNxJeU/yJd2WY7iDcV3ov7M5jVw+Vo6xS52dzZW
 F6ZCWRgxXqsCn8YDByz69z8MDtxHZxsz6B5lgWz0mPootRUN9Yd5ZDbVZqAGi1V/X77H
 p7iWbVW8vbANNElLbO8FCZsnG4Yn8XUV/ffAy4jjJvaPyGB0fMOQuG+Sry9pCH70JrVz
 Z0lZU0MTCDj2qd1SkQA+qLPpmX5En0vFMliV3glqBOIi4d1vvD3R3qYsIg9oSLy1oOUo
 jGgg==
X-Gm-Message-State: AOAM531exPiHdYC/WwlK1P4RPcG0JYwTeOrCJ5GhOmjbeKw03yFdU1aB
 eNOCjsU0RjC9z04t8qOLQAM4Jg==
X-Google-Smtp-Source: ABdhPJwjA0HKtW5RnAhXG2FNgUUlpUw/qdy8sps0dvxv//ta2VkfUp1OsYXy7XpvrQigkWOMocasnA==
X-Received: by 2002:a17:906:355b:: with SMTP id
 s27mr1962213eja.368.1593165812420; 
 Fri, 26 Jun 2020 03:03:32 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id b11sm12032075edw.76.2020.06.26.03.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 03:03:31 -0700 (PDT)
Date: Fri, 26 Jun 2020 12:03:31 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626100331.x75kegnxutfogdoi@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200626091652.GD26616@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626091652.GD26616@lst.de>
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26.06.2020 11:16, Christoph Hellwig wrote:
>As a bunch of folks noticed I don't zone_idx does what you think it
>does.  That being said I'm very happy about any kind of validation
>(except maybe in a supper hot path).  So if we want to validate the
>zone number we can do, just not as in this patch.

Ok. I will send a proper implementation of it and then we see if it
fits.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
