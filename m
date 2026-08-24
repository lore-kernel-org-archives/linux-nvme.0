Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F096C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d9nIwkb3lcWkRMsR68Ijz63PkJrkuAdq8QtCVpAa+hQ=; b=r8FulFQsVHixOpAckl0c4EDDLd
	LHAp2gCQGwl+GTxifvLOyu914fsLOKWokjZI1Q6IaH8QGJBZlgpZLSyDxTeE0tdT+qqLOZ6nvwM2d
	rE+RIrx4F70E7JItkeldSEj+L7Y/YZYLAPmIgK8w336B11Sr1zf1i8wwp8+u9DbL/KSEUvSL47nRm
	R70A328RA2GXFoOLBmEDGQbya/anR6LLVfKzIL4UTXRJsuWh0qqIAp5Sz1OvjMm+6kI6ATED/mSi2
	7FXRyq0r5cCwLDzHg/870K3nZa1GpfoKcm2tafbVhOaSKWAiAYOFXo/kEEm6dqpl1s6f0s58+jNDa
	7OK0x2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyZG7-0000000HFHC-3Lx4;
	Mon, 24 Aug 2026 18:18:59 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyZG5-0000000HFGd-2Lle
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 18:18:58 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-47fe377a217so1816649f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 11:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787595536; cv=none;
        d=google.com; s=arc-20260327;
        b=iUseGMvb5BXEjLmEDKZPt8OCVaiu8ix2TAjHrCPL19mnG3H377DIr2hpKqNI2yac8r
         MaEDS0/By8HhIs3u5U93u5OCLoHt7okndHVKMcEi5lV/graIJ30M+Z0oVqRfrU7gcUUN
         HCyQCAlU4u4E8hIZaVbzEh8OnMgt2DDIE8ltMef5QMkbFsOmFZ3d0Y+G8ZLjUVjuaUa/
         R/HVKEm24u/gg+BHWaqK2s95jsXI5CT/wDim6z8u7D6wvWE8wyCt8mYM9gLPWcmMMeVz
         ++AGU+IvGq0vov1yML0RVOl3cxZrXG+gPFuiVdXBZOkg1DH2Mc9v54KiWeajUtUiUn3s
         FN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9nIwkb3lcWkRMsR68Ijz63PkJrkuAdq8QtCVpAa+hQ=;
        fh=mFq9CjbbsXSIpalHr0kqCZDTRsPrwTaiKSTN26buXcE=;
        b=ZcfGlGWRUivUknxXJcUvq1/72NvdQ9UWt3S2G4dOZNcmn4wzPnO2OD6uBDpxAauL65
         kKTXSlVJkEGVnklYm/exdShIHHk1lR8dEtU7RsIK/8qlkvS4509w8B4IO3MgrsUGCzkb
         xw6UyYWiRtrbE3mRrWfxZHpK5obW4EvYhYKrpnfkVwob3chQtX2OzGd+cRTL8wlC2Wsj
         zM6OKwCm2BLVcLWDBVvjl7wWt9u2vyVTeWtQMxS81Y9+5PFqMlEMonhK3pcFyqRH9nQz
         qTLIYsU5FsnchIJLbWk3XwKkub0+ImaVkNZ+rNXEISbF/T2MhnAh5J1o/apqNh6kF6vk
         PcxQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787595536; x=1788200336; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d9nIwkb3lcWkRMsR68Ijz63PkJrkuAdq8QtCVpAa+hQ=;
        b=skGk6Scv2h3XxGhLoC9cATzUYrzGARWzudeKKi3ffQJbQ8GGhX0KGrYjLJGCyRJQSs
         5soOLNiNVawozlwjEElhR2QEaq1tXKXVFtp/eWHkFLSTZUMzLRD68bpEOlyA+kZbM+od
         xUWuuIwmguEWkqb3aT9/wfqP1DVL4drtwI767Fw5RoKjojbiMQW5QYNgPlOWQExOoT1M
         gq7o6wLKVj7HqX6cmlzDRfTsLBH8GXOJVAhB+z9bbqZKUy4u9FUwjgRrSx51ZJIajxIe
         ++XgvC7Ic9ZM1wRR7rJpukR+1FYgKpKcMiiczzl1xPlFMU1vHMFC5ltU44ZxogVENkcH
         nIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787595536; x=1788200336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9nIwkb3lcWkRMsR68Ijz63PkJrkuAdq8QtCVpAa+hQ=;
        b=iJHz0cIQnzaqaHc1s7ETu4gyx9BzZQ7w/B1RfBwGKCxHDZmUbb9Ccc66TtAHBnZK60
         JMEva+gpnu8lv5G+XexIMT8r4FqzXRYYeSpwFvCYWMFKOWp7q3VA0tvLbxtlfwxmWk4L
         paMFZQLjK4tAeyxE4jsUTmNeUHsVUN/aw7XeHKCzm2IIEdF2ijqs4U5mh+kg1S1qOcdr
         YqDgpa32sZuI0dVGJ+GS1OLiYEOobalA7OnzFMxMa90V1GwYM3AnILFsltxpUSe4rxz2
         XqdnYcsGRVUcZ9GiYghzwRvDZoSvf4od1ZwwkrDDnQMh+0GrHe35enSc4PiuHanSGeA+
         97Tw==
