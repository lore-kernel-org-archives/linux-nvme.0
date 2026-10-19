Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB1606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hGyUolBu;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Zi7Zdazr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fbdkiBRqceNsAEo7WpDOWPS1EXWmU9r7NLF53sieob0=; b=hGyUolBuv1+e4zZO+nQUFzRFbv
	NKU2WW00XBwcgscwmSQqE822egeaMkD6Z5X/2zZiUCou4SKptsFd0wHNQTcfzegDiZ5X5Y9tZ8ic/
	hVN1DwPAiDYohRSPQym5Ufz+lSXh/yibk1QTQK56yqEEd1mk8miFBepclp1NwSTruS45eliYx7P9Q
	oGRgQexZv7PaDi1ZvvRPqeSp97it9sW+I5Tff9+ekez0IAJTH/kHMD04NrGHO6bhCGzQClkOtvihi
	q9DJwFY32mhyuQFJSkXFF4Wz4uanWHzIiieVwySAD1iyaClHfvzz4KL8PpiutLBQ91LiXYgxx4b2z
	CgSaS4Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIv5d-00000008QGQ-05bf;
	Mon, 19 Oct 2026 21:40:17 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIv5a-00000008QFp-1qM9
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 21:40:15 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so75165f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792446012; x=1793050812; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbdkiBRqceNsAEo7WpDOWPS1EXWmU9r7NLF53sieob0=;
        b=Zi7ZdazrBdRsLe7un9DGBedeHqS4tQtD9uF+1njycE/FRDpWTcg/fbYpg+bNAKmHVC
         W76+E7OlGTCDJI130HSGq/sxH2VY7MSaj4h5ss9n6odIElWiLEbP52h771jQ3Yhdve/2
         E6kJyDI/8F0ygKBW67SH/dn1AO3kxu6xRewl7djxGqztBVm/vtg6+giO0csSnDKuSm1d
         rjVYn2ixh/AoId31WYh05pF2crhJSEZ/eoRLRl5goA6lzCSdx0oP1sDkGdA2oXKyGG/m
         ne0suZGqgbzTTDLwq/F6zhdSwyIh4YYZIlQYAzctVsgzWUSYLpF/hQMAjo05aqf31iOg
         j12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792446012; x=1793050812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fbdkiBRqceNsAEo7WpDOWPS1EXWmU9r7NLF53sieob0=;
        b=jEh/iEUvwTbkSB0Z1tWXXk6AMGsElV49tV3jsaj0l/9flj2Sdif+Z8fDBKU8DRd5dx
         eUXPXlN2hR81SQrL2omCk+nC0ty33Wbi+E5FVAwT+TponVgKVYOEPoffpiSSg42Q+/N7
         aKkKWhUoOUydviJMUbsSdprB31GFOGAoYPzdlw6n5StP8R+5vOO+gFWzKxuzZ7DMcvsj
         3sELKDD9jJkollp8WN88c6BhcibO5XNTWQQBTMjNykVdZlfx/s5ZUkuNecRfI6WPqRpn
         5BM+7chCfzNnQBrPgsiVOe0Nzg0Pt9pL9DkmGXfX2rYiG63G4Gk9bhzC0T6tOHvC9Ozw
         7TIw==
X-Forwarded-Encrypted: i=1; AKwUvBwgmccRzKWxjugUywUVC9CbUtpaOlM0Hs2VMrSNNMPLcutKFvO9ilsY1u48OOOzRJinyjy6ueqYgG4D@lists.infradead.org
X-Gm-Message-State: AFq9FYIauPkeDuhC2Z+jnUfxko0Nk05HkEJ9RgcCc+vjT+WXlquqP7E0
	jwR8PdlRMfnVPEopEZHO0Ix174TMnOnfd06+bMvyfCoknP8XOYnO7wKaqp296cxE+lw=
