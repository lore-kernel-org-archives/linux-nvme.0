Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43849E82CA1
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESQ9N6goUNwmGmnpRv8WDFurZSvzm+kjlBNSu8wYRfg=; b=HQgo1TFxml+Mb8Y2kx2lK5KfvH
	qbtGWjzD+88Dsev5E8lVhxm8EBPJqXZKZmXOe+iKPtCu4/U6IL7aMLeyy17A0cGY72/o0/idx79xS
	0vtB7IPN6RI2uUaofvOcixIeckBOhpD6W4pU0Du6XyKbctRQuU99uLSzNXXSA+ce8rRfuT1/bdunl
	11z84C3uCEyCnX1tRAyT18pl/s++Eif2/J3dEsUfERfYMUOtmSAO7vtifuBIXi5EOZ7B3Wlvmg7Nv
	DFZJ03HYVKVJkuBI4aTmFkbp0Ag4CzPvlJG/Iv8nxBhwu+osSJFD5a8ihsxUGDp1E/4rXA5vMUPSe
	bjCq9ETg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlVrV-001ASv-24;
	Wed, 27 Sep 2023 14:50:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlVrT-001ARp-0J
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 14:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695826194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESQ9N6goUNwmGmnpRv8WDFurZSvzm+kjlBNSu8wYRfg=;
	b=R8kf8wb7HHcv/BhciAKr5ouxvTExWVGcQI4dqIkYcnDT3Z9FIjoBecAIDFrvKdcMGftdDD
	7tsaCK9qOaNA8mwvHHkdasswTOSmwBf40mmoeimaM6gHairq+jSAdOGBhgWU9RbRCRVTFj
	gWNw8xuodg8nmQSj7eMu8j9uPAWVXrg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-w9mtkBABN8-1owcHKRuCtg-1; Wed, 27 Sep 2023 10:49:53 -0400
X-MC-Unique: w9mtkBABN8-1owcHKRuCtg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3232c3df248so5101503f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 07:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826192; x=1696430992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESQ9N6goUNwmGmnpRv8WDFurZSvzm+kjlBNSu8wYRfg=;
        b=lToE98c0fzfZFMxNsvwITyyombbMFQnuMSlbby+71P7W6D6Q9jUWn4uNURzEFiqyIL
         PcId3yBr6dgXuBszGF2OPwID8ITF44DX4JDVU9pQc0xRDqqD44mjT/CQfVoA+KvXb2hn
         zNjY3NLxJsBQak982c6tHpqbsOBVhScMPExJSvCXdhxUQn/akUBm7XNIKBcV/D3wQhKT
         /cRDUo9k1M9rRydRsz5a9U0cq0dkI7K3/RR5fHEGazZJMJ+sLDF9y3Zou9CWMp7Mbfpa
         RKRp/5iC94jyVVvG6TPCcdkgHWT8nb3Dgo9qfbHYxeWUDCfD4nioVqMRx2gM00i9eWJv
         M4RQ==
X-Gm-Message-State: AOJu0Ywl0KeaJdN9lkedw9DJ57b4SFz9c+Vtf2zziITNDOT6f68jFntc
	Vr3N1c/ahzWTx36fZFocbh00saegUGqCT8Qb3ron4zNlzSQFuTVqY3MMNQm94KW5hKsEVmaQPbt
	zK70E/cGZ4eTEqUBnZCAU5qzrCYM/AxnG9mO+wyi7gzM=
X-Received: by 2002:adf:f7cf:0:b0:313:eb09:c029 with SMTP id a15-20020adff7cf000000b00313eb09c029mr1637699wrq.43.1695826192244;
        Wed, 27 Sep 2023 07:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSCi4hwwHHjMFLfuu0wua05club8i5r1hKZCgtrxnNIOfxttKazGIKEdsMjZnD1YTpjGZfecOw3ec4DEF4k8o=
X-Received: by 2002:adf:f7cf:0:b0:313:eb09:c029 with SMTP id
 a15-20020adff7cf000000b00313eb09c029mr1637685wrq.43.1695826191971; Wed, 27
 Sep 2023 07:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230925163123.16042-1-emilne@redhat.com> <20230925163123.16042-2-emilne@redhat.com>
 <e0bdbbf8-83a6-4ce8-b313-80eab6809b34@acm.org>
In-Reply-To: <e0bdbbf8-83a6-4ce8-b313-80eab6809b34@acm.org>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 27 Sep 2023 10:49:40 -0400
Message-ID: <CAGtn9r=5DsnsEBUpHxCXwE=r5LR_H5jE+w3yDzUYhYhDp_+_jg@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com, jmeneghi@redhat.com, 
	mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_074959_206111_0F112B00 
X-CRM114-Status: GOOD (  15.99  )
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

The function is only called in one place by the queue-depth nvme path
selector in a
later patch in the series, so it is called in the submission path,
which is why I made it inline.

Or did you mean that the function is too expensive?  See other discussions.

-Ewan

On Mon, Sep 25, 2023 at 4:56=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 9/25/23 09:31, Ewan D. Milne wrote:
> > +static inline unsigned int blk_mq_queue_nr_active(struct request_queue=
 *q)
> > +{
> > +     unsigned int nr_active =3D 0;
> > +     struct blk_mq_hw_ctx *hctx;
> > +     unsigned long i;
> > +
> > +     queue_for_each_hw_ctx(q, hctx, i) {
> > +             if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
> > +                     return atomic_read(&q->nr_active_requests_shared_=
tags);
> > +             nr_active +=3D atomic_read(&hctx->nr_active);
> > +     }
> > +     return nr_active;
> > +}
>
> The above function should never be called from any command submission
> code path. Hence, I think it should be added in a .c file instead of
> include/linux/blk-mq.h.
>
> Thanks,
>
> Bart.
>


