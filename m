Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F4C43334
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q9W+AYQhTfDqw0DcmlGTy4nkEzBZg/fKCa6yQMLJFTI=; b=pXfxnXw7X6mrb3fulG6i4pSslJ
	ITE8Nle+7S9h16Qyp2+dn6zrdJXQR4XJPsirrn01Kk+NGjJnCwd4Ql1wY8A7fjA/cqcJj/A9cI+gA
	J2alCNp8ZojFOXjFja56NXG0qq7z75XojhsW7lyQdctLQbqenYLRrqnts6qoaGqJH+VSXQKVT6ehe
	Dlda2Ulh5UB2v52+iydh373sCnTGBigBb9zhu53P1ZgDPcQh6Ft+d4IfPDZ7nHXauHmPDVqzUfLE6
	BWY5Nrwm/l9378tADVti8bl7SVNb1nozVdRweZNNpheZG1V6/ptpdWx7RCRkDmtaIufiRZxWoeq9l
	VvOtRX5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9qLJ-004U0F-Vt; Fri, 08 Jul 2022 15:56:34 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9qLF-004TyG-Oi
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 15:56:31 +0000
Received: by mail-ed1-x52b.google.com with SMTP id fd6so27368328edb.5
        for <linux-nvme@lists.infradead.org>; Fri, 08 Jul 2022 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9W+AYQhTfDqw0DcmlGTy4nkEzBZg/fKCa6yQMLJFTI=;
        b=kdB3pSMaJi7UAN6aiUyuaT1fqFegsQzC4WgAiLyygNW5CBcMKmBIP69/pGweP4kpjg
         t4FvW1fi+WMJg/o+lRdYoMlfF82+vwR3Cem5XXQ5C+1S2OjPRR640/R+6jjfULQgP4Hj
         rZxrNV0GBpYNph1WDGgQ+oU77YCA4qLwMbQlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9W+AYQhTfDqw0DcmlGTy4nkEzBZg/fKCa6yQMLJFTI=;
        b=Bn4KBztmb+OvTeUeAlE6976T6R2qOLwnQ8nRGopmaGGCW/3duXUZZvLyUNMo3iqVbr
         WLXeVFSPsKjRLTLG3fot0vXMYmQngQp/qmrWL9zMsDhluQMW3hUgyHbs1gDdh/EhMqyJ
         LHHZiD1XIoQI/uqAPyISHcUVrrknxtJaS1QjHQLd2bqrEoYDDHnKv5OS5HQ9HJ2/sXAJ
         ntJSP3vq7jQhEee7nMDKKVRpUhvhhvCTPXz2WFR9CQjRj4Jg/WYgTJS79kB/+RpgOwb/
         HMqh1sTKY9ZymwH4U6fE3Qv0kmaB6bhd4KLVdAKjpEz7C8yvqiPeuI4GtO4LaN/5Fc2C
         CQOA==
X-Gm-Message-State: AJIora+Xx/XSeyp3nYOL4D77PTJD2qq4eZts8xpvW91xcFqPvq6gzSNY
	/q6VwRkjnPuawSb4ueyKoV2EJvYDfTPEhD04eHsK0NeU6vmMuWFU
X-Google-Smtp-Source: AGRyM1tXAbdZYwV0gKiMZ58lkxkxUzt3KcB8fQVviNtUX2hvVfGkUoccVE79VE04qe/Tolt/Ih5VTHCC2VdXVsCyVCM=
X-Received: by 2002:a05:6402:34ce:b0:43a:a4bb:27a6 with SMTP id
 w14-20020a05640234ce00b0043aa4bb27a6mr5715980edc.158.1657295787092; Fri, 08
 Jul 2022 08:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me>
 <20220707211245.3989107-1-csander@purestorage.com> <20220708050038.GA15655@lst.de>
In-Reply-To: <20220708050038.GA15655@lst.de>
From: Caleb Sander <csander@purestorage.com>
Date: Fri, 8 Jul 2022 08:56:16 -0700
Message-ID: <CADUfDZp-oRUYoXxMwtA5qYux2-AKuimXk-hHWMwwv5tD1ZDUXg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: use in-capsule data for I/O connect
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_085629_903718_0F16BD96 
X-CRM114-Status: GOOD (  16.98  )
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

> While I'm fine with this change, can you please state here why this
> is important?  Is there a use case where it really matters?  A controller
> that is unhappy if this doesn't happen?

It's just an optimization. Without this change, we send the connect command
capsule and data in separate PDUs (CapsuleCmd and H2CData), and must wait for
the controller to respond with an R2T PDU before sending the H2CData.
With the change, we send a single CapsuleCmd PDU that includes the data.
This reduces the number of bytes (and likely packets) sent across the network,
and simplifies the send state machine handling in the driver.

Using in-capsule data does not "really matter" for admin commands either,
but we appear to have decided that the optimization is worth it.
So I am just suggesting we extend the logic to the I/O connect command.


On Thu, Jul 7, 2022 at 10:00 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 07, 2022 at 03:12:45PM -0600, Caleb Sander wrote:
> > >From the NVMe/TCP spec:
> > > The maximum amount of in-capsule data for Fabrics and Admin Commands
> > > is 8,192 bytes ... NVMe/TCP controllers must support in-capsule data
> > > for Fabrics and Admin Command Capsules
> >
> > Currently, command data is only sent in-capsule on the admin queue
> > or I/O queues that indicate support for it.
> > Send fabrics command data in-capsule for I/O queues too to avoid
> > needing a separate H2CData PDU for the connect command.
>
> While I'm fine with this change, can you please state here why this
> is important?  Is there a use case where it really matters?  A controller
> that is unhappy if this doesn't happen?

