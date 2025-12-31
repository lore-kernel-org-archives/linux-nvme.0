Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CFEEB572
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2G5N3iRRZylV24gPMe/ewiYhKqx87GwpYl6Y8LOzVs=; b=JCp00cMWyv18tT8EFzvHTFw8gg
	eGa/B6hoa9/KRzq+8N93nLP/TgNylH96q18A1zhyKM//x2DQqqWJwibKCsGI6U/UXNhqyrn7t4lLg
	V5a4HzwNJh1tiaa3ZWigxDL9M71Dw4TfhQc2ZtK5OftIaNvzZqjCZT4OjSCwcCR+xZWNfsa3JPgFT
	D0mkl4uiHo57h4neY5z/F6IawhpzGPhy0eVcZ88H8fO5f1naczNk7ErttkbcJ07weQQXlxC1Pc0Af
	EYMM2We/IDdH7Mbrlyrr7g74r03VW6mWnCx6xMazdS0DajS+XS6HU8Pvnw69HQXks21q3fgLl0Zl1
	Q/wbafng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb5F9-00000006PgT-1VZ8;
	Wed, 31 Dec 2025 23:04:39 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb5F6-00000006Pg8-1fhR
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 23:04:37 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so12010246a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 15:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767222275; x=1767827075; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2G5N3iRRZylV24gPMe/ewiYhKqx87GwpYl6Y8LOzVs=;
        b=LHyBRzcxwko2qjz+SQiuRLB0qs9xc2Im3y9YtEQkiRAn8dXW6lHPxEN1P8PuT7KqRI
         oXLCvXBZ504yikywrFZAHZpHbYhpnfux1i01cvUF0IdDxFw2Q/h8zXU3p4QVDMNKyeB/
         M/U+PDn54zros1q0xqlyv4doMaPhCksAE5Xo7sMkSfG26EaZ6T2LNgjnbbb5iDSM2PkN
         d329aEz3xvf1JkvB5z/Nvr6l7Zjrd7m3ZT/kDj5jMqScYaajvREQG4uWb80QJfnRc1gj
         1hEi0G0EdOrnl1pp2xHStCxOEtUrIhBu0kDC9prAvUCeDKqQEwZUZaDeEpRrpkAB1mgS
         nRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767222275; x=1767827075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2G5N3iRRZylV24gPMe/ewiYhKqx87GwpYl6Y8LOzVs=;
        b=BqqkNmIZP5QD1gmMn/9cWZTDMzbxnqFoz2NnJKJZlQYBf0k7VKtASdHi/qGhAq+qpm
         W1y6KeGu+DgvkjAkg66mxXsvtDRbAfXA1MUWCvxgM+mC0V+SNGdRvPLUhbD3MDl+pLo+
         CFgmrrAT4bwl+au3GZhmCTTdAeRRYh1lTfTvMvymJQaZ08CLpq0joR3WwdV7xxvzUKmo
         MQsR764n6MDfhIZjbza8kJ/aZlvyg0tGHCs1QGo/2lgGbNa79KgOdljfV3fMvyoplGdW
         8RAEkTu9N/spoM457SNB9bnTkKzi9Da2t0VOLW4lz5urzi4heGkkdnry6FnXsHmNViEb
         8djg==
X-Forwarded-Encrypted: i=1; AJvYcCUKNDko33OZ/vWH1HQNxni7DgNzsQ16es0brwd1Na+G07zMw1wSh2DWHKfsetlKMCTYqrR5Ox6JfNf6@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0FHK60vVSepZmkl32nn7nJMpErPnmmMUwgS0MM+bAG0H4Af8n
	GiyMaXilhHkqyrcyRO7AbO7VYUPpnyhi5HRK0f/icJZSL4IKx0nb6yA8rWTEEYfBqco=
X-Gm-Gg: AY/fxX6vAtdYL0EPnZyFHj37otCf2EHdJ/Wse8e+uFb47Brf+E2pwaYeCNYqo+ExnJa
	54mhZb7eTtBfpjTpovJZeT845gHcqA+LiEXix3XDQC+WNxRRTWGjg5w8m/PyVUNUpk01ZGhlQyg
	CcPDg2YpdjffGpXY8nEo6CarwrxIbPSF3xoEVfhmBHEoFMlJl78lO6oNuDHnMSe4zXnECTrBG8v
	UorpWaDVXVNCdvO3fdwVxjMxM7jd80OB0AcazIrHeYylNXhTBoRV4LHrXbRuCy9CVufMBSh2v1g
	xRIwNGYPfFOGKj1a8gqi57bGnMYNFvFmJkRicxgyzu7WrR541Y8gbLcjtMwU6sOmYawBWykznih
	2yrWis8p09qJjbXuuxDvIxPuF9aja8WaQqasBzJ/d5XoYYDth6IVnO28IiRLswQ5dgqUbZ/0DHK
	Z6LkOOndpzSxM5RQLDuf9gluOfr7qqDaU=
X-Google-Smtp-Source: AGHT+IGrPhSy6rlcxOoTc/7hlT47oXmlqW8b7dhSxfG/6gsuoH6/fVFIyMvOVFBteaGYWU0asZoMnw==
X-Received: by 2002:a05:7022:42a1:b0:119:e569:f60b with SMTP id a92af1059eb24-121721aab79mr40439531c88.4.1767222275059;
        Wed, 31 Dec 2025 15:04:35 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b05fe5653esm84386956eec.1.2025.12.31.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 15:04:34 -0800 (PST)
Date: Wed, 31 Dec 2025 15:04:33 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
Message-ID: <20251231230433.GO3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
 <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
 <20251225171709.GA8129-mkhalfella@purestorage.com>
 <f627fab9-9d8b-4a05-b2fd-e951ebb17fba@grimberg.me>
 <20251231223652.GM3864520-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231223652.GM3864520-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_150436_443770_D185B76E 
X-CRM114-Status: GOOD (  19.31  )
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

On Wed 2025-12-31 14:36:53 -0800, Mohamed Khalfella wrote:
> On Sat 2025-12-27 11:55:01 +0200, Sagi Grimberg wrote:
> > 
> > 
> > On 25/12/2025 19:17, Mohamed Khalfella wrote:
> > > On Thu 2025-12-25 15:29:52 +0200, Sagi Grimberg wrote:
> > >>
> > >> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> > >>> Add NVME_CTRL_RECOVERING as a new controller state to be used when
> > >>> impacted controller is being recovered. A LIVE controller enters
> > >>> RECOVERING state when an IO error is encountered. While recovering
> > >>> inflight IOs will not be canceled if they timeout. These IOs will be
> > >>> canceled after recovery finishes. Also, while recovering a controller
> > >>> can not be reset or deleted. This is intentional because reset or delete
> > >>> will result in canceling inflight IOs. When recovery finishes, the
> > >>> impacted controller transitions from RECOVERING state to RESETTING state.
> > >>> Reset codepath takes care of queues teardown and inflight requests
> > >>> cancellation.
> > >> Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
> > >> or QUIESCING?
> > > Naming is hard. QUIESCING sounds better, I will renaming it to
> > > QUIESCING.
> > 
> > I actually think that FENCING is probably best to describe what the 
> > state is used for...
> 
> FENCING is used in HA clusters with persistent reservations. I find it
> confusing to use it here. Let me know if you have strong preference.

Nevermind, I will rename it to FENCING.

