Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4FCC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 12:52:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E069761166
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 12:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069761166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CyVTTF7+zP1m1Vztr6N2hyd0N3PAWNun77IYr/RwNwA=; b=qDzLkcG9DlrLzDOKIPBmbLNuk
	GnVmi5Gi2UF5xcfut7ZM/rWf+lXZZnHLV7d17CzWNpqeGMC3eRexadaLL8eFNJORt4NTALDhulhCS
	vLc50RGfVvygAeUANJppXM3OPI/kEXRl9+xZk+oJ4RkP7C+i++9OJBzrRpuRsVc3q1N2/YTkQksil
	jyh2s48zyDjnxJeKymVHp4xyQvHEu2oDJSnAPDU3/PARg77uM2Gk/A7RSJ9h4XadHgb8nUPWM6QDI
	dQw7x2JHhfqVGUGHHlrCripTN6xNtmYopKSASj9RqLvSqv0C23G3m4oYgEd8/FbzB6KZr4ojYgUl3
	bYeR/jLGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1licjQ-00Eyc6-QE; Mon, 17 May 2021 12:52:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1licfH-00EyLM-Fx
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 12:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=MjdMp47WSDPK0/KMZo/AhMCEj1Bt2rJUjgVzBC9ybKc=; b=AYHioOa1fxLPaLwPp7SfjXyUNJ
 yFbEZy1pFRkMxBnyatOiE35iK3L4hLRFuIXjTc3gMVWCzFdc/uM/rYH6JvLTEobE1kFYkoRlwEA0N
 gXn3wnkKDnyM9yJ3Ejh3uCvRKGenNv96nZAcgJtyTEEnYtyOBD4dRUd6Vq81QyNrEFYviNKgSGc+e
 PPfDF00KNBr9IbU1/ZfSXkdRKROxNSbgwpj/Cd7fLPb12BPRJPyTT1xSMHfWWoJwXzNAiEtbuLOjd
 rKcrsAyoLKJxcRLxxGzIBySROksT9PY0T8jdUZ9TN2jsBq79iOqZhZjDA5vpezvuVm5GwXsk63vCU
 9P9qYwMA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1licfE-00Dlsc-T7
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 12:48:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2950167373; Mon, 17 May 2021 14:48:02 +0200 (CEST)
Date: Mon, 17 May 2021 14:48:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.com>, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
Message-ID: <20210517124801.GA17259@lst.de>
References: <20210506134823.2566853-1-hch@lst.de>
 <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
 <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_054805_115403_F722A648 
X-CRM114-Status: GOOD (  21.47  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 14, 2021 at 11:08:25PM +0200, Martin Wilck wrote:
> Hello Christoph,
> =

> On Wed, 2021-05-12 at 16:53 +0200, Martin Wilck wrote:
> > On Thu, 2021-05-06 at 15:48 +0200, Christoph Hellwig wrote:
> > > nvme_init_identify and thus nvme_mpath_init can be called multiple
> > > times and thus must not overwrite potentially initialized or in-use
> > > fields.=A0 Split out a helper for the basic initialization when the
> > > controller is initialized and make sure the init_identify path does
> > > not blindly change in-use data structures.
> > > =

> > > Fixes: 0d0b660f214d ("nvme: add ANA support")
> > > Reported-by: Martin Wilck <mwilck@suse.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > =

> > Thank you. I'll prepare another test kernel for our partner.
> =

> Our partner reported a crash during NVMe controller initialization with
> the kernel I built with this patch applied. I'm still looking at the
> dump,=A0and it's not impossible that I made a mistake backporting your
> patch. But I thought I should inform you anyway.

It does look weird for sure.  Did you backport
"nvmet: use new ana_log_size instead the old one" as well?  If not please
pick it up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
