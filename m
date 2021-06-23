Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AECAC4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 18:58:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BB3611C1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 18:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BB3611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yxHPOdmHnGLMvnWjWSSVrS26jVK881TIf2S0+MjIPxk=; b=tFopEVBYlwjL5+
	nGPHIbmlkUuYzGLVMm2cyItMmnPAUnh7m9tCL4N13fNYqFhBLeWTcCzoWy+zp4gA0bNbeXZd0v7t9
	OMdamANiwP+ziVqcz0Cr1gA88asC7R4art2oVY+GyQrAFajfipnt31OAZ98GP/ajm5n3cEfoC35TM
	PUcSCPK7UHXIaspAgKZEwwvnntLwFhNcCCZh6M3J/9gbeoHODAu1wYmdcLWyHBirhi849FzBPuWzM
	qS5Y/p5mCmWxZmVYcEeutZGH+vD7fpvxmDoUlXDvG2hvGJzE/2xU9z91gxv8fPb6mIcuNEIyBEvh3
	5TT2owJI5NKg9iKSTPNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw85J-00BjR0-EY; Wed, 23 Jun 2021 18:58:49 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw85D-00BjPy-L9
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 18:58:48 +0000
Received: by mail-ed1-x530.google.com with SMTP id h2so4944315edt.3
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aVSgeDzA7TCC6oouErSACADUJuY4cjc3vAh9yJ+kD80=;
 b=ZPGIeroUPvm36CZfIKAt2NyN91O3hx3QZh785QojV2B4yd6pnQd74aRPq/hsjIENOO
 obzst6lC6QI1jifhlPKeTGXiuymY+eVSifHsEkLIsuTw2LdGltIDWSdmy21umFDJsVic
 CADxu+QOk4wMSanDLEUc+TpiqPlkNBwkkMjuTVWlf+oaEd7pmn3hUEKs2pH4Hatar4rV
 EzMdzbwIOvfacqW6aKiMkCQvgJBGXWG6CVU45ug94gDxw8Q/XPcsgvUmVNfT3xTaQ6nf
 ziFzpRBRzmaH9KpMVBW5krw9tCebuf+QNCcg+Wx244XS2tmSkbzPiP4SLwejVMvN2+IO
 mY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aVSgeDzA7TCC6oouErSACADUJuY4cjc3vAh9yJ+kD80=;
 b=JYLqo72Uje8lZ1+xn9ZpcoxWfVPwGeVaL+2qG0LLOjWyPS0k0Y6r82ZupUOQjgtqH7
 ItkMo2MlPTSby1MNjLl0KudORlpQd6IEW2XMYLCGervXbe0mIdS6bxsJ0XhKaOYGQ51C
 rA9Y+TzYkXvifln6rRy6H4mgIErbds2D+LTR8gDMVXc6isJ2KNMr266vvu6BetspQQhd
 MbqI43jGCZyanMGJvvl8WvjgJxYkbKpZlCBN0nOSJLRr8V++k1/hDe9OoAnWDTWD1es6
 SHqh2/YLsw3mejJge54DAh5g8HZhndvQ17a6ww6i7V9bUiPVE9s3/YcBCCh48uaa1+gF
 vrgw==
X-Gm-Message-State: AOAM530pPllV26TFeCrEqR6X+jfAwEH+LC+xCj14mqX8cvXmLCBlKnC9
 Jlu92mlO+cBx9Z3YQTAuCNeu8j8zGyuax588a3k=
X-Google-Smtp-Source: ABdhPJwe8EHYWW1jYXkYDYUZeW0trYoloOVl/qmRBFYISpk0dh4/+aKUaLtPVNSnoKZ/bSwnlyRrME5Fnz6c7Ojre9I=
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr1679415edu.362.1624474722195; 
 Wed, 23 Jun 2021 11:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210621051046.28783-1-smalin@marvell.com>
 <20210621051046.28783-4-smalin@marvell.com>
 <20210621064956.GA6019@lst.de>
In-Reply-To: <20210621064956.GA6019@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 23 Jun 2021 21:58:30 +0300
Message-ID: <CAKKgK4y4m-SrV-C0pu_ro4XqR=h1s=XYh9AgLQRTGxHJPb_U3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] nvme-fabrics: Expose nvmf_check_required_opts()
 globally
To: Christoph Hellwig <hch@lst.de>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, kbusch@kernel.org,
 davem@davemloft.net, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, pkushwaha@marvell.com, prabhakar.pkin@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_115843_735574_D9F1F2A6 
X-CRM114-Status: GOOD (  15.01  )
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

On Mon, 21 Jun 2021 at 09:49, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 21, 2021 at 08:10:41AM +0300, Shai Malin wrote:
> > From: Prabhakar Kushwaha <pkushwaha@marvell.com>
> >
> > nvmf_check_required_opts() is used to check if user provided opts has
> > the required_opts or not. if not, it will log which options are not
> > provided.
> >
> > It can be leveraged by nvme-tcp-offload to check if provided opts are
> > supported by this specific vendor driver or not.
>
> WTF is a "vendor" driver?  Vendors are not really a concept we use anywhere
> in Linux.

We were trying to refer to the "offload device driver" as "vendor driver".
Will be fixed in v3.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
