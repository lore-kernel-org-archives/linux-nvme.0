Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AB7CA0EFA
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8AyYiZ1DRspvXal5ETzZ+ar5smxrk5R5JNKj9ucDghM=; b=laclCfr3Otf5lE0E5vhLEVQQsq
	J2w4xx7ksMG/nPDcKxpxc7TtLlIQ6dlO/mU+AE3r496D5m32A6HUavrrhDjZxaq6qQ8COxkmcko3k
	mSQj7XVTCPWcb9mZn3tYed5dwcmlwwHGnrGGf9Cu3mwa6s5argSrbjyEplBOKaaxnsp2f2WuhiPa6
	oe2kv8PozKuh0L205Mj0NgcPh3O+gixIXsRmzYKB+bTej9whk2bkYZOroEqykknWn6ZwhE+CWY3iB
	vDCZ/Rm9SPcSPs4jpPmArzY+dx2i7kCe4wUaZlFPAH4FegP0Eg6CMyDLtL7ETQ9A7bTvHvPO6gsAJ
	5wWfnM7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upkhS-00000004YJA-2jdA;
	Sat, 23 Aug 2025 09:38:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upixz-00000004Iye-0rsx
	for linux-nvme@lists.infradead.org;
	Sat, 23 Aug 2025 07:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755935228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AyYiZ1DRspvXal5ETzZ+ar5smxrk5R5JNKj9ucDghM=;
	b=U9k2q2K64JI9XXaxB3sneRkTDpqF+ogdJ74MQZKZTC+dU/wTroYj3kHAWz74AzIwr9K572
	eFfuw1UQQvnzhdurgUPH3dB2kp2wQqE3XBJvRkAIHI7UP//AfvFeALIGvwkgW3BawSYyEg
	KVgwN+VoIlR8OPYUkwJ23unaNfKucrA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-62eUlX4mM6iRBUnq4O2Itw-1; Sat, 23 Aug 2025 03:47:06 -0400
X-MC-Unique: 62eUlX4mM6iRBUnq4O2Itw-1
X-Mimecast-MFC-AGG-ID: 62eUlX4mM6iRBUnq4O2Itw_1755935225
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55f3b9e66fdso94222e87.2
        for <linux-nvme@lists.infradead.org>; Sat, 23 Aug 2025 00:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755935225; x=1756540025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AyYiZ1DRspvXal5ETzZ+ar5smxrk5R5JNKj9ucDghM=;
        b=fHNav+tpZlQRfabILF53+B99qqiv1nftVoTCDTNd6XtAnN9HrWa9sdTxkGNzo/IAGA
         fVKheiKOCsMEKMXxjAjz3x/jhFe9o9VmROkOG6v3CVdkEcOiiA2qImzD/mIhTuyOvCAJ
         /cPws9JMP21jQQDPjD49D4jkrZHlRGPs6S714Blo/IrSZnlxx/as/61qscZgXNpfBygM
         LeBnUE8ZZuSFVKmdUrqdk0ZlsmtIvffYXbWi5k+oFS5oE1dAFhjRJ3RrgNsw1C1rT+SS
         pVhz2Jiu+adJfaTfPrRHzVKf6l4VY5WqZ1Kuss9aQYetQgRbqAuZrOFXxXROu8/XSt6w
         8OJA==
X-Forwarded-Encrypted: i=1; AJvYcCW3D6G3HBA3WCdP8W6zyAsB1ZTTLEsrTwX8jCBxhvbag9ONyhOBQhp/6Rjk26xy8RR27w0klRnovLse@lists.infradead.org
X-Gm-Message-State: AOJu0YwngpY0d9FJguZgqs9JGauth2gA+7wg3DajKvYrpRRP5MEiq3MM
	WbQJNkEp6iGQzIUQcacQ+n2hkan1cFnsBnEr5+yIHIaGoCU32Rnus4Ba2FyzwHuSmKyjk3SPkrg
	LTrFsK0bEuljj9dJf9c7lhnSZiOVhn9mojTwSe4GtUlyf3RLsd4DkGXVlk83nkQZ3TF2/+1uod4
	9yOI1DRSyDl1lVvTglX6tp1x5A4/T9jr7ow1uKsVFGp80=
X-Gm-Gg: ASbGnctTKG+8DX8rVrSDgSdr2Ca4StwrLIjnIpYSIabMMMEgs0XV5mIFmEAd9IPPqLw
	hAMqxKcmdQNi17n5JkLdMzc5pxWvh63G2T56+orY5CL+8CHnCEysTzqd23WosuFPuhGaIOB4hJo
	8hE2IM803waNcj+aOJg7NyZQ==
X-Received: by 2002:a05:6512:3b13:b0:55b:8086:c496 with SMTP id 2adb3069b0e04-55f0d3ae560mr1937573e87.52.1755935224632;
        Sat, 23 Aug 2025 00:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5jwtLH07ld4CwlJWBU7vDwqWCf0gAL4JWhmA3EHN5jY+4HKrRXO9iuYcAQNKsQYnc2cUdRe2V0dYbttWAcdw=
X-Received: by 2002:a05:6512:3b13:b0:55b:8086:c496 with SMTP id
 2adb3069b0e04-55f0d3ae560mr1937566e87.52.1755935224200; Sat, 23 Aug 2025
 00:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <la7o2yjqljxt67an6kyo4qj76mwedxt7f7az24s52cb63obgfk@xcxhybk46qud> <85ddc96b-c9ee-4dea-b10c-ca44984442f9@nvidia.com>
In-Reply-To: <85ddc96b-c9ee-4dea-b10c-ca44984442f9@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 23 Aug 2025 15:46:51 +0800
X-Gm-Features: Ac12FXyPlzuGEGhbMiJvNTPyCUVXe9pLWcisX1EEkC00zRbc8OgdI7bJltTwUTs
Message-ID: <CAHj4cs99bsdOMCsriD81itfpHY5ZD+7EaFvi-EEhx+dNymxt6A@mail.gmail.com>
Subject: Re: blktests: _nvme_connect_subsys() improvement for RT kernel
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vCKLBPSQ1gfAjVBjXtywCzDRJBPO7EdHCYAdBw_O-iA_1755935225
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250823_004712_360010_97C38A9D 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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

On Thu, Aug 21, 2025 at 12:54=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 8/19/25 23:18, Shinichiro Kawasaki wrote:
> > FYI, Yi Zhang ran blktests on RT kernel and observed that several test =
cases in
> > nvme group failed. To avoid the failures, Yi worked on the blktests scr=
ipt
> > improvement which modified _nvme_connect_subsys() and some of nvme test=
 cases.
> > In case you are interested in the work, please take a look in the GitHu=
b PR [1].
> >
> > [1] https://github.com/linux-blktests/blktests/pull/194
>
> wow, Yi can you please post the patches here so everyone can take a look =
?

Yes, I've sent the patch to linux-nvme@ for review, thanks.

>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang


