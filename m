Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21589C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zz2eNH3ByABvVgHFT0hkzZRhLZmSUzNFJzczzdfYHaw=; b=mPPJ/YWZ1MI2FBzgFqLmX+nCNt
	lbD2YsXvE+f/FZ56Ty++aoJbY7AWQZfHjrpr4BQU4vnWS4+fmBe8ecqnTOMPGuV1AxZcDbSAGGDWt
	U5BiMpRPFyGNgUBYhVfV1OzNMNyjE7XX4KRCrFkFp7czlDMWPScsocuTrHPH/5UpfHk9xSslNRyei
	q9KcXQgvFa4Zd2ejQiFR2ZpdH7Hl3dOIEDYtqYzwpAnwDdiJwJW34blqjwXEsmGwDXQXD05iKtEDB
	sihR1OnN3mAuSLb1x7+D5Tg5/k4oqbII7JEBtpzV4SXk9OI0JIB6TnnisWR5gTTRGUK5kkUnu7SP9
	4OWRGxjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riEig-000000053HH-2XPG;
	Thu, 07 Mar 2024 14:27:38 +0000
Received: from mail-oa1-f53.google.com ([209.85.160.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riEic-000000053Fj-2CLG
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 14:27:36 +0000
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22187576d54so154611fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 06:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821653; x=1710426453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz2eNH3ByABvVgHFT0hkzZRhLZmSUzNFJzczzdfYHaw=;
        b=smb0avmxx8olE7paPKTOb4BIK/KXoG//yLPL3nHyiBMLlBM37DE2Q+QtNLAg2OWjMr
         HHp06VQLgpu2gudVJiZeyWcyX3413/Y45RKAMnpB/alPZUhPcnI+DRo3wfBwCTKlxQ3f
         0Vs41caEQTBe7UEiyyxYvIRPxqRy840OLA4ol9i4fJbeNSP97SmOvjoYinPoZYoAbj8a
         H47vuHXqUTkUipt2GJ/s6kHnALAP7uzKLc6z+1uxB1beP53sLhsLmK9azZgAMN3AdyvK
         Im+YT/9fkhlYHLrsp+BhIllohRM133mH/2s9eqvL7lvxJ1Iu1j0wjzyTKLp2SR2QMR+k
         j63Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9LmbBNmmdzaKd1eqhPRF4RsVM8q8guVQqHpoirtr/8tZQr8YkyVZH8CdbVzpQTrfEDTbg68YcV1KI3RvuURh84U4IQyizGG+bY5vG4iI=
X-Gm-Message-State: AOJu0YyyPZokkOvy/HyRS8IlhuIS0J4UtMQ+vCsmwIH/N+6YwsWFvKmF
	84GTfHqLCgd2oTDZSZaT7KGNaglGX3SUBJhjOI1/badCKPQtxSAuKdHjQSDuV7RxT9SLmwVFsBD
	sI35I3+ERPK5qqHbFbIqNp+41vHw=
X-Google-Smtp-Source: AGHT+IGqfSUTe7mCD0pnZ/JliykSKoembhWqBxpNjNgmBqhFl8UiprBe2mqJOT+9O7kdEW/FaIX7LFRTHGa5Bc1mBEU=
X-Received: by 2002:a05:6870:3123:b0:21f:d2e1:c93c with SMTP id
 v35-20020a056870312300b0021fd2e1c93cmr8436495oaa.45.1709821653127; Thu, 07
 Mar 2024 06:27:33 -0800 (PST)
MIME-Version: 1.0
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
In-Reply-To: <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 7 Mar 2024 09:27:21 -0500
Message-ID: <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown timeout
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, maxg@mellanox.com, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_062734_593511_039B0D7F 
X-CRM114-Status: GOOD (  15.83  )
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

On Thu, Mar 7, 2024 at 4:29=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com> =
wrote:

> > Some words are alarming in routine kernel messages.
> > "timeout" is one of them...
> >
> > Here NVME is routinely setting a timeout value,
> > rather than reporting that a timeout has occurred.
>
> No.
> see the original commit message
>
> "When an NVMe controller reports RTD3 Entry Latency larger than the
> value of shutdown_timeout module parameter, we update the
> shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
> informational debug level instead of a warning level for it."
>
> So this is not a routine flow. This informs users about using a
> different value than the module param they set.

I have machines in automated testing.
Those machines have zero module params.
This message appears in their dmesg 100% of the time,
and our dmesg scanner complains about them 100% of the time.

Is this a bug in the NVME hardware or software?

If yes, I'll be happy to help  debug it.

If no, then exactly what action is the informed user supposed to take
upon seeing this message?

If none, then the message serves no purpose and should be deleted entirely.

thank you,

Len Brown, Intel

