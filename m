Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D215606A338
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jXkAfDZd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BpALniv2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U+3fADHBtsF/MrBXaBc49Q1q3VsfxuOMj2WMoEIQOns=; b=jXkAfDZd6IxV6b
	1qucrj5kSekD7NjGhqF1dp1jBoVz9F3FpbImbfTK61iqawX7IGPkjCTsKp/zVzY7gdzMC9IOU8my4
	eGVmXEd0zLKBLYfKIZEJ3vKaHcFufwua3B4qsu8SwOR607xEyJ6Y+0j/NT5lO6nRDmRPwNdzUsFce
	2nH4tCiXBp2QR0QO23hw4BGs1eDG3/xIWfa65yXrP34zkVDANaQVjYTZVtUpUUS7Mz9Oqwy48Skzy
	MnxsTWLLP5euV2SKUFoi6/zGvlLxl78qLQljRIPMY59Kw1DQdDpyCPvvfF5iiPVbBZehz5Ql0uSlk
	6HPVVB0aRPeXsEI/ARZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuae-0000000Dg7N-00nA;
	Fri, 13 Nov 2026 16:57:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuaa-0000000Dg6b-2Oc9
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 16:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+3fADHBtsF/MrBXaBc49Q1q3VsfxuOMj2WMoEIQOns=;
	b=BpALniv2RbHa4lPm41heSBFs/DC61RLRzcDeZzfvc8dR2zaCZnEijQ9N+Bt6cumqFqyUFV
	RaZoKRGV5Eeg8axyTYh8Z2oV2Y++6TQU0fL+uaOOJAwBM4g94Vl/aoJ5KS5nHhKHjUspr5
	7iofpwTJi2oORewCrxOREO3naHg8E4U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-jhs79_vMMm-wfQZr4FPizw-1; Fri, 13 Nov 2026 11:57:22 -0500
X-MC-Unique: jhs79_vMMm-wfQZr4FPizw-1
X-Mimecast-MFC-AGG-ID: jhs79_vMMm-wfQZr4FPizw_1794589041
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5364605e74bso13906541cf.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 08:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589041; x=1795193841;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+3fADHBtsF/MrBXaBc49Q1q3VsfxuOMj2WMoEIQOns=;
        b=gyTU8KMp3s7sC4nX96ZrrkV8mtWoG1yBnwptX4XwG5iqRXSvGHxSc6T56cYvqQ9Ex4
         kXOxrJHZ3qAj7PBAxrFrGWTG+Nw1xoeOsY2q5TUq1iV659A+SGTrkSWIqrjgkE23zFHa
         2D87mHvDz3bT3sc2FePbLVHydilIwCzRVhDiS4H0SztZz+Jx7nO8SFnzPlq13w9z0FyR
         hiA8kJzx7FhOPvdszEnCVNuPf/l3uFhJebt/t7Ec66h7LbDwZyOPQC0YOhnTs1tC9+mN
         /Smuf6OZl8C8NK7YWVQAuHvqntSKTTZ4AyrjDdDpMS7LGkBRQA5aFdHvWo3KaLip3zka
         j3+A==
X-Forwarded-Encrypted: i=1; AL+hErHjWCxg+0D95oHrYc/VStvx0NH3oQgp98eyw8yiz73WNfTTxBOMHqshxlyViOOfVoiTyUVueZaI8cTm@lists.infradead.org
X-Gm-Message-State: APuU4Z+tJT3doECGRKPXezqX9TsZCG4P2aqwVGbO/4j+IA3Zvwhe72jr
	9TcoXDw2D3PUwHUVR3LEwj872g4FH18lNO5GV4MmTdGb539TPzsSKeHJgNZTX4CNfHHGRQ64EJL
	RQnCkBs21OcvZrto0sh1bw/QPic2dAW9N0gI1e5DKeRDwdCM1NU0nBLDD4kGEE/eywlCK
