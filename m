Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05704C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:49:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0AE611BF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0AE611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MjaBkM6emqeCZcDZdF6pa0GJL0Xcb2ddBHe+87jldqg=; b=GV6igjOIpGUV6eIHwVoak7bsI
	9M4pgEuzaSwo5CPCV4YE3mlsiGMeRtkIDsBi8IHYY/wRlyqpu8PHS2Bv1wazRWZNAyK+imh3mhSW/
	+GYqKkq1ofTHE7oaK8NlwICr5KsnCizRcHbBezIXQ3oodVDswthzNInLfMoX3i2OYI9hPTxsC4ZXi
	UCZCBK+3Wfv/J0cTn8/TA00fMA25drvVpdWvvc0HOZweIKc+MPextf38NfB9S49oaxweZ8+KqYRjZ
	lNJM/btXQSp+sVRy6DGlbfEYc7X+CN6AUyIhwcUV8AeCFf9G4+5Me0hma0InVIfFq492n4VK+lFh/
	xtpCvfzgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ligQX-00FZDz-3K; Mon, 17 May 2021 16:49:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligQU-00FZDZ-8F
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 16:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=/0ewZPkfGYK3n/ezs5+hmPqNYrO1IrRzDwrPluHMyAk=; b=U96lZrk8JJRh/IL6MYHN0rwrHU
 BjkJ2h1ojno/+Fjy0MGK2DF6z4xEoo1fQJPp/+kfZSG4r1yF0NHRTmmU1BWy+7ApjZs/VFSMFAmFz
 CPPe0uOO5ZbR5zW7KJhhzMfdP3NKm03Ewbs9wzhBGgehmWjwY6F/lc1MzinPVKR6fRja0/26EhYpO
 feIm+hk7L+ctRfoDN6iOzdpGXCWUfyqeQCLjxgULOxka7eN3kz/xDLkLpwS3MkjI/GKQbadQ165OB
 l53gz52jY8eBO5aCl+YX40FbQ2bgZpud3JqHG46qp++dxdXwAjXyeKeD4I0Ay97jA4xaMMK4sc6Vq
 rOYhepHQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligQQ-00Dzfk-A3
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 16:49:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1621270141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0ewZPkfGYK3n/ezs5+hmPqNYrO1IrRzDwrPluHMyAk=;
 b=e6kzZ4iuCx8l42ICVEU9zL9MOccTVWzBxacsl9fg2Mb242pjtKt5tSEj/TOthKnt7qeeuY
 vYy6dy4KRLAAMV2AINezMrI5zI+K8C75TfnZ32pQJtQSK0Lsc9rc4nyzL3OVKEK0Eg291u
 Rp/phxbt2ZTk5ox7k7wVP5OH6S3sLiY=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0550FAD05;
 Mon, 17 May 2021 16:49:01 +0000 (UTC)
Message-ID: <8e1d9d30dfbfd9ec1694fe4c20c4347b86c393d1.camel@suse.com>
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.com>, 
 kbusch@kernel.org, sagi@grimberg.me
Date: Mon, 17 May 2021 18:49:00 +0200
In-Reply-To: <e44553cbf49bc12c006f3295b0258cac1755e042.camel@suse.com>
References: <20210506134823.2566853-1-hch@lst.de>
 <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
 <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
 <20210517124801.GA17259@lst.de>
 <e44553cbf49bc12c006f3295b0258cac1755e042.camel@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_094902_512500_DF49B547 
X-CRM114-Status: GOOD (  24.37  )
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

On Mon, 2021-05-17 at 18:47 +0200, Martin Wilck wrote:
> On Mon, 2021-05-17 at 14:48 +0200, Christoph Hellwig wrote:
> > On Fri, May 14, 2021 at 11:08:25PM +0200, Martin Wilck wrote:
> > > Hello Christoph,
> > > =

> > > On Wed, 2021-05-12 at 16:53 +0200, Martin Wilck wrote:
> > > > On Thu, 2021-05-06 at 15:48 +0200, Christoph Hellwig wrote:
> > > > > nvme_init_identify and thus nvme_mpath_init can be called
> > > > > multiple
> > > > > times and thus must not overwrite potentially initialized or
> > > > > in-use
> > > > > fields.=A0 Split out a helper for the basic initialization when
> > > > > the
> > > > > controller is initialized and make sure the init_identify
> > > > > path
> > > > > does
> > > > > not blindly change in-use data structures.
> > > > > =

> > > > > Fixes: 0d0b660f214d ("nvme: add ANA support")
> > > > > Reported-by: Martin Wilck <mwilck@suse.com>
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > =

> > > > Thank you. I'll prepare another test kernel for our partner.
> > > =

> > > Our partner reported a crash during NVMe controller
> > > initialization
> > > with
> > > the kernel I built with this patch applied. I'm still looking at
> > > the
> > > dump,=A0and it's not impossible that I made a mistake backporting
> > > your
> > > patch. But I thought I should inform you anyway.
> > =

> > It does look weird for sure.=A0 Did you backport
> > "nvmet: use new ana_log_size instead the old one" as well?=A0 If not
> > please
> > pick it up.
> =

> I missed that one indeed, and it's the culprit.

I wrote nonsense, sorry.=A0

Applying "nvmet: use new ana_log_size instead the old one" fixed the
issue for me.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
