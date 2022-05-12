Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822F8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8Uv33sQzQ6sncxKZAh6lI3KSUSZf2EKQdApwYwgjD4=; b=SNN/HpMBscn3cevzszLX/PvEPL
	kn0vVxrZlw5MZv4pgaGC+zSYSBZOC110fGGafhitGGItsRbbRkQHbgtVckq1p6n4RUdeBr0d1gef1
	/qclLPFiQ8vivGkjQcLOjch30dO7QGQLfG06Cv42VkADs/ZypwiaoNzx7eFPz5GlYp+CIKPlr4LRE
	suEhNTuPkjShoukUY747CkAJXLTUNtPrDQgjABVzPDajFIodk3zGyDV8tWjefJnHy31E/C3swiarN
	wYV+2A3NrwyUWGLgbCB6wbTILGhJfsdy8vGJePDi7ELOwG6W0cgqQRN7cHl/bfhJWcSN8e162Zraz
	MKTzZmgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np4RC-00B2dD-D6; Thu, 12 May 2022 08:44:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np4RA-00B2bw-7z
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 08:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652345083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c8Uv33sQzQ6sncxKZAh6lI3KSUSZf2EKQdApwYwgjD4=;
 b=ZAQV5MkHJ8qEAGWIGqsrXQfdTLHHP5ctlyf4G8qDIYojuMhyPw/pSmWiiQXtWqcbTyJ0Ps
 XEZVCfhufc/ehqvj7ETPLKyHu+3ISc5Xy6JBy6nuH1cO3O4DU4gGtid5XN1okyKmpQVC5k
 IBxZuwufnJ5OxLZZ70LGhRmFvHBgGNk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-HPDrJzHyN6mGuunDkRHdWQ-1; Thu, 12 May 2022 04:44:41 -0400
X-MC-Unique: HPDrJzHyN6mGuunDkRHdWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51ED43C161A6;
 Thu, 12 May 2022 08:44:40 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4BFCC28106;
 Thu, 12 May 2022 08:44:33 +0000 (UTC)
Date: Thu, 12 May 2022 16:44:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 2/6] block: wire-up support for passthrough plugging
Message-ID: <YnzI7CgI+KOHNKPb@T590>
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055310epcas5p46650f5b6fe963279f686b8f50a98a286@epcas5p4.samsung.com>
 <20220511054750.20432-3-joshi.k@samsung.com>
 <YnyaRB+u1x6nIVp1@T590> <20220512080912.GA26882@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512080912.GA26882@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_014444_402429_C028A26F 
X-CRM114-Status: GOOD (  15.44  )
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

On Thu, May 12, 2022 at 10:09:12AM +0200, Christoph Hellwig wrote:
> On Thu, May 12, 2022 at 01:25:24PM +0800, Ming Lei wrote:
> > This way may cause nested plugging, and breaks xfstests generic/131.
> > Also may cause io hang since request can't be polled before flushing
> > plug in blk_execute_rq().
> 
> Looking at this again, yes blk_mq_request_bypass_insert is probably the
> wrong place.
> 
> > I'd suggest to apply the plug in blk_execute_rq_nowait(), such as:
> 
> Do we really need the use_plug parameter and the extra helper?  If
> someone holds a plug over passthrough command submission I think
> we can assume they actually do want to use it.  Otherwise this does
> indeed look like the better plan.

use_plug is just for avoiding hang in blk_rq_poll_completion(), so
I think we can bypass plug if one polled rq is executed inside
blk_execute_rq().


Thanks,
Ming


