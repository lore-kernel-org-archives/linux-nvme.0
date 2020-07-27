Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C4AC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 06:32:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB4E20714
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 06:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kd2MRvFM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnhBr7wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB4E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wq22woZ5DxsL0RGYfcN9SRftp5ZZNFOIRQl9jNF3EaQ=; b=kd2MRvFMTsqlGMe3Jd3hGq46g
	Xhl4wAb1f4AaZC4NeIlhmJU7eoiPdCAo/u6CrwlMnB8uQZOvvp3WvxSDxjOcMcRuemh6DPDacLKGu
	agxknCZTfHgeGYBahvpa96bVMt+cdJDkehmfErvBSQTjg3dMyzxFQ2D2QTArndrhKFE6cN2yK3yJA
	xFCfHFXwal00/JBDfZafp4g5dptUaKdN3ICFEvyX9gxZsENGsS9FQsN3fzSmm8JMLZVlu9y2vrBY1
	jtBseDePxG9KjUsv+zErQoSTinpwgnhKAB/Gj7vio90W4mV9FblqAH0svgKKsUSpT7+PLxpN+XF7Q
	WfMNKnI8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzwgj-0001a6-J2; Mon, 27 Jul 2020 06:32:41 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzwgf-0001ZX-MD
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 06:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595831556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJtngrEk2ZTwLRW9iKTKZSGysZhtZ1fNHYksyTSX2tM=;
 b=dnhBr7wiJJjcpCAwhOheppO7h9Ak/NPcnisY7lH2Hmt5ue/u03g+z4R7Zgx5i40wBrl5OE
 VXPK1SfdTWwgr3hzxFJ/zF/0jBfSqOAbBPDY9f5IKfhPE7GIjy2qiIRB/9eUBzAmPSZc2f
 NgN69QZVNyE4haglmvUOdtvuK/L7R1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Z_xYT0RHOvWRtl-nTClzRg-1; Mon, 27 Jul 2020 02:32:33 -0400
X-MC-Unique: Z_xYT0RHOvWRtl-nTClzRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B6C01DE0;
 Mon, 27 Jul 2020 06:32:32 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5302F5C1D3;
 Mon, 27 Jul 2020 06:32:24 +0000 (UTC)
Date: Mon, 27 Jul 2020 14:32:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727063220.GA1144698@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
 <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_023237_849046_E72A2E98 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 27, 2020 at 01:55:53PM +0800, Chao Leng wrote:
> 
> 
> On 2020/7/27 11:50, Ming Lei wrote:
> > On Mon, Jul 27, 2020 at 11:33:43AM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2020/7/27 10:08, Ming Lei wrote:
> > > > > It is at the end and contains exactly what is needed to synchronize. Not
> > > > The sync is simply single global synchronize_rcu(), and why bother to add
> > > > extra >=40bytes for each hctx.
> > > > 
> > > > > sure what you mean by reuse hctx->srcu?
> > > > You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> > > > to each hctx for just simulating one single synchronize_rcu().
> > > 
> > > To sync srcu together, the extra bytes must be needed, seperate blocking
> > > and non blocking queue to two hctx may be a not good choice.
> > > 
> > > There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
> > > Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
> > > not need if which do not need batch sync srcu, I still think it's better
> > > for the SRCU to provide the batch synchronization interface.
> > 
> > The 'struct rcu_synchronize' can be allocated from heap or even stack(
> > if no too many NSs), which is just one shot sync and the API is supposed
> > to be called in slow path. No need to allocate it as long lifetime variable.
> > Especially 'struct srcu_struct' has already been too fat.
> 
> Stack is not suitable, stack can not provide so many space for

Stack is fine if number of NS is small, for example, most of times,
there is just one NS.

> many name space. Heap maybe a choice, but need to add abnormal treat
> when alloc memory failed, Thus io pause time can not be ensured.
> So the extra space may must be needed for batch srcu sync.

In case of allocation failure, you can switch to synchronize_srcu() simply.

Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
