Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8A1088E70
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 04:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x6U+h383hbtxIya/D6Y217NExz0Y/LsWlDjWtoNjy6I=; b=DZ/D6QkNaYy1fI8ew/y5pWoZB+
	G/EJpSA3E31OKeBzF/NIoAj7+lYQSiQvPd0UtT4oEyG8QizD5eCXeqq5rcHZ3mGSuuSbpQfX5mhJk
	Zt1vpQ+Matv641jvvOzxA2GvJkfg1VGnncxbImWPzUoAO5YTos6zrRO7IG6kL25QE3MSefNccLe7o
	HPUZRaCctSiaDBkvj16nwXjDdkpU7wEbreQg5MkEKqfIp84AAw3pRci6nyeMDjRSx4BNWyczzIhcw
	FNNDnAacvUfDJJbVIxnnS4nA1tSE/c6G7NCepNM5oDio4DPhhRM1u4l523a8UPqhTtvWk5cSaPOej
	65UGzM3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w34vo-00000009tip-2cBy;
	Thu, 19 Mar 2026 04:24:24 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w34vl-00000009tiS-3YGk
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 04:24:23 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b976536806cso74072566b.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2026 21:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773894260; cv=none;
        d=google.com; s=arc-20240605;
        b=koV+mFd9/znijEiQtVypOdykDtprYDol5szT8B3plPE2hgJvsEnODLT2AkNn61lsSy
         3L+mzq8P/r+2HLL7YdxvngdfD2M5gADiqwDe47LvvBEd/pFSveyx1n9RewL847O8WDYn
         MET2qWgKnn3C8oq8ORtqRQ2tozdM2AaxBW1832E/D7nTk/k62Egvvt7QOrznF23Ar3yK
         rmgiEu3xd56L6Hhw+HDhns8PFv9d6T9RJn4je8Ily/TkMIDE/wkkD5HF5RWix/Y9olXH
         7gbUdeuQk21MBnWpW37uAK1qK2vLRsBYdaQETgxACL5IkYJ6HyyU+nr4tK8dDplrzyBu
         A87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6U+h383hbtxIya/D6Y217NExz0Y/LsWlDjWtoNjy6I=;
        fh=ygfeI48c6pLEc5rf18j9XgibM//KnkDTVdiT9lPgSXs=;
        b=PZ0zxbLDi+JOxR2pUbBytwQQs0JcAPA6f+9N0cjMtxELaHnE9c8MgM4yzFR5BH82FG
         UClirZf8D1wo1RcL0eZglyzNOdctMCjX3yZhLgdo6sZoFhdu4x+JFCXNzxuaXfYZZKz1
         u+5BESv9Q9akPzFgrCO/6w7mBvvbx+jX5zAewYTYOCMLXN7ZXmoKRCO7lyGPzgy0gpNh
         mjJP8cD3e9207B1APW+lTsFGuxZtl6dVnAHhY41qbLGN2Ir5qnom6+v0SiCZwgZH/6uz
         S2cWQIeTVlfxSmbGGrzyei9Jv1ZQ6hUJwkP2QBGGc8dwxHjXXNFOFkqP63DLlWhNKEn1
         LM2g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773894260; x=1774499060; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6U+h383hbtxIya/D6Y217NExz0Y/LsWlDjWtoNjy6I=;
        b=JERTcpWK69omTKkWAbnLXYghh3U4FAtJo/IrnVBbbIqAMmvisbZA8gpg13WFcl/Se+
         f8hB2IE4x6AFdYfMM9yuS9zlBijqT1D9BdpVAt6E4yM3AieaTYfRkhTAF/DiMibROrxZ
         +x+oekm7GsDiaJpEQ//kDk3+8rlVzlSOAzFw8CY2WFq6qTrmqY8tSzMIscTmI5j6j4Ah
         PvhoHsiPLpekaHD4kkQlzKueqLQTHEXSxGTQLiCy4wOwePtisv2F5t6t2arveodVYMYh
         Tr3ymCYqLgAKoPLlLcpRgIC+8iPgtOp26Q9ZMW7F8oxqI6q7CB/bkpduyfqyVebBQz4T
         uEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773894260; x=1774499060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6U+h383hbtxIya/D6Y217NExz0Y/LsWlDjWtoNjy6I=;
        b=qo+U54IJ97GXeMKLTnhMP2ryK7CHlaMY70TQ7FJy2NvksXEZE2El17Zvk8yIAjgUf7
         aRNUXepCE4cEAIMMV4wbs/ZMB99O6Hvs5qS9dsN5HyX3AbpUmVst8+E6Txx8jNQCXT2I
         9/6ITMSfQ29WaBISdADEEJGE5RoaeBzCObhEJE3SO6tiOcJ3jLgAUuTUFhclkqbT6McH
         WHdW3al21Pa6/FBVIxIq3FpBkNJfEIuDHd8GZs3jksj72Sw/SaZ9hqRT4zT1zPXAf3PS
         LgEiFzSQNsHITW/qJi9216XcFkyzGaCco/BxsToOlWb7K482K7j2DHJGBIlRkBtAJw8K
         0aqA==
