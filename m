Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD60AC5518B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQJMhA+yBs1z9FnC74N3PQSu8ZVw3Tei/QGCRoCC5t0=; b=CYkctbs1r2ARy/Oo8/0yuLlfb+
	xUw7GQyXYCq4oJ2vrC1HQcrTWjLqKsLlGBEuiwGR2OD+Wq5VnF5jeBqsqAPN+IWXR3BJRseeqdQ6J
	GcNZdavtIRSXNh+yRTThl0293Ajk0SG1fnFMzE4cOW05HTBt5gH9YbgTcmezAUciB0zMp7BC59Bue
	fVPtWUCi9wgyTHBOOmT6IGICMvXM34EwDHjiVGYUrrePpIaW/b8V1FLZEe/bdsSspkzEKenHxpd9L
	WJBcw9vMRG7Gm6tFHkDQzSi4Mq8TQ/D+y65aYmKLbC3JIpELGr74Lyqx+hZVglpe5stPGLakZqbsn
	vl0XHFdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTCL-0000000FEQc-27lS;
	Fri, 20 Feb 2026 16:17:45 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTCI-0000000FEOu-3qpO
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:17:44 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-65a39ac036cso284518a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 08:17:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771604261; cv=none;
        d=google.com; s=arc-20240605;
        b=FBRWyxRFXATMywJ1TxIT6payYDoK6EInmSwyjXbs9jnXnw2Is7Ek7YJYjXHmWLUHzV
         oAn+wEvimk/DemVhVvCt7hxJ8qdr9EML2lxL0CqTPrz5g8QerNL0iOHiy/MmPcdkdbxi
         OcVRsRk91MW96x9O/4uFzPizDypKGIyBTVz1P4whSZbh2dG95oESDm0pOlfGMS6HxVyS
         btsTzwOxwbapZjVPBpJlYd/dRqG8ZzRMM1xyZIdJ92I/V4fR1B3HdGy+JzSpnKenuYMO
         6PbABYpaVYTxvcJ56wiKyJiCOU05CXhOgPXrJNtrCDqbuiwwUu/P+rcSCHyoJdDEfzHS
         0XTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lQJMhA+yBs1z9FnC74N3PQSu8ZVw3Tei/QGCRoCC5t0=;
        fh=cNpn0neM8Wgeg5cmWPkNsrR8WwCaEhwDEYDpolQQJlw=;
        b=fIJ1K/CQpxadwDM41rI9MdYkg5XE7/KwHLaFl9C9EXf0uhjniqTlsDu2I+uwXCZFKn
         aNAKUtcPw0mPcxkagi2hNwZf/TnAEc8g538IcTypY7VyfKlBVz+MhtZrgBOu74fMSDml
         H1jSsBLRlHegSgAhjEK52AtzV39zmp8tf/731qC9l/wc6HEa3uLIjrPCMp7n7xE7bfbN
         Qr0/TW8dr5/MCCy71tYgERsbmrxmS2NKU86H9IfZQHbvYXgm1m2mXmFLxrPLAeJswHIy
         ttaJwTVtAbbjpHG2G5/GUckXL5kqTpHYXd2BJw2AQ06A9qvZi3pjoUOq7+NPvgy6Er4Z
         6+Jg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771604261; x=1772209061; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQJMhA+yBs1z9FnC74N3PQSu8ZVw3Tei/QGCRoCC5t0=;
        b=DQyXSmWPMmbJq2TGjVt1gibTr0JsNLi3L2UzWiAeW1SrjT3HllirZPAm0FL5vR9Y1M
         7AJNYUWsW3k11/vrNPo8h+67JNjFGJ10cConYxQ0yutbIzwT/ygmPzvhS+AhWusSHTPq
         q0yWP4UuvmRKKZKuxbE4JuxF5diYyAbEr3ip3hGEei/upEz20s1gJ5CgASCN61/mp6Pa
         eRWgdksQfDjWYHtAcGtRWtILdqQEMtp8HLLTDkdknPQj9H89JEJ21OlqWSx12TA+GETc
         7ZMH/4m5LQ786d8IjcRL7ZKxLnfKoV0WM4HVRYOJbVtgbEzKtOKOSuLqmbMvF7Jt8oMa
         aCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771604261; x=1772209061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQJMhA+yBs1z9FnC74N3PQSu8ZVw3Tei/QGCRoCC5t0=;
        b=GQs7hcE0Fx897KyXb8u2yIFLQyS2r07IWV/80WYFkBIXnm4c+2heLsn/wPtUZ9KLQo
         KgwcVkW4ql2X1Gbo+5TDOGBoWn27ZU2I6ljhRKDTc9nRpNilyRGLJ1xOFtY0Q0WcKmBG
         U7/qJuaW4zMa15Xv8bNKEBMte2S5aWPJNcsuAoH8Q7CIELUr1GhRsCCYKcWxoM+aYJqc
         c0t1f2q7I7sAmLUVFDZ/wfV5HXgskejjkwGLHH0EEF3p95yLEYcrVomxTM2Msa8QwlwP
         X6DsvXktsYdeHAsVlU2rKp3+a9HB/C5LnceveOGgHeCW0ksALUu1Mq6ZX+zCcjBehnel
         Vlhw==
