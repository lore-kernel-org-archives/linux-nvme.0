Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B1C79FBB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMs786uqXSKku72JuRf3CgcJHichpdADmzIa67sOeNo=; b=3eddYXRp2jOOGNoy9Iq+NZfSjh
	fkqiM9Jzm9E1WwThzto9g+3uukIa9JKAYSKVuAv8JMQ8I3H5eG7WOpkKEr7LpM1twNtxPRDFj25DY
	PfIpEgEgdiqOnW/x++b89L3l4/fieMHzETglvNx+9iEPbBc5rlpUpuS2qpUXnDBdyUbmflZYVk0Hk
	95n46DVrt7ArDxSKak4DOL0/W4wK7AFNw+itR/C/2JVMak+7eQbL81HgRwS/5oUTEwlEsJozRnuPS
	8ONoMoxZ4hkESXn/DD4Ou3nSqsRlgUmMJSbOG4I8Xz8gMlwdQO4fWn5ygWWROldVEKzpxRqG+DbgT
	OkJz7QFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lRs-0000000FLFH-3aAx;
	Thu, 10 Sep 2026 20:32:44 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lRq-0000000FLEl-2swg
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:32:43 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-52d7a3defe8so2727031cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789072361; cv=none;
        d=google.com; s=arc-20260327;
        b=TTA5YdVCY927dR6rj7EZ37SEiYPWEQbeeEud8Ayje1yR1j6AIWj0HukPGPf4eBBqev
         vdw4hTVobWq0OxuDNd9Bvgc9aCldjQZYIDKQ4/2ngYm1KGd0DqchsFGW+E9mYYXdKqG6
         m4q6k84Gq+5kKnaE8WTjEr77xOe5iH2QjPae1heJaITMbylhRerFH3ggXRUoYCPGbuIh
         d/hAJ8qgY2nO9XkxWHMMgTkQzO4kPTPdlba8uyESdzOxPrFJmfJHOS0l15pf1bSwAgng
         pATgUw/co8QGXDHqi5wlSvlt9+O3VXmWdENVnQtGlDeol+Qi0VFXk5rhpre2vA4RFDOx
         jpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMs786uqXSKku72JuRf3CgcJHichpdADmzIa67sOeNo=;
        fh=v28S4iQUE3cHWj8IjvwnEngtFGpeKS/idYtWJJdEvYo=;
        b=L5YqLscjp1ejonH/91NchSERwUxm//Yy0XGMNqGJYuR4HHL/0aHt1kNxYznBr7kH7p
         upQZzGUY27sAFC+2hOOF5RXDM0s+6VSV+dzrONd41K6NxDtrbw2Au9/bWpRGxl56DUtZ
         Iv99iilV/88ghQwkhSAp3sVrTS6Nv/Ez8vEWSYWI/sEiGqRKAb8O5doJyKEf7/rhNmIN
         NJq5auGaY7GMs6TeWkAJyOmXzF2Z/mr6OjSdTsyviCvrQu7o6RFJMFJ0VHtY29oz/3O4
         IbAXanru7zHhYTbmoG4+fDDlaUw8NEzXS80w+tfgaafZZUVl292UaV4JPPhZMq+78JDE
         ajpw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789072361; x=1789677161; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMs786uqXSKku72JuRf3CgcJHichpdADmzIa67sOeNo=;
        b=fZsoxqVeRKDjtBkoIM2lA+ujqLnjyNuQACtLSeyx5TrckGfUDVtL1cD4FPOPuHSfnX
         6avERWg1HOPruSAt2pgxsMvTag6dZBYh2rAntGwcj+EwABFobP3swMuoVmMa1g5v6vVY
         jEAvsIUO/NPrZB7jwqguxvKCHvvMVCvOZOTmcEaFaxnm/nacgZKQvqsfZXm+lpAA6tkT
         IkWxM5ghPdf1H10fjjrCa49QgBlspCKPN8kTuMI3uxnS25+09/vBsAeAmpm0qMeV9jba
         JzjZPOOjwpoQjCe2Kn/VjfTdpWe1Cx5mu1KZLwPYJd1fXimyryUFIO1hDt10z5GQRThn
         4OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072361; x=1789677161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMs786uqXSKku72JuRf3CgcJHichpdADmzIa67sOeNo=;
        b=CNlpcFcR7gi/+KF6SNJ+QpzXDSlgmZhkOe7RVyRLPJ3khSk1yh6e3pJVX894OaH7oS
         cHaJN19g2erik6//1djInmdkFX9UvKIQyBZHsRLPKJ1aR3XK+8f4Xfa4sWU+Uvb0MAYr
         yrTFhaDPxBD945ud4gweYOxnbHwoBbKNmcBwsD5RrQuQhA3m7SONmGYFhArnVpaErkEp
         ZCfQKb3SiCOAz5WjJqNb5Qx2Za0gHhgmqAuHkb+vs07eowc/fr8GAa5JP4HVruFx27sx
         y8s8s4RmsXLFGr3a4tQvNRYVG9ttCH8A2yJuW59/HbITIdn1eUdvmh6iZxuNWgVmDUfG
         QEzg==