X-Forwarded-Encrypted: i=1; AJvYcCXqfJlczEGGleNRuqUXDS1zH5+0pH2+hYrW7UQseHPNlcp+7Dil2bYl7ZMb2jgb+famFTz3vJsny8ue@lists.infradead.org
X-Gm-Message-State: AOJu0YyNarWJpqJS0xQcX5JPfbT8kA/KyYlYKJHL6zeBXYq/KvP84lkv
	ED85gRy3WwbugRaLiY6sTGz6hw8SSc8XE8Nk4VjuIfOlPF8xcUNWXY0T1jYL1tqlT7ZR00r8XYH
	lI4MlD7stSYSWb3Vqvv+dvg/Mu/gVbgsroLpc
X-Gm-Gg: ATEYQzywnuCLCIa2nkh5uCgr9nhZUmwXUWQWhIJ3pp0b1Hk8WV8GgjOkLxNf4mmN+fD
	veLou3zo3oyPHI3UTcMkimsn/oCwKwFpf8Ij8iqncnwfz62thCEx//pStx1b9Oc2YHohHK95g+O
	DzpCOOL/v4QOAz/DidLpRDinBSSYVaulKE212oBBlgDI0CAh9EUVzHaf5M0MbDGPITR/p5Pbi8l
	0x7Au0Vtxh6tExaIgM8vU9cASjOUcHDRYmV8hFIQGjl8sD3s/hptxAiODngJMOSud/DuHh6364v
	Q7jceslKr3dXReB5TW/gyS8CkUizB1hEoP9vSw==
X-Received: by 2002:a17:906:209a:b0:b97:841c:6dbc with SMTP id
 a640c23a62f3a-b97f4a74871mr224948266b.29.1773894259653; Wed, 18 Mar 2026
 21:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260317031330.2794078-1-alistair.francis@wdc.com>
 <20260318-straw-snazzy-a8976b9c9427@redhat.com> <45828832-b084-4e2d-bfb1-751c4d18321e@suse.de>
In-Reply-To: <45828832-b084-4e2d-bfb1-751c4d18321e@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 14:23:52 +1000
X-Gm-Features: AaiRm52obm1fTOYV1jCL3GfRRUKbSWk6ynii-EME3GtVQRWnS8unWP3PMgd34gA
Message-ID: <CAKmqyKNohDf1X=RoD8WZKftjE8kGhQ2XkDXtTRPMSp5zyks9Eg@mail.gmail.com>
Subject: Re: [PATCH] nvme-auth: Include SC_C in RVAL controller hash
To: Hannes Reinecke <hare@suse.de>
Cc: Chris Leech <cleech@redhat.com>, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_212421_971755_B9052408 
X-CRM114-Status: GOOD (  16.87  )
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

On Thu, Mar 19, 2026 at 2:48=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 3/18/26 17:40, Chris Leech wrote:
> > On Tue, Mar 17, 2026 at 01:13:30PM +1000, alistair23@gmail.com wrote:
> >> From: Alistair Francis <alistair.francis@wdc.com>
> >>
> >> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> >> included in the Response Value (RVAL) hash and SC_C should be included=
.
> >> Currently we are hardcoding 0 instead of using the correct SC_C value.
> >>
> >> Update the host and target code to use the SC_C when calculating the
> >> RVAL instead of using 0.
> >
> > Am I correct in reading this, the current kernel implementation is out
> > of spec when doing secure channel concatenation (SC_C !=3D 0) with
> > bidirectional authentication (R1 takes SC_C into account, but not R2)?
> >
> I certainly never tested secure concatenation with bi-directional
> authentication (seem to have fallen into the same trap as Martin
> George). So the chance of regression is rather small.
> When you fix it, pleas add a test-case for blktests, too, such
> that we extend test coverage for this particular corner-case.

Ok, I'll add a blktest test-case

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

