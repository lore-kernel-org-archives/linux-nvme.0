Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B62BC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 12:32:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CE961288
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 12:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CE961288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MVjLLaTX3R705Pa4S7YCGoDhfLBE36+Q74OSzWaxDsU=; b=QYiDoSxwVwg1VgWjjyvmkXfvV
	XjSBjC+htANEyHQcVmvT3badq/1hEELwT85GHriez4KZhA3yzAtznE8HVvsGK0PJQ3/0a3K0j9mlp
	0hACAxUU2ZzFv9PAuLm1b3bR73FiRfqi0BJDMkabmHKoWatJj/eKoqg63VODtetUnAdNh0x9aLZRc
	gd+xN7PDLyfA+SkOdvEa1Jjc3toPoxfBxYvp3DH5W+gsdv7Q62tyKZXQsp7Zha3XJ218OI+KCiz8O
	j1ZpU4j6gkiVO1WtOjlNkqMt3a5ukBagNVUQ3zbmVrm9Z5ipSMPFFLlVmK2LsvswSh9B+/5BI3kQz
	xGOL/+VZA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVvjS-006hJd-Iw; Mon, 12 Apr 2021 12:31:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVvjP-006hIu-E4
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 12:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yhl8pbOdaalAMsJe7hpEsxkpuZCX76ZLSoNM9EjUzXg=; b=NWvISwA39cRqLvHU2Q9qtG57Yw
 PilHy48QIdcHcobe8L3lT8cpgbmLoZfm/f5fr8ZekFoLpIi9Q5lpF2HtTy07obmU4Y9q85vPctuos
 OysgSZp6G9+PNKgMzpvXzc1NeaFr+dzkeS11lhV1YwHM7z4nQyM3lW2Fb8qkSTYsg28YO/znfRJRV
 XQJSdIXbmKesGegikfS54non/wFVXSaUL4OELZ1CxzpC6COwnO4zIcQ1sWDnyhWjm7X8PXTtF3c/H
 pk42Wn2jntKQT/KXdwrscmIuur3i78p0T3klaY59pc8hARf5Vfbgg60gmVAxTpSW6GkeUlvWdvQnt
 /Se/awiQ==;
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVvjM-006DjD-J0
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 12:31:53 +0000
Received: by mail-qk1-x731.google.com with SMTP id q189so2600564qka.8
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yhl8pbOdaalAMsJe7hpEsxkpuZCX76ZLSoNM9EjUzXg=;
 b=ZeE8zb6t0XIFVZLLoUGRpWjAop1DK+ouuw91eGaUzcyLjqA9UncZmpBEhi5dwGWnRR
 ny8yXVOpcMQqK7RzvTNtQkPmkSxN+C4KRja+6nQioGBMTpazgxga8abAHpp+0qjm+/D0
 o9CUweHOcoFl1q1kzxxfr+ja5byOhx8AS/h4ppM05JPMxyuEPANFfUgNPmQHBq2d8O5/
 jZPxdIs6BJ4sgEx0yCovkDn5jKxl1lxe/et0Am+M9q1Djn0nOjXy8yGi/RFLfkn/TCeD
 6bD7cvt9gbmrXELHEXf10YqaWllg4HXT6GFIiilLXIXW9SQmN/4ulNtqO3EqYmyeDas/
 VCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yhl8pbOdaalAMsJe7hpEsxkpuZCX76ZLSoNM9EjUzXg=;
 b=hph8TNgp/VOfCq3u7ixGdmRgv/xq9fXheKvyJj6MtlafTqabBROqG595t1Uvw7bz9Z
 +T++Q85uOgztpGJuvPVyhkWhXMDHuWEfd+/K1ecYwuEYJ9GHHrPo8V2dENANNPZjaT+Q
 9xnJkf0W6o+Qg5S7X+2ehB09Rcu8PsaYGKvk3/hEU0eKD6MvQqOIqdJscxGlFspNMcC9
 S/8GHRPG/rFa02iPRRPpeIcKCBN30VwJkaDCelRcmwSCoPM6+Dh/YYOcarOv9evT18Jx
 r0D35fpQxLnjQmbqeLyXcyk40GDM9Vpm4iiHreNpBs1bK0VTV4wIsxPMOWaj08NXTasd
 iKIQ==
X-Gm-Message-State: AOAM532fspuRpiOWQ3ZGhVtYLVug9AsGxfp2JceOqVe2HWUKf8tnifIh
 n8wxtHnmJ53fa1+y6BaHYqekNw==
X-Google-Smtp-Source: ABdhPJx8PSGB6O3Wlv2NeBxl5ItnZN806vmd3MCvmCqjX1oQRVk1sPDCEH4F7g5hHz96mXOEqRCdkQ==
X-Received: by 2002:a37:7147:: with SMTP id m68mr26181180qkc.286.1618230710480; 
 Mon, 12 Apr 2021 05:31:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id h62sm7728650qkf.116.2021.04.12.05.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 05:31:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lVvjJ-004Qej-5p; Mon, 12 Apr 2021 09:31:49 -0300
Date: Mon, 12 Apr 2021 09:31:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Steve Wise <swise@opengridcomputing.com>,
 Leon Romanovsky <leon@kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210412123149.GE227011@ziepe.ca>
References: <20210412122330.5166-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412122330.5166-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_053152_786939_256F5D01 
X-CRM114-Status: GOOD (  18.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 12, 2021 at 02:23:30PM +0200, Daniel Wagner wrote:
> Drop the WQ_MEM_RECLAIM flag as it is not needed and introduces
> warnings.
> 
> The documentation says "all wq which might be used in the memory
> reclaim paths MUST have this flag set. The wq is guaranteed to have at
> least one execution context regardless of memory pressure."
> 
> By setting WQ_MEM_RECLAIM the threads are ready be running during
> early init. The claim it guarantees at least one execution context
> regardless of memory pressure is not supported by the implementation.
> 
> As the nvme core does not depend on early init we can remove the
> WQ_MEM_RECLAIM flag. This resolves a warning in the rdma path:

What does early init have to do with WQ_MEM_RECLAIM?

WQ_MEM_RECLIAM is required when any thread in a reclaim context goes
to sleep waiting for a WQ to complete. For instance by calling
flush_workqueue() or many other things.

The sleeping reclaim context must be guarenteed that the work can be
completed without the work, work queue machinery, or anything the work
has become interconnected with, recursing back into a reclaim.

IIRC the issue here was some destroy or flush work in some error
condition that happened to be under a reclaim context?

I don't see the kind of analysis I'd expect in this commit message to
justify this change.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
