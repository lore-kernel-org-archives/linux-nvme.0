Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6AEC76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pnUfxiNzIDCXaSEDlUou/KQ85PIVBXyvNqN5IYn9Rr0=; b=b3hvBJVH4RhFB8CknIFcoiTQ/S
	2NrM9t/frttHX3PVVVkDiWif0lW27Dh3FsOuJVT+uU0EsOYmfvVW4dF2xHAN8TyAIzME9n7yvCKkn
	EiiP9FfQ6Bg43y9pPVqQ8XfcrUrH6G/9YadSH5PBXU2dRm9nmn6Yc98ePdyFcQyfRUPOnqHFtLhR5
	rNXzxDQpEi2a7d9rZyn/67PHHsr57ypFmEQZNRloNRJtEFQ5cvW9n+MSBGyGLdBPEPQvkZoRR/Ob2
	/pNc1qtLbC7pnUOh3wuO9uOyJFj6155ENAcGhN4umMPXmybPLMSyNR4YDxT7vkd7VaNnJG/AS27Jd
	HGqFQuYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjP75-00GGiN-1t;
	Mon, 03 Apr 2023 18:41:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjP72-00GGgR-0H
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 18:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680547260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnUfxiNzIDCXaSEDlUou/KQ85PIVBXyvNqN5IYn9Rr0=;
	b=QfsNM+i9LtCQ6/w5/I9ZWOS1nWSH30gwx+0WpbxDIzzYN5Dp9EB3gZREQEIRkNlaPtD8sB
	scBQMq7PdV5RvPcfSlVViSXtvZCsAOenYGOzk7iBtP69+YLvjlO3Kir1YK0z5oPpReTrkp
	fVSjkVu4eVLjCoqIuO6GABvewkshwQ8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Xsv824GWPT2aiyfg3LJkbg-1; Mon, 03 Apr 2023 14:40:59 -0400
X-MC-Unique: Xsv824GWPT2aiyfg3LJkbg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-17a03f26ff8so15963031fac.8
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 11:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnUfxiNzIDCXaSEDlUou/KQ85PIVBXyvNqN5IYn9Rr0=;
        b=N+/RjicSkfeuYBigQyqr5K1IrCyxSZxJJddg1OYj0DPJ0GMRmK00uOjzySkusb+hPk
         8Fr9ZHubtFkFr/QGBGU4k0nLSYMVN4Gx+jLjMe6gVIG5iA3F3ShOw2S2jhMx5Hw4kmz6
         GVysSYVAQM9AHBw2vEZj/TSsl83SX54zpzIukahOFLUH6vgWh2QzwB2Uxw7/TMi3xBpR
         rKpgK/O7kTM+y+R3+OWClsyLFxX66q2nbl8VhMiJGYkMv9yqSzZJMHTOEGSC74F/Ofw8
         NM0FxkP3SgN/st78O21bXtn7/z+IfNfEyqlc1B8bSyuGWoXy2YTY698OfxMkA7PJYtJ+
         xa3Q==
X-Gm-Message-State: AAQBX9d6Gt2xElyyo1ItH3XuAhohdae0+zzzXc+MxMSJQ12HnP7vNAwK
	rbQI5JrO2eg3XY5dDrYkVyW91FUs3u4AdmBN4fFC42gAN0A8g6nwHduPQ0xrm6iIPhIfkpeGDpj
	mSFbq9ZD8XjdsXovwlVE0OWxRyJIOPvmGEvk=
X-Received: by 2002:a4a:1187:0:b0:541:521:b527 with SMTP id 129-20020a4a1187000000b005410521b527mr198584ooc.7.1680547258079;
        Mon, 03 Apr 2023 11:40:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yjw6SX+mZhSvcqaOrhUXUnvCZA88w50+qKtKQMN6F8MzrhjcbntFSEGSL5GlXqrbUxSoQBeA==
X-Received: by 2002:a4a:1187:0:b0:541:521:b527 with SMTP id 129-20020a4a1187000000b005410521b527mr198576ooc.7.1680547257803;
        Mon, 03 Apr 2023 11:40:57 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:45:ae91:c478:3bf0? ([2600:6c64:4e7f:603b:45:ae91:c478:3bf0])
        by smtp.gmail.com with ESMTPSA id q40-20020a4a962b000000b0053b543b027bsm4255367ooi.42.2023.04.03.11.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:40:57 -0700 (PDT)
Message-ID: <02ba658226be85a2b5ea678116fdc4c3059b82a7.camel@redhat.com>
Subject: Re: Issue with discard with NVME and Infinibox Storage
From: Laurence Oberman <loberman@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: minlei@redhat.com, jmeneghi@redhat.com, "Hellwig, Christoph"
	 <hch@infradead.org>, axboe@fb.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Date: Mon, 03 Apr 2023 14:40:55 -0400