X-Forwarded-Encrypted: i=1; AKwUvBxp2EGSc4OoMtQxRw405vIJ6I+VpCoMP1fwF8xhkU7idzOK33HT1TIve4S8+1O18XIworqgsbujK/vQ@lists.infradead.org
X-Gm-Message-State: AFuF++m9qogO3iSmL4+FmzqXDE+Q7Qp0RUFpxkebDnQgCrr9OpoGigND
	eprn1rp3poc4YN8f51XxZuLwqQk9rdcCCHEBV5VK/N7ZYZS75l3h/xQqmjkc9Kd1q+pmEwZm8qU
	DsFZC9WQqk4rfpioDdNTTk+aezp7UqqX+JSOsWrhn7Q==
X-Gm-Gg: AYBFou371hYFeacQ1HcIJJbfhLXNDkFqHiAno5CZYdMbg5Vb0jazs21Jh12i0gbB3ZN
	YSK+vJ0MxwiL6LR2arhLZHfkmWufAv8weMF5ph92/m2TlY9cCqGwKL/WOSbM+7uNkldDbKc6//F
	VN0ByiGvhZwf7DCQ1SJiKQQxDOIELPew9G/T9hpUAoshZaTnwYT0TkJJwbuwy7CF2lU/MBAIEAv
	S/AzD9qxrBiRr6N+OctjKtWhmJjsb/TIycJPMaEzmXrygnRszWM1AZQzQAyfOpw+m9Eb5I6GNX5
	PjLa4Xtc7pVMtFeqF616QI2uc7TxgUGdrK6Ofmxp9RosqQfojO5nK88=
X-Received: by 2002:a05:622a:1cc6:b0:530:b2e4:91c4 with SMTP id
 d75a77b69052e-530c87cde3bmr17847751cf.61.1789072361124; Thu, 10 Sep 2026
 13:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com> <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
 <CAMof9cWdXR_040SDs2N=3ETvdmxvjx+OokfkSDr7DzVbLbuenQ@mail.gmail.com> <39448561-8877-4e20-98e6-fd85acc3d569@grimberg.me>
In-Reply-To: <39448561-8877-4e20-98e6-fd85acc3d569@grimberg.me>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Thu, 10 Sep 2026 13:32:05 -0700
X-Gm-Features: AcwNN1VVO80cI_G7IjWKmJQTZEGiEoTj8YfHr2StmC_4xE_l1DVdfhFj4qx9Qq4
Message-ID: <CAMof9cUv3EbdppfCSK++QO_-AgmqqpqO8AyajwUTjxt-mBQX0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and startup
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_133242_732330_4042C9A4 
X-CRM114-Status: GOOD (  21.16  )
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

On Sat, Sep 5, 2026 at 3:30=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wro=
te:
>
> >>>                qid, queue->io_cpu);
> >>> @@ -1846,7 +1856,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctr=
l *nctrl, int qid,
> >>>                queue->cmnd_capsule_len =3D sizeof(struct nvme_command=
) +
> >>>                                                NVME_TCP_ADMIN_CCSZ;
> >>>
> >>> -     ret =3D sock_create_kern(current->nsproxy->net_ns,
> >>> +     ret =3D sock_create_kern(&init_net,
> >> I don't think we can just change this...
> > Passing init_net explicitly does change behavior on the synchronous con=
nect
> > path. However, with queue allocation now moved into an async worker,
> > current->nsproxy->net_ns resolves to init_net in that context anyway, s=
o
> > the initial connect path already loses the caller's netns regardless of
> > which argument is passed.
> >
> > If the goal is to actually preserve the caller's netns through the full
> > ctrl lifecycle - initial connect, reconnect, and error recovery; it can
> > be pinned at ctrl creation like:
> >
> >      nvme_tcp_alloc_ctrl():
> >              to_tcp_ctrl(ctrl)->net =3D get_net(current->nsproxy->net_n=
s);
> >
> >      nvme_tcp_free_ctrl():
> >              put_net(to_tcp_ctrl(ctrl)->net);
> >
> >      nvme_tcp_alloc_queue():
> >              sock_create_kern(to_tcp_ctrl(ctrl)->net, ...);
> >
> > This captures the caller's netns while still in userspace context, then
> > carries it through all async paths =E2=80=94 so reconnect and error rec=
overy
> > also honor the original netns rather than falling back to the kworker's
> > init_net.
> >
> > Is this approach preferred?
>
> Yes I think so

Alright, sent the patch with the implementation in v3