X-Gm-Message-State: AFuF++k3YbcHYg7C1hNfy883MqAuvyligAkylEST3KB3+wstCmlw0BVJ
	ChRIqkwCxas+jpdgRselukP0zQBbjoNQ2d4XCsa4k6x21oEke+PnAo++YUmOQ8zr3KdbtqjoTOA
	UdV6xCH+O0NDpjstzBmZoKxJWunl+xKoex/lL
X-Gm-Gg: AR+sD13a3/HVdW5Ag+zNIOSouyPouw9xGMPFfRUptyk7vaFwkPSU3c2nSTE3Y8D0rpZ
	jA3i3zeYTc3frJfwmQMrsboKR8Zn7zl3nl33fvWLwlgm9o2tQwlwS1Qy8XHVJp0BpjYneogWUdp
	TYw+nyAnsTLyRj+6y2ZlPNcFVl4ws6n8zw2wKKcoit2CLfy1FUmRkszk2y24P43pSV5EnhFrdGD
	Emk1yC+0m5yAnis6tO0RBNZomSuuXvkWLxfq3XUFDyCJlYogF72k0sOW2Is/7q3G+GFKnejDaZc
	VHFsN4frxQhDhFgNWCD7wA8GYnRDq4Q8b5arJMYuHYlHTc8=
X-Received: by 2002:a5d:64cd:0:b0:482:b886:4ce7 with SMTP id
 ffacd0b85a97d-482c0b95967mr43689414f8f.12.1787595535416; Mon, 24 Aug 2026
 11:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
 <2026082412-matchbook-perennial-03af@gregkh> <CA+ysrSKxTa--qGNrZu5SPLner+OTvHYFjfuSRnFW+xkqnQ+VBA@mail.gmail.com>
 <2026082438-stank-rectangle-bbdf@gregkh>
In-Reply-To: <2026082438-stank-rectangle-bbdf@gregkh>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 24 Aug 2026 14:18:44 -0400
X-Gm-Features: AcwNN1X4eNYF2QN_O3rg0172PpOXAb4bfvH5zAnAPuSONAcYeD6xEm4ymFQfUuY
Message-ID: <CA+ysrSK0VHVfkCow8gtJ6djJhtL0VULngWm6uZ+J9ZUdKOXBWw@mail.gmail.com>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Ibrahim Hashimov <security@auditcode.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_111857_622642_FA37D7A8 
X-CRM114-Status: GOOD (  16.91  )
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

On Mon, Aug 24, 2026 at 12:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 24, 2026 at 12:07:28PM -0400, Shivam Kumar wrote:
> > Hi Greg,
> >
> > Just the CVE, if one is assigned to 4a3f002, being recorded as the
> > reporter would be all I'm after.
>
> We do not have names/reporters on CVEs at all, we rely on the git commit
> text, but also will be glad to link to any external documentation as a
> reference if needed.
>
> But I think you got the git id there wrong...
>
> thanks,
>
> greg k-h

Understood, thanks for explaining.

A reference link would be great if a CVE is assigned. The relevant
thread is:
https://lore.kernel.org/all/CA+ysrS+fsJQ+4x7jHoSEX_tiYRQJC8LEhuH2stKA6Q4qSK=
-MWA@mail.gmail.com/

And apologies for the bad commit id, the correct one is
4a3f00262a044e8e15064b1a6860968bf0500bf4
("nvmet-tcp: bound SGL data length before allocating command buffers").

Thanks,
Shivam

