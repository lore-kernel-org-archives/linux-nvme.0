Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60395CAC5AA
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igceweOCMUo01raWQK/ovbjRIpCnrR1NxycWwuR/O60=; b=CM7VW2IBuJLAyAPkv7gyRWW1tt
	DzNxTPLyVo0dmFkI1Wm2ki3q5YNa15QBAEI7iyFXzxNWphusrK85jwjQ8A+wTWlosELM3G1I8gkTX
	Wl5YJ7GqoqD6VTDHbMKT2YQaB6KftzWBJ57NaumfKLGPT9GWYbtFdJZ4083o1botvfJeG3kl6JHFn
	srdphyS8FPhqGm7WL5yKg+gDcCnJNmWhlK+QbFlKBCWplOA91nCvhXJPvYi2uB3Dv6S3ZvWrv3M+L
	ch6pToSvblUgWylbijUCQ8TJVq4RN95f4Itn9rCs71DRroPcvn0c6cPAQ43okQlyjRqllDelZVio9
	bO2WPIiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0m03-0000000BKg1-2I0P;
	Mon, 22 Sep 2025 19:14:59 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0m01-0000000BKfe-0V0l
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 19:14:58 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so1542800b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 22 Sep 2025 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758568496; x=1759173296; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=igceweOCMUo01raWQK/ovbjRIpCnrR1NxycWwuR/O60=;
        b=MFTNcZ9N2C0CFH/9irEhdKRRoFHd6b32es2zhviZit4TgdwBlwCB7rA1p+HswodMW5
         jZ0j+OnLtWvBvVOc0Id9ZSbUgj12IVRoAvkl1jGr6EoNtTTTEPWJKuVaotGriYLQ6R0M
         OvbIWbi8pkq6awnptyG57Ksstg6gk2yNXlfPg7pC693i74XcGXoL84pDUgcZI8Uwm3FP
         JmKKGBkV06oN6IvBJCaCr1JfEuDdkrDEiykz823/It+4J4MgU5tasQpUXZquWYm2nD2C
         AYmOD6OLkavwQDtlb7x1NrjuRcoB8jQNR42bJlGmhuwkVB/hnuLQjmScgaW7xhtqy6jL
         1S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758568496; x=1759173296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igceweOCMUo01raWQK/ovbjRIpCnrR1NxycWwuR/O60=;
        b=kgRsDWatqVdICTRozL+C5/QBinll7YkGx2yfFXWsdbPepSlvfXevuSUcMGhMxtM+G1
         NHXLNHGuPrf8rTzlWlYA0ZGB9KE+VsW0hT87K5GCqp/VGYw0uP6gPJqJOwGHHl3NKJp8
         FEF6991FuKULmsyBvyd73vP2wxdXo/Zf9GFSuic2CPDuZLC91HB5qCp744g/2WgikxJc
         XltUExtyP6ycyVcJ5X8HB6mN7bR3cv8bjxhybuUpt81hs9kLJRVL3ocbwkAZjL4nZJxb
         4sI5Q1sBBKRAwIJ6JifhVit5p94+cQ1w8hLPhARnOhkuD3lsF4T7X7f4EYlOlchCj5K9
         88pw==
X-Forwarded-Encrypted: i=1; AJvYcCXUIN7hN+8b7F6W0GcaYNrahTqW3B1/o8qSl65dw4+2/ANzSyegTZEEHATfofGic/Cbb3lSasWHVX0T@lists.infradead.org
X-Gm-Message-State: AOJu0YxWzxBw49whAyRM7l5SX+mBMWPpbL9znY5sdqZov7P+qKZNOhUU
	Fn3jmgktvuZ2dpi6lDo5kVrO+yMnGOPmGDL0rgKSXRFwDQoiFOKI/8WZ
X-Gm-Gg: ASbGncueGD2WgHXWz30oq+08O2mZrevDRYjw3vJo2XMeP8bM1hVPHs2KlZxFMi2AwjT
	Roy8MuoQ0gQva8jw9q4KPunVwKdlBOlAyEiNNCGyuPoaJQ3GerLD7SP3gBCZaMJnUCP8bfLc+O/
	zDYokGhM6uCa9wueOEbaXv+QQTBTNiZL7fELMEy2zSFSCweJUHBXyLKdIcPP1BqD3auT5v4sWLK
	oEhGUVB0ZsXZERSTzqRmOoZnu49QBpUT8IF79AivccEcT5//d27KmOKtChscSrwXdFEO2Pe+u+j
	X1VFP8xGKGriMRpos/rPRfRlZuUCBiuexpps1zLVhjkm7wNu7ihDMgqfiUdmnXCoZ/kVkqxEsyV
	KWGxAJG3G4pSgzEmuYMAEPBlewjbhjhaW+WIILtjHO8KyL9PiGC43doUz
X-Google-Smtp-Source: AGHT+IGDFuwUlDsSB9ju6/PPjJ/63kYcYZlIDgfXQcsrHNZ+QkIbyD3yZ7bGXB9pDvb8VqcyTa917g==
X-Received: by 2002:a05:6a00:17a3:b0:77f:2ecc:8c9f with SMTP id d2e1a72fcca58-77f53b08ab9mr12104b3a.18.1758568496287;
        Mon, 22 Sep 2025 12:14:56 -0700 (PDT)
Received: from [10.0.2.15] (portal-nbc.netapp.com. [202.3.121.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm13182425b3a.28.2025.09.22.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:14:55 -0700 (PDT)
Message-ID: <a74d50723816faa5902fe08b42dc70e74b8c0ca5.camel@gmail.com>
Subject: Re: [PATCH v2] nvme-auth: update sc_c in host response
From: Martin George <martinus.gpy@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: hare@kernel.org, Prashanth Adurthi <prashana@netapp.com>
Date: Tue, 23 Sep 2025 00:44:52 +0530
In-Reply-To: <8638a12a5f221b874bb0ec54a5b0bf1bdc31131b.camel@gmail.com>
References: <20250908172457.5512-1-marting@netapp.com>
	 <32cffc9b-8be5-42db-bec2-871293c5549b@suse.de>
	 <8638a12a5f221b874bb0ec54a5b0bf1bdc31131b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_121457_162322_5EC10D31 
X-CRM114-Status: GOOD (  17.17  )
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

On Tue, 2025-09-16 at 17:11 +0530, Martin George wrote:
> On Tue, 2025-09-09 at 08:43 +0200, Hannes Reinecke wrote:
> > On 9/8/25 19:24, Martin George wrote:
> > > The sc_c field is currently not updated in the host response to
> > > the
> > > controller challenge leading to failures while attempting secure
> > > channel concatenation. Fix this by adding a new sc_c variable to
> > > the
> > > dhchap queue context structure which is appropriately set during
> > > negotiate and then used in the host response.
> > >=20
> > > Fixes: e88a7595b57f ("nvme-tcp: request secure channel
> > > concatenation")
> > > Signed-off-by: Martin George <marting@netapp.com>
> > > Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
> > > ---
> > > Changes in v2: set *buf to sc_c as suggested by Hannes
> > > ---
> > > =C2=A0 drivers/nvme/host/auth.c | 6 +++++-
> > > =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> >=20
> > Cheers,
> >=20
> > Hannes
>=20
> Gentle ping

Pinging again. Please review and provide feedback if any. Thanks.

-Martin


