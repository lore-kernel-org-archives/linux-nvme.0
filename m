Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C7606A31F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BVdVHaCl;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bY0+hOPM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sBAvFW7bzMhExUP83iqtexbgaAfC2c8EaagREmHvjoQ=; b=BVdVHaClyAhz+3
	p3QUlWepDQCX9hIjbRt50VpgMuN1WRi7Ol3xjyiFAKMRVC9dMXC3OXuKhGGvhns4Ywl1te91Uvxnc
	DTxWzxcKqbvpxQV51gaamDpslMYU4xZY3sKdVxTSYa5sLDR1gNoU6QI/k7zvXBZ82Vj34DInTQbX+
	bh++iWJXJA8hCW6C7PsfOPMwxIHoAJDraPj+XsPnokb73y2RvzDLyB+TtkNVr04g0XrSrq2DLV9vw
	YXJxz4hOxtiPQPdG0rKgw8f8WPuxBNbEyFShxFj3qB92KHPqtg5rTNG4VvdQKXUBzVLLhxupbzMnl
	C44b9nf78Hod9zNDJwKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKFpt-0000000GSZY-07hs;
	Fri, 23 Oct 2026 14:01:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKFpq-0000000GSYF-1duw
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 14:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792764087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBAvFW7bzMhExUP83iqtexbgaAfC2c8EaagREmHvjoQ=;
	b=bY0+hOPMWC5yxpFaNqYaIn1t/woqEE3wAU7wZn/wgr5rXYubmjo//fG0YPf9T8v9SIPsyF
	PK5liVshuM9/hZNU338pCAMeSj7Yz3yUIt2gIhpKCXw15/I7EzNkSa+aCTuEIU9HqPbATu
	SrYeJt+skc327zmPMZ3SnWAwt4/SAKw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-YOwbUgl_MfCVtm5NPd3dFA-1; Fri, 23 Oct 2026 10:01:17 -0400
X-MC-Unique: YOwbUgl_MfCVtm5NPd3dFA-1
X-Mimecast-MFC-AGG-ID: YOwbUgl_MfCVtm5NPd3dFA_1792764076
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9179a2035a4so42942606d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764076; x=1793368876;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBAvFW7bzMhExUP83iqtexbgaAfC2c8EaagREmHvjoQ=;
        b=X1oYvZtA1qRPyoC9NmoWGZSchFyuKM2jUygaqBWlyz1N8L1uD0zCDD8TSydqEFva9k
         8kYNDDbUOumTAxrJaL8dyldaCr+lAhToG71yeeEcqSvHSWf/teZFcVfY/moKz78Ztivb
         PCnb+vBi9Zi7hDAVDsyjge2bOU8p0sJgAW6iPEy/IIoVU3OI7kIaEofwrJW9RhbaugEx
         uM7c23LXZndDDkM9APCWfybZQgbnvkW3eoE4seOoGE2DAC2dyYXsLzijDGOX//gwsVrQ
         K5jb3czWcUfhSoyMQrKp9I791LAJ40b/JJ4yOYPRxELPvfl68YaGTkzPPMTRR9Rq0uPe
         YyoQ==
X-Gm-Message-State: AFq9FYK4vz7UTp1HBBTWHRC24uibASoT9BSWZ92GxCRHPeYdKzb9g1YP
	HVDxBdlDI8XCRl0our8WTd7Jk19KMFH2+KHS2qcX/2vwL3W6JXH7fEq1HLhJjrD1NaVSSzNeog3
	6pA5OeasYpP88u8d31g1cl0M2TxAya5d2QUHJmsA2sRueXzqnDlt+dUilJOHXrjlF2hVU
X-Gm-Gg: AYBFou0zF976gtnouqSuDd190QLMbgBrj4D/lb4pHVi58hyL3aKZwRjZv55bxnOR+mp
	g4Vi9EoNP2cgms8joNCVWphgsWKwZX32L0jW9w6xeW+6x+I6ds7G/IFs0II1Pt7l9E3527fO2iv
	FFZlAnAjIiQTXHK2d+HgwOdz/lxyPnSWCkvkv8CRIb5c5PUfhl03ONxseI7A/4wYar5iUFlGS0E
	oaw0k2ReClAzxI/POa5Qc+OFF5NfApC6v9aNsuPPg2ELGbie2Yw74zRCYKTrHTXeIWuyyP3V1vG
	c1h09dCNMvZi12e5F7RrqCNQPgkDvyYDW7qzTwfBi3XasFcjRDjWIMezzS5KTl+a2Q3lqulS7za
	o4k37D9XJvL4pzNbMbL35vqbOd7sMCw85oh8X
X-Received: by 2002:a05:6214:5288:b0:91b:5d39:e137 with SMTP id 6a1803df08f44-91c23446dcamr91085076d6.34.1792764076274;
        Fri, 23 Oct 2026 07:01:16 -0700 (PDT)
X-Received: by 2002:a05:6214:5288:b0:91b:5d39:e137 with SMTP id 6a1803df08f44-91c23446dcamr91084126d6.34.1792764075384;
        Fri, 23 Oct 2026 07:01:15 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c450b122fsm2439396d6.2.2026.10.23.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:01:14 -0700 (PDT)
Message-ID: <41702ce74457dec608620f4b5ba9e7ff5ab482d8.camel@redhat.com>
Subject: Re: [PATCH 0/2] Fix for nvme quirks module parameter
From: Laurence Oberman <loberman@redhat.com>
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 dwagner@suse.de
Date: Fri, 23 Oct 2026 10:01:13 -0400
In-Reply-To: <20261023094806.944563-1-mlombard@redhat.com>
References: <20261023094806.944563-1-mlombard@redhat.com>
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xfCg79yiyongPiQSY1oT0KmY2eiJIlxZ3tQrJ8ZRcww_1792764076
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_070130_624689_B629FB42 
X-CRM114-Status: GOOD (  11.13  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-23 at 11:48 +0200, Maurizio Lombardi wrote:
> The first patch fixes a boot hang when nvme-pci is built-in in the
> kernel, reported by Ramon Jesus Miranda here:
> https://lore.kernel.org/linux-nvme/20261018155426.1299676-1-ramonjesusmir=
anda@gmail.com/
>=20
> The second patch increases the quirks parameter's buffer.
>=20
> Maurizio Lombardi (2):
> =C2=A0 nvme-pci: fix early boot hang with nvme.quirks=3D parameter
> =C2=A0 nvme-pci: increase quirks_param buffer size to 256 bytes
>=20
> =C2=A0drivers/nvme/host/pci.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

Unless I am missing something, this looks good to me and i know it was
already tested.

For the series
Reviewed-by: Laurence Oberman <loberman@redhat.com>