X-Gm-Gg: AYBFou03XiY7XlkkKjWzGbs9LnX+phOk99Nln1Vkn8L5L3QoDjNd/Bu0LvGSdHtAq+U
	anhDT2THov6tNdqX8VQ0t8MsacBrtB+vYIdtm9qcdkCIZ/M7PCS0OTCr1CPA347a6fCLitIxADw
	VrJ0tcq2P4VfoT4iKQjXu9C0dH1W29LKc9ELGl2hgx5/CCQ2j9xHnEPd44z6HDXRhkuBp0vBBDP
	pOOEgF3sn+Da1LtOQ1NDUn8AE7qiKQwRmPllajLfePO88PSbxtmPFZ8592rkbWlUQ2zsox749OB
	FujrTSqPw2rxLkVA2o8Dxs9mEfu+CYwPCyqCn5rEeI/jRRyRI1nJbbb+Unipl0+VfgBEuMzope1
	l75K6wVZuMOcIsFupZrGtqb7beUFqO1/ydR6+QF0AV9tfOHEoN5PgWAnMLSxt0kmybP6ElEmYyt
	LUCC2B1vOYWtmRGS8LdNye6ulZ7gcMHUIMKhsl0yu5zVwphivoQm6aIoA2iJ96R2iMIih+oO4=
X-Received: by 2002:a05:622a:5b99:b0:533:9753:4e03 with SMTP id d75a77b69052e-55ac1234676mr51640251cf.0.1794589041498;
        Fri, 13 Nov 2026 08:57:21 -0800 (PST)
X-Received: by 2002:a05:622a:5b99:b0:533:9753:4e03 with SMTP id d75a77b69052e-55ac1234676mr51639761cf.0.1794589040871;
        Fri, 13 Nov 2026 08:57:20 -0800 (PST)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23c9ca2esm23837726d6.6.2026.11.13.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:57:20 -0800 (PST)
Message-ID: <3ae74838e0f72360398e69ec7e960abdb8bcce43.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] nvme-fabrics: bound reconnect_delay, kato and
 fast_io_fail_tmo
From: Laurence Oberman <loberman@redhat.com>
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Date: Fri, 13 Nov 2026 11:57:19 -0500
In-Reply-To: <20261113165002.12536-1-marting@netapp.com>
References: <20261113165002.12536-1-marting@netapp.com>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4lpnPBNTz1Hke8TfU2MqKVuiCqz4dTaA4KWOBXL3TMo_1794589041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_085724_689319_07E2EE16 
X-CRM114-Status: GOOD (  13.43  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-13 at 22:19 +0530, Martin George wrote:
> reconnect_delay, keep_alive_tmo (kato) and fast_io_fail_tmo are
> accepted=20
> in seconds but later multiplied by HZ (and, for kato, by 1000) in 32-
> bit=20
> arithmetic, so large values overflow and yield bogus timers. Bound
> all=20
> three at parse/store time so the conversions can't wrap.
>=20
> The target already does this for kato via NVMET_MAX_KATO, and the
> host=20
> recently fixed the same class for admin_timeout/io_timeout
> (4a5aeebf1a00)=20
> and partly for reconnect_delay (f92fe8dea19c).
>=20
> Changes since v1:
> =C2=A0- Add patch 3/3 bounding fast_io_fail_tmo, which is the same=20
> =C2=A0=C2=A0 "seconds * HZ" overflow class and was unbounded in both the =
parser
> =C2=A0=C2=A0 and the sysfs store (spotted by Laurence Oberman).
> =C2=A0- 2/3: reword the changelog to drop the inaccurate "1000 >=3D HZ"
> claim;=20
> =C2=A0=C2=A0 the bound is safe because kato is unsigned, so "kato * HZ" c=
annot
> wrap=20
> =C2=A0=C2=A0 even where HZ > 1000 (noted by Laurence Oberman). No code ch=
ange.
>=20
> Martin George (3):
> =C2=A0 nvme-fabrics: bound reconnect_delay to avoid overflow
> =C2=A0 nvme-fabrics: bound keep_alive_tmo to avoid overflow
> =C2=A0 nvme-fabrics: bound fast_io_fail_tmo to avoid overflow
>=20
> =C2=A0drivers/nvme/host/fabrics.c | 10 +++++++---
> =C2=A0drivers/nvme/host/sysfs.c=C2=A0=C2=A0 |=C2=A0 4 +++-
> =C2=A02 files changed, 10 insertions(+), 4 deletions(-)

Looks good.

For the V2 series
Reviewed-by: Laurence Oberman <loberman@redhat.com>


