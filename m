Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F5C3ABD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YoqLD9JbMjx/kzkI02wwXOFbn2tSuQL7l+cMQlH/63Y=; b=q+GfYgb09WZmuPqFM84tjTJ3vQ
	SXaKv50+mNoyj74D4ZMTy6/FIwWoU/Zpi35GIwJgstGamjvKi30u2TO5Z7i/UpUPJyELljdAbkpXS
	n/M9dwiJTe4GdieqUf8fcLwzLxNNpk8yxO92h2d2g8TqK2X3ofpvDwlWA2gPSsKr6C7eT2pMx+0R9
	+D6tCQ4Ge4gcmZ9V288Yt1zODZxRZwc/pFn/cVjpTEU7q2YRQP6ra7cOzzb+gNJziGr/aHcYEJ4gO
	Ce4rnZ4N3c/4Kog9uBhbvIbXoayDV0X4eV+YMUZaqWQNNaUGE5Jp7798S7qVbBQ8TAIwuWQr7yNew
	iH8PDonQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFyIr-000000044KS-0Lhi;
	Fri, 16 May 2025 16:52:57 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFyIX-000000044I3-3IKt
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 16:52:39 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id bab8766e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 May 2025 18:52:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 18:52:31 +0200
Message-Id: <D9XQOUZ07XJ6.S9M2PRLSX98K@bsdbackstore.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <bgurney@redhat.com>
Subject: Re: [RFC PATCH 0/1] enable quirks via module parameter
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
X-Mailer: aerc
References: <20250516155025.44958-1-mlombard@redhat.com>
 <aCdgznvTZAJiPjM0@kbusch-mbp> <aCdmR_5pzny8nptW@kbusch-mbp>
In-Reply-To: <aCdmR_5pzny8nptW@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_095238_161468_A3B7643E 
X-CRM114-Status: GOOD (  11.95  )
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

On Fri May 16, 2025 at 6:22 PM CEST, Keith Busch wrote:
>> Can't we already do this for pci using the "new_id" attribute of the
>> nvme-pci driver? It takes up to 7 parameters, the last one being the
>> "driver_data", which is what we use to setup the quirks, and you can set
>> that value to anything you want through that interface.
>
> Oops, maybe not "anything you want", but you can set it to any value
> that exists in the driver's table. That may be an unnecessary limitation
> in the new_id_store() function, but let's see if that's sufficient
> before considering changing that.

Thanks for the suggestion, I really hadn't considered that.

So the idea would be to unbind the device and re-bind
it while specifying a different driver_data, correct?

If that's the case, I do have a concern: how can I do that
if the root filesystem is on the device that needs to be unbound?

Maurizio

