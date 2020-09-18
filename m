Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4B6C43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:45:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3503E207FF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ho6gNKId";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1QMh/1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3503E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=prLH+V2mskNTaUuslmhtB9VLFFmSnaJWwz/dqUkS5cU=; b=Ho6gNKIdtZ38iirNJX5P4BaZs
	d3SrtWlHhPqakCsHDY7rIbrWy+eYP6bZW7uahgyBS9czdus8AG6jbhCw+zZwZxloh1NFPXH4sz7KO
	dNkSKX5ThNjv5pTxdP+KgQk8kzQXzIZic5PGIsxbKO4Z2lM2H0oMGshGM/rabXe0Dso3gwy08O9Jz
	5Uar9TNbu+STtoi9/NXFwOevKme19HUwmLoNQkffRi3d2dztO5AM7eV56rMetfydB5qFOjJE8YF8d
	oSZ6+VOUH/OLjqI94pganiWkpPXPxelBWgzAdFyGtb9XrWM42ABWCyfieUeAhVoIoqcp83E2SxTA2
	YMscq0OdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ4WX-0005pl-GJ; Fri, 18 Sep 2020 00:45:13 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ4WU-0005p3-VV
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 00:45:11 +0000
Received: by mail-io1-xd44.google.com with SMTP id b6so4730412iof.6
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e4G74ayMYYm8alkLYYmxH5Uc6z5TXOik34xjtBhvtLM=;
 b=J1QMh/1DktBhJdqjoXuxY3tyon15N3kc1z8ngxb5e/y1Z0pWANPU7Bx7uxQgLhZ1Q9
 wwkoGQOQ0FE3gF4jZQfFy5ywK4bLNJfCRdw2p3h6CDy2bxUNATRhwWSasY/9tJjxXGEP
 S5+ai3a8KkHhphKkpN/iU4UqHR0nywadXaTkv757v42pFUk0VK93zsraPmdmiCwyTRsH
 aHrgk2QrUdHcYL5kWsUfFVvO5Q+y+v0wfKvi9Y2/A+G5BHd350+iabu1ztvnZZYfvaJJ
 h1VJMWmzNORhkFwNls0qARP57lbPiBse3i4gLLMkZFRn1tFU9cC/9tiSCIxn9sStvsPP
 +hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e4G74ayMYYm8alkLYYmxH5Uc6z5TXOik34xjtBhvtLM=;
 b=TjBvUJMqt5xXukMP0E8DFUpGe/9DPoHRHVDAO5WPvN4O4a5ZxHDPGcN0hmKVWkthdX
 gJham4jX8gr2cW2WAf52Z53xMOaylXDV/cUI692OyR1BOgXWGb5iw6hLDkZVNk5xExDi
 Vzvy9eRRyMMlZutut7gVIim6SOtiwUhdeRJb7qOZQ8eVnEn18QOJpsVpVUioOPixrmmJ
 vxxecgJaAH7+kI0DgzJlSnFDjkCjTKXyW2JRwTLb6TfrNqcRW/2EqRRHUGKLDmfK5iDF
 7fv72Ld4mWDYeHf5oxSpwmwTM8JqQVLF+zoQbd1IldTJCZEMJCnYKCnsIQ+u4Wz/KicQ
 OXOw==
X-Gm-Message-State: AOAM530rcKR8sDDF05NS0Sf1uSlE1hshbkPOedB6ror6E7OguhgwZiEk
 79SNf89l2+iXJ0++9/LMVHBMoU3ra0vQdtgDCd4=
X-Google-Smtp-Source: ABdhPJwanZJw1WRBbyHvHyiYFr5PUCc2D56a5CUrtsyhpRF0XY0IgkY/0bUSD/Sh0RBXfH9dZPXjR9Tbvbi8SqHbmb8=
X-Received: by 2002:a05:6602:154e:: with SMTP id
 h14mr25664671iow.17.1600389909156; 
 Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
 <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 17 Sep 2020 20:44:58 -0400
Message-ID: <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_204511_038304_9171280A 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hmm..Yeah.. I see your point.
I was naivly thinking the command_id was the culprit.

On Thu, Sep 17, 2020 at 1:14 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Sep 17, 2020 at 12:56:59PM -0400, Tong Zhang wrote:
> > The command_id in CQE is writable by NVMe controller, driver should
> > check its sanity before using it.
>
> We already do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
