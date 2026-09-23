Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D54C9830B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3bP9y62Oup4lvnhqrGRztmwfkpYx216ETMbJiizVEoA=; b=kluFXxshoXDpcSNjPpIxpnUg7e
	85BdMyO7MH88cA7dLj7egHSOXT0Bm1BV2yIsDE+Vcl0dg+GpnTXnT1+Desp4/zk+CuJFaeEBVCYNX
	TvRQYCY3Sx3O1NftKJdtLH6fIw8LEW1PgYxP/m6Xy8SFGPbbMIRPWOIGOb3dQ3Q0K3YgV4B0fxbIT
	HvUu3J84UALQF7PRuZCyLhlvx9VZSonS6ko1JU+Ux7dVJy1mNu+SE4bKwcHv4t3rhgQCAxNvX3uoM
	7o0/uCY7EWDt+eXg4ie+QcwLdPUIS6PPw3icdC2AxgHpPvkdqT1EeYIAbbZoMnhh9Jain2p6yMo6K
	W0/udjIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9PIH-00000008oLF-1Fh6;
	Wed, 23 Sep 2026 15:54:01 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9PIE-00000008oJN-1CtG
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 15:53:59 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so5819295e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790178835; x=1790783635; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3bP9y62Oup4lvnhqrGRztmwfkpYx216ETMbJiizVEoA=;
        b=S3ujTr4Z3KvHrmB/v4BHOZokySC9IqqBbQYllmgCDVRoZWMaFVCAT7WlRE//TdDNKZ
         6uJDsBF87P6X1EZ/Q5i4A4NR2ahl4sxTVBZQWoRlub1Gc3+TYOxa9+9k0veeoHuew0dl
         9k9Dbf7oi6pbcuEoEJu0qjV011t6VInNT1JCFhlsxEB2kYoLj3XJ+sMlxrkDaADsRuZV
         GK9nhXdsl/76LwVxfqPSiOxv4AZYiOH72H/i6pms8wGxDM0/OK8pK4gqqQT9cJS+Pj7d
         NFwOzDEdRLjrz0sKtCwHpxXYrurkwyNJy0FPunSRvJGCPnz32APKfrx2+jsWWtF9pJck
         rubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178835; x=1790783635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bP9y62Oup4lvnhqrGRztmwfkpYx216ETMbJiizVEoA=;
        b=Pj4lmPJF5raWihKrh4xYlW7fAGCmDDFmc2wGSHJaZg9U81oWff5WbTIXW0m9W8Dyxj
         7N/8Ni5oPJQSZV+0qzP2xG9XnoyhzFXf+fG3WZhMWVSDMxJjqRElX+NCkZYMkg9RZ8PP
         xKKg8WJiNgAHDNJP7nm7GIu8r5q2rCgMjFkxrsKTLEwtFPxedrzBhEfdsR2fbTM9k/Bi
         iZ0WestTsUKg3hTwycwi6B9VX8xHRoVutmESwho4GrZg4YcUzOWpV8iC2cZCJ+YW+Pk8
         g8DU1GbYFkhrXwG/pCYVEp9/SY/+o2pIjD1lBp4ss/xpetcvAleb/33/wGDxb5QG0jX+
         huQw==
X-Forwarded-Encrypted: i=1; AKwUvBxG8UidxO/molrMIxj6PoJt0pab9BtfGIqGbwOMvBXaI2Y7CLQTuN6c97Ds+nub13o9zSzIjacHzYV3@lists.infradead.org
X-Gm-Message-State: AFuF++mlqTf+FKBTLcU/BzC9MOBy+iERWamaEz5H35i0kaUNETZrIICB
	9k+QuqzxrZ+FRklHt3wyx/1zU6ZuO2HJCCZ4SWFi8WsjfSZd16Drv5r6YA5yQ04K3TM=
X-Gm-Gg: AYBFou3yTgyCu3CxUXKC64dnfWWSLmLbZVCB3YHzi9hSugNJ/Z+mGopx5MxkUkHjE4e
	hGDno6UbOHGcSOODK2ImNnn3OTnZkBXiPutiWVE1PfovFGpl60ysTjbeyD1MAThEgOSg4fRfFO4
	oQuA9xDC67cBjB8iPrmKme4oY2nATHgBDLQhH6vIRny+c6LiOOMPPnTcDITh1k7UAbOAbw3ZPUh
	qFqX0FCbaJdaKAqFrfoopJauio/XKTbthXRUbOl/WJL1pTlFpE7o8XXm57PzZzow70Jukrhhdk0
	mCRZdZAZCsFuvVvvW61rP0xtEjEHvuaUJcjH5ymKkKoWToVfaBoLn3bUeTdeIbqw4vD0LOLrvzX
	3mD/3rPC6x30OX9/ae9gi7wkCPPV/OZznk2tzmCBQLsOT9dccay4M7Hs2IULZCBMwKkKG0oEGh4
	J+nrnWLRyZyDJ95GGuQJjAIeIbSfew7byzQJvCk1SS0VUcBWtzw2g93QjPG6M5lCihPzNQ5opVF
	xheotMSfUht
X-Received: by 2002:a05:6000:490c:b0:487:a15:dbee with SMTP id ffacd0b85a97d-4886708e6f7mr4833638f8f.21.1790178835301;
        Wed, 23 Sep 2026 08:53:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684864c8sm7826188f8f.13.2026.09.23.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:53:54 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:53:53 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
Message-ID: <arP0TmdK3FnNfbwH@localhost.localdomain>
References: <20260923152653.40953-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzlqajg3mv3arfe4"
Content-Disposition: inline
In-Reply-To: <20260923152653.40953-1-yupeng0921@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_085358_405225_D08A7955 
X-CRM114-Status: GOOD (  15.00  )
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


--hzlqajg3mv3arfe4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 08:26:53AM -0700, Peng Yu <yupeng0921@gmail.com> wrote:
> Scenario:
> * Create multiple nvmet subsystems/namespaces.
> * The namespaces are backed by different LVM logical volumes.
> * Some of the logical volumes share the same physical volumes.

Why are LVMs mentioned? (The test scenario doesn't seem to use those.
And the example is backed by RAM, so where would be any IO to control at
all? Note: I'm only giving this part of my attention span.)

> * The subsystems are exported to different users.
> * We should provide each user a specific iops/bps quota, thus a noisy
>   neighbor won't impact the performance of other logical volumes.

Why cannot you place users into respective cgroups and configure
appropriate per-device limits?

Thanks for providing more context about the scenario so that I can
understand what's the goal and obstacle.

Michal

--hzlqajg3mv3arfe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCarP2CxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgvggD/d9gzMHzRXPo0QW3GozuS
6+GKtlUqeoMNLRjR4PNAct4BAOxZLhmoLgG4njhrXd22B3KrqQFIKeHLGaLL0g3u
KzkJ
=e8GX
-----END PGP SIGNATURE-----

--hzlqajg3mv3arfe4--

