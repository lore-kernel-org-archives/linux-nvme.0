Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FFC11F64
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 01:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8677961C6F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 01:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8677961C6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ewBN8fU89Y+dANK+ijSCdWOsZzHXzQf6OefyPxJlqY0=; b=sHotid1F1MpfLH
	V779zislTzsq9Ko9fWsFLUVsDhLWJn2+JJ86nunu3q/jMotRivf+IgeY+TobD5ZnBt8TDqAyiQ8dt
	chB0WCvqOsYAjZPtqgucLT0hI5NYGncWjvB3OzeXZQlxdI6uqUjVMM12/MFn7B0NTdLMWLX6Wt8TJ
	KHm9xkxvNuLnY+Dy47y2gzdoSKYYUT3AffZYfwxmx0ZjYC1iohwUfess8hQAKDCKBR9XfcEpe9Ob/
	RboPFYh9lBvLb2SWqUYoUR+/au5jw1yR54glITLJT3cXw4651QFryZIBT/lGJFPpJU5CciCLdmDFT
	4kexiUIMNgTK5KU36RPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly2b9-009V07-1I; Tue, 29 Jun 2021 01:31:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly2au-009Uza-63
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 01:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624930277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J83aztfmcvGFx3aprS25WPTJKUaIP1R/fWg4KY+Lskk=;
 b=e1c4O7CjTMFtMuiClO/JoXgXIpPuxZimLVJKYv4JwejD7zWerjYOUpbiGceNP/nz4gWtTF
 J1Sd3y2dmoO9Ra3s/vnJGvHQqlF2bbrRaz/lm+T9xy+GgR4p4/VPlIvYa27NKe5ACvaXhL
 tEQEk7LJDblmDSjkYq15wmVyg4gZQvY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-PK8qmiSqNYiC-_AK4T099A-1; Mon, 28 Jun 2021 21:31:15 -0400
X-MC-Unique: PK8qmiSqNYiC-_AK4T099A-1
Received: by mail-yb1-f200.google.com with SMTP id
 o12-20020a5b050c0000b02904f4a117bd74so18833399ybp.17
 for <linux-nvme@lists.infradead.org>; Mon, 28 Jun 2021 18:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J83aztfmcvGFx3aprS25WPTJKUaIP1R/fWg4KY+Lskk=;
 b=gfkK2VN8OKelPkCFavgxymD2kckJu9Aegm7LgjAaes4WmTBt2ZJe20qswICHWWbROi
 4icjitNtc+Itg7AGy0UVumUJRY3QBmyx5kG29IfGuoI5DEtZwkxHWgpcUkMufgStmTZe
 U9YWWDXBSx7JyN6JHniuBsjAa3upfUfGb2hSyy7uNlWeFceTfIaREIp6E5ZUPyqNPU4i
 nc642Yp+r0Xx+4b1faiCb7kv57zCqD0BoSyhxesZa++KdJYUHeAzQvF4ITsZKT8O/JEV
 pMCXRbsy8uzyM01wbYi19ZPFuLEp/GQcA1PXqj92SkxPTmhQs/zHLguKOnC15/XTKVuF
 BBNg==
X-Gm-Message-State: AOAM531o7S2oQ/JKU6dwFuMkaiulbhFQZ9faN3lGqIIaIggCj1CGk6xy
 dYI6sT+oxUbalAf7m7HA7y68zGGZ/oe+FK5FBmLCiGsP43EFpNLELB9ouoZ17VcGzRu4Jxkx8iH
 hk+oT+bYGZOYec5nUW7SDUYBOG8jx9ngJrNauIlVbUZ4=
X-Received: by 2002:a25:cccb:: with SMTP id
 l194mr33056356ybf.310.1624930275043; 
 Mon, 28 Jun 2021 18:31:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg64Am3hyT5XXI40O8sOGedigWbE1KiPXfj3EDTWrRopTpikakALD7ZrhDh6+GKLYo1bF4VY8akiYNCKLJh08=
X-Received: by 2002:a25:cccb:: with SMTP id
 l194mr33056341ybf.310.1624930274874; 
 Mon, 28 Jun 2021 18:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
 <YNXTaUMAFCA84jfZ@T590>
In-Reply-To: <YNXTaUMAFCA84jfZ@T590>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 29 Jun 2021 09:31:03 +0800
Message-ID: <CAFj5m9J9NL9qHjo1X9=PdE1-Nkgj2zV-ifdZ9aqqts2QNUpf8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Handle update hardware queues and queue freeze more
 carefully
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=minlei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210628_183120_342299_85B1DE1A 
X-CRM114-Status: GOOD (  25.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 25, 2021 at 9:00 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Jun 25, 2021 at 02:21:56PM +0200, Daniel Wagner wrote:
> > On Fri, Jun 25, 2021 at 12:16:47PM +0200, Daniel Wagner wrote:
> > > this is a followup on the crash I reported in
> > >
> > >   https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
> > >
> > > By moving the hardware check up the crash was gone. Unfortuntatly, I
> > > don't understand why this fixes the crash. The per-cpu access is
> > > crashing but I can't see why the blk_mq_update_nr_hw_queues() is
> > > fixing this problem.
> > >
> > > Even though I can't explain why it fixes it, I think it makes sense to
> > > update the hardware queue mapping bevore we recreate the IO
> > > queues. Thus I avoided in the commit message to say it fixes
> > > something.
> >
> > I just discussed this with Hannes and we figured out how the crash is
> > fixed by moving the blk_mq_update_nr_hw_queues() before the
> > nvme_fc_create_hw_io_queues()/nvme_fc_connect_io_queues().
> >
> > First of all, blk_mq_update_nr_hw_queues() operates on the normal
> > tag_set and not the admin_tag_set. That means when we move the
> > blk_mq_update_nr_hw_queues() before the nvme_fc_connect_io_queues(), we
> > update the mapping to only CPUs and hwctx which are available. When we
> > then do the connect call nvmf_connect_io_queue() we will only allocate
> > tags from queues which are not in the BLK_MQ_S_INACTIVE anymore. Hence
> > we skip the blk_mq_put_tag() call.
>
> Your patch just reduces the race window, what if all cpus in
> hctx->cpumask become offline when calling blk_mq_alloc_request_hctx()?

connect io queues after updating nr_hw_queues can cause correct hctx_idx
to be passed to blk_mq_alloc_request_hctx(), so this patch is good, so the patch
looks good.

Yeah, there is still other issue not covered during cpu hotplug, but
that is different
with this one.

Thanks,


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
