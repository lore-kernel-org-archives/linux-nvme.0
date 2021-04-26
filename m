Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28DFC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 16:27:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352F9611C1
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 16:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352F9611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C5cbfaS1sBr90DeHS6jGcbF7ociRXiWGbpEnE7fE4WA=; b=D0ZwUNtJqbRoLClEgp8ZNZ51R
	JfFAtlbZLyYWGU556VowHIwzO0MLT7ZsPxs7fq4eUZ4nqpmdFKtxL9HTlfqy/t+OTiciBFfH7H4RS
	E56jddyfuvp21UIywQIKfNM7hEyncBZIMWGI8VRZ2ubPoIy4gku7Qbb5jO/1i9c/lE39vcoaniLrt
	PxHUsgLsORFvZ+E+qLKpJY+m2Yg5pdFExZDxlJtc8r7h6+7w+WQ2RWxuYZo0kC6AfArDORN6h7wBk
	RCWsn5zvdxbmMJlNE0IbrCzRGz5AoAEaT8oSpArwzAmqXzsvHC5xoaEWYBMS20LW1w/Go6b+IBmk2
	hfG0ytsyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb45K-00857N-AJ; Mon, 26 Apr 2021 16:27:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb45G-00856y-Oo
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 16:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=YS6rGxbgzt47nKPxM57puqPoVOL4x7kpMwj4upVHCgc=; b=jgELv+fMR+OMLb08H+W5Uh/cMg
 wltosOm+rdDETVaIZOFM5IObohTxM5YBUXhDOAhCdGWCfUmOzvLeSM4zDQwBr7+swLS3/st420VYE
 iaYFZkY6wRBGYWk+zGzIP21VZ5gYaEgYma5cFnsPRKcxIPpCFWptDjs6fyqjSdkOHeauzg1+GZFw6
 oo7vakj/RrnF3UT7hsd9XHOKQtG53pyLBOvBXHUnV5Jj03WCq0Sadk+hr0Hl34hUDdxewqjLLAebM
 9Wr4yKXbANc3z1Y3AAFlb4Ay2IcHd+7MVUSuZbc+Nv8E2XBUVgJ1vL7q0HPkb9GrBvpbafRslnUOP
 JdUmSOwA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb45E-00G5aA-8C
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 16:27:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619454458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS6rGxbgzt47nKPxM57puqPoVOL4x7kpMwj4upVHCgc=;
 b=NsPI0csXVIME0yWjck0zoKV3VDAK0HLbTFPAbZtZ9S+DBFY4IrvTiNaPs5le5HW0TZtMz/
 5nCLshCL0XF1dohhSH/7xsjuh7SYgxlvBWQ/JBmNTMHTI8aNNVaxlf/Nx6WoiJcQXLcMfb
 vdWBCmUdrDtPmMJiumN0t9gA8XBTYkQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 888A5ACFD;
 Mon, 26 Apr 2021 16:27:38 +0000 (UTC)
Message-ID: <2df7213105b42f08fdb021e084f277bb881fb230.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>, Hannes
 Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Date: Mon, 26 Apr 2021 18:27:36 +0200
In-Reply-To: <20210426145105.GA22120@lst.de>
References: <20210423133835.25479-1-mwilck@suse.com>
 <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
 <20210426145105.GA22120@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_092740_459275_6B3AB91D 
X-CRM114-Status: GOOD (  18.42  )
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

On Mon, 2021-04-26 at 16:51 +0200, Christoph Hellwig wrote:
> On Fri, Apr 23, 2021 at 05:21:03PM -0700, Sagi Grimberg wrote:
> > =

> > > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > > index be905d4fdb47..fc07a7b0dc1d 100644
> > > --- a/drivers/nvme/host/rdma.c
> > > +++ b/drivers/nvme/host/rdma.c
> > > @@ -1202,6 +1202,7 @@ static void
> > > nvme_rdma_error_recovery_work(struct work_struct *work)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > > =A0=A0=A0=A0=A0=A0=A0=A0}
> > > =A0 +=A0=A0=A0=A0=A0nvme_mpath_stop(&ctrl->ctrl);
> > > =A0=A0=A0=A0=A0=A0=A0=A0nvme_rdma_reconnect_or_remove(ctrl);
> > =

> > Its pretty annoying to have to needlessly wait for the ana log page
> > request to timeout... But this is also needed because we init
> > ana_lock
> > in nvme_mpath_init while it can be potentially taken in ana_work,
> > which
> > is a precipice for bad things...
> =

> I also really hate open coding this mpath detail in the transport
> drivers.=A0 Didn't you at some point have a series to factor out more
> common code from the whole reset and reconnect path?
> =


So ... resubmit and cc stable as Sagi suggested, or work out something
else?

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
