Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ECAC76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJ8XMJlmFNN1HI8OQhQFUe31S1D65GN8q4I0UmxuaGA=; b=B8w/24ELHzba3cr6tbjxfdr3YS
	CEYTqVvXGe+JH5rBcxUKIeVxy3gDTaBQ5uY5aUup5+c80dLN5shqfAMO0JaeIm2cRuqBul3M02UCc
	TrP40XivhNz4x/kbvC7tbSfwbjOh51EvYYn3fXUN22qToUtfFTWCrBXTOl2vLAkrl+T0w/Msq26Bb
	HdBjsojbkonh/rnRIqHRPejpcB/+TdAUFuxf5NjQQBMT4foNUAz279ELLEO7zv2PF5mSsnPaeWiyI
	OD1/V59vvexc1WR/8hn/zSGoqVkvvFy/3usZARIkehLfQdIGL3QIiTf5eOh4VeaN/aSkIncVNz9vG
	QWMs2OoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOlA-00GAxv-1B;
	Mon, 03 Apr 2023 18:18:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOl7-00GAwq-3D
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 18:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680545904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ8XMJlmFNN1HI8OQhQFUe31S1D65GN8q4I0UmxuaGA=;
	b=AOjk377XKj01ker9ZTBkEKY0Lcdzhxi2ItQP4NEpDUVPbU9DYdqbCgeV2vzd9F/ajIs35D
	UdizHG+S5udIaMTw9YNwjNDrxWWbqi+vhTG+BrBkpXGc0Apdx8JrwfD2Mg5DvyfnsqZksS
	uhAN3ux6GgdYvNChVZ816eWSAF8Jjgg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-0Q-yebTiOeGZmXRiiG5C1Q-1; Mon, 03 Apr 2023 14:18:23 -0400
X-MC-Unique: 0Q-yebTiOeGZmXRiiG5C1Q-1
Received: by mail-oi1-f200.google.com with SMTP id s66-20020acac245000000b003897816aa08so3298139oif.4
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 11:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJ8XMJlmFNN1HI8OQhQFUe31S1D65GN8q4I0UmxuaGA=;
        b=YBp5alnp9hyK9SZ55ojmY85JNk8QcMwTImAnFgozWbPQOrBbx6ybxklsk3QirHFsj1
         IBhqzZVvxtOsVpkLIskZ6a3wkiHiZQ+Uz8Hns1HBDnsICjx7oZf64yn5qIdeLTkP5ZZw
         z7GDrgocmpG8iF3713GPpLJpoeazJaTDgQE6Fo3Q6gfCVvLtcD9pGSq1f6KzkHNtiEUo
         8gcTQDF9V9E6hf46IPNorWK3XZ5fnZpi41Ed+c2HZyLGXdOEWt37zW98d0zb83krMgrJ
         l+Mz3VSTxP5GxxpblZJMYFW+zIiMYlsGwk9UUrKPC0jduB8SfGkWnTefz1aEYHA77StN
         hxrg==
X-Gm-Message-State: AAQBX9cb9WVxoILuRwhcs1XlMFTrHVLWqF/HJRtCendhIfXtMs9DHyAZ
	7SV7YMCfecnxu8ptgLTT+n5RDQxJRbcNKvWrFX33JipfpxldZYFNo9zaQUV/EjQH/swwOKPmUNk
	/TZCVKz6LyhTUnXh0R0X7PPDyZH8=
X-Received: by 2002:aca:190d:0:b0:388:7983:2e06 with SMTP id l13-20020aca190d000000b0038879832e06mr40259oii.52.1680545903034;
        Mon, 03 Apr 2023 11:18:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJTMOs7xiTnNhy76LPqf+lB4UfRxzDL0CJcy/DmfoXMw0QCihh+8yf0/HqeQmAIrmUxXEWjA==