X-Gm-Gg: AYBFou33/YHLEhNsh6F3AdTv7NJk56dnFGPmFofUzpBWdwniWz+2nVJ7EEfmfXOCZRa
	ccNhl3oV7KIEoeqUQaf0I7uAM01eGnB350V++A9LwTRsVxaffDurqLTjjHmumIFQcobChau0F8b
	5NyV9yFyxnAIhTM8l7z9DPz0aBt9HBamBw2hcS/WXm3uABVtscksUXC8m4caSBeLLX5QIMPMEzR
	VLjC3pRwmZAwQCk3HeTcwJMMMLJMHslZIOypaF7H6pQN5VoB4d1Mcx8Z5I2ECWO1JfP1Wx2Vj+z
	geoTNJKp4LL4ZD9WQaZtaTrAw2RSKjk+9zMmS2hVqYYAcIj8+9irZaKhDZSC/NPCAA+DxEHR1M6
	yBwSYL6DXukv/l5cCA822IOl8Pv/TpPI8+dEoR4crd9NnFlROEj9G4rP5z0Bgq99E0QQFS2CLnq
	vi/JFSYDdGY5/txf2mY1CSWyEkNmK0iNenUJQHYdBdc+saaqDFMYWpI5iZNqeLTdiiy2X2KXk5B
	9qCvfniLh/MiM4T7Wvbtl+UAxZnGA==
X-Received: by 2002:a05:600c:2256:b0:4a1:e478:7878 with SMTP id 5b1f17b1804b1-4a1f53dce01mr4437525e9.18.1792446011568;
        Mon, 19 Oct 2026 14:40:11 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e1d83a338sm1464721f8f.59.2026.10.19.14.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:40:10 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:40:07 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <20261019214007.GO2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
 <ebc2064d-70d8-44c9-8230-5ba4b24cf5d9@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebc2064d-70d8-44c9-8230-5ba4b24cf5d9@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_144014_498742_07145A87 
X-CRM114-Status: GOOD (  20.35  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-10-19 19:18:32 +0200, Daniel Wagner wrote:
> On Mon, Oct 19, 2026 at 07:01:38PM +0200, Daniel Wagner wrote:
> > > --- a/drivers/nvme/host/sysfs.c
> > > +++ b/drivers/nvme/host/sysfs.c
> > > @@ -542,6 +542,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
> > >  	static const char *const state_name[] = {
> > >  		[NVME_CTRL_NEW]		= "new",
> > >  		[NVME_CTRL_LIVE]	= "live",
> > > +		[NVME_CTRL_FENCING]	= "fencing",
> > > +		[NVME_CTRL_FENCED]	= "fenced",
> > >  		[NVME_CTRL_RESETTING]	= "resetting",
> > >  		[NVME_CTRL_CONNECTING]	= "connecting",
> > >  		[NVME_CTRL_DELETING]	= "deleting",
> > 
> > The ABI documentation needs to be updated.
> 
> And while you’re at it, what’s the impact on blktests? I can’t quite
> recall what you presented during ALPSS regarding blktests. Is this
> covered?

Both [1] and [2] trigger "fencing" state. [1] focuses on not seeing
corruption while [2] also inspects kernel logs to make sure that CCR and
CQT are triggered when they should. There is no explict check of the
controller state in these tests. We know that CCR/CQT will happen in
"fencing" state though.

> 
> Keith, Christoph, and I are mostly concerned about this patch.
> Experience tells us that anyone touching the state machine will
> introduce regressions. Because of that, I’d really like to make sure the
> upstream testing side is covered. I know you’ve run tests in your lab,
> but we need test cases that everyone can execute in their own
> environments, and blktests is the right vehicle for that.
> 

I documented part of the testing I did in lab in my ALPSS slides [3].

I addition to [1] and [2], what kind of blktest you would like to see?
If you describe the blktest in detail I will implement it and put it for
review.

1- https://lore.kernel.org/all/20260917020752.1672578-1-mkhalfella@purestorage.com/
2- https://lore.kernel.org/all/20260921205951.3023714-1-mkhalfella@purestorage.com/
3- https://drive.google.com/file/d/17lt_H3FxeoDSWD8q32diO7e03JYJaimn/view?usp=drive_link

