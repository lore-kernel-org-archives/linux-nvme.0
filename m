Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE9EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:06:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFDA64F30
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFDA64F30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Km7BFFrMpV3WGckhIuWkPV3QKrpnVdP3kVs/8TIT5sY=; b=DDKWAPl6HK1yMCsM8KwxNdWcy
	+bNomCAejp64+LGbX3nbdsuvFrpNoid/0j2fdSBZ/Tw1ZvYn+5XmbBeimLVWFpIHHJqcPMg+dUeBT
	DsYaRvjFaIMmyNS5E/X91hUi8LwLBaIXz4z3Zx8FBVHBZbEZWlcP3/0zE925iUEH76+V1y+BZt5KT
	iCAvdSlghurZqfS/oGQNA170W0FgG75ORGO2/UjBfhFNBV7GKvbXONUZmvCCZ2aym5HjF2gv5xbp6
	4OUwyWaToZyJs+6qf64BYK+xy6A9n6wiLptrApMkiPab3stkAqSnQkH4DhkLZncbbYy0yGmiYGCEl
	qcNW82o3Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZFZ-004Amd-7p; Tue, 09 Mar 2021 10:06:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZFV-004Alq-3c
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 10:05:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1B87468B02; Tue,  9 Mar 2021 11:05:56 +0100 (CET)
Date: Tue, 9 Mar 2021 11:05:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de
Subject: Re: [PATCH] nvme: fix warning in nvme_update_zone_info()
Message-ID: <20210309100555.GB7243@lst.de>
References: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_100557_259394_C1CE5FE4 
X-CRM114-Status: UNSURE (   8.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.12 with an updated commit message indicating that this
is not just a warning but a malfunction.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
