Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2DFC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ktL0fHVgtHQfVJIUoe5UJ4wbLjpqJQnzZzGtCL/23+A=; b=PCNw3Z6q5AnjAkLImoVqKGHstt
	GKVagDMNkcq7gjla5YNBva0XMnrvPJvSegbnKP2cODF/JtJdll2ACu4qWC2IQtyFUR3iiugJjQTga
	TQvZqh2n1pJEywKEMfDWHUz9Gr1cPk9flrmt2YSlLBj8kC/yeTRASIv4YKaJhNXkm8pvVa2GJ/edg
	3w1TGqlw4A8SFclNNc9kyRRQEeUbQXZHrs0BUA8rMIDBgfcAKxiWiM2hLTUyyanHLEVZ1fJbAhXOo
	4y6iSWBq6GdwCQPHWosiGH/FIkvubqu2KUcWG86Jj9C6D39BGe3y4PjFZIZKeHvMngn6IMvGIzt9J
	gKkOeXuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pfH-005IDY-0N;
	Wed, 07 Jun 2023 09:41:15 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pfE-005ICp-10
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 09:41:13 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2566ed9328eso6062361a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jun 2023 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686130871; x=1688722871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ktL0fHVgtHQfVJIUoe5UJ4wbLjpqJQnzZzGtCL/23+A=;
        b=c8fWlbRUznj4WvGpAeXxqAvtx7Sthie542VYqgKvyVTRetNKGgnLrEUo2KQOG/oB54
         XAcGO3qB8LmlO70ROFmz9XdgXcRCu+gyOSAebRKs7tbIeP2T7W5FR1riBTasy0FLrj+n
         FOKiQspyLQDj48vUNEJg1TQynRqIJPU9nRXuKplOGL9KWEe6U0gX9RghNZHFSY0Px4m0
         f6M48XM1Yf/bIao7lbt3wGUOk3cBOC6FXwcjPau9WjSy5g3WfAdLXk2U+7J40vQbjsbv
         n0RDjW9pbMUpDLBrPM6gQffIHTA7Vua085oT0YEfwGBtOS/gz39AmEFV2kNjGL7L8sQd
         5B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130871; x=1688722871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktL0fHVgtHQfVJIUoe5UJ4wbLjpqJQnzZzGtCL/23+A=;
        b=fbYNheAagGBAn1VKSDO+VfKUjxKyVUdVAfrZqWB8jyJwG+vhzAbqJBpkq2kE8bWFpw
         0/I4ttSXKkHs9C0wgmfbU8CH+1djtcfQW/eugbQf5WwpRjL3nkXVmomk2xIxJMEza8uO
         M27UgZfAhoUsJ1cYn4+A6YAlf7VHtswghXNeVYf4K+o+pxUULSVWYWgZhjFmtsjzGl6a
         SeJQ9+OZcUtMBidM+5bxRyEvtibxiB2ROxIgd/TPp8eg36sdAHuS5kSYCkcR6EVeybtP
         YT1Wg7Es4DCNFZfHrfZ1YnIFsPOkKuzSs4C/KpR5AYPSz67RQeFGraN2pbmeDam3hew4
         /A9A==
X-Gm-Message-State: AC+VfDxHCn2kc6CPP+gGbKyAK1a4/mHs04yGXWjbcN1u9ZbBU2r/oqSh
	4k2KfFix5glYxGNdwIkvAAUfmEKIYfSL19sxFEiX52jrkk0=
X-Google-Smtp-Source: ACHHUZ4OAb7TByt978EyX6/GW401cCu8C+o9TATmZtCKVBdW+HcdCL321tNTfKOwq1eAEDcM9dvfAFDQXLRVCT38NPE=
X-Received: by 2002:a17:90a:4585:b0:256:4d27:a300 with SMTP id
 v5-20020a17090a458500b002564d27a300mr3875014pjg.35.1686130870972; Wed, 07 Jun
 2023 02:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230606082134.20623-1-irvincoteg@gmail.com> <ZH9y9j2KBHRW+Olj@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZH9y9j2KBHRW+Olj@kbusch-mbp.dhcp.thefacebook.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Wed, 7 Jun 2023 11:40:59 +0200
Message-ID: <CALL+9eipeO-pt1pyHpEq30R+2gq4YrKAUy=XsFCZZzJsK318bA@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: warn and abort if shared ns with empty list
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_024112_350343_73DE2C04 
X-CRM114-Status: GOOD (  26.56  )
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

But in the case you are describing, wouldn't it fail at
nvme_subsys_check_duplicate_ids?

On Tue, 6 Jun 2023 at 19:55, Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Jun 06, 2023 at 10:21:34AM +0200, Irvin Cote wrote:
> > In nvme_find_ns_head if we find a shared ns but it has an empty
> > list or its refcount is 0 we gloss over it and go to the next.
> > Ignoring when such a case happens means that when nvme_find_ns_head
> > returns NULL, we could create a new nshead with the same nsid. Hence
> > we could find ourselves with two shared nsheads having the same nsid.
> > Instead warn the user through dev_err and exit.
>
> Let's say you're holding a reference on the old "head" and then hot
> remove the drive. The kernel will tear down the device and its
> namespace, but the subsystem and empty head will remain due to that
> held reference.
>
> Now plug the drive back in. Today, the controller will attach to the
> previous subsystem, and make a new "head" for its namespace (because the
> old one is empty), and you can continue from there, though the new
> handle names may look a bit odd.
>
> This change won't make the re-added namespace visible to the user, which
> doesn't sound right.
>
> > Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> > ---
> >  drivers/nvme/host/core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index c8a471482421..175f1516083f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3341,6 +3341,11 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
> >                       continue;
> >               if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
> >                       return h;
> > +             else {
> > +                     dev_err(ctrl->device,
> > +                             "Found shared namespace with empty list or 0 refcount\n");
>
> I don't think we're guaranteed this path is using a "shared" namespace.
>
> > +                     return ERR_PTR(-ENOENT);
> > +             }
> >       }
> >
> >       return NULL;

