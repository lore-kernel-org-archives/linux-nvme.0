Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217C7CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 02:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODkJjmMveWd1Ds6+LgEGIz8GqVc0G5GcHZLt+F+UsUo=; b=FvFxaaZDp7AZ9Sd/ru8UAVTFdu
	bqooam3wzr8cCeHHyFNmU5VCtA6qB8fqeQiSfSouoPLKRx2+YquyH15F6Phl8oi3TQXdakSv4JRXX
	edNpunRq72foaG3yj49Vt7CDcsx6MA8ekbZwsz8V1SQH+HSvx+XoMiCLjXuIZRVhA4aSY4rsJ4e3V
	aXK3mlNXsSFq7xXHa/0lD67BBD/NmXmn2maeai+Ct3BnOMJSlpBP+ku7NDXK3k8345a0VSTh8e5bh
	mbMFNv0pW7wiNxV3dRdd/3cB382162OJXCKxLuRV2Im+Hwrx9cZpyjuxdvDSXHDyKPvjiHjVs3p7j
	k5xjIKFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNhyO-000000075Di-24Mw;
	Fri, 15 May 2026 02:08:20 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNhyM-000000075DJ-0rkB
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 02:08:19 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-63133de7abcso2526814137.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 19:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778810897; cv=none;
        d=google.com; s=arc-20240605;
        b=hU0bpZQo8ejP9h4/9MxzdBy6afPB+NTncCgVJA1IFf7U1X5mwNXP+9Ilss5kfohkff
         od1Y9dKt9hqIgdv8FCDMhtdut1Xn6zoiIeTld6Ic+BU7v2JRhI8D4Adt0EnUjcT/WkPQ
         a1d9eUSCxHix4YeoaBjxNqxCUBK1rh7WGySl/TWtHQTBVVGfXzTkk7V+JJXWAYQhE4Lu
         TytvCsntwTmi/Po/UbwhhH0ctPS+UC/Qc2TmVz0OY8cdP1eYWjJU/9tFGwzqLd3uLNmy
         Tq5UsNKGteUYw5aL+tTdJxuH7MlXVlGqZL169L6VSentDq8zWThrX52SYBZ+7w1nD6RR
         YccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODkJjmMveWd1Ds6+LgEGIz8GqVc0G5GcHZLt+F+UsUo=;
        fh=PrGPUihC6MWQf64nTB5bYpPXqVkPTY4qJVsg9MMpHJ0=;
        b=j4NXDmaydsaAIGYZztZPpiWEsnMssa/5YokQ2luDojgLxLH8gmYQhprPh6Z6G32xRY
         iNsbDMzEsrBRQNgfVNhsN0bR85V/ws8X1ARzOG4yihrdaxrUQDtQarGtCffnA+2OSRPx
         Kw2P9vYefZ7w7rqIw7/1G5FYBSRIlCDJIy2008y7eWAzB6Lryg3tCGJT4aidcGno5EBf
         I2yBwaESi/4whkGnaEk2svklSRv9bg0WsnLtGCx6P6jQOe1btq1TPWTUeOcNC2EBJkwH
         t3sMlMShnVPt/Z2hKVQvfNEJrKpUgMePEw+q+Tyhze0bNIQVlFAiL9qDAJMT0nO1sP6x
         yNiQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778810897; x=1779415697; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODkJjmMveWd1Ds6+LgEGIz8GqVc0G5GcHZLt+F+UsUo=;
        b=YRcxEVL6fCM7oez1ZLFfBppGAoKQH/gZ/YLUuZ37YwvvkZE98RaP3xGnCxBDSDWAYX
         m7Pwrl/fuoiObVbBFymH7WARByJALLT8oewhUhMuhTqqUYQ50q58rGoIqekikaR4dvSQ
         ia3o0cnoDBxQahiCwQocwI8lY+faMm0Kp6VO1q58zIGivzSwmJm7rsHuPEjuJ/W52hkA
         nLPZ1Zsuni0t+zukSG8p4B8gkx4RSSRoryFolzUI/qIiCXvdSSFugdgb4KjWDaI0VTg5
         0jpo8BnDkMzhwGqZB0WiOCIH6pkE39bjr+rqQbxjtKzFVjO5nabKoh05fEXjoRRpDTyS
         ngtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778810897; x=1779415697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODkJjmMveWd1Ds6+LgEGIz8GqVc0G5GcHZLt+F+UsUo=;
        b=hzZfPXtFhVog/J0B32hQf/tBEvugo6Zn3ypHzaqjwFJmsXE1cWHVpv6jCdGjQAvGH8
         KqBcClvAWULHKi34K9ILtDcGD71hWfppHanfvBUiw94A0ua2Wk6Co8QoBErPS35rN9rO
         BF4LfFzBfbyNOqGZyZCpWY+h5+cP9KK5QhBjRBRgvzy+ubAf8sg+fXWk5w3XpO0zjSiw
         mwL/hoKIzE8eU3S+lEdVRK0f6l6T9t98Og/Eq8F7ijaYyIc9dnb0jCquRxbUL9bJl6IT
         Xd1K2VcU5lFJWRoRNZs08gwHPqeiYc8GwVSYUPpnQSIKeNroZejJVNb5bkskz7pI93jv
         16rw==
