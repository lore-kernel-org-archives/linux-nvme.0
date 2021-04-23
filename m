Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21FDC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 16:44:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9073E61360
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 16:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9073E61360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tlg7A7OjUOiZ0rmUt2c9R5eIs7K8q95IMWGwwCWppJI=; b=aeoEY8zmWZoQ6jZIMevKCo3IN
	PjYO1ii7RFiOS+jhN813i/CohyDFkZeUcv/G3xkUyo8op3+fwdFQxJgRW3LoF5bYQimR3iF41rARN
	9QuVeHGKO8IPG0tffhqA7/Z0aC5lVlsuG6H/PJgXw8PXyc7mz9GDqi+6RaiJqebWBWITvUClAuFF/
	OKU4Rjgbwu3AJleWyWuMdE90TOpfkVrVLVUQqjJ0nXFPkRFYa9m3krm+HOww6Zx9WSTaoyo6X5Jx8
	kJabOHRVi6zTE/HH5t84G+82AAp+hKuMdmA4NOGXw9sNtQnCD58/M9GrWReyhSRAarnvUznhH+L7X
	H/iNMCPag==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZyu6-001un8-7B; Fri, 23 Apr 2021 16:43:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZyu1-001umC-V4
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 16:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=K1qRDBrEfUUC3AqgbmmyENG9RnIP4rRFbHrN+54+aP0=; b=quZPMm7seicUcPvZmjvJqCup5r
 r5vGVlFdD33b8/rJdvSyD3N8x69gaN7JiG6WO3v1Ar9Slfb1tqqwIdhJtkUZ2F9fauKMx/9m3Dfx8
 O8NX1UndNfusWfcAF/W9BwmGA6B3rkpY5sN+7PrH1M8d0hcg+6D3y8HQlu7BBGip/v39fkEHzKlwe
 m/S8e8ENIjncwLYend3PxegmZScuPFK+Jv3ivF7BB7QRPufKSuqbzqPX4o3bgsjHrCDWLDXx4TaJ2
 Z2szJsy6SMNpXYsfmmvmVacTb2QQCK0VjY9FZOhA+glFRblvVQJqkyzwp7DEM9TaW/HT8jwIJ9lP5
 tl8jChFA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZytz-00EYpk-7h
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 16:43:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619196210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1qRDBrEfUUC3AqgbmmyENG9RnIP4rRFbHrN+54+aP0=;
 b=LFI6+480j8p8n7hANBBORd6XIyAnG7XgdUhC0fDuFecpt0PlXYW6lv2vp6JNVkrulrTB22
 RBD5/Jl5bMep+KNSUDFEuOa9Bd6PZC3beEcE8wi9jYY/Cgrwbeb2HEwrLa1ZZE8yJYG5Xc
 3LkbiDS0zrKCZ4NEh8us0K59c0cLzq8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D5D0DB164;
 Fri, 23 Apr 2021 16:43:30 +0000 (UTC)
Message-ID: <b2315ed2e6e1c273c9e000b107c38e41e2ddd33c.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>, Hannes
 Reinecke <hare@suse.de>,  Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Date: Fri, 23 Apr 2021 18:43:29 +0200
In-Reply-To: <CAFL455k3aBLcZrZPq=Q-9aws4UesstA5gSOr_E7mEFrLT+KbKw@mail.gmail.com>
References: <20210423133835.25479-1-mwilck@suse.com>
 <CAFL455k3aBLcZrZPq=Q-9aws4UesstA5gSOr_E7mEFrLT+KbKw@mail.gmail.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_094335_437044_75659DC8 
X-CRM114-Status: GOOD (  11.07  )
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

On Fri, 2021-04-23 at 17:50 +0200, Maurizio Lombardi wrote:
> Hello,
> =

> p=E1 23. 4. 2021 v=A015:49 odes=EDlatel <mwilck@suse.com> napsal:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index a0f00cb8f9f3..46287b4f4d10 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -2068,6 +2068,7 @@ static void
> > nvme_tcp_error_recovery_work(struct
> > work_struct *work)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > =A0 =A0 =A0 =A0 }
> > =

> > +=A0 =A0 =A0 =A0nvme_mpath_stop(ctrl);
> > =A0 =A0 =A0 =A0 nvme_tcp_reconnect_or_remove(ctrl);
> > =A0}
> > =

> =

> =

> Do you think it would make sense to call nvme_mpath_stop()
> inside=A0nvme_tcp_reconnect_ctrl_work() too?=A0
> Right before it requeues itself by calling
> nvme_tcp_reconnect_or_remove(ctrl)?

Good point, probably yes. I'll have another look.

Thanks,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
