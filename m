Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B30C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 19:14:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D1120899
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dxwUpEOo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f2+bfCz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D1120899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pCCIYg3LhPjMurGYDZksPtPd3N5n09oMI0kAM/sf/2Y=; b=dxwUpEOoL+QVEE
	YxEofl/P7u1vDTX+q2I1DFG8SRGjrb0tJ+QTiCg4Dufey6r7ZheePBzgmgvg218zyFThFSi1s3LfC
	MoFxTPJXwqil2lGbECgOpdNtIowAhF9y1JRJAMojeZxwWqfML8Na3TKeHnkVfCBuNPGnXt35Ga2xe
	p+xN6Td7M3ZWbSs+9+MVVdMZ7T/PYCDwgTfGKiJDClkoP7GXIAvr9n2OVnhiOW9LKPfvwmpTzGR+8
	wvBcoJOR+V8rQ+sAjRPlApDp2PKAyH3oHO1KAZcZ00v6163dk9pJ+1BgPwAQPylfYjG5ZZxSyRBpF
	+abXaRvsUU6TsvU0DS3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je1VZ-0002RC-F7; Wed, 27 May 2020 19:14:33 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je1VW-0002Pa-Al
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 19:14:32 +0000
Received: by mail-il1-x141.google.com with SMTP id a18so7964874ilp.7
 for <linux-nvme@lists.infradead.org>; Wed, 27 May 2020 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6gQSEGMWPgkGGVyHG9Pe+5fUPTmNwG1QJK7jkF0ZgaY=;
 b=f2+bfCz5l3s2mc0xZ3f2Pq3WNIRwZ8/K67kflMCF9lRfWG7wXe314goLmBz5B0Cd60
 +5vJVT0dTUlySipyBR16irIcNP5wMDuUMy1RkgvXzms9Wb+oEtNLdKXLWMsusauMh+xZ
 NvgnYCDf3lgOevnvYhzKPhv4lszdeNDNo4nIbGDDXy2uvj+nCnHj/hIGINnlzaHpVnXz
 U2Mhbx0uzLlIHEMjPHZVWXi0epD+kk0mf41r3vnhMeWCo7aOEN2h0PZpzy6BNLO2CdJg
 4CXuHrITF4Ep7CvoDtfk7R317k4qcgw8oCXy50U5YmzOtUeC08H68OHTNLpfOoE9BdNN
 BAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6gQSEGMWPgkGGVyHG9Pe+5fUPTmNwG1QJK7jkF0ZgaY=;
 b=aK0mr1XjGQMypjWxUhdAHcxfCc19c97S6SvnzazjpKSyAyJYk+6jx6ZSUhb3GNWdh4
 ag52mUTVAWgmrPocSYKxU1B63/HrZNlx0O4w3zZgLZr2dXmBm96TbkzYnzMpxjFc1W5/
 kxoQXoWK6La07HYqrnx58zPj9kUhjjN+ou8JcN6ESSVUKNrUgMj1CGTFGjUBVP6VEf87
 n0wJjbDorScJR2WXfG18kJ8eERZE4jGFu1s8QdkRIXNJ6YTdU2LIqcUeTVplPlUZlIo7
 7BE2kdsHlfDbaOs64CvwQsedm9gFl4nuRfRZ8nKMOzvPPBfK0RJKka2a7BKjeDdaIfeD
 7MzQ==
X-Gm-Message-State: AOAM532nHSn4qU40wVpVcfULF6qs+btnkyGbxs7ak7ORxcEdrX3DzhQZ
 /rirUJbRvv/PANTtkwIv/3/ldQ==
X-Google-Smtp-Source: ABdhPJygidZnbAa0eGY1UJRtoYPZNdP08x0hWzTxRx7yxq441Lory3g22et2VwaQetBDV6SZ86g0Yg==
X-Received: by 2002:a92:d147:: with SMTP id t7mr4292743ilg.151.1590606865912; 
 Wed, 27 May 2020 12:14:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id g21sm666621ioc.14.2020.05.27.12.14.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 May 2020 12:14:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1je1VQ-0005Pm-Hp; Wed, 27 May 2020 16:14:24 -0300
Date: Wed, 27 May 2020 16:14:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH rdma-next v3 0/6] Add Enhanced Connection Established (ECE)
Message-ID: <20200527191424.GA20778@ziepe.ca>
References: <20200526103304.196371-1-leon@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200526103304.196371-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_121430_563160_ED9E57F7 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: rds-devel@oss.oracle.com, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>, Leon Romanovsky <leonro@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, target-devel@vger.kernel.org,
 Danil Kipnis <danil.kipnis@cloud.ionos.com>, Jakub Kicinski <kuba@kernel.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 26, 2020 at 01:32:58PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v3:
>  * Rebased on top of ebd6e96b33a2 RDMA/ipoib: Remove can_sleep parameter from iboib_mcast_alloc
>  * Updated rdma_reject patch to include newly added RTR ulp
>  * Remove empty hunks added by rebase
>  * Changed signature of rdma_reject so kernel users will provide reason by themselves
>  * Squashed UAPI patch to other patches which add functionality
>  * Removed define of the IBTA reason from UAPI
>  v2: https://lore.kernel.org/linux-rdma/20200413141538.935574-1-leon@kernel.org/
>  * Rebased on latest rdma-next and removed already accepted patches.
>  * Updated all rdma_reject in-kernel users to provide reject reason.
>  v1: Dropped field_avail patch in favor of mass conversion to use function
>      which already exists in the kernel code.
>  https://lore.kernel.org/lkml/20200310091438.248429-1-leon@kernel.org
>  v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org
> 
> Enhanced Connection Established or ECE is new negotiation scheme
> introduced in IBTA v1.4 to exchange extra information about nodes
> capabilities and later negotiate them at the connection establishment
> phase.
> 
> The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
> to carry two fields, one new and another gained new functionality:
>  * VendorID is a new field that indicates that common subset of vendor
>    option bits are supported as indicated by that VendorID.
>  * AttributeModifier already exists, but overloaded to indicate which
>    vendor options are supported by this VendorID.
> 
> This is kernel part of such functionality which is responsible to get data
> from librdmacm and properly create and handle RDMA-CM messages.
> 
> Thanks
> 
> Leon Romanovsky (6):
>   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
>   RDMA/ucma: Extend ucma_connect to receive ECE parameters
>   RDMA/ucma: Deliver ECE parameters through UCMA events
>   RDMA/cm: Send and receive ECE parameter over the wire
>   RDMA/cma: Connect ECE to rdma_accept
>   RDMA/cma: Provide ECE reject reason

Applied to for-next, thanks

Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
