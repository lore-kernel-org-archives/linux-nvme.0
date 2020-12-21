Return-Path: <SRS0=EJ6s=FZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCC2C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Dec 2020 07:52:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD7322C7B
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Dec 2020 07:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD7322C7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3adkYqBDMQi753m31MP2vohjhLe/FgnmdQ5PYsvaQac=; b=MoX7CwdXOA/INUysQ3ZUorsgG
	1Jct0zZMtoeDz2Xl+eF5yD6QF3C3LDc+Ol6Jp+8zHUtZANwNwQWIdNdur+jUB2vmWFDiGzxaKmEnN
	7m9xO9XWRWQaU7zwnKVLxtcGG5IZFB3Szr5QIJrOE/p0ZJRr63DeOopsAWRv2nevkuYC58FlbSXsI
	XlL14xR5UuDDUeu2rPCkjppWsfdw8CQHOsveFe0XQ0ll2EnKF7QiO0ysxRlzdJ1666sA1WshVwAE6
	/zhWARWjmC4OEEhY1M8+JQK8GLg0Qbatnc0j98V2diFtizZ8KyQ3qmraCZ+PpCaB/6gOUxq2eCt21
	Y76uMy+6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krFz9-0004Dw-8F; Mon, 21 Dec 2020 07:52:03 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krFyi-0004DX-R7
 for linux-nvme@lists.infradead.org; Mon, 21 Dec 2020 07:51:37 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0BL7oqDX013437;
 Sun, 20 Dec 2020 23:50:57 -0800
Date: Mon, 21 Dec 2020 13:20:53 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Request timeout seen with NVMEoF TCP
Message-ID: <X+BT3VpGDywEb1wX@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
 <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
 <X9mgW4AxRpQsetN1@chelsio.com>
 <52bc9a04-777d-7a29-d784-468a69aa1478@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52bc9a04-777d-7a29-d784-468a69aa1478@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201221_025137_013957_9EFF7558 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Friday, December 12/18/20, 2020 at 17:35:01 -0800, Sagi Grimberg wrote:
> 
> > > Potnuri, does this patch solves what you are seeing?
> > 
> > Hi Sagi,
> > Below patch works fine. I have it running all night with out any issues.
> > Thanks.
> 
> Thanks Potnuri, can you try the patch without the nvme_tcp_io_work
> portion? I think the issue can be resolved with just adding
> nvme_tcp_send_all..
> 
Yes. Issue is resolved with just nvme_tcp_send_all() change:
Test runs fine for me.
Thanks.

> Thinking more about what Mark mentioned and it is correct
> that io_work needs to reschedule itself if it wasn't able
> to acquire the send_mutex hence I am not sure it is needed.
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
