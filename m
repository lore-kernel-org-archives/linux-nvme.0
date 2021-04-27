Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF62C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:04:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C28610FA
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C28610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CnD4Wz0+Gc7XXzJq7b52xpaFuOrnpMTKhtBpFDKuN64=; b=b7dqpIzmuxkhqp23F/BqfUaxI
	elndc3liKnxc+Z8wQhMue3tyQNCH9SdmdudAEh3nKiNpn18zpvSNsKthQEmlUizkBnz1XZQi17bHT
	7YMQG1Bsz3DagbE2+5RzEg9QKsBrFHTqhbFRXYC1Vu9I+GDPxjkt9qwidI39MvwuCehG4CwWtT/cq
	l8lJpt8+IUyoHdAGlcMaUR8HEQJ6q6LSE4OVz/RM24PFM+B6yW7+8Xm+SIZmpBEdaOX/qCAm6iDNt
	X0sSOPjSPaHpJvqAz5Z2aO6GJBGdzZdQ5rNV0cXgYHDHbzm4vmctK4ylPF5/s9J2QLwW4YcPGCkX3
	YHVFRGFRQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbJdn-001B2y-RJ; Tue, 27 Apr 2021 09:04:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJdk-001B2e-Oe
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 09:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=MbyyO4VLAotClac/MmzKAXSvgHoreLRBV7PYJzg9ogA=; b=1VkOZje39sCTQtKsGStaaHZTD9
 5cMN+jxc/SDZY1LMrDU5pbXRCgu48EzG+i3og93bhV/lkPMmzamqZYnpYwfn+ewKTZw0qGDxdSrzf
 4pCdbbnTuPMQgy6iI2p1EivlEzVZwZumqHSenoM3lKRcObxcD8bqsm9hmYtbOAkiTdBk14v6K1r1K
 yn3lFLXT7H2ISeQ8kCbqjp7OU+sPp7U44Hx1zYhlHNLnYcTbsawC7vCZqBJ/LQbUhLlQAQF7CKDpi
 4m8DwbDrf/5X7xlbLaZL0CE4J8rd438MX+tKQ0F4JyjLjNenNrgbVbiH+H9RujuFzYSa10XIl61LL
 0HJmhHHw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJdh-00GZBz-Q5
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 09:04:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619514254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbyyO4VLAotClac/MmzKAXSvgHoreLRBV7PYJzg9ogA=;
 b=fzrrh5uBNF5JENkPRFLB6kfPNzJG3w+FZXK68MINciwIFQtmGMZFm2fED0xm8dSnLttKd7
 oqqeRhud3KuHhCVcWN2oRT9i5MjujdW7Wu4l2KoBZrvUW58kga9xOSFnVXPEIJg8Tsus0n
 mF66PuTxbKXaFCLDNkQ6kpITp/0nkk4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A0B7DB01D;
 Tue, 27 Apr 2021 09:04:14 +0000 (UTC)
Message-ID: <f73b09a13d1aa6e47e3ec256cfdbc0b0c3ae30e9.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>, 
 linux-nvme@lists.infradead.org
Date: Tue, 27 Apr 2021 11:04:13 +0200
In-Reply-To: <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
References: <20210423133835.25479-1-mwilck@suse.com>
 <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_020418_011499_6554BEDD 
X-CRM114-Status: GOOD (  12.85  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-04-23 at 17:21 -0700, Sagi Grimberg wrote:
> =

> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index be905d4fdb47..fc07a7b0dc1d 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -1202,6 +1202,7 @@ static void
> > nvme_rdma_error_recovery_work(struct work_struct *work)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0 =

> > +=A0=A0=A0=A0=A0=A0=A0nvme_mpath_stop(&ctrl->ctrl);
> > =A0=A0=A0=A0=A0=A0=A0=A0nvme_rdma_reconnect_or_remove(ctrl);
> =

> Its pretty annoying to have to needlessly wait for the ana log page
> request to timeout..
>  But this is also needed because we init ana_lock
> in nvme_mpath_init while it can be potentially taken in ana_work,
> which
> is a precipice for bad things...

What if we move the ana-related fields into a separately kmalloc'd
structure, rather than embedding it in nvme_ctrl? That way we could
just detach it when the controller is re-initialized, without needing
to wait. When the timeouts eventually occur, the worker func would
realize that it's detached and just do nothing.

Regards
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
