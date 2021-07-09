Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101FEC07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 16:43:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FFC613BF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 16:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FFC613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BjGJSyINCrq3mPRrRz+JJFMuGGsNjaLXcDVLBgOEg4o=; b=STB2D/jDq757AV
	r8czJap/uLog8YQPeW+MOkftVmEhvoH2G+ZyXCHoZ2SjrbR34H/wpnsULuT5b7jGyO6oVvV0AAxnM
	gcDr61l0qDUSNGQRURhITvytDxFQnL8t0vIR/sD3fFP4rdg3zFC2Hy46l85llhAe6djH7Y57DTtuA
	n1ijInWX9xjNEyqrVwUkuymjd3W9egTvHKfFXHckLECnsw4gXeko7ioVOR2/kLGTgLBY1u+kmhRXv
	A08WAZHrgyuFXXbTIYJClJ1J75QCOP/Qv4FuN8PxOP6n+dF/wPcqT9vb0d6fOBQ4dJk1HNuuAVq9/
	MXpPi+Zs2dCQClP8XhyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1tai-0028vF-2I; Fri, 09 Jul 2021 16:43:04 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1taf-0028uO-On
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 16:43:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 94C0822329;
 Fri,  9 Jul 2021 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625848978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GqMGaeS7pORjjou7yseLa8mm5Ypx7LyOSQJgsBCm4c=;
 b=AwMFv4Jl+bcWd9Xaa/+25xWXOMrQ3RMDLYQ8rZGrMYXOS0hpxj8qyOjter2LAqPdwzj4rr
 BmkgM9p35ZPIACyax/m7J90oCQPjhzlmkcelLlKf2ITsWdzHeYAZaHs8Zb+pZrd5dSkPAX
 3t3AlPsl6Z6xvngGIR30fxNGd9okvio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625848978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GqMGaeS7pORjjou7yseLa8mm5Ypx7LyOSQJgsBCm4c=;
 b=xQWc6hy5FIe7GG7mws6bWprl9NKG3d7M+l1cH0JqxpMWYdQYhG2L15gZDX5CbasBVxtvgj
 523ocLsybbmxZeDw==
Received: from localhost (unknown [10.163.25.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B4D1CA3B9B;
 Fri,  9 Jul 2021 16:42:57 +0000 (UTC)
Date: Fri, 9 Jul 2021 18:42:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
Message-ID: <20210709164257.hzbxrbgjnnooidqe@beryllium.lan>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-6-dwagner@suse.de>
 <cd630e81-68c9-c62d-de73-8b0ae33c2cfe@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd630e81-68c9-c62d-de73-8b0ae33c2cfe@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_094302_004450_9156F968 
X-CRM114-Status: GOOD (  20.32  )
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

Hi James,

On Fri, Jul 09, 2021 at 09:14:07AM -0700, James Smart wrote:
> Thanks for the note. that definitely helped follow what is being attempted.
> I also agree with Hannes that the comment from the rdma patch should also be
> present to understand what's going on.

Sure will do. Though this has to wait until I am back from holiday
though :)

> Looking at the patch - this is not done in the same place or manner as rdma.
> Freezing and stoppage is prior to cancelling and that doesn't correspond
> where this was added (this is after all cancellations). We also seem to be
> missing a nvme_sync_io_queues() call in the sequence as well. So I believe
> there's more work to be done on this patch.  I'll see what I can do.

Thanks!

> We really need to see about a common layer for transports. So much we do is
> similar. We were ok at the start, but we've drifted apart over time and the
> requirements to the core layer aren't propogating to all transports.

Yes, makes a lot of sense to me to sync the transports implementation a
bit more.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
