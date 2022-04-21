Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE1BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IinI33pSr8d3WhExYC7mTfj7eLtY6joSBsl3ibPhoGg=; b=Qrafn7RsYyavsmnnnCJWR9mJLQ
	DVjm4QADhM6OSukB+XErK3x7SDnsI6Km6cIaOJx7v34jKLkg7kh0qkvJhPg8wlbQ0O1g4E0wom67f
	kQn+hvNpAYl79Xi02a1gn9hqoAYuq4/Xolyx7z5vco6hjot6sWPdb4VwtlIj5rLHGbGHxDS4KgvOA
	lNzSuyZ5gkUH3Pqv2eFQuylSjOBmy9hJBLBMAwtVL3O5z/gmgltnOTaXB5tgR2uquMwWXD67ugxbi
	MpexM3fs4/mkwkRs/QjOrEfErPfo9YCOYR9GKDpF/zHhhYHwRPCNnQvslWzqeBmIAsWDFlTlzb5s4
	x+QldPsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nheEe-00F1Fi-3I; Thu, 21 Apr 2022 21:21:08 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nheEb-00F1EW-He
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 21:21:06 +0000
Received: by mail-pf1-x42b.google.com with SMTP id i24so6122482pfa.7
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IinI33pSr8d3WhExYC7mTfj7eLtY6joSBsl3ibPhoGg=;
 b=DCakvaO85AHCPkXp1OMlJGDTQgPZHI6loyZStX1R06qX3I8dlTt8gy4VOUJ/X1QRo5
 kj/GasYXiUQfIkp1NFVNFCx3EL3XjoHbJHjAjvCnBsRgeJ3Te1ZQUT9RVkXXzc7oahvi
 T6ldgq9In5sBxJlTibzusLYfg9f5Js72idQqPI712gT/X61EPmDWdmuVgGOUlHfmH1OX
 tBUqSwrtLOnSkSIQGg4T8kZ3yKXcCJ8WxP32RePAeqhVPOXJM7Q6YRCzd0e5qp12hlNK
 9agkcAvEgTQ9aWn+ojFuWjNXu6sbKRHPBgOdfl8Ef9piSRNhYS6a7t0rtNXuhCfVGL0w
 b0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=IinI33pSr8d3WhExYC7mTfj7eLtY6joSBsl3ibPhoGg=;
 b=4stxg1F9bUsAo0f+ExzcS+bmBm83k4iQst2bHE+TSsUO+fiFQgSumnRZLlQ+SLDo7I
 h4A8o6dvSCNvk8ulpDGXgFWMwSkowAoJ2jwblc6bOyP6+5f4/5hn/u3l0njWWcrF6zTZ
 32xZFnwFK3Ktl89P2tRpWBrbr0pigu0xZWyzG4FsXqZ01i5/A1zpZlG2vhu9wN/AnwmV
 BV3tziEcik6UrZ1djSwg1yTty0oaxjdQ3hofbkXA/1U3if86AnWzcgTh+U352JelVpeG
 91mH+qMF9X1uOqusCSkLf7r2J7xzdImudnptzFS1qfofn4Vvrlystnd/sNJ3t2/6KhAb
 4r4g==
X-Gm-Message-State: AOAM531qLOvDHdPCdDmunT07UiLyJ5q0j7otNq/jLFIZ1l6hCT3B/FiX
 Kgv33N+MD5fFEKPIm43UBfQ=
X-Google-Smtp-Source: ABdhPJy5TJ66lJLVdKIjrTX7qAzuwVt4TUqEbAZpVabpPFZJqIcnhheMAkwWTUQtOy10+JNdywDS5A==
X-Received: by 2002:a05:6a00:1a0a:b0:4fc:d6c5:f3f1 with SMTP id
 g10-20020a056a001a0a00b004fcd6c5f3f1mr1626949pfv.45.1650576063704; 
 Thu, 21 Apr 2022 14:21:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a637e10000000b00382b21c6b0bsm64796pgc.51.2022.04.21.14.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 14:21:03 -0700 (PDT)
Date: Thu, 21 Apr 2022 11:21:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/15] blk-cgroup: remove __bio_blkcg
Message-ID: <YmHKvY658MbXQKzj@slm.duckdns.org>
References: <20220420042723.1010598-1-hch@lst.de>
 <20220420042723.1010598-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420042723.1010598-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_142105_635548_2DE094E1 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

On Wed, Apr 20, 2022 at 06:27:09AM +0200, Christoph Hellwig wrote:
> Remove the unused and deprecated __bio_blkcg helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

