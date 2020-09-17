Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF3C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:25:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AA221D41
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MG+/n+YU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZeRmYeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AA221D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8XsG+5Yai38qMMNCxhKHD+DqV9w/G8dEBgbO+24IDEw=; b=MG+/n+YU6zjKtB+DCqM4I4Qla
	nKNW7zO1SkRs8CxULjR5MJwNWIPcMqEpGIWzopq305AYnAUdka1Hr3ZueGRpoK/WxOkojRNcim0ws
	l0LbpB7/P3mqhTKGn9oWHkHt4Cig5FuS7vi++QTA9Fx0EhsSm+vlnfVgepckc6DDWxtdMRnkl2rAF
	fHNuS2d2UqviMJDoVbWaJfBixIE+AOuY+v0D/vX5kzKyxymtnzzNbezRi/8h40O1w9BYyuwkUumHw
	0PqxqUm8xiopKd6t+KP77jtDEIdFu5hc7RIQeVQHmfkwwXJe0MMhv8Wgeabmu5k2qc+Evdf+/EQoY
	0P7tKYAyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIvmd-0004Yb-Hj; Thu, 17 Sep 2020 15:25:15 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIvma-0004XX-0X
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 15:25:12 +0000
Received: by mail-il1-x144.google.com with SMTP id t12so2671540ilh.3
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qFFaAiUYQGx/B/LQ4VmSRn7rzjJpXStmCMvHShYB6Ug=;
 b=QZeRmYehLIc7meVnuqibRbPZMvp2rsT2Zwr2pFBBsmMNUi3jV3/JqKEb5ojpLHNaOd
 PAKCJKTW91q/lcDCiI2nN57WoTjnaprxx2n4Ao2+uM9Ivz1GhDMFEKkJ447D3oJwUMc/
 F2H485GOMU7HmmbazeFlvK0pZHcrL0O+f+LP900wn7V+YoYnJOkk8pODOuJDEXrFe5VH
 pWJQOUSxWk3RzBGRHzzr89TvrRZnpMbOpPeQ46k7ju5/7yDGRlwgKzsCNr17TLN/kw+v
 q1js1exW5eRtGhxFvNpuDb5xHyjQUKuuBj/l6jXoPpwIdsr2sGJRdTZj0ABhmV0jhYoj
 COYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qFFaAiUYQGx/B/LQ4VmSRn7rzjJpXStmCMvHShYB6Ug=;
 b=NKrQptA0pfwHq2xumHil84EWUbwC7aDHSwa+fWVKiycmxbBeRpk+p5n/Bd2rznokC3
 LfPidJpr50gMYO8fHAQU7YgymtrVDGU23+VYwHx4LbkJw+g7VZ4g4J+UVngNpico5Rr9
 +IgFCekxPYc+KyLfQLm+zx9NvM0qFjAwgFxt8K2FPjEfPfU1KWqlCnOVek0Mm2qQklBL
 acQaIcSwMOzw3I+dFFqBomq/ofUttqt/5QQ26598hrzKxjuEewQge0o2jKkxruBkcDXy
 m8ahxes7TtyTYBVvvQV4Soi0CRpNfKFo/UDZOZaWR3TDajKCc22jMnYe0mYoaAqJ801V
 cKMQ==
X-Gm-Message-State: AOAM5300nEROIOwZAaLbSuOOMIx/JsQ7HkKKtn9Nhn3YKeG1ne17E0Qr
 ZlxcQgiqKTORTr/Dh8m9c3c90Vt6OaW/OGXyBTs=
X-Google-Smtp-Source: ABdhPJxb4aw3x4OPxv5mugv8+g2gLOkcsWi99lTIO1oOop9Mrfbyxyq4HLv9Nn3Z4dC7+v/GvtHZmsYhuhGFF5dlIDs=
X-Received: by 2002:a05:6e02:c07:: with SMTP id
 d7mr26601655ile.301.1600356310371; 
 Thu, 17 Sep 2020 08:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200917082651.GA4595@lst.de>
In-Reply-To: <20200917082651.GA4595@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 17 Sep 2020 11:24:59 -0400
Message-ID: <CAA5qM4B=KcDK=SmduJt3am=gL1miNKoKuEZWRqft1f-kG03fEA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_112512_071217_1B765D95 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hmm.. OK. Any suggestions on how to fix this?

On Thu, Sep 17, 2020 at 4:26 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 16, 2020 at 11:36:05AM -0400, Tong Zhang wrote:
> > if a nvme controller is not responding during probing, a use-after-free
> > condition could happen
>
> This now leaks the queue for the regular teardown path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
