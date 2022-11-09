Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237C1C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/V0AJh/Q00CosyYGNGaYLGxfBnu7hrJvbYjJouhTFy0=; b=bJJ9KnngtdixYFXY0K98WBSgaE
	/eHRT6f33TcbktUX0Nt1O9KO8NBBs7fZFf9bI/D3cfr2EG0zKDQoSjojrEXG1hOdyBO+GAnGQ7YaM
	PztdVxfr5+CvOH0/pTPEQsY+gz+qzwUw5bEdHRq1EdGJ5vDEVIg7MZ+Hat+ZOM2oXy81AY2190Mip
	U3uVNCrFJcX61+F+94UOZauShDJpuEcQpvLxm+ACKzrRbvrFsPXaIHY8QjCBTKEmps+UvYYyQTCJa
	NmDJ2d6dbJPZN7im3qc6n0Q57ozyEsjJowiMk+8eNcmELi8z25avdQ2z+zTs5dLM5VSEYvhJC9d9/
	ZEuSlGeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ossF4-00HISK-80; Wed, 09 Nov 2022 21:04:14 +0000
Received: from mail-oi1-x264.google.com ([2607:f8b0:4864:20::264])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ossF1-00HIPY-6O
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 21:04:13 +0000
Received: by mail-oi1-x264.google.com with SMTP id b124so20171016oia.4
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 13:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/V0AJh/Q00CosyYGNGaYLGxfBnu7hrJvbYjJouhTFy0=;
        b=DZfkvEL5DA5h4a0fMdmP1qgjlz+xnUGa1eRx0DYseMHUDb11te8yyOxHJIaMZZmnPr
         tDphbtsfYNNpHHqqHd2/5lJ+Wn+xPqowLnn5ucK2My3+KMF7Fq8q/CXGMv82tWrI89bw
         PRxKu8ZYGfS7jJdqH2tP7IkJfnwyAcbActCe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V0AJh/Q00CosyYGNGaYLGxfBnu7hrJvbYjJouhTFy0=;
        b=TeZzQmR6weq2nirl8yivM8AsFA2opT0ZAOZOquYt56T5IHg6eRyinpOcXWjHyfxnOi
         Ri5Sgk8b3if08U2UrxC/XUtQxrPaLEStPfg6hL9sFSGwoqBP3DkrcsuMb+qTqhgPIFaQ
         7cOjmDd5qnA2igRLCTQs7o0DWBN0HbwPM446YnJWVKq7wnNOlttOyp/ZJd4ywKz2rzIR
         lRfVowa30NUrYbX08vetMlWHBpE9dOZTB/SO1FkAOSQxrwNFgpgpzMP07nioDXdnzlsN
         F9BhN+Nh9+pDd5vsQXDX1qffpISB8ZNIolXavuAiEtCqaN1HqOCrHnuXMhOVetchOE4w
         dGmw==
X-Gm-Message-State: ACrzQf1hyyNHaLaBAM/FYatrNqsVpWeSuWAU0ES1xDr/u/c3+89QO4D/
	gIpjmQhbMJm//FgvsSW5EfrOaiVOI1HwusRhQu7ZVbg5mTSQNj4fJpJ4MFbdg0eCxg==
X-Google-Smtp-Source: AMsMyM6+EDeSNecN+lgL15ZIthNFBD4RvNQVcvpOEHsWZ5zXHGKPspsb9t/gejn2eq1IQ9HY4j+6nDZWRSvh
X-Received: by 2002:a05:6808:da:b0:35a:595f:7fe9 with SMTP id t26-20020a05680800da00b0035a595f7fe9mr16694537oic.147.1668027847684;
        Wed, 09 Nov 2022 13:04:07 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id jf4-20020a0568707b8400b0013193edfb20sm898686oab.37.2022.11.09.13.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:04:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id CAEB4221B1;
	Wed,  9 Nov 2022 14:04:05 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C5605E40496; Wed,  9 Nov 2022 14:04:05 -0700 (MST)
Date: Wed, 9 Nov 2022 14:04:05 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2] nvme: scan sequentially only when list scan
 unsupported
Message-ID: <20221109210405.GA2659347@dev-ushankar.dev.purestorage.com>
References: <20221107195443.2176099-1-ushankar@purestorage.com>
 <Y2rpIJ9lSJYnb+GG@kbusch-mbp.dhcp.thefacebook.com>
 <20221109062330.GC10528@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109062330.GC10528@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_130411_803993_ADF13565 
X-CRM114-Status: GOOD (  18.16  )
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

On Wed, Nov 09, 2022 at 07:23:30AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 08, 2022 at 04:41:20PM -0700, Keith Busch wrote:
> > Looks fine, but I really don't look forward to finding out how many
> > devices, if any, were secretly relying on this fallback.
> 
> I'm a little worried as well.  Maybe we can whitelist a few status
> codes as suggestions that a device might just be a broken.  I.e.
> "NVME_INVALID_FIELD | NVME_DNR" would very much be an indicator of tat.

Can we get away with just testing for the DNR bit? The practical goal of
this patch is to prevent fallback to sequential scan when the Identify
NS List command fails for transient reasons, and I think the error code
returned in such cases should not have DNR set.

> Also Uday, the return value from nvme_scan_ns_list can and should be
> dropped now.

We'll want to keep the return value if we go with the above suggestion.