X-Received: by 2002:aca:190d:0:b0:388:7983:2e06 with SMTP id l13-20020aca190d000000b0038879832e06mr40255oii.52.1680545902772;
        Mon, 03 Apr 2023 11:18:22 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:45:ae91:c478:3bf0? ([2600:6c64:4e7f:603b:45:ae91:c478:3bf0])
        by smtp.gmail.com with ESMTPSA id o11-20020a9d6d0b000000b006a32ba92994sm2447603otp.23.2023.04.03.11.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:18:22 -0700 (PDT)
Message-ID: <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
Subject: Re: Issue with discard with NVME and Infinibox Storage
From: Laurence Oberman <loberman@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: minlei@redhat.com, jmeneghi@redhat.com, "Hellwig, Christoph"
	 <hch@infradead.org>, axboe@fb.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Date: Mon, 03 Apr 2023 14:18:21 -0400
In-Reply-To: <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
	 <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_111826_112558_2B0F7495 
X-CRM114-Status: GOOD (  27.00  )
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

On Mon, 2023-04-03 at 12:00 -0600, Keith Busch wrote:
> On Mon, Apr 03, 2023 at 01:35:22PM -0400, Laurence Oberman wrote:
> > Hello Ming and Christoph
> >=20
> > Issue with Infinibox storage
> > ----------------------------
> > Really discovered 2 issues here=20
> >=20
> > Issue 1
> > Kernels 5.15 to 5.18 inclusive recognize the discard support on the
> > Infinibox device but they fail in the nvme_setup_discard function
> > call
>=20
> This first i ssue should be fixed with this commit:
>=20
> =C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
?id=3D37f0dc2ec78af0c3f35dd05578763de059f6fe77
>=20
> > Issue 2
> > Trying to narrow this down.
> > 5.19 and higher (6.3 included), no longer support discard on the
> > Infinibox device and log this message so I cannot run the test for
> > the
> > discard issue
> >=20
> > [=C2=A0=C2=A0 35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
> > 01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
> > [=C2=A0=C2=A0 64.810437] XFS (nvme1n1): mounting with "discard" option,=
 but
> > the
> > device does not support discard
> > [=C2=A0=C2=A0 64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f=
-18cc-
> > 4a26-894b-8b0f8d79a98a
> >=20
> > I then bisected between 5.18 and 5.19 to this commit
> >=20
> > 1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit
>=20
>=20
> > commit 1a86924e4f464757546d7f7bdc469be237918395
> > Author: Tom Yan <tom.ty89@gmail.com>
> > Date:=C2=A0=C2=A0 Fri Apr 29 12:52:43 2022 +0800
> >=20
> > =C2=A0=C2=A0=C2=A0 nvme: fix interpretation of DMRSL
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 DMRSLl is in the unit of logical blocks, while
> > max_discard_sectors
> > is
> > =C2=A0=C2=A0=C2=A0 in the unit of "linux sector".
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Christoph Hellwig <hch@lst.de>
> >=20
> > =C2=A0drivers/nvme/host/core.c | 6 ++++--
> > =C2=A0drivers/nvme/host/nvme.h | 1 +
> > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> >=20
> > Note that Infindat mentioned this in our case they logged with us
> > They say they fully adhere to TP4040 MDTS.
> > Towards NVMe-oF 2.0 specification, TP4040=C2=A0 - Max Data Transfer for
> > non-
> > IO Commands (MDTS) was released with additional fields to control
> > these
> > parameters.
> > These parameters are supported in kernel versions 5.15 and above.=C2=A0
> > ****
> >=20
> > Our storage target will reply with 0 for bit 2 of the ONCS,
> > indicating
> > UNMAP is supported based on the DMRL, DMRSL, and DMSL values.=20
> > (older kernels will interpret these values as UNMAP NOT SUPPORTED)
> >=20
> >=20
> > Let me know your thoughts please. for both issues
>=20
> The commit you found unconditionally sets the discard queue limit to
> the
> reported DMRSL, so it sounds like your target is reporting DMRSL as
> '0'. Prior
> to that commit, we'd use that value only if it was non-zero. I hope
> that helps.
>=20



Hello Keith,
Many Thanks as always
I will inform Infinidat and have them figure this out.

Regards
Laurence


