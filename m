Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EA7C5AE59
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 02:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=; b=b9otRZYqswTL20fFD+w0+s31yM
	nY2tZ7/ZK84w8WgpOGFKHLwFc9/N2Sr/JrUjRNb0cuxEqi7b8vglzaQ5CK102bWIKHujSH8mETF19
	xWzJA5CQ+pOTr+z/aSPokgdA42WmPw5mq3XcjNfUhaWoT0OWGomDT325OPXwhVb5xeKZHb4lQ73Lk
	HE8Q14w3iomBXpw3njzS/BcEd8YLode+PzkedfiHwHewZ4S4eoZE/nkPgAdUJkIwww7puZ26PcpKC
	5fzXBA/K5dkV0JLYGPmCyXVlVHLsOxys3iGiMxAtEgiqNW61fQEpZms2eIWyyFmfD+gOG9Vzpa+EA
	UiAYeD7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKpsl-0000000Gxy3-3Bdf;
	Fri, 30 May 2025 02:54:07 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKpsi-0000000Gxwx-3ofn
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 02:54:06 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-234c5b57557so15693845ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573644; x=1749178444; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=;
        b=LDD4y34aOvkOWVdT9mXPBCDey61rwQncumr+Wmkpv8Bm+QfMMroTvWJic7wQnFDoHE
         YMC5Z49hqdBN78musrPKp0gOiYE+FGNR8EPWKvnR6Z5Higen8iQppzSOqrCcZPf//FIz
         T8KXv9tX+nwLef5LwuvBadeQ5ymdjEiqwT/Dh+byE7QJAvLsyRTgB0+PPVIJr2Nz9o+/
         64liD96qCGu+MRzriV2F2m0zpd3RhIYGvrLU7KQAQaAxgiJhHbKxGrTuH6SyTscxppbr
         BxLPk94pND0uAHtzeKlyvp+YMA8osMdRyyRschkjGzTZi+2MAVZBnbndhlLcXG7FVAL4
         RfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573644; x=1749178444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=;
        b=XMDBWNa3SD3CED6DtsVBOeTgK8/iC3LxsKn0CgikafbbIcnGKUHPfqBC1uSsEtefAp
         4qfFfH13PEtt6+BhLDKDKHFLXd+x/nYezocRaFCXAS3H7Tdb0R3jKR4ZYydgylizgWAx
         kx9kZSuYvvcPEsl9gBxapgBAwQjlBQYuolvdYPCkvnX6spYefGPHY54MXxyfB8GUGt7f
         tLLoExLsolnQya1cHCQSnHcNZICClbmYW2VZsdS/XS365SvX5e8nJ9EtpHImupscIS/u
         02GMDQ1x28Itq8B4GP/rSDtlGK74Pr7pbryAOigf2CjpEoeL10MPBULxuQvH5PKEGLyS
         qSug==
X-Forwarded-Encrypted: i=1; AJvYcCVFFIg5TRaNPEioDMyG/iWG3CIlA+S56Uboimb118M8BhqsbVg5jm+qGvMtvuFvyi1b/a6Js4Z5MMLb@lists.infradead.org
X-Gm-Message-State: AOJu0YwmDs0KCwAbCIzjOEEk8c02RhRhpaYIohJu/CRdMcb0V8WIFCae
	F213Y5MMD7i+fbgoitNYWBiz4vpYN5b1JMD6qRDPmhRbgMjoVkERFdY=
X-Gm-Gg: ASbGnctC+qu6LN5MZ/5UV/sYffN8QTJhyfEXMHXW0xM3l5HZl2SaFTadqzzVXuk7l0A
	jd+l5dT04dZkBNwhys/p91xRZQJk+Tuy9C21v6mJWP+EgnpSKlBofqBao7iZrsWH6aVGXzxXwWc
	W6gFjYvy9bBw+NrPml0B5BNwjsfuLN+n3WihHFrK/IyeZJxbvLQsq2YCd2osOP/SCSP5BoRh/OQ
	ZqSzbnZKCl9vi4XUTo160LI5V236urwz0gd+QCKVMiXilh0FlQ9nulGN2m0EaPlTCdx3mY7bLSv
	fXnS86+WkvhZk9ksAQDRYjXH28vN
X-Google-Smtp-Source: AGHT+IGgDezX7cz1uOZykPYiPInz+eIk19WtpZF+nVK4hwKpEI92osR/Nx6vpb7wz1AjRVv5hZda0w==
X-Received: by 2002:a17:902:d544:b0:224:10a2:cae7 with SMTP id d9443c01a7336-235396cb241mr8527095ad.40.1748573643807;
        Thu, 29 May 2025 19:54:03 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9380sm18830305ad.203.2025.05.29.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:54:03 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
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
Date: Thu, 29 May 2025 19:53:41 -0700
Message-ID: <20250530025401.3211542-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053227.GD11639@lst.de>
References: <20250526053227.GD11639@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_195404_951692_6D3CA21B 
X-CRM114-Status: GOOD (  20.60  )
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

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:32:27 +0200
> On Fri, May 23, 2025 at 11:21:09AM -0700, Kuniyuki Iwashima wrote:
> > Let's restore sock_create_kern() that holds a netns reference.
> > 
> > Now, it's the same as the version before commit 26abe14379f8 ("net:
> > Modify sk_alloc to not reference count the netns of kernel sockets.").
> > 
> > Back then, after creating a socket in init_net, we used sk_change_net()
> > to drop the netns ref and switch to another netns, but now we can
> > simply use __sock_create_kern() instead.
> > 
> >   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> > 
> > DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> > from __net_init functions, since doing so would leak the netns as
> > __net_exit functions cannot run until the socket is removed.
> 
> Is reusing the name as the old sock_create_kern a good idea?  It can
> lead to bugs by people used to the old semantics.

In the old days, sock_create_kern() did take a ref to netns,
but an implicit change that avoids taking the ref has caused
a lot of problems for people who used to the old semantics.

This series rather rolls back the change, so I think using
the same name here is better than leaving the catchy
sock_create_kern() error-prone.


> It's also
> not really an all that descriptive name for either variant.  I'm
> not really a net stack or namespace expert, but maybe we can come
> up with more descriptive version for both this new sock_create_kern
> and the old sock_create_kern/__sock_create_kern?