In-Reply-To: <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
	 <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
	 <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_114104_196213_1F4C8E72 
X-CRM114-Status: GOOD (  31.29  )
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

On Mon, 2023-04-03 at 14:18 -0400, Laurence Oberman wrote:
> On Mon, 2023-04-03 at 12:00 -0600, Keith Busch wrote:
> > On Mon, Apr 03, 2023 at 01:35:22PM -0400, Laurence Oberman wrote:
> > > Hello Ming and Christoph
> > >=20
> > > Issue with Infinibox storage
> > > ----------------------------
> > > Really discovered 2 issues here=20
> > >=20
> > > Issue 1
> > > Kernels 5.15 to 5.18 inclusive recognize the discard support on
> > > the
> > > Infinibox device but they fail in the nvme_setup_discard function
> > > call
> >=20
> > This first i ssue should be fixed with this commit:
> >=20
> > =C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it?id=3D37f0dc2ec78af0c3f35dd05578763de059f6fe77
> >=20
> > > Issue 2
> > > Trying to narrow this down.
> > > 5.19 and higher (6.3 included), no longer support discard on the
> > > Infinibox device and log this message so I cannot run the test
> > > for
> > > the
> > > discard issue
> > >=20
> > > [=C2=A0=C2=A0 35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
> > > 01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
> > > [=C2=A0=C2=A0 64.810437] XFS (nvme1n1): mounting with "discard" optio=
n, but
> > > the
> > > device does not support discard
> > > [=C2=A0=C2=A0 64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a3=
3f-
> > > 18cc-
> > > 4a26-894b-8b0f8d79a98a
> > >=20
> > > I then bisected between 5.18 and 5.19 to this commit
> > >=20
> > > 1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit
> >=20
> >=20
> > > commit 1a86924e4f464757546d7f7bdc469be237918395
> > > Author: Tom Yan <tom.ty89@gmail.com>
> > > Date:=C2=A0=C2=A0 Fri Apr 29 12:52:43 2022 +0800
> > >=20
> > > =C2=A0=C2=A0=C2=A0 nvme: fix interpretation of DMRSL
> > > =C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=C2=A0=C2=A0 DMRSLl is in the unit of logical blocks, while
> > > max_discard_sectors
> > > is
> > > =C2=A0=C2=A0=C2=A0 in the unit of "linux sector".
> > > =C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >=20
> > > =C2=A0drivers/nvme/host/core.c | 6 ++++--
> > > =C2=A0drivers/nvme/host/nvme.h | 1 +
> > > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > >=20
> > > Note that Infindat mentioned this in our case they logged with us
> > > They say they fully adhere to TP4040 MDTS.
> > > Towards NVMe-oF 2.0 specification, TP4040=C2=A0 - Max Data Transfer
> > > for
> > > non-
> > > IO Commands (MDTS) was released with additional fields to control
> > > these
> > > parameters.
> > > These parameters are supported in kernel versions 5.15 and
> > > above.=C2=A0
> > > ****
> > >=20
> > > Our storage target will reply with 0 for bit 2 of the ONCS,
> > > indicating
> > > UNMAP is supported based on the DMRL, DMRSL, and DMSL values.=20
> > > (older kernels will interpret these values as UNMAP NOT
> > > SUPPORTED)
> > >=20
> > >=20
> > > Let me know your thoughts please. for both issues
> >=20
> > The commit you found unconditionally sets the discard queue limit
> > to
> > the
> > reported DMRSL, so it sounds like your target is reporting DMRSL as
> > '0'. Prior
> > to that commit, we'd use that value only if it was non-zero. I hope
> > that helps.
> >=20
>=20
>=20
>=20
> Hello Keith,
> Many Thanks as always
> I will inform Infinidat and have them figure this out.
>=20
> Regards
> Laurence


Hi Keith=C2=A0
Closing the loop

The challenge was the other issue was masking me testing the fix.

I reverted that commit (1a86924e4f464757546d7f7bdc469be237918395) and
now the original test passes so we are good here.

Linux localhost.localdomain 6.3.0-rc4+ #13 SMP PREEMPT_DYNAMIC Mon Apr
3 13:40:21 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux

[   57.090328] nvme nvme1: new ctrl: NQN "nqn.2020-
01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
[   61.441213] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f-18cc-
4a26-894b-8b0f8d79a98a
[   64.627670] XFS (nvme1n1): Ending clean mount
[   64.665657] xfs filesystem being mounted at /data supports
timestamps until 2038 (0x7fffffff)

Then running the fio test passes with no issues so confirming the fix
you called out (Ming had mentioned this too) resolves the original
issue.


Infinidat will have to fix their DMRSL issue

Thanks folks

Regards as always
Laurence Oberman



