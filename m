Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541AC1088E70
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 04:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWY5ogxQFG0MD2zNXgpQVrvKKbiufaHFYO8S1wwxync=; b=tJRssWKOG6aqlcgY/YMeTjhaOj
	fqeyzlzlx6DecCcht9hKqfVtlHXgOyxpB0u/6lBBRis1cTwJN8DQB+5+XWdhTYLIfuFx2sx1mE0G6
	JSK9SiXJy+4NaWPTmXX0Rf6jvmvDD6PGzTHxiXgU0ChF/t3+SHCiU5YEJm5rzb8UwDCx5Y/WFb+PU
	HmOyIaAQK/sqnOuqx/MDoAmax1EWg/aDGj9NE4u2QZWM8CQjnS2ihAY76X6Y/K91Jyb7t6A8mWQas
	fM41C87Q/oykoUgVRh+KtFKPFhZsVZpSvnTzzPXYnWZ+CEpHGK6FYzjySt2vOdWSaCfiNt4tfkdtL
	JwAJG0qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w35IA-00000009uf0-1xNb;
	Thu, 19 Mar 2026 04:47:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w35I8-00000009ueu-2Onx
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Mar 2026 04:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UWY5ogxQFG0MD2zNXgpQVrvKKbiufaHFYO8S1wwxync=; b=TuryIGRZfll823y/NRHQG63XXp
	AqqOCJc85stGhiX5hTiDdjnfj8BIV8wf1pESzsvKjXp/s3hCY9c6N2Mw8ROC6l+pvxk3FoUHZhjqg
	8wBPhMNP43XPIRma12N/i6beq2jzVBWF1gkGonDL8r9Z9WueYDxARbe3o6pKv1JJ5l/VO+8a3pREC
	8mGg7AyvM9EvYUye7Cw3b5dqocnEzClborczwvajeP7iGvVoJv7Pi6O/1P/rfnJbUXgw46eVH1bJD
	h02+XshH/w4reRvaaq9UmYgm7+1UBkLTqoTYbUOqYPc7SfM8ufsFg1uN4xeW4akB1rZBQxxfefIpE
	qxEKVueQ==;
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w35Hx-0000000CiwZ-1OZ6
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 04:47:26 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-b886fc047d5so83595466b.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2026 21:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773895635; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+c8mKCL0UfNLpLZDGFX+V1GI8bvZ+xsOgh9hNylKNiQFJb7L2d0cb+ehiQsaDSBjE
         2qfMcPkmrhfelG2b8OlvROX2gvquqjSnd2TCx4uYIQj5oVfQsLo10cN+oNwIOF3Ebufk
         uIxSmTbC3Qkxa8a1uOSxheyAhOsVYco3WOnnF7I/70+CKGancLpT1XtC+9UO1ZZVy5bo
         8K9xCB2aLzV8982RIrw+usyUV+hIRbCtJyCPByb3OivBbf9rOGOXPBGekPYS70mh2CgV
         vZ16rRa9ZR1M7JWA+HhNA05mLnkh9Vb0c/MTvqAMnNWOCklWLn7f5DzqkgLMAX/KvSMo
         gS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UWY5ogxQFG0MD2zNXgpQVrvKKbiufaHFYO8S1wwxync=;
        fh=C6EDT19p2EnVAh9YYIoGrMEkhEIpFNENkZm/10A85nE=;
        b=M3DZRyjbjIcbDYiiSlhBcHyJU3MPJHWT4VoX0yfR9N9XMAPE9xZ9mls9Gmdyvkvc7z
         pTAUP69Y2QcjqpS/fkUMrx9lmndJfIoQ4HbiLIvvTJ3iJjpVSZLuUlZnpkULyn9qG0Qt
         X2dFilzjV2ZSrzV3skWkty3vhcVzh2OV2ReXTAdSDu4OjApud22AT6K+FQSTUQPstRoK
         /1VnCG7yQl0hPsdV8bo3t5F5sQ/tWQXK7/milbHk/GtSYTX9nGSMYiL1R5tCTs3VkNwk
         gaLbgdNbLcwgo72U3h+rQKDfwNtaNG+vhVqrFELxRhubwsnYGXmQ0Z8ucoWbeVec7v8D
         hiPA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773895635; x=1774500435; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWY5ogxQFG0MD2zNXgpQVrvKKbiufaHFYO8S1wwxync=;
        b=cQvw9TJrwFYEhOD5gjXdSORB0mQKqI+XCWKSdb8vSBMeIg1xm06zvWZjiDhhLhFLCT
         vJFIRbOnbrTr0NLEOtUu6gqTYUF5ipMD6S+MSlpIhyRESr9MdUCYvkhYtdGaYcOcBS8M
         h23yG6yoFDugs5cnmTDpA5jScVGXDi22osDA7gAuaBWdPW+fhFz3CsHOuqhLTvquwddu
         JhGRKApwbPDiNvozBN5NyTqCZkI5b5jA52cuqaQ5q3jvS3ixbVwKpFKiYrLGCAh/Igsw
         kE/0x34tqneAZdhtlEhz8GbbQ9qhc7e+L+MMOL4IeMiBKkexui53MD3/1kkSOW7/gFDd
         qJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773895635; x=1774500435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWY5ogxQFG0MD2zNXgpQVrvKKbiufaHFYO8S1wwxync=;
        b=g2+HysL6Bgd8huTEFOQ8REAFlaAd1VXfR8SkAngQMivfSRe/Y1PWTUq3L7e5VWesnM
         7ijsSXT/X8ChtczYFMuHnCRWs4J/3EZ0d06wNZk+pa8Q6cQf/2GFCPAE4XXmF6CMnhqH
         WehAQ0c5n4jINKwG42P2YTzbls6kOlzgUHeVx0MAT+01Psa30N9X0Ey1LN9UGM/cVdc5
         Tk27EtA+WWKfYdVoRTxDgqh0dPtlVR1oQXTEKpPZJCeF3qcDd36yb47k3k24XyQE4u8q
         IVAHgb2fTe+d1QUEE4v5nAygwzOdftS4FZ97GZX55DRJHtM8pmqN8Dv3OgX9PymHIYTz
         VvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV20oM/F/0kmhOZhJa0rSB1hBgFZUOW8ii2F4TYKNx9D3QWBsBlJdHtS+Vgc9pl4xLxWYuaEWA0vAIQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwCTBNi1vmPT/tP4TUjvhP/IfP78dBoyPbW4JOUySMpRtvOZ25t
	/eO6Rd1XBqJB91dgNaS7P039uQow3VvLyn6LbKgx2iUf/m3ZF/EC5M//7zC3Xz1jH1oQTLFa09b
	nhCkBW07ibdt0hAGJrvjMV+M6uucLa8k=
