Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB2CCF2D6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSQQWhEwYzqsSK80U6a+jDAT9oZq8I0PTtw89JMbS0E=; b=Pbnz/22l/tuhjmi3YSy11bybI4
	tL0yiba7NT/teHpu/q0Oy48JMsHY9gTEhQhv6yP1M6mDR8bLU03cT5Jo8tirgPtgSFZg+w7/kuz2j
	hjymBgp5fJPYm0Sl8SN+GbioPQRjqOSbkYbWWxccDi9jMleX9ahE3llcpf6bwQUvY0SyEThlog3VX
	GB6+5X22BPPyatT/ymiPTnbFoD9vPnlLr4TmVhRiKBH8/UJg0Ji6PpORdW3LQ7xpmMDdoy8kW0WBZ
	yBxxaiFpsjG63K+kvM0vvK3GwuvD8LQoR/fEjhkAYM5Lfk7/qTLAfgvJjJL6Ln2k3DIuYOrpMvQlh
	dpsRC8Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xImiP-00000007Q38-2v0I;
	Mon, 19 Oct 2026 12:43:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xImiH-00000007Q2I-0qjM
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 12:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792413814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSQQWhEwYzqsSK80U6a+jDAT9oZq8I0PTtw89JMbS0E=;
	b=KmnR+vvkkSeSvyh9bqS0B9qKNQNqk2DkPOMWrcXJHtDbBwWm6BSEpRHNRCA7eDuD7PMmk5
	6WL+Elz+5n9UKAGhTP+47SKyWiS+iojpefdLPE8V1n0irakK8arNJTiV59zFcnTQfsbCmS
	vQc70xUVE+amHJtVDfGl0DOoBTXDYu0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-K3apgDzuOKCnI8ekjd3dKQ-1; Mon, 19 Oct 2026 12:43:31 +0000
X-MC-Unique: K3apgDzuOKCnI8ekjd3dKQ-1
X-Mimecast-MFC-AGG-ID: K3apgDzuOKCnI8ekjd3dKQ_1792413811
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6756044f260so3645105d50.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 05:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413811; x=1793018611;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSQQWhEwYzqsSK80U6a+jDAT9oZq8I0PTtw89JMbS0E=;
        b=mF19zGFWM7tp7x5us39BQeXuEZnqxbVF+r+/wvZxiTVcRHqeY3TiTQ5RTQVvxEhNvC
         yytBkmXFEkG8vumFrhJX23iZzonF7b6Q1A+tFHLbv05tbdIxASZ8T7XLhZ9/jDzVJ/6Y
         g5ORI51hsPlaBNuLwvj+4JRiZo6hT0i69663s5KdVVBxv3g4ya5k3BuOsMnxT1XqYH5U
         HLDLTxRGJtsG0XQPkvFEdofkifvt1Fjn5pVzQSMc65X6cAWc+BhpX1Fa63acKJV0PTan
         LzSNucFkddawwsIzRDR8sVfnl+Ap6kWC/bWk1ERoU+fCYbAKx0feR8kG+PncYcVO+qXu
         vzzg==
X-Gm-Message-State: AFq9FYJ1fgdX+EWIMnm5LItoYdcMUIr3qiuXxi94d7FuYfDPKbyetba8
	7qY09GTWuF39OB1rNLXr36QVWR6FL0lJ2ZNjF9nXXoGJTdRbNQCP5TF7bmHKTXeNxVOupXscksl
	lya3eVNpBk9bCklqAw2So0P/BpvSUpkKKzSu2fkvgifZrqz93ZON/PlXD/vWQuUKx0tJa
X-Gm-Gg: AYBFou3Sobe1u5mDa6D9Jg9Pf3VEtbcasrLOgeKgag0KA2ie8a+YqSjShbsj802/9E/
	Z1dM30oA1FIzqgUB/iEg/sSrxN3ZwJRDnWwChc9z5ehXUanyiDvnzA9WIprx/p2KuYv1p0sCiWp
	NlVQufxMwxO64YN4QMDeZUu5Zde4rT7yJamhncTMO1kFHMVd5PBAbM3YrZKImyN0TjCiTx4eyoy
	CdaH1l9P1FMJl7MmhmbDCsp51kqS71dtUhDYBvQloLdvfa3cqCL2Zy34Om1x4rzTgiOo/P5eE8s
	3EdhUbkbNbldK/uNzvh7jvmVsWXRIReIBzGoc+jQZ1yOZGrEn4fHBsQMpS+8MFEs9Yh+orMiA+k
	9aJjG0Va7dX+7wuYTIhvUScKNHL/pNhcrzvAL
X-Received: by 2002:a05:690e:1517:b0:677:a948:8d50 with SMTP id 956f58d0204a3-679ca8268eemr2007998d50.14.1792413810823;
        Mon, 19 Oct 2026 05:43:30 -0700 (PDT)
X-Received: by 2002:a05:690e:1517:b0:677:a948:8d50 with SMTP id 956f58d0204a3-679ca8268eemr2007993d50.14.1792413810372;
        Mon, 19 Oct 2026 05:43:30 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1f1ccadsm4040764d50.22.2026.10.19.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:43:28 -0700 (PDT)
Message-ID: <1a84584bc9cf64fab6b4e17bdf2050f9b176ad6a.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
From: Laurence Oberman <loberman@redhat.com>
To: Martin George <martinus.gpy@gmail.com>, Guixin Liu
 <kanie@linux.alibaba.com>, 	sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Date: Mon, 19 Oct 2026 08:43:27 -0400
In-Reply-To: <c4b6b7cfd51a498df8aaa7f5bc5cef9a0605b733.camel@gmail.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
		 <20261019075607.808947-4-kanie@linux.alibaba.com>
		 <sashiko-outbox-176783@kernel.org>
		 <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
	 <c4b6b7cfd51a498df8aaa7f5bc5cef9a0605b733.camel@gmail.com>
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NiGfA5zi7nT7hZ7KpBe7zs4j22iQyTX_zA0fcU1Fh_w_1792413811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_054337_318654_2C05ED88 
X-CRM114-Status: GOOD (  11.96  )
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

On Mon, 2026-10-19 at 17:43 +0530, Martin George wrote:
> On Mon, 2026-10-19 at 19:13 +0800, Guixin Liu wrote:
> > >=20
> > > Should "service-time" also be added to the accepted values for
> > > /sys/class/nvme-subsystem/nvme-subsysX/iopolicy?
> > >=20
> > > =D9=87=D8=A7=DB=8C=DB=8C
> > Sure, changed in v3.
>=20
> Not just /sys/class/nvme-subsystem/nvme-subsysX/iopolicy, but this
> should be added to the accepted values in /sys/class/nvme-
> subsystem/nvme-subsysX/iopolicies as well.
>=20
> -Martin
Hello

There should be no changes needed for my original iopolicies patch=C2=A0

iopolicies_show() walks ARRAY_SIZE(nvme_iopolicy_names), so whoever
adds a service-time policy adds its enum value and its string to
nvme_iopolicy_names[] as part of that work. The new name then shows up
in iopolicies automatically. The existing iopolicy store path already
matches against the same array, so both attributes stay in sync without
code changes

Thanks
Laurence


