Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997FDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 11:03:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AC26103B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 11:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69AC26103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNKj2A9aHZSA2A3kXt7jqTmGai+Do+jtz82gXUgVuCc=; b=b4TlbaP4zRu2kvdRkk8X8j/kA4
	VmBILGSTfJ+CflrmWFjGO1TXBHu4WsFJYryWTT4aN1qwudhHbo3QXF4CGcmHK6wi6x2J0e10zp0sp
	rzo3Wo94WxgcpggU79xc5JbPriFclUmsYSp1MQ7CCOkKLF231Pfjyr1cm9Y6xXuesVsXv4VsFpHSq
	nPpuLb7aGEkFcVNETcWrOKsp+f13joLrQUNrx0N+dYHwU16e3WU2SoeaisEMVk51HgTlg40OhgmWT
	2bp2xmXAGG5p6tf3LXyAfgG8vEVIl2qb+D10nJ6J/XQo7xkaffICxUtAxEgFwpJCWKWN3o6dXDW+8
	W0KqIAyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miE3A-004uAz-6T; Wed, 03 Nov 2021 11:03:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miE37-004uAE-PK
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 11:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635937400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNKj2A9aHZSA2A3kXt7jqTmGai+Do+jtz82gXUgVuCc=;
 b=M2PbFPstcG9F858I9b2CQWy+4VklOCqD2GA1BYNWkpPHy9g2X7GLM+dbfzI5nP7CG07fnt
 hz48i7swvz3Z2BMcBIsVYuVAqhgdceqHHw7ygCF4Djcp5+8EBHqJR00WQCSGY6HmqQS31H
 V3PofBJiVS1BoRojxKFfCE7CgJbU9Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-GsGEFW6zOUaU6b_TUZfe6A-1; Wed, 03 Nov 2021 07:03:15 -0400
X-MC-Unique: GsGEFW6zOUaU6b_TUZfe6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FCF987D541;
 Wed,  3 Nov 2021 11:03:14 +0000 (UTC)
Received: from raketa (unknown [10.40.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7B36788F;
 Wed,  3 Nov 2021 11:03:12 +0000 (UTC)
Date: Wed, 3 Nov 2021 12:03:10 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Subject: Re: [PATCH] nvme-tcp: fix memory leak when freeing a queue
Message-ID: <20211103110310.GE4840@raketa>
References: <20211103081817.94820-1-mlombard@redhat.com>
 <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
 <20211103104516.GD4840@raketa>
MIME-Version: 1.0
In-Reply-To: <20211103104516.GD4840@raketa>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_040321_916239_B663D14B 
X-CRM114-Status: GOOD (  14.64  )
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

> > 
> > Thanks Maurizio,
> > 
> > Why do we need to the pf_cache.va protection? nvme_tcp_free_queue
> > is already protected against re-entry with the NVME_TCP_Q_ALLOCATED
> > bit.
> > 
> 
> It's not the re-entry what worried me, I thought that nvme_tcp_free_queue()
> might be called before page_frag_alloc() had the chance to initialize the pf_cache, triggering
> a NULL pointer dereference. I am doing some tests right now and it seems not to be
> possible so maybe we can drop the "if".

Oh wait, if nvme_tcp_setup_ctrl() fails it could call nvme_tcp_destroy_io_queues() and
iI guess that in that case the pf_cache is not initialized, so the if(pf_cache.va) protection
is necessary.

Maurizio


