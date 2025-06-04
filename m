Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5E8C5B543
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=; b=MisNNuOzsbhuqSlP8FV+nOfBgP
	i5O/DB39J4UzH73OKBWRc3rB6mmn8DT9FpjiPiVs9Snde+MSPpcv4KHiQ55Jv4oM6X+H/JQeanaHa
	lCK8NlN3z0ujJ+fhLo+SsEQoc5e4FPq39eVKf7ZpSoe/0IiA7erg00oEIfakZBgZ5Erf+n+9zlG65
	hjSzoGtlZMSqAIm9E3og14vjPrYNm3RthQsAIsj0q+ZRssEMx0Ahu4hIRoRK9VwGqeVbaAks8gg31
	Y/9tvDCXGp/3rsIDZMZzguUwh2/nZzbNf4Kxj0rJSvTxeRtrncMMLUsljamFiIhDw/5qGDsWVgS1k
	B4zhbiag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMszb-0000000E2FE-1dNc;
	Wed, 04 Jun 2025 18:37:39 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMszY-0000000E2El-2X22
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 18:37:37 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2349f096605so1848175ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jun 2025 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749062255; x=1749667055; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=;
        b=I9K1vMUKRCGk92aP/f8wuCcdwEKUFdRsuUbOOxKQqVvVjsJnCwfeOCe6fSc9ZVDpJM
         TEZvvE2t31euCRAyFHNOBlmALlHJTJgjPKjcV1xZGlTHza3YUIUYUAHVKDhozPmtGcgw
         863X85RSBFUKPnUiJE67V+a28pYKHTYCQJUFhcVjHrw3KX2M+/0bUMZjNSwBjJk+ircf
         Cu2MHH9JZCijVoMFLPUwOimZ8Ww9Kz0oNb6byfDoLiV+abRZFDUklxAmtpTPqG2JCMsY
         fsSSxYtR9vqh/ORU8wzcROX/ANgCtTV/jpDqtiOpKM0gEm8WyEQbpWhXiJRppyb041np
         zoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749062255; x=1749667055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=;
        b=lkZZn7j8H7Bj5xUhHj8gCRtLgUFsSJXaLjPtOYiEDKdSNx+v5zO0xQ6iyC9CjHtkco
         XZ4Pu1azPi9f4XpDDB1xowuw8g2eRR83oqj7j4TZ09h8UIUbLoqVQthlcrXLVII6XvyM
         OPzdrOU4YTEXERlNEdStrQipsPWzStXPLolSQ1A9v4U+KLhRffDVD/ST1fXArVhzgMaC
         zdNF44C8n9yGqaJn4KAN+OTyq2qYqcKNxDYWys6sWd/mKfQpa/OsX/Rmz068A8vFFGwA
         pGRUsdM0T0jXEphsoIvHjhe+HowfhMSPvAFQoWpARG6vP0or/jSez/XGSiDd1oPmnT7W
         lLzg==
X-Forwarded-Encrypted: i=1; AJvYcCXaQvhoq5I9HP+yRxx+8ICkbIKvTfpbOeIZluj77aqf+G2MxFglV4rtJ+DetHazsXsZSZn4WtM0ME1T@lists.infradead.org
X-Gm-Message-State: AOJu0YwH+rIMcgJsCbHMq4cypVLIE6NmstMLWv5rkL+6mEfrC8ULhuYf
	wiGZY8LjcKh2y5jAAYIIu/Ktt/u50qmZWx1oIvLdlw0YeMGEgmdLKWVyxwADkPLcqQ==
X-Gm-Gg: ASbGncsD8d6LiO92XDBfQ9TmZC/s1GNyVaiZCWdDoQH3mAtgjNlwaae2GRlg9IwD50e
	/qdO7yeb8dEyvxY/L8kzraxDOYiRAJkxYanowjt+pK5qH2u1P3+i9W3Wkoa+7vFheWZwiIMlFfp
	eW+8BpFacMZjyoVa2QgHvkjnX0/cwoiLGQZ/75mFeWMHW70VK49FS9vZ5q/PL0LeSaHNpEtLWij
	vYwfuQchxdW0534o0CWcjwIbGxY3z9Ydxp7QbWL/VIqBaBYKp5T42q2lvbXT67xuUSu2cvyqWkR
	IQ4KSPG2jfzxBoUmquy+857nsaWB
X-Google-Smtp-Source: AGHT+IHzeMlOG8WaEKyWojPC70HY/eTfvQSuJDc6Tquqle6do5jo7DuCE23TvCyOkWhB0uyKaHd7DQ==
X-Received: by 2002:a17:903:3d0b:b0:234:a033:b6f6 with SMTP id d9443c01a7336-235e11cb901mr52517545ad.31.1749062255383;
        Wed, 04 Jun 2025 11:37:35 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c63sm107254965ad.241.2025.06.04.11.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:37:34 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: david.laight.linux@gmail.com
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	hch@lst.de,
	horms@kernel.org,
	jaka@linux.ibm.com,
	jlayton@kernel.org,
	kbusch@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sfrench@samba.org,
	wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Date: Wed,  4 Jun 2025 11:36:43 -0700
Message-ID: <20250604183733.135820-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603223020.3344d362@pumpkin>
References: <20250603223020.3344d362@pumpkin>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_113736_643081_2400CF29 
X-CRM114-Status: GOOD (  26.59  )
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

From: David Laight <david.laight.linux@gmail.com>
Date: Tue, 3 Jun 2025 22:30:20 +0100
> On Mon, 2 Jun 2025 07:08:17 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> > > In the old days, sock_create_kern() did take a ref to netns,
> > > but an implicit change that avoids taking the ref has caused
> > > a lot of problems for people who used to the old semantics.
> 
> That must have been a long time ago.
> Was it even long after the namespace code was added?
> (I don't have a system with the git tree up at the moment)

2007: 1b8d7ae42d02 ("[NET]: Make socket creation namespace safe.")
2015: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")

It's been long since the implicit change, but it's only _recently_ that
people started to notice the issue thanks?/due to k8s use cases, e.g.
fs mounted in netns (ef7134c7fc48, 1be52169c348 + b013b817f32f, etc).


> 
> > > 
> > > This series rather rolls back the change, so I think using
> > > the same name here is better than leaving the catchy
> > > sock_create_kern() error-prone.  
> > 
> > Ok.
> 
> Except that you are changing the semantics again.
> So you end up with the same problem the other way around.
> I can imagine code ending up with an extra reference to the ns.

I don't think so because it's rare case where we want to use
the no-refcnt version and it usually happens under net/ or
drivers/net.

Now we have SOCKET entry in MAINTAINERS so I can add sock_create
there so that we are always CCed to prevent such issues.


> 
> The obvious name a a function for general driver use would be
> kernel_socket() - matching the other functions that were added
> when set_fs(KERNEL_DS) was removed.

kernel_socket() doesn't fit here as kernel_XXX() takes struct
socket, not struct sock.


> 
> I definitely aim to end up where the existing code fails to
> compile - just to ensure all the code is found.

You can see the patch 2 renaming sock_create_kern() to __sock_create_kern()
does the job to find all users with the help of compilers.

