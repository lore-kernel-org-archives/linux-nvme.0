Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EDDC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 09:34:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A1C6103E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 09:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A1C6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aQR9f2zEDRuREz8WbeBZzUDpJRqSHXdHJxMB9+lAxFE=; b=J9Q1+2x77+GOVsGeHAgWIyrGj
	XDwO8Uffl2ZcFEc0RiWmAZzxJI/na9Q6baxUSfV9wQUCxu1ctIcwehmUIoixoPVkBC2/W2x1BpG5t
	Dph69lQ4AtlpdcMadTijURkPyeir+hfvdCd8jP07o8jp0+W50bCCgdyDJLIQ/wxvDtDC71Evut3un
	KAa/xYu7zpuuvVNqVEQVKM19u/5h3+QI18x/Q5wkUBfZ8p5xBhWPrrBWhni0AnzbDMUMMQyFMJySz
	Rcb8UoqMGLA4rJqyPL8LDZyGCKlXFY8HsSs++A7Ol6qexcAUuQ0UcW/owP058sulfIuptILCGThkG
	YKdfY0bHg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laxdI-007KKE-R7; Mon, 26 Apr 2021 09:34:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laxdG-007KK4-Pb
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 09:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=Pa6TNwz/rX6c3xahSoGl5EPCzLvvDWHlvRYJuMFMhaI=; b=CRJZ1d6PRGLqYDt4Ws0OkBqL7p
 wDmKXkrn2LKz/X5Un89fCs0hQDyqsbwSIYCLJSdbcugg97cY4dr8mqELpC8rVwiClD36o+B9654Lf
 mYjQliROg55BayiQc+72x92Kb9TO+7adPB8lxn2y5l24S2psy2vH8vt99hObKjqOYoTxG/vSNFvOD
 drc0MA27cHEBMISavxmmklLPKlwURymy6olP2aLfzCLsGI3+Qemu5kpM/hntwIIQ5XaUu/oRGRS4c
 SwX2cvaPcqVcD65FrT3Z/SxcN6lXd1A8b+qGnqaNizUZly5dux012W7hoG9Z0cCqb/RBXS924jxZG
 0UlzGexw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laxdE-00FreX-1t
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 09:34:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619429655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pa6TNwz/rX6c3xahSoGl5EPCzLvvDWHlvRYJuMFMhaI=;
 b=twqnB8SkTcwcWyz8OZJJA8gs28s2XVemXN1zRGzyAOAcVeGITxAfxeMkjkquyjY3V2+MZY
 1sUAaM29NyU/Y32P7S2f6EPRbTEdjCotKmFUcMOLnHmPK8ijub6cIJUUMPiwfksQGcQjEn
 EyQpCEjfH5wGAueNpzw6UQ49djsTOfQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EFC5EAE03;
 Mon, 26 Apr 2021 09:34:14 +0000 (UTC)
Message-ID: <181b5a7c61e31abff2f4d0102281c0e0f96a7832.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Chao Leng
 <lengchao@huawei.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Date: Mon, 26 Apr 2021 11:34:14 +0200
In-Reply-To: <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
References: <20210423133835.25479-1-mwilck@suse.com>
 <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_023420_260914_DA60A30B 
X-CRM114-Status: GOOD (  21.68  )
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

On Sun, 2021-04-25 at 13:34 +0200, Hannes Reinecke wrote:
> On 4/23/21 3:38 PM, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > We have observed a few crashes run_timer_softirq(), where a broken
> > timer_list struct belonging to an anatt_timer was encountered. The
> > broken
> > structures look like this, and we see actually multiple ones attached
> > to
> > the same timer base:
> > =

> > crash> struct timer_list 0xffff92471bcfdc90
> > struct timer_list {
> > =A0=A0 entry =3D {
> > =A0=A0=A0=A0 next =3D 0xdead000000000122,=A0 // LIST_POISON2
> > =A0=A0=A0=A0 pprev =3D 0x0
> > =A0=A0 },
> > =A0=A0 expires =3D 4296022933,
> > =A0=A0 function =3D 0xffffffffc06de5e0 <nvme_anatt_timeout>,
> > =A0=A0 flags =3D 20
> > }
> > =

> > If such a timer is encountered in run_timer_softirq(), the kernel
> > crashes. The test scenario was an I/O load test with lots of NVMe
> > controllers, some of which were removed and re-added on the storage
> > side.
> > =

> ...
> =

> But isn't this the result of detach_timer()? IE this suspiciously looks
> like perfectly normal operation; is you look at expire_timers() we're
> first calling 'detach_timer()' before calling the timer function, ie =

> every crash in the timer function would have this signature.
> And, incidentally, so would any timer function which does not crash.
> =

> Sorry to kill your analysis ...

No problem, I realized this myself, and actually mentioned it in the
commit description. OTOH, this timer is only modified in very few
places, and all but nvme_mpath_init() use the proper APIs for modifying
or deleting timers, so the initialization of a (possibly still) running
timer is the only suspect, afaics.

My personal theory is that the corruption might happen in several
steps, the first step being timer_setup() mofiying fields of a pending
timer. But I couldn't figure it out completely, and found it too hand-
waving to mention in the commit description.

> This doesn't mean that the patch isn't valid (in the sense that it =

> resolve the issue), but we definitely will need to work on root cause
> analysis.

I'd be grateful for any help figuring out the missing bits.

Thanks,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