X-Forwarded-Encrypted: i=1; AJvYcCV9gO8xFlYBaWHxJ33yrX6FkLppB2XIfbVOWPFEe0RQEBLMFFu5nxngIKi0f7pqLxlCUUx9sGW+gHxq@lists.infradead.org
X-Gm-Message-State: AOJu0Yzsm5yu6KfKVKUWePsP4o8eVd91o04V+DHkmJVRg9xo8psHAbfM
	SFZ8US060oeKrestmqFt2orOUpD+dU6xqHXG9FtLcQ/jXPp9QxaEmw9Z+PYqM3DfbaEBCdsdNLW
	Ft+0ldwYb0WyECD7sjQ81Ua9MtbG/tq8kNkcoedRgwg==
X-Gm-Gg: AZuq6aKiobnc2D1gqhRUty6M5fxW40N5cEm5mJ1O+tbhb/LG+Knrtxeeti98cTUmAV0
	eF7wIQDNo7SWkWoRs/gY+IaE6n0dNgQxnGLtKLof1bOQOP0F+c3fM3QRzEVFOM0S0KH5U2/jyhd
	QY96J5wwyBQ44wEoq8hvDM3U90GXMnYUtI7wNQJ5/73wL+wWOoDFaBgfIV6JY4u0/I2fPvzwOLo
	HM1ZHHijFNEyyM5UHrzilb/GxQ0tyt+ZM6ZhwcQqWI7nfWKZpzH7vWBzeMSTAdjEW4Ihr19BBKD
	WqFFpVHT
X-Received: by 2002:a05:6402:2551:b0:64c:9e19:983c with SMTP id
 4fb4d7f45d1cf-65ea4ee138dmr61564a12.2.1771604260632; Fri, 20 Feb 2026
 08:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20260220032809.758089-1-csander@purestorage.com>
 <20260220032809.758089-3-csander@purestorage.com> <20260220160741.GC15071@lst.de>
In-Reply-To: <20260220160741.GC15071@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Feb 2026 08:17:29 -0800
X-Gm-Features: AaiRm538JB1h7XXDuK8J0C0RlGnWOyfDYmxUa70Z-tJTPub16XPgDy6HU6Aq1w8
Message-ID: <CADUfDZrx0pvf4HLk73vMmJNLQ8cE8S0FLLTj-hUE7a4f=uE-RQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] nvme: update nvme_id_ns OPTPERF constants
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_081742_970998_49629636 
X-CRM114-Status: GOOD (  13.65  )
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

On Fri, Feb 20, 2026 at 8:07=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Feb 19, 2026 at 08:28:05PM -0700, Caleb Sander Mateos wrote:
> > Since NVM Command Spec 1.1, OPTPERF comprises both bits 4 and 5 of
> > NSFEAT in the Identify Namespace structure. Replace NVME_NS_FEAT_IO_OPT=
,
> > which represented only bit 4, with NVME_NS_FEAT_OPTPERF_SHIFT and
> > NVME_NS_FEAT_OPTPERF_MASK.
>
> As you're deeper in this than me:  do the older specs require the
> other bit to be cleared to zero and this is all compatible?  Or do
> we need to guard it somehow?

In NVM Command Set spec 1.0 (NVMe version 2.0), OPTPERF is only bit 4
of NSFEAT and the higher bits are reserved. I think it seems
relatively safe to assume bit 5 will be reported as 0 on controllers
advertising older NVMe versions, but you're correct that the host
should technically check for version >=3D 2.1 before using bit 5. Let me
know which approach you'd prefer.

Thanks,
Caleb

