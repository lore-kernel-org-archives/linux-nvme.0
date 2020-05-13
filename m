Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECE1C2D0F8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 04:06:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31460206F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 04:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SD3ZVj7x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb9Bpama"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31460206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D+3m1lV1OsqJKJZRAKqKP1+aHTaLGBJCKn7fM8cELOo=; b=SD3ZVj7xeCHo5d
	ZZkkZYfmE+3cEaXc4RZBqeQ3+mZ2gt8XkMoNEFljN8lmfGJu8HBuuNiZNkFSW+F5UAMdSpPfLVojA
	FnHHez8dohCySq0qgBq3knUZVjl7CnEz/sewKz0KNbEoghUfukmgV+dFtPR/YLwgh+L/51YhaCq1j
	gANmVuM0nWJuwnsNK3i1wPLZZV0PLKO1By9IRmcJhPAbyXXDkIQEccQI17/llBQ6eoDGYEeRxu0py
	8TdzZ8V0gRptiEj6/oDhX7i5uSIG8MBO9JuNb1dvQmdtThocod5BO2m0T5xLGL9o5+wviz5qilXTx
	Amnje+9HLGWxuKZ/rQSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYif0-0005TV-DS; Wed, 13 May 2020 04:06:22 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYiex-0005Sx-31
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 04:06:20 +0000
Received: by mail-qt1-x842.google.com with SMTP id o19so1576014qtr.10
 for <linux-nvme@lists.infradead.org>; Tue, 12 May 2020 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n+3D58xKR4MKgkvkpePAFTFahnugDFqu62nRJaKyapw=;
 b=Zb9BpamaEXNwaOdRgWgGsMcE+q5yoIrtOgzVxXI6n+UIDY6YIRowJ2fpFCYbJJIBBC
 XKijzHXmUMO6Y+wk5cuWhgi7RkOfcisbJ0uxj0ZSR6lYR3SWMYMudgrxYqu4eHIzk0cT
 Rciba9R+joNYxNVkOJl0aE22D3vzyV5V0o6d0RVGEKo8TjB5G3I6HBZNDgXPM8LeqJJs
 ijAFytcRQCvhahzkkOKuoDaT2HEs/qyBpJ7fRrsPN6VvkfTQA9SNDJo7ezQvVvPHJ6Qt
 AFgpv96IeO1xyCrslwNzrfHyM1Rsv3lve7oUVC/45+6zbhPoPt34JP2bU2DNrYjo4OYI
 TUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n+3D58xKR4MKgkvkpePAFTFahnugDFqu62nRJaKyapw=;
 b=pQGcxJsveubZgp1PvyIIruSuh1PJRzs9jeClKr+hgY1HUwFTiTV19vR2mEk7WXatBw
 zqMtjFQVEyluYqngp7J+Jat8QrMxqp0V8Sw3MVGLgNgD2rAJq/ScpFpF1/e6uIRrIIws
 aJcrWteZG9jqs5cygZe7KxvoI6xbgNs32omwFfExKNqn0mg6yfpR1sVJxAlntmqbOd0n
 W9zYgzhOZblKT01QPoVcM4nH4Tms5z/7rXi7H2EMGJkhgXBxlSyYg+gWt2u9bdu4XnGs
 LDMAS5iTyQRVNFHdsIJwFLznpy+LBMR+aZ2aP3x34HireM+1f6HGUmEkeTn+nFhjp3BH
 NmEw==
X-Gm-Message-State: AGi0PuY4bj70ChxA4ZZlwcDMBsZj62lOPdusNcpzA/fE4ibZU8znksK1
 Br+i3aBA8xdlb/Gma9hOWyfoq8iZBEO5euvKQnw=
X-Google-Smtp-Source: APiQypJMcxAT943nwkZW4pVy0739RlsgOxvl4k4jheiENRAA0HGxTn14/wfcF/CDpowgkJHFaL1ciajT22GQuDJNBcQ=
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr25200012qtw.277.1589342777223; 
 Tue, 12 May 2020 21:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200509062203.GA19802@192.168.3.9>
 <20200512161749.GA16555@infradead.org>
In-Reply-To: <20200512161749.GA16555@infradead.org>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Wed, 13 May 2020 12:05:54 +0800
Message-ID: <CAA70yB56mKZ=dcM0kwAYb2OYoJ78jr4SdyYvbAY7Nc=fyhLw+Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: make sure write/poll_queues less or equal then cpu
 count
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200512_210619_130097_3C7DCAAB 
X-CRM114-Status: UNSURE (   8.65  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Weiping Zhang <zhangweiping@didiglobal.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 13, 2020 at 12:17 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Thanks,
>
> applied to nvme-5.8 with a small tweak to avoid the forward declaration.
>
Looks more better, thanks a lot.
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
