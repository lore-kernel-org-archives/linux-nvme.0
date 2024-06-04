Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4674BC25B75
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 02:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYmrUeIEnxNASm4Rv4REBEx2tuNVDm13V9FC/wyhROw=; b=AOUl6CE1QqU5bBwtDx+R08FxkX
	Lb0whowQO6TcUS2+QQja35X0KebQhqVzAYk+cf8aX12vAFKnVB0jhaFRG7/BogzJQ6LSbmNxtI9uB
	CG9d4HOe5xASNHbbbBQEp3NHkIPY365T4MHk+YCEMkGqOO/al4YYdyftf6wygW6rCasonw78xlRaP
	VXYTAxTBtEqaDQP+6wCEUjoR1XTVQGn+AeXN3bVyyOmAnRFVoM4lDQjJetoO8oc/13nt0GeICYSGC
	2e3i4GkGMJpPhH+iOyi9+wWYJpnynH0RHAP8EnC0WY/BVFri7XYXTRMLr8uSKUI7DqLT5Q2qQMJLg
	1Et1DyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEKAa-00000000xPx-3L5l;
	Tue, 04 Jun 2024 02:45:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEKAV-00000000xP1-3EsD
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 02:45:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 23B0560EEA;
	Tue,  4 Jun 2024 02:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35640C2BD10;
	Tue,  4 Jun 2024 02:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717469097;
	bh=2/N5puqzQP5TVf+PYCoNCARjrzah4rCULj58mKqhwso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twMvipqQe5MnxIn4eZOjrKoILW8RGuWs4Dg/NK4U6KZAFe7HfNW39hBsi0p10GJ04
	 Sy9Cr0KX5eHvjR5ctdN/Bm0E3fVWy2hdttoE2P5UbcNO2bgxbnA8zV8GIpngFcnV3+
	 L02leJvO+osVoP01DoNNUxypNUcEYKQp6cbFvZr8vIVlHyu8zWZMjIclk23/sG2c+M
	 ++Xi+5Gwgp7AX7VDAWKANhPQe2N9GSer5lYTfWX+n5eHuOxOZ7//KXQM8j+oRpL1QQ
	 YsNSTXVV9C91ZvPUAnuXv75jmrjDAXJ2sdqvhiZdWHWlxY2ONerHBGOUNUL8SHJXaJ
	 VbyMZGdu7gArQ==
Date: Mon, 3 Jun 2024 20:44:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, mlombard@redhat.com, hare@suse.de,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH-RFC 2/5] nvme: tcp: split controller bringup handling
Message-ID: <Zl5_p7C3UOKnp-St@kbusch-mbp.dhcp.thefacebook.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
 <20240603230524.3854115-3-kbusch@meta.com>
 <CADUfDZpbsNmYsVX6AvUtmkjD92zJvWWjyS7KBCDzhHSksL+tqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpbsNmYsVX6AvUtmkjD92zJvWWjyS7KBCDzhHSksL+tqQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_194459_903776_2C570BF8 
X-CRM114-Status: GOOD (  11.77  )
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

On Mon, Jun 03, 2024 at 05:35:13PM -0700, Caleb Sander wrote:
> On Mon, Jun 3, 2024 at 4:08 PM Keith Busch <kbusch@meta.com> wrote:
> > +static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> > +               struct nvmf_ctrl_options *opts)
> > +{
> > +       struct nvme_tcp_ctrl *ctrl;
> > +       int ret;
> > +
> > +       ctrl = nvme_tcp_alloc_ctrl(dev, opts);
> > +       if (IS_ERR(ctrl))
> > +               return (struct nvme_ctrl *)ctrl;
> 
> This cast doesn't look right, as struct nvme_tcp_ctrl doesn't start
> with a struct nvme_ctrl field. Looks like this should be &ctrl->ctrl
> to match the current implementation of nvme_tcp_create_ctrl()?

We can't take an offset here because the "ctrl" is an ERR_PTR, and we
want to preserve that for this function's return value. I could cast to
a "void *" instead to suppress the compiler complaints if that helps get
the intention across.

