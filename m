Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B182FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 16:49:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBDA60187
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBDA60187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=awrrYTaMlB0z3ZGcPP+KWFgrT
	rQOKQYyjnUW7nWjCq/cSLlWNqs2uwcbX4Lc/QNJt2h8yiv8IQXFU1p6ID6nSc1qmZjUwLDTuy7HqC
	pTsYvsPTg4GdgKCSUCKyvsnh7Z6e+vj4DbYBKp7DKlkTxk026Od4bn8G1zDxHAZPjaXxxUlyU9M7X
	nsktcBRu3k8BM2jAmX1LZF3PvNg5m7ROxsfsktlMyiAc2b8IovS/FWOegzVJfWIJ4JkT6rC/OlC3z
	vXTYZrBfv8OgYFoelLiRaD33D/b5P76RWh/xQSIjAbSjpr7ilGP6VbmigDvYvSebIbti45ikeN21w
	wwYMRAcXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4o0t-0006YX-3q; Wed, 27 Jan 2021 16:49:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4o0r-0006Xz-Jt
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 16:49:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C551F68AFE; Wed, 27 Jan 2021 17:49:47 +0100 (CET)
Date: Wed, 27 Jan 2021 17:49:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
Message-ID: <20210127164947.GB24228@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127103033.15318-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_114949_817146_A8B82423 
X-CRM114-Status: UNSURE (   6.96  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
