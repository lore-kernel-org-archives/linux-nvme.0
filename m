Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008BC54FB3
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 03:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=; b=3GmGnfLufstReBXLbXJW28Aolp
	mYfEU6FM7iY91DCfY1kfMRQuZx4RH6gS5ZyEu+HIRVeclRQ5MsAdB7az3MCsoUmGbkmdECB8ZPOFI
	L9Mf43Cx5Ko6+vCDwFeuvAB+2jv2ZRkBEGh8j6i6bpVHg9mCskgSAWV1vViNa3uyKtagWYDfbCkAP
	sPtuQMUerUQldFooXiJAdN3dPdZUSgW+J3YinJtIzqiTM3ZLL+VYcTdI/IRdND2REi8We8xDYd0qA
	a+7x5OArABSNhYPUYgKm+z5wbDk49Fh+xuXR/32htxlqthPU6NEeAMTYXMM8kARyd4BU5U9RqtR1V
	MPWrTQmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKq1a-0000000Gzej-1KB2;
	Fri, 30 May 2025 03:03:14 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKq1X-0000000GzeM-22Y0
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 03:03:12 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-234b440afa7so16908435ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748574191; x=1749178991; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=;
        b=SOFWlxkoMFTwbjVZr3ldTsmo6JkYi5rzIN2V2oN+brd6VrMZn56fGYNDqa0+WFdOCE
         mnAgywyPXejTAcDKSZJTfCm0DKwKdP2UbyH6AExpqmgxS12hTANDlwse3VyRt4UuuAi7
         De6If4YwyG3JtDlbM2+zuDEUmKt9oelZVfZajjthVqbjo8Okd4z+4RZhtNjMHYDHmrGD
         f6tYz6WAlQl8KpdLY68yQ866/jmBNk/S/iXIpc/UIMIbjKbJBV/pCQFUl17QwF8+NU78
         GmZKio4qHACbSDL1hFF4WCufPsra00mtFN3D3kSuOrk90pLhupQhk9cLz7dlZS04+ojq
         ZSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574191; x=1749178991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=;
        b=BcMgfGWo9o+DldJl4zNSB/247UH8BS0RY5kID23Nt0W6pRYTAkROoDkMfWNSKAPvd/
         66rstzSicYRwE7Bo81PuHtihchAUaWDeb4KzzPlpPFoxaLk7IsGd+69fL4NWVfqDAVee
         eiNQDAWmATsb0Kge4sbTyb722jrZiWbdoBXb+Z080Q9jM+JqeQLXwwbo+/NUw+dbvwuP
         a9wYlwsYK5PtpIGO0YbZ5It5/ODEjOkH/H/mB9NtaJD5Hq7rIaWRQbXulnWttS7DfYrS
         CZufoGSsgr0NHZs6452VHefQmeGSqwmPS08Hc11kRFmnbGBf/ArNbF0PPiFFXm7Sxuap
         bcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTVBIo/KjGpHGvj+aTSPceYCrf9Tzxmq9v/wYx+MD5HneqHIPUd8Nh37DJXJW/FCe2ta9GnV9/nmVy@lists.infradead.org
X-Gm-Message-State: AOJu0YzsAiF+afoJepj/LHgbIG7XIGUPJRnEZI00drK56QFeahX/oFne
	KMH1/1cPV2jj8kfOsq+NlxpDlYwiVIT6M4TV0BPO9GxP4JRgoQTNaYo=
X-Gm-Gg: ASbGncvldhi02TXlbt4vjahDFdrRtzJq4OSOOX7+j9vbNCsMS/yb+SWSfeHEsjLZDWL
	Ps6SVOVcf4CkiBfdArDSbQwxCqU2F/9e7+Vo91RlK4noJIaMVv6j9lwbeHcOFh+PmGnKNytejXo
	n8jmeE+TZTEfQndzUFBDQ6KWl37A9eVAQb35R7tSJ/foydUyIJcUOYEHodx0Jr0/QOc7MUoSSYf
	c+AkVVNFpuie1lQUKgw3VWCdPA8NbRzYXR40Js8I/NA7nAYplsrfLbU6bka8gc7Xc4qx/fTkDHv
	TStpMQUxnoaqypJXlnYV5gVaeLwax3LI3jBlCn0=
X-Google-Smtp-Source: AGHT+IH5+ZA6UonngWZ7LBmNIn34EiLQrTu0vlE4C8gBCmZnRcJjAS0SauUD8I/Jj4mLKSLrtUkOQg==
X-Received: by 2002:a17:902:ecd0:b0:235:5a9:976f with SMTP id d9443c01a7336-235291efe5fmr28715135ad.24.1748574190723;
        Thu, 29 May 2025 20:03:10 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdc5f2sm18964755ad.96.2025.05.29.20.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:03:10 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create() calls with sock_create_kern().
Date: Thu, 29 May 2025 20:03:06 -0700
Message-ID: <20250530030308.3216933-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053555.GG11639@lst.de>
References: <20250526053555.GG11639@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_200311_523821_7DE7DC04 
X-CRM114-Status: GOOD (  14.21  )
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
Date: Mon, 26 May 2025 07:35:55 +0200
> On Fri, May 23, 2025 at 11:21:12AM -0700, Kuniyuki Iwashima wrote:
> > Except for only one user, sctp_do_peeloff(), all sockets created
> > by drivers and fs are not tied to userspace processes nor exposed
> > via file descriptors.
> > 
> > Let's use sock_create_kern() for such in-kernel use cases as CIFS
> > client and NFS.
> 
> So if sock_create is now almost unused and the special case, should
> it also be renamed to make that explicit and make people not accidentally
> use it by default?

I actually tried to to do so as sock_create_user() in the
previous series but was advised to avoid rename as the benefit
against LoC was low.

