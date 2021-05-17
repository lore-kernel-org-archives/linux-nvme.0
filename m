Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A3C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:47:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70952611BF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70952611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LWfLgLnrh+YB5MP33oQX7A+JHcnYktL4MObOcoGka8c=; b=WdlcVRdBpRcWPKBsgilze752A
	8zoCU20k/z+qgWB7oGDSw2oG6XGCHN41KYv7aXU0nKNPUqwd1kZuW12W/v7mrQbPMB4Bzt91PLU70
	4iSB5zmdkw+q/Sq5Y6YG7v16puSHpG2LUf1i/V18QUzfxlUYtOpgB0RyUIiJ0EQaVxt25mUeuwJNB
	Mr6tD3EHERaBOIOVFjBHFMgl70f+PSrn5zli9aKCtYgZd+sFpv9A3nzJnkdRJ4bAh99KxCaN1m+0d
	IgPqcZfklpgrAkO09qZcHVmMiIfVlKrdR+GPUL19wjurwAJRKTBVexoxa1WgSyiYxA6TjmZSnzTif
	rYtKpKjLw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ligOk-00FYzB-Cf; Mon, 17 May 2021 16:47:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligOg-00FYyi-Cs
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 16:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=xB2vZ6DgPHlrhXYcJ5ZhAHULN85l3vdQHkX3+UGPqmQ=; b=ZQHytr4NBXitMtlhXrIUD20gUf
 HZFnpu+BgQ3Wy5Qqn7WA5FdjHI9QShW2o0fhpOI5exvO5Csajlo82vpKf6GbwenmHSRWdgOlhb9kB
 +zGltIXj7eZ06Yhd4zzw/0GclaSwTsM9TgfNbtkHdbT5hGJNC90E30pdR3SEqmdcWz6/OrJ9tBn4Y
 gHcFZmqMG01xgfNhmiOWzR12Zg+9SQknfwzjTyMLynsXTBHFgOskc8wAEET78Ur3Oq2X0MoZR54j8
 8y1Tsl+uFDWcoowq9kjkEqV7C7JWD4Pycd6KLTZYJR1ZcTH/5xzn3VYhIqp3UEXH04oomdIr3RPnA
 WCIRp3KA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligOd-00DzZH-NF
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 16:47:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1621270027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xB2vZ6DgPHlrhXYcJ5ZhAHULN85l3vdQHkX3+UGPqmQ=;
 b=fSR2v2Q+sX0o85u1rcRhgqX3jK9NzqUtQRzoYs1REu9sAGq64OYaqbnH1H/U55aMUtxx4z
 9WoSgqLI65cV6T6SfI3hxER3HWAwclLpSpVHbTw2IyWmVnQ6ZZalPSrA+hGwsM0qBxSCLk
 XtgjAM/axZv61OB5khlKYwFJeNcF+kA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C439AAF70;
 Mon, 17 May 2021 16:47:07 +0000 (UTC)
Message-ID: <e44553cbf49bc12c006f3295b0258cac1755e042.camel@suse.com>
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.com>, 
 kbusch@kernel.org, sagi@grimberg.me
Date: Mon, 17 May 2021 18:47:07 +0200
In-Reply-To: <20210517124801.GA17259@lst.de>
References: <20210506134823.2566853-1-hch@lst.de>
 <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
 <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
 <20210517124801.GA17259@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_094711_944940_930C9883 
X-CRM114-Status: GOOD (  21.28  )
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

On Mon, 2021-05-17 at 14:48 +0200, Christoph Hellwig wrote:
> On Fri, May 14, 2021 at 11:08:25PM +0200, Martin Wilck wrote:
> > Hello Christoph,
> > =

> > On Wed, 2021-05-12 at 16:53 +0200, Martin Wilck wrote:
> > > On Thu, 2021-05-06 at 15:48 +0200, Christoph Hellwig wrote:
> > > > nvme_init_identify and thus nvme_mpath_init can be called
> > > > multiple
> > > > times and thus must not overwrite potentially initialized or
> > > > in-use
> > > > fields.=A0 Split out a helper for the basic initialization when
> > > > the
> > > > controller is initialized and make sure the init_identify path
> > > > does
> > > > not blindly change in-use data structures.
> > > > =

> > > > Fixes: 0d0b660f214d ("nvme: add ANA support")
> > > > Reported-by: Martin Wilck <mwilck@suse.com>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > =

> > > Thank you. I'll prepare another test kernel for our partner.
> > =

> > Our partner reported a crash during NVMe controller initialization
> > with
> > the kernel I built with this patch applied. I'm still looking at
> > the
> > dump,=A0and it's not impossible that I made a mistake backporting
> > your
> > patch. But I thought I should inform you anyway.
> =

> It does look weird for sure.=A0 Did you backport
> "nvmet: use new ana_log_size instead the old one" as well?=A0 If not
> please
> pick it up.

I missed that one indeed, and it's the culprit.

Regards and thanks,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
