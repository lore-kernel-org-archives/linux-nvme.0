Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E99BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzIVLFYgbIHKi0WfmGy/b7PPLkLPtlBjK1VwtmfcCaA=; b=4UkdrIAg+gWARqHAPQPrqPrmZy
	IhrAxJ16I1Wig8jTBHlB/DRrXgOw0s8YaeuZoBIBMqj8hlkHmRVwBs1Gs/OfLXKyo+FkL7CRCRvP8
	yL+aK622e/aGslBnyY4P+HTHpI66FKMReSl7b8V240QMqJIEOY/Xe/+WvnukIBhs8mPN28YzVXjC6
	+SAGJStceA0Idat2c3t6TFMDpp6DZUCfYkHrrFBt04H7sG2Y6JkwDk6X/kblcAvjqaQw51f2BDIne
	U8Ws9rzrkc0bsb1NKmkGyqKgJLnLwjueBs4P7VJNfyYSRQDr4WyLxJF4wEDQ5ehCs0mp5II29Q2Dg
	9i6lU+5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQEPO-00BwAr-0Q; Fri, 04 Mar 2022 20:20:14 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQEPL-00Bw9c-97
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 20:20:12 +0000
Received: by mail-pj1-x1033.google.com with SMTP id v4so8252727pjh.2
 for <linux-nvme@lists.infradead.org>; Fri, 04 Mar 2022 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=MzIVLFYgbIHKi0WfmGy/b7PPLkLPtlBjK1VwtmfcCaA=;
 b=2xgKttVdE+/3e73yVrW7xAHaDB3kKqtj49qJHIQnLCF0m/Opwy1KSuE9in16hG+ho5
 4pncR48ceZqaBfGLvTX53Sn2ScC1bZ6IsUHeELUi3rPOasHA0Xq8YIAJ4WOEq7PMYR5x
 OZcZaSdaQeFi70GWxawnI2Qy0xZE4Ltqs0zEZeMIBBIFT31oDwKMNHfE7Hfd4iFuqtU1
 QIlBlYTLi0Q++xOVL4tXESTdjUyZPOUAvjuufrwIQ6DKdOVG9Q6xK7pOCnZmRPvD5ifH
 /KkHUjNb5CadrWEaCLx4pT8+ljYKkchUVh3UvokT/F0ByHWSmvTVXZ3rLMg5LGBADHpa
 dk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=MzIVLFYgbIHKi0WfmGy/b7PPLkLPtlBjK1VwtmfcCaA=;
 b=dQKDIe9dr0G86Ib1csDiPiyjIZlFBdQcZkk96P1tZhW8paKG5e3N90z8srF7GOrlMf
 DkNPLuieDJMq4Tm7UsvAQ1nkYNCl5S13HQ/qmzXL0SEyuSf8M4Fee+xlkcmz6Ab0QYnJ
 xY4XCsIIomn0dihwIfEDhs+5xMTGgmRtyP5IZnKpqMbYYVY4g1fT38+ytOWPoQTtk62N
 bWh6EJ0ksf40HL8Nt2MSQs7jIHZDiTte+x1VJ/6gP5jwdxYHJSramW7FrLxBpcXRBIxS
 0Dp4AWx7aDZrjwuDVBTlu2MyxrppjYHogsZZwJxgxqwqTYs23AcMy70AkOk67qemITlg
 rhkg==
X-Gm-Message-State: AOAM530a9+itAVv9FbelvIXDu7tqtOf5dSiPFQYhYysm6S0NzJCRdsg1
 L1EaTUQxMVwICnUjwgPyg20EYA==
X-Google-Smtp-Source: ABdhPJxzNrjaHLQHQLD/BhExavFf9aVSlD7kGy6+cUzSlMmSh60/B/1lked5Soafp5AjkDLXFnEiCg==
X-Received: by 2002:a17:902:7404:b0:151:c3f9:e43a with SMTP id
 g4-20020a170902740400b00151c3f9e43amr105492pll.12.1646425210378; 
 Fri, 04 Mar 2022 12:20:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:380:777a:c32a:5fa9:a654:f35:71f6])
 by smtp.gmail.com with ESMTPSA id
 mu9-20020a17090b388900b001bef86b7d92sm8488608pjb.24.2022.03.04.12.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 12:20:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 linux-raid@vger.kernel.org, song@kernel.org
In-Reply-To: <20220304175556.407719-1-hch@lst.de>
References: <20220304175556.407719-1-hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Message-Id: <164642520857.251407.3488369238595834309.b4-ty@kernel.dk>
Date: Fri, 04 Mar 2022 13:20:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_122011_342710_DC7F935C 
X-CRM114-Status: GOOD (  10.89  )
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

On Fri, 4 Mar 2022 18:55:55 +0100, Christoph Hellwig wrote:
> This support was added for RocksDB, but RocksDB ended up not using it.
> At the same time drives on the open marked (vs those build for OEMs
> for non-Linux support) that actually support streams are extremly
> rare.  Don't bloat the nvme driver for it.
> 
> 

Applied, thanks!

[1/2] nvme: remove support or stream based temperature hint
      commit: 86cc47f6c199a71fdb28fe781174d9974ee14304
[2/2] block: remove the per-bio/request write hint
      commit: 6928b8f7eafaec1f0ea318fec71b537a165e552b

Best regards,
-- 
Jens Axboe