X-Gm-Gg: ATEYQzxvygCD99zt+Yk5HL6nwDQoncCZG/bTTwe8cESjpcBtG1diVZhtCOyPG5h5Mpn
	LKOg95nLNFJDWN7LHq5AgLXYP1JU98WMycIoTshj3d47j3+JgKm2Ivt4cvgU2X1yGNlh6daKphw
	/fO9yxYhsj+fTEk7mKQ4NhxTa+T5NO9dqREYkjwhhKdK2YcjuQKatEXOqzag0GNQtfutwUgLHHQ
	9ek7Jsp4fSBjaA32DvtfTje2KApe7nSYdrCovgXrDRM/6MLHS071sTZQQ4pRTbO38U7zzpdPRqV
	s+0PGpaCUllO81uTYXcjO3p0wN0+7e7Z7ofx7A==
X-Received: by 2002:a17:906:cc8d:b0:b97:306a:cb56 with SMTP id
 a640c23a62f3a-b97f493bf6cmr251478366b.22.1773895635028; Wed, 18 Mar 2026
 21:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260318004658.3681991-1-alistair.francis@wdc.com>
 <20260318075655.GA25711@lst.de> <20260318-giveaway-lethargy-dbfa148ebbf0@redhat.com>
In-Reply-To: <20260318-giveaway-lethargy-dbfa148ebbf0@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 14:46:48 +1000
X-Gm-Features: AaiRm51tAUcbTMlheW7r5Zvhs4EnAmkvOClDDqpsiIi23KhMgN-pAyNdZLtIRag
Message-ID: <CAKmqyKMmW9L5-Op-ohbTk4NZ0mmJ1qb2Gc+HhR4Xf6nStnm53A@mail.gmail.com>
Subject: Re: [PATCH v3] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C
To: Chris Leech <cleech@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, yjshin0438@gmail.com, hare@suse.de, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>, 
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_044723_384098_F348C554 
X-CRM114-Status: GOOD (  20.54  )
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

On Thu, Mar 19, 2026 at 2:25=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> On Wed, Mar 18, 2026 at 08:56:55AM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 18, 2026 at 10:46:58AM +1000, alistair23@gmail.com wrote:
> > >
> > > +#define DH_GID_LIST_OFFSET 30
> >
> > Note that we have a target side patch ("nvmet: auth: validate dhchap id
> > list lengths") also adding defines related to this, but in a different
> > place and using different naming:
> >
> >
> > +#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
> > +#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
> >
> > Back in the day we usually did nvme.h patch separately to handle these
> > kinds of conflicts a little better.
> >
> > YunJe/Alistair, maybe whoever resends next should split this out,
> > add all the required values and add a pointer to the spec?
>
> Is there a good reason to keep a single idlist[60] in the struct
> defintiion and need this offset at all? Or can we repalce it with
> somthing like haidlist[30], dhidlist[30]?
>
> NVMe base spec r2.3 section is 8.3.5.5.2, where these are seperate
> fields named HashIDList and DHgIDList.

The 2.1 spec kind of implies a single array with an offset of 33 for
the DHgIDList, which I assume is why this was written the way it is.

I'm open to changing it if people free strongly though

Alistair

>
> - Chris
>

