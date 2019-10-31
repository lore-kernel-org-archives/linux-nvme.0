Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABECA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DFE2087E
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LOWD1Wur";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd7hRbEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DFE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mc+Gt7xBEJI1Gw8pnx/73PyAF6QPyZLMZ+JS1USoAc8=; b=LOWD1Wuriewdgh
	69b0k7kn0Hil6En7Lwe8s4TNxDLNzgxSm1SsXm9e9bTT6V4X1Mq/YYmDQ05bly5JcibHF0043yNPg
	9Og+dFQ+FPbw1TnKxQ2BDcRbUS3RMa0BBPJXKW8lZCJOb5cf0llevqx7NPIiddh18uFY4wlQ88i4v
	Xr/fD64yB0TaZ8W/7zCQuRuIq04Tzzb0oFcVmOOKdtnrfUbv0XlwPvG4c8sJUND4vpsPYj4mA1O+5
	nGLHjI1eI9f1S1dlM7qIAt0loCrlT740yAPRBb/o1LwlUcyUrFi+iIcdZtFkrPrRntTz0HRQ0hYe6
	d7K7gWUTDUMYlRyiATJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQAyz-0006JK-P1; Thu, 31 Oct 2019 13:59:25 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQAyw-0006Hy-S5
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 13:59:24 +0000
Received: by mail-yw1-xc43.google.com with SMTP id z144so525053ywd.1
 for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2019 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6lc72BgRwD53g5GkhGUqFFG2nhb0dXxx1JADtBs5rJw=;
 b=nd7hRbEAfWE8bai204exlUd4eQxE+PqtFpB4gNcChz18ASnUWtYBaJ7hq9VvRDL2Mt
 9J1qcpniYjzrbZZF76uQKP4yZ7l0m26a3Oi696396zqnYybZSMV4jbZWNYIc0TuOavVG
 coo19mZKcAn8G4QoLCo9pNivxwz3JdkdMXDLrDWI2KB4khoTwd0/B3TWA9ttzwc3vuUz
 JIejUDdHxuSCBhI7MZG2MFRCFX+OMIsoY7gepXTB/RhrmJeo31B4ELQ07NhPc5XmGo5E
 KW0So4p5uEzR946cLNcCBFQ2cLahz4wu4ihWFl7cq2CRQgiVgVSLPZcrcgjxBK/HL0QQ
 fJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6lc72BgRwD53g5GkhGUqFFG2nhb0dXxx1JADtBs5rJw=;
 b=K9Z9uMbmVXQEmTUcMLvUBkO8xzNMzJwwU+BOrisIyoZpvxqfTTd+jtin/tIn0niij1
 pHRPnvHV9cFTdbuZLwKYVqs9Fqs4at9uzSFllv3MZQeOwZubg0hK2VdKfTt90+2A3ip1
 lxy9NXhaG+2dil1TZxdb8qPsX7kMQ8EMIzkX887obZXJvKr6jHQVVjQL49UsfN8y1WyB
 WaRjqZ5Cnh9APLw1//Veqw6RL0M1hplR6vJKhyPArrYpE/FglKytJvLjYFx6zKzaQCoV
 Yn5vItQoJnIjfl67u66qnqon7VpCAjDh38fu4eN4mHirqz+9qO18mvW11By+8fu1gHQa
 Gcgg==
X-Gm-Message-State: APjAAAUvbQ9Qa09XNugoEJVGZ7S6qz9P5JlXH92rrf/mu54WVRyNywBa
 liO4jKPhfs51oTsP3WaDTOUysg0LPnc1wAsFV8A=
X-Google-Smtp-Source: APXvYqxnJjDho9Fs/2WI2ekNVqdpR61OXuGHmahrpf/DG4rRrgDRSb2F2w/896cjP6fYX7HUL+77E3xhip/EDSGoPcQ=
X-Received: by 2002:a81:61c3:: with SMTP id v186mr4332558ywb.151.1572530361617; 
 Thu, 31 Oct 2019 06:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com>
 <20191031133921.GA4763@lst.de>
In-Reply-To: <20191031133921.GA4763@lst.de>
From: Charles Machalow <csm10495@gmail.com>
Date: Thu, 31 Oct 2019 06:59:10 -0700
Message-ID: <CANSCoS-RzcutTWHN1t1iyW3GjqNcY5xFUZtJhAThDp5SPPrDAA@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_065922_931815_62EE622A 
X-CRM114-Status: GOOD (  13.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 marta.rybczynska@kalray.eu, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 31, 2019, 6:39 AM Christoph Hellwig <hch@lst.de> wrote

> All that casting is a pretty bad idea.  please just add an explicit
> reserved field before the result, and check that it always is zero
> in the ioctl handler.

Not quite sure what you mean by check for zero in the ioctl handler. I
like the idea of being able to use the same struct for either the
original or 64 ioctls from userspace. I don't believe adding the
explicit rsvd field allows that

- Charlie Scott Machalow

On Thu, Oct 31, 2019 at 6:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Oct 30, 2019 at 10:03:38PM -0700, Charles Machalow wrote:
> > Changing nvme_passthru_cmd64's result field to be backwards compatible
> > with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
> > field. With this change the first 32 bits of result in either case
> > point to CQE DW0. This allows userspace tools to use the new structure
> > when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.
>
> All that casting is a pretty bad idea.  please just add an explicit
> reserved field before the result, and check that it always is zero
> in the ioctl handler.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
