Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB0C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:08:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB5561166
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB5561166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vQlQ1CdY0FQlaGRt8mxPbKeIzuAgs3+h0g1ojKTMvag=; b=kLpX4Gy5fYQKAaBEkQlCGryv6
	VCkWczMMnxnZlOnMW3dfJzKcHUeMyf/S20lW2ae0Fa/DyXtHWX18DFGIXEyipUtwusOtTup93h630
	YULAPKI1HrBHGvkNoVTyzaI7X+U1n8SbCSW34iDSS6guowKWanOc0FWEt/lEW9rQjNdDia+uQ5VQC
	yBXtVVV5yZl5dvr4Jx8R4FTtJLTfpSlpmYcy7lnoX60N+7hU+hxgxKMQNk8ji5fIaVxk2YbwJs07W
	CJm12oORVd+xHvFyT92scoYZwksp1P7FgkdgiHSl5+8v+RtA7Mygq/9riqwugB1T148zReseWyRw8
	QB0VLCY1w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWYhQ-00BccG-9k; Wed, 14 Apr 2021 06:08:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYhL-00Bcbo-Ue
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 06:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DLY+BPEaCUxsj8E74ndjgbAwoMQI+uEFhNFwsjmdQeA=; b=jNDrRK4h/V3RGM1eU2eiEdwP2g
 vrytEtM++1hig17a4iqO8kDrBaVaKwKbwUBRHbF4IfZ1qTMtMJanh+nynQpvdo+7ZFelJvDcXyyy0
 0tE45vQpZwycpCEEW0GdVUyYwA5LFACoq4UI5u3XinSXKmJuiUmJWjqFCLEIzzxOpn/uusbuZFNuL
 nFWWGQEQU/czkroSr91mNOi82dlVZo5/15SVshBZjkTTqr2i3tn5dmufi8F8HFqLGRP732hZqezho
 KzV9g6Pw4Cv7h97r45lu6y3SE4gHedw8pLt1Q3Kaq9pZY2AHoopyF2JQyMPC9KkQ4avo4pcUt9B1n
 2/zO6HVw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYhJ-007W1v-4w
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 06:08:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A749B68AFE; Wed, 14 Apr 2021 08:08:12 +0200 (CEST)
Date: Wed, 14 Apr 2021 08:08:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: avoid memset for passthrough requests
Message-ID: <20210414060812.GA24949@lst.de>
References: <20210414051629.103383-1-joshi.k@samsung.com>
 <CGME20210414051747epcas5p265826317a971aaa3337efb6472a9df7c@epcas5p2.samsung.com>
 <20210414051629.103383-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414051629.103383-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_230821_381226_A5BBB795 
X-CRM114-Status: GOOD (  10.01  )
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

On Wed, Apr 14, 2021 at 10:46:29AM +0530, Kanchan Joshi wrote:
> nvme_clear_nvme_request() clears the nvme_command, which is unncessary for
> passthrough requests as nvme_command is overwritten immediately.
> Change nvme_clear_nvme_request() so that double memset for passthrough
> requests is avoided.

Please just move the memset to the one caller that wants ->cmd zeroed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
