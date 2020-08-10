Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B753C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:06:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CC72076B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ghWewMA3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWPAxe56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CC72076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s8g7OP+N/aSxTKzcx/jsFPE6u0MG8XP2iwtMP2uFJn0=; b=ghWewMA3taAagR7zssoY7PydW
	FYj9o2hMNutw1oaeOOpjXL2CbUdHQxwXI6vY8hrPK6ft7u/Hnrel5VYmxZBGARRGO64Dswh7MM3Fj
	XkRFoy4yXYJhLfSjSVaEfFoBzOVof7ctY/smd042/FOmEsZ6GQ7iaD5HZWDCUb7XwewfAfw2DtdAi
	i5X05hXPUiOczvGFzLoTy27J8VydSaNWpFqm80hHQ0q/8ytgk4o6dCaeYzKCElKcuJudGF6crBom4
	8VaFIxuzWL9pYOofYM+oO1OHqmR2riNAumK1xhOqNj5d7ZIbxhNQq/y5lCxvuyZSRTrte3jDHzxpZ
	gpp+qeGRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k59NS-0002ru-WC; Mon, 10 Aug 2020 15:06:19 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k59NQ-0002qU-4p
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 15:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597071975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nxo6fmOUw2RjL9n8el0AFvTK2pjsUPa2rnRV9scUKmc=;
 b=bWPAxe561F8tNnSCgQfBxiICozz2gB5Qumm1dxdwUZh/g8/JhK/e2NKPyj0ROJmgFfP35h
 Rk/U0QOqWwd2cllGMOvfEd7Wmtx+DlYQF/n45dalp97doGp2QLn1na3RqzrAFyTubI8O1s
 IRo/Orrfw4e+m0T2CeWo2eYbdTQYjEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-1LAjMqAWNd-BxTg1jikKSQ-1; Mon, 10 Aug 2020 11:06:12 -0400
X-MC-Unique: 1LAjMqAWNd-BxTg1jikKSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EC7F1083E82;
 Mon, 10 Aug 2020 15:06:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB9AE10016E8;
 Mon, 10 Aug 2020 15:06:10 +0000 (UTC)
Date: Mon, 10 Aug 2020 11:06:10 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: nvme: restore use of blk_path_error() in nvme_complete_rq()
Message-ID: <20200810150609.GC19127@redhat.com>
References: <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
 <20200810124355.GB25070@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200810124355.GB25070@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_110616_481405_6FD7CE0C 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, "Meneghini, John" <John.Meneghini@netapp.com>,
 Ewan Milne <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10 2020 at  8:43am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> Just returning from my vacation, and I'm really surprised about
> this discussion.

Welcome back!

FYI, I got roped into this stuff again due to reports of regression from
Red Hat and partner QE testing of latest RHEL 8.3 stuff.

I have been away from all things NVMe for a while so apologies for my
misfire that dwelled on nvme_complete_rq()'s blk_path_error() call being
removed.

> If you want to fix a device mapper / block layer interaction you do
> not change nvme code to use suboptimal interfaces.
> 
> One of the reasons for the nvme multipath design was to allow for
> tighter integration with protocol features, and making nvme do a detour
> through the block layer for no good reason at all does not help with
> that at all.

Yes, reinstating blk_path_error() was a distraction.  Still an
outstanding point to discuss but it can be pushed to the
back-back-burner.

> And if you want to support the TP that added the new command interrupted
> status code please read through it - the status code itself is just a
> small part of it, and none of the changes proposed in these discussions
> would lead to a proper implementation.

Think you likely glossed over aspects of my exchange with Sagi.  That's
fine.  I don't fault you in any way for not wanting to labor over this
thread to this  point! ;)

Really I shouldn't _need_ to be the wiser about all this inherently
local NVMe error handling, which happens to be increasingly complex,
that seemingly has nothing to do with multipathing.

NVMe should handle the command interrupted status code, ANA and now
ACRE in a way where it isn't conflated to detour through
nvme_failover_req() et al.

SO that is what I hope to rectify with some simple patches.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
