Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E0C282D1
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Mar 2025 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PDWzcbxIvlIvGTw93dXaxSEzESqsRSQBbR/NvExKmkg=; b=h0tZXzYpiKbNSitvtxp9iZVl5J
	C2ObU/fcPxvOhwmAthrEcYwpVSzFzkObsTNIhx20G/dCGc5857s5HnkIkN0YeJqw+lg9G7ynU1ltb
	wZnekZKE9gGpfSzZMi1DxRaQCKkDtTF9o5xsbL6MBa29KPYYXBipVtJU+TPljbNwIjDuCECUyLvM0
	mlOcpqs2Z1a3Sr1qPVlHaTVMXQL26lXRJ491zVoo6Wlwa7wenVAZoRtN8YVvG5vTLDqbynaWaVOW/
	ZoOvm65GedM9hqrVKXk4Wegf93EC3qTO6V2NdZXm8o5f+GxNcy1nkFQcQUCCZXzYBIjuIdE6ZcRdT
	e6+BasQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tohpW-0000000Fw4V-1wXS;
	Sun, 02 Mar 2025 11:49:58 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tohpT-0000000Fw3s-0a8u
	for linux-nvme@lists.infradead.org;
	Sun, 02 Mar 2025 11:49:56 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so33372805e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Mar 2025 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740916193; x=1741520993; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDWzcbxIvlIvGTw93dXaxSEzESqsRSQBbR/NvExKmkg=;
        b=NIVDLHcwag3qIOTSyzj92mPFzw1pzLA6AX3jh6xGJJvPy05w5Uy8Se/c0fd70fSSsf
         hFZnxcu1D6N73QuYdVsKR7lMvTLUaNki/eMVDYOh1j0a5c5dHCqbASO8U6+SgJ/Oo71I
         o+7k9u1xfYxwFGe2NFQezB5k7D+xEGWxL1SLzuY+dLxzSZx45XH2EnThI8ExYsEUIpCq
         2+xvwIhvsSjfRWfpOnrokdbm1FM8+Zo78oejkARa49O74h0mpz7m45sbzefwF0a8NgoH
         x/SoL4fTqfJMkQQ6kT+0+Y8HOw1cU/tX2fk/wV+5vEk4dGagkH1OmEzDFembLXWdnIAm
         PgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740916193; x=1741520993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDWzcbxIvlIvGTw93dXaxSEzESqsRSQBbR/NvExKmkg=;
        b=E6o2+Nsg5nL237Y9V19sz5dV0WrsNZsAFCdPG8yyG1hl4rKt587uHWSe1N59NEBms3
         bUtBJPOAiQ8SLtbGYg1qjBKlKcKfq74jt3tJiG5zpitR6VEPeflUQlo/hWDp7Zg1QGPY
         IUZkuFXBoiKJQBOyRT9JJazvUbzOgITDX5P7uuxLtZp3MEuVb2nSoRJYeD16G8F+MPKM
         YQUjMu+Kycgmx/FBJ8gP1a2jM7b02P/RGtGPAcPb0MD93kkTIBv+lCCW5yAwwIMph8fC
         ja12sJ5WMrA28MzXpEo1279ls6PaQIH8AI55OKNXk2VhBI25DMUSPG4h898VH2iomZ36
         fmkg==
X-Forwarded-Encrypted: i=1; AJvYcCVKV2z/4VZI1xcFtud0o56CSbzSSz3bMyqWiHlKczBQMitwJeGqnu1oOpIjFnAkQymJ+KWxuIa66KwG@lists.infradead.org
X-Gm-Message-State: AOJu0YwyL/acb9Y1V2hspVom2Oye3IKhe6gVcu7r48g2DzI3r4+F4olK
	Tr6fHyHzSMUvtqWKqJDsBImwO2GqtbLv70XiV2gIWQF3dXGuWN0/
X-Gm-Gg: ASbGncuVRaJ3/LW0yY7CPclyjz/B/9Gf6CpsRFQ2KYtzyaL1pPSDIqLsqdux5Mn4/J4
	gMcecTcqz73wB/AyNi5oR9H1jRUKaPJeP3WB6pyXPiStb6MYDKjFjk3BtKf7b21OU467ByeyxXL
	CkWTkUkILO/XvvSVgwkuw7bYTkGAq+PA72ZrnjypJGdzzqTQ0fVR09NmhaGT/W3cUC+LeJRkqhr
	iFwyQLs5pyWY5+Ag17Z/WTTx3rcIhJQGLY8a9GcymIagW1dL7IdptsGevHiTwWVQN3jxHGjjmIw
	bTrQp50VVEbeh5NIr/Z28q1+4Zz5Y1GgN6DVWAfgkVQ1LMEgP+C1Xguv6KKZ6kygJJL178F3O44
	7TMssEG4=
X-Google-Smtp-Source: AGHT+IFSnVl3KaEQhdVggHE4Q1aPuMVBXNtHqEHxvCXcB1KPL9q/eBkWt8pH6VwwowmoXs0mVYntEw==
X-Received: by 2002:a05:600c:138e:b0:439:9a43:dd62 with SMTP id 5b1f17b1804b1-43ba675a8fbmr67558155e9.24.1740916192800;
        Sun, 02 Mar 2025 03:49:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b694524c6sm125935285e9.0.2025.03.02.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 03:49:52 -0800 (PST)
Date: Sun, 2 Mar 2025 11:49:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250302114951.6eff96d7@pumpkin>
In-Reply-To: <20250226190122.GA3949421@google.com>
References: <20250226062841.60688-1-ebiggers@kernel.org>
	<03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
	<20250226190122.GA3949421@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_034955_183597_936A2ED0 
X-CRM114-Status: GOOD (  19.05  )
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

On Wed, 26 Feb 2025 19:01:22 +0000
Eric Biggers <ebiggers@kernel.org> wrote:

...
> I have patches for nvme-tls almost ready too.  Just been taking my time since
> I've been updating all other users of "crc32" and "crc32c" in the kernel too.
> And I need to decide what to do about skb_copy_and_hash_datagram_iter().

I've wondered if any of the 'copy and xxx' functions are actually worth the
extra complexity they add.

The (non-Atom) Intel cpu will copy at 32 bytes/clock provided the destination
is 32 byte aligned (so for an skb copy you may want to copy a few bytes of
'headroom' to align the copy) (I'm not sure how any other cpu behave).

The 'and xxx' algorithm is likely to run faster without having to worry
about writes. May cpu can do more than 1 read/clock, but only one write.

I guess the main benefit is for buffers that are larger than the l1-cache
(or half the cache size if you do the copy first).

It is likely worse for the 'iter' functions (which scatter-gather copy a
linear kernel buffer). They have to allow for the unusual case of multiple
fragments - and I'd guess the initial fragments are likely to be short.

Although I'm not at all sure of the point of doing the IP checksum with
the user copy. My guess is it helped NFS (8k UDP datagrams).
These days most high performance ethernet hardware supports checksum offload.
So RX UDP datagrams (which probably rarely matter) have a valid checksum
and there is no point making send() checksum the transmit data.

I ought to double check that the TX data is always checksummed in send()
I don't remember a conditional - and you pretty much never need it.
UDP TX are going to be short (no userspace NFS) and the normal path transmits
on the callers stack - so the data is likely to be in the right cache if
the checksum is needed.

	David

