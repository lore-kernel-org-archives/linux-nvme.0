Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D8C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 11:00:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5A02074B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5A02074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eBz2aU9CzwMGoPcMvC4r+dDqYNXHyXIIBNbBwANlX7I=; b=0BB2qEMcXNdFDMJ5jZ+nYMBKR
	GvCToNJIOXiO6QNoLQzWkxM0BbtrRkG26Mrkp2hzO3/yRItBVYD2EOlB5SbvH+jPGznxhSSoinC+s
	RnxuASF5b3okwMdDkA+QF6uTdqmVcX18ejYNSwskOVy1vCexv4+tSgFTyI/Vctt6Gs0ciV0NLfMdn
	m7E96ACI+cEzrTP5ZTI9Mp0Nh1o7sX5fCGX6kic+We6rTXT/R5+67tU5npJ3F/xKgpvWgsYv9S8Uu
	Ug/MX/J9Qu0/wLsnWkllPBlesaCYcrXj+opdiuUgYTrBoADyiepHjMvDIhJxB/O3Dm04HMgBVJcMo
	TJ4R4XIow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4iYU-0003Et-28; Wed, 27 Jan 2021 11:00:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4iYR-0003E7-Ja
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 11:00:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7B33AADA2;
 Wed, 27 Jan 2021 11:00:06 +0000 (UTC)
Date: Wed, 27 Jan 2021 12:00:06 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a
 command has been aborted
Message-ID: <20210127110006.gx6j465hnz3j2p4v@beryllium.lan>
References: <20210127103326.16191-1-hare@suse.de>
 <20210127103326.16191-4-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127103326.16191-4-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_060007_793145_ADF38FD5 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 11:33:24AM +0100, Hannes Reinecke wrote:
> When a command has been aborted we should return NVME_SC_HOST_ABORTED_CMD
> to be consistent with the other transports.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
