Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36391C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:08:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08DD22D2C
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08DD22D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qosi3gsxxmGzszRwcxkibz3p89D41oWUwVfDpbJtnhk=; b=qRSSDjABiSv/KU1FQfI8M2Brc
	2GQIMdBVOe4ZrlV/E641qA6s92/dPZBD7J3Yo/ThYNFzHyKwCar4DsPdqvKaKGK14e8YEeou1YI/T
	uN6BwhR0ydrhkNuCAFTLCk0/qd2H5c/AYOQc8BCFqi7bYYCldpb6VY/fYxyBGQeYKcmMEw3fES4sI
	5RS6FCicMOV4YY9HlurHJUBQg7z4juCMjbZx94NeLai52MJgDE9QmlZxJw8i9t5tVXMZyH/qq0KSI
	NN1VPBVl4enQeU5xD0IinRPjk6Ch/xmnoxrgEYsIAHE3sIinph2hPxkBq9bvYQjxKoepwKBGdAieZ
	H3VX/Wjvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzEjP-0005Yb-2c; Tue, 12 Jan 2021 08:08:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzEjL-0005X4-KK
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:08:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7114567373; Tue, 12 Jan 2021 09:08:40 +0100 (CET)
Date: Tue, 12 Jan 2021 09:08:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/3] nvme: check all retry delay times in Identify
 Controller
Message-ID: <20210112080840.GC24949@lst.de>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-3-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108144659.7126-3-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_030843_843448_E72E4552 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 08, 2021 at 11:46:58PM +0900, Minwoo Im wrote:
> If none of Command Retry Delay Time(CRDT)s are set, then we can simply
> skip to configure Advanced Command Retry Enable(ACRE).
> 
> CRDT selection will be made in Completion Queue Entry that controller
> has responsibility to decide.
> 
> This patch checks all CRDT[0, 1, and 2] in Identify Controller data
> structrure instead of checking the first one: CRDT[0].

Why?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
