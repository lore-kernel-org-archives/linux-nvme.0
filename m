Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECADC43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 16:57:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54296206A4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DuhnE29s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sog7KaMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54296206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UBy1utcXLxQqmWyI74RWxGVSk9ciHylHcVLDuc5OpwI=; b=DuhnE29sqMNvW0WPZuC2UfZiN
	jYyFuvYmSuYhhwq2VAonk1ub3Z7btI6HqmSMB7DpyBjUXUn7N3YNQjynJxnwoBbb+B1FnRN3nIf/D
	LkvpGqctuOH0v6DdNWPzf03kISRactKpqkSGntgEe9/9cAndkw8ZUjcr+ureKPNhf8mKABAvDZc+W
	KuCXblGbV7pMtWyJYrG1PkJDnOupCaX4iKWOcDsYf8dLI2RpQzlXZ3Vo1v3N5IpPOWrMkT4or1r/I
	I9hNXbJfbPF0DGsZZTn1+U+QOgNdneJ2qG0ry1xixB1UciAp7uK3FLhOrOzaL72iaZmEYiG5RD/n7
	YDsl65ktA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIxDg-0000oq-Ph; Thu, 17 Sep 2020 16:57:16 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxDc-0000le-7y
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 16:57:13 +0000
Received: by mail-il1-x144.google.com with SMTP id y9so2998625ilq.2
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bC1NcC/3gidYXCraT60Gha0Mskxal5CIrv7vcfFm264=;
 b=sog7KaMBpFzPZ3X+j8JIxEP8Br4VuN/7bbEbqQ6pgKnWfUg+mphsD4ykMF4p7N3xE8
 TX0oRzojfHz/tkwzrqGaB7cov2rrVWj2cohzLfxXJDhqs+ssiTrawp2cR6AEnJsPajFG
 CFABejwOXs0LhY7rdRnP0BnlzMHQUYisOPHVt65NAUJ3BmKxMjWhbkwDZizccHNP6L2C
 9xYX5X+OpIs14f7hv0Bqi0nyH0wteb/H4IVY6mdi40+uaB5h1ZheE9z5SIt7mB1GSx6r
 bBzDe163r5aQwI6dLgMKAx+oQzdCjhVkAR/H4W2QypVb/Y/82/YiwrKBPmO+1aZWV6XD
 BpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bC1NcC/3gidYXCraT60Gha0Mskxal5CIrv7vcfFm264=;
 b=qk83uikevtnWL8ym5M/9YGFoCKipmSMY39onnmWvHfAYSGYGeFwG1FUwphEYsrcdhr
 fY0pW1q7dwsvcMJDvOOzcS0lqNKaT1EaQNoOaDg1CiABbnjUG//W6WzEHQpL5FPXEL98
 ogO700j9HSY9sTsaa7KkgmawVED8fEHClzvuJVbmvyvVNZm3ptIeTQ86LdMCrba/8OwL
 q9c1zqrcyEvqBsGcBxDqOkRMac8/QIjt74DuhjtBSITERqeQHpanIM23jDstDkA21E8B
 lmxPJQjwI4mlz284OK4I9WsKBs+A6ls4QYtlMcK+y9a97SjaV0Dwx5OzL/mICq0BQ3gz
 a1ew==
X-Gm-Message-State: AOAM533iGnbt4TR6Q1I4OOnnn3JY421X+Ddw3nVoHq/nrH7KTec2B+rZ
 jIfD+b112qXzHCRkIIfuYyYezeK/KdVp1tAUKpEmLOkZvjM=
X-Google-Smtp-Source: ABdhPJzryqIcyg4u45DMs3RqBmJvDVkP+yaW9gZAShRD12e7AUM84+dryjgpeBwIQ5GY9XEXjTPw9YMBgpWVWQlmR+w=
X-Received: by 2002:a05:6e02:c07:: with SMTP id
 d7mr26971412ile.301.1600361830153; 
 Thu, 17 Sep 2020 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 17 Sep 2020 12:56:59 -0400
Message-ID: <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_125712_364791_781EA6C6 
X-CRM114-Status: GOOD (  12.91  )
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

The command_id in CQE is writable by NVMe controller, driver should
check its sanity before using it.
- Tong

On Wed, Sep 16, 2020 at 12:54 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Sep 16, 2020 at 11:36:49AM -0400, Tong Zhang wrote:
> > @@ -960,6 +960,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> >       }
> >
> >       req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> > +     if (!req)
> > +             return;
>
> As I mentioned before, blk_mq_tag_to_rq() returns NULL if the tag
> exceeds the depth. We already verify the tag prior to calling this
> function, so what's the real root cause for how we're winding up with
> NULL here? I'm only asking this because it sounds like there's a bug
> somewhere else and this change is masking over it.
>
>
> >       trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
> >       if (!nvme_try_complete_req(req, cqe->status, cqe->result))
> >               nvme_pci_complete_rq(req);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
