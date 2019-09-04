Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6C3C3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:54:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32B123400
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nu5oRAps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32B123400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ORJ8FSHwvrjy3SntT+q5yjUPb2E0RP4G1ZgXwJXJAQ=; b=nu5oRApsN5kjpx
	xitKK3o77ew0ntoqRrr5poOgprwVgk07YlE4hcRodIEG+ZUAVYtnse2hAEnftPjpkEGF8v9ZepTPK
	GP2QxQKmJgrjMoJtEKzVcGzPHq6uwdAgtPIU4i5aE+yzcxZGoVvDHaQGQ3ROp5EM4Z3fiL/qVvTdr
	81Aa1fsgG9g1FKrH+c/TspUzm+G2kY3KAeFwMufdB502nL6krNj5vI46VHENGp9Bs7KmcHMLWvSOt
	WT1vFgLu89tIAkqnUBaZKW70dRu3kXF1hMHgWbijB4Z/Brj4g9ouo4AoI6kQH2oUrQaDlNgcVYic2
	ThLLMf+LMZPHs/zp0V0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5OFO-0000Sy-3a; Wed, 04 Sep 2019 05:54:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5OFL-0000SX-KV
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 05:54:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2605A227A8A; Wed,  4 Sep 2019 07:54:20 +0200 (CEST)
Date: Wed, 4 Sep 2019 07:54:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] nvme-tcp: introduce nvme_tcp_complete_rq callback
Message-ID: <20190904055419.GD10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <1567523655-23989-3-git-send-email-maxg@mellanox.com>
 <c5757c95-2a4f-410d-a275-85d8c9da737f@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c5757c95-2a4f-410d-a275-85d8c9da737f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_225423_823838_51756D55 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, martin.petersen@oracle.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, shlomin@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 12:15:48PM -0700, Sagi Grimberg wrote:
>
>> The nvme_cleanup_cmd function should be called to avoid resource leakage
>> (it's the opposite to nvme_setup_cmd). Fix the error flow during command
>> submission and also fix the missing call in command completion.
>
> Is it always called with nvme_complete_rq? Why not just put it there?

Yes, unless I am missing something we could call nvme_cleanup_cmd
at the beginning of nvme_complete_rq.

Max, can you send one series for all the nvme_cleanup_cmd fixes and
cleanups and split that from the PI work?  That might be a little
less confusing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
