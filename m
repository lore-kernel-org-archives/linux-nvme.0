Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA14C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrxP4ndUftOuFZ1StQ/yYeCNcw8ZxdOe573u3uyywGo=; b=xU2g2vUFt9l9kq3jq5oW0WAdF3
	u6/dFn9LtDtdUNPKqlrVxL+vvM0zC+8fLI5dRKSOrwpkRNUpkLSjky3BNl0YGJ3965j3/tSi9+Hmn
	y6UGNQjmsyPib1y+lhyzEWmP7F4QKlfHCp90f1w7E1jZg5GiPBVSNGAlEXMc8a9evYLzF19GEPfon
	alcRLH73kq3S5NZdybZdGRKwBb0mNUI/m1iyZEEqvpFxbtkFNIkDHLjbYNR78JQh5DEy7gU83gbaQ
	kE2KwdXCWUp6ZqyfOMqW5D9bzERdtupliAJOxa0vWHGyRNJNpX50fEOSS9A953D9f5DMlxQHIGLqv
	w2yHqJbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP3pr-0000000B18X-3A6B;
	Wed, 03 Jul 2024 17:32:03 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP3pp-0000000B17O-0L8r
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 17:32:02 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so347404a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720027920; x=1720632720; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrxP4ndUftOuFZ1StQ/yYeCNcw8ZxdOe573u3uyywGo=;
        b=HmZqqxQ0ix/dnA3RQBnaExgnCXoMuZEBIJ2bm2tduG9+dvGn6/9ArLPJknPnPTI1mT
         ltaaGyz0k47rhW2StrXyuXWqFrN07mfpmUg89kUpGOGY9QdZ6HRcbblPKxd4RNAvqpJl
         ZNrZXT9Txpse7ngOiwUqYzyaXIkh68nJFHwIih2QBjQpQCxnixiYGS9OBsOYoHzPsUBx
         vBrtdl5Cmoqrzs/GmtdC1ejjRaSIH1QukvIfX4Bl8yfkhwJabO3MCx5meKLlEolpkqcz
         iqm6ebzBrSfiuSaunmCDWhpHefyMBk8kXyLVpf8SoccMw9IxuhBJewVT1ZT2mt4W0C53
         xvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027920; x=1720632720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrxP4ndUftOuFZ1StQ/yYeCNcw8ZxdOe573u3uyywGo=;
        b=QjGRmtBWtUlK005Q+wxtUuqGTGO31uLGQr0IOH2eMiUP/ckbSWA5wAq/cLl0j1Odug
         77ebJ88VR771n+e7hTp6lBFtWazGA4J0BNIJyMPVPbxOcAGDclIAEzTw9rLWMjk5Ja6O
         ETQLRyZEjfCOpHAnMpVbNwZIIK20Nxayvtt7pyOQR10PRAT+qh9brQeJYB4rCrBSfibK
         enc22VdYOTaCU56nau93sGWfDbGPuYvcbEz4I9igd2kvrH8QIEgwJk9bK2TjrxRC4RD1
         1KYV+G7YJCqHS0NILIE0uvgbyievK6NR3CrbtfhI4Ze2nOKr9d5hI97oxZpOq12KmtR5
         WDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUh29ES0egsXajQJDeFt0Kv3HekmgSSJkS2se3vIldvfyy4F/s9khjOnl29AfdNWi0Kfxw2Lyr66QFkB4cnDsni0bXwD6ibTyGcepLSiw=
X-Gm-Message-State: AOJu0YxgbnsADOIL9Q6jI/4S/gWQdc9sfjzfMPghU28dhVgaYeg9HaPN
	MuaM9w+holt9BRRTWHZH4G05WY66LJ3lECzXgPdz5FYLgn4K0edp
X-Google-Smtp-Source: AGHT+IEtQuZZUImKNTldKfNJjFS9a1XS5KLWXz5R285EZSXZrze+MjRuT5+3ZfIbVqnOo+10xEkM8g==
X-Received: by 2002:a05:6a20:ce45:b0:1bd:4bb8:6509 with SMTP id adf61e73a8af0-1bef6224c5amr11918108637.55.1720027918532;
        Wed, 03 Jul 2024 10:31:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d1f77bcsm8418413a12.79.2024.07.03.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:31:58 -0700 (PDT)
Date: Wed, 3 Jul 2024 07:31:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] workqueue: introduce helper
 workqueue_unbound_affinity_scope()
Message-ID: <ZoWLDOEvoY0MfNHt@slm.duckdns.org>
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703135021.34143-4-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_103201_140454_BC80FC18 
X-CRM114-Status: GOOD (  15.72  )
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

Hello, Hannes.

On Wed, Jul 03, 2024 at 03:50:20PM +0200, Hannes Reinecke wrote:
> For drivers creating their own workqueue it might be useful to
> switch to the 'cpu' unbound affinity scope to keep the locality
> and reduce contention. As it's cumbersome to instruct the user
> how to switch to affinity scope from userland introduce a helper
> workqueue_unbound_affinity_scope() to let the driver set the
> affinity scope directly.

So, there's already apply_workqueue_attrs() to change the unbound workqueue
attributes including affinity scope. It's cumbersome to use because the
attribute structure has to be allocated and then freed. The alloc/free is
for the cpumasks, so if the API is too cumbersome, maybe we can just make
the cpumask part optional? ie. Allow using workqueue_attrs without going
through alloc if cpumasks don't need to be modified. There probably should
be a function to read attrs from a workqueue too.

Thanks.

-- 
tejun