X-Forwarded-Encrypted: i=1; AFNElJ8YEOKdePe1Wv1BMnxMCd3UlHdgZx0gnTsPhkhF594ioRf4mp3Hsl89QhMea/SCufi9PAh0kJOfOv6W@lists.infradead.org
X-Gm-Message-State: AOJu0YyKWRNl8/VVCF2ewxgqU+rV0dhjJ16ACjYPjfPtZ9KySaMxR+pQ
	3JjVKyZIYAwMHO1hcgWd0DnmYdkvs/v2R/0hinKFM4tY7M8KB3FkOK75LRksKLE+zez9L1xKmWc
	RGuS5wzIn/F8iDk1j2MR8XFfyVZ14FT0T/c6P/dEtaw==
X-Gm-Gg: Acq92OErwmIlPnyNO0Xt5YavoOYvFwSZuZRvRscdFzDuMQZ1NYxp56WqHKgdWIX7CRq
	fRn7aOh2f8Xx5x6T+Hw+d2eV8qmVzRFOQHFYTg2CQfe3cLpxHK78Xpo3KgjL+DUzerZqsdrk26C
	xG20sa8DoJQ9v7Ju919nUzacTJT4WBUHa1Vb4PA1YKcyGy81VWFL6JBbIt74qyobJ5R5CIxaeVX
	xq8IULdbMUfaybHxQNNjU+CYJ2cIL+RwjoO8QOLDrGnYanY2FkyNZZT2yizciwfCPvosMEXqvca
	h/TPfxH1+jSQ+uGZOYirQULVFj6uPKyQMqQDAxOJcJdPlGx9ndhzPSAzI7c8L2JHZwdEwQ==
X-Received: by 2002:a05:6102:8012:b0:631:7781:fe93 with SMTP id
 ada2fe7eead31-63a3ec85e08mr949892137.19.1778810896882; Thu, 14 May 2026
 19:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-2-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-2-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 19:08:06 -0700
X-Gm-Features: AVHnY4JAppppANswTtsygh2iV7M5GGmXk9bMLM-nznWzqMMwgqcIU5dw7d6bRZ4
Message-ID: <CAPpK+O0CG4oZiwPBEFWDXz1mhfk5qpBEB6QWt6nHGCkCgTSaDA@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_190818_255728_723460E4 
X-CRM114-Status: UNSURE (   6.78  )
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

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> TP8028 Rapid Path Failure Recovery defined new fields in controller
> identify response. The newly defined fields are:
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

