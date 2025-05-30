Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A88DC54FB3
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 02:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=; b=iyAl8dPp6zNpTowbu6o0eVe0+F
	wlvSZvf0EQKsIk0RPJ8q3Wtnx4g1dEnUJHZoO2xOBTyyyWVSlDPKar5/sO8U0yyv8A2kW4roiM45u
	dxYCsZ4qkoxnd/NXfSv7zsMiAVtFdpGvHe8BbVwFaB1UXgHzM60rqBtFaO2PW194754g/F8ZNKEep
	auXMsnsJfaAuD9tYzkaGRti2jt/D4E9Rc4o3zR0qoXmG09SE9oc+lW0cbWGJAXu/bYtt8xgynC3CG
	5eMeKMiX5vizS0vjaXqHx6u9jY7DGkuYdlxi3wyElXbelT6qb+fmrmUiOyhzr7eghXXu3ran9Yq3Z
	J/FFb5Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKpkS-0000000GwTo-2EdP;
	Fri, 30 May 2025 02:45:32 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKpkQ-0000000GwTK-3OrI
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 02:45:31 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-22c336fcdaaso14808005ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573130; x=1749177930; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=;
        b=GECq80c5YGlFWfLd190tWL2tOdakKD/IYhXg2Tq3uUGY4VY8mOuUsbhrG3v+TYfw7u
         KTjEuo/WhtHxKIhZbH1ZD4a7Ynh56IMEZccaIGZqEcOwpp5Q+fHeQ31t9pnS28IrOaLE
         PpZt91R4rviJ+mB+ieglLRmHEw87ROPAlWPEWfJrhQWckqSSSrNVsTPpCT5pQE+fimkS
         5zffCZso3PECqZ/UZfyj3m3FROOdWYrE9bkAu0hMG22pkvIdq61Aywx3uAAmPcuWIlcf
         C23V5S6RICtjzetHQ5AsqToXIiZV2pmrxaO80s8px1qX4uQgQilEl5Igtul1rQBS4kLK
         0w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573130; x=1749177930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=;
        b=KdXPPtWSBrm40n48NJT+jDvb7bFb5jxzRaIKS9pkqfBqeXaDWQOf/ugc9peIikbOG7
         rYsU1MKbyNCPDrBrTZxoFwOX2el8/Ykdt6vZR6e88YamToW/QSCZ79vfldaHV7D8mVum
         Z8+uH/20AjDK1Q+VTz0xkRTJsfXVSipwN7HLhU0Vi/Sj8OGKPDs4cC2JPmAjlYhMT/th
         KSRx2Has+0p+h7B9v8mWDsctBXlbbl4IMqu+y2fN2YKlqQxxTKdPRAQ0BQPNNwLJRLmU
         osICLMkLL/CQHof+Ej+4LSBbrwzZZd3e++BBeekPO/9ela10tNS8EIIUO7gpNr9IuJ7+
         B+ug==
X-Forwarded-Encrypted: i=1; AJvYcCXrjUWMKXhkeiwCd9S5etjim/ht+urVKnQaWc2feljh1Yxi2adFY1M5HFPXORU7Sa66qk9e3nUgh2wF@lists.infradead.org
X-Gm-Message-State: AOJu0YwtRlxTCuWyfpVbfl+HxpmK/uyR8530RYJf/QGRDfkYsa+/Wrls
	OMWgHPc88Eh3/AWeKKdOTI/v3wLM7OXcjIqhWpVG+gc81LjndLFEL5g=
X-Gm-Gg: ASbGncscIlFGw5eHC+ESkMBl3NkttUm73/5+i8p+G+6lmfGdKPZfhuX0XKk/KEdGTVq
	a4QAHbI7Luqbyh4o+YDrP9TUPwW/o2qrk35aa1hqi3P0X++g347OejZmYXgEplXkelwdn3jY5ol
	hbpJZYdJkOUEHJtRZYXGDEXaDPKJEsGpA4uRqeaS/34s/epEEwJf/iMPSn3QHl/8jOZdMuKf94O
	iySJ2QEfIIjCsKgWycL1AvTvu3/tz8U7SknPRgo9dIwLkn60Gn/2HO1eBzRj0Cc8YI3666m1u9L
	i1kqB36ozdXigZm71OmGGX3xX8og
X-Google-Smtp-Source: AGHT+IGmhneqjdBylW4JYpgbPUNRknu2JzSpNlC2hWsZcakXdR7Ir8On6/7pieVXkB9LlKcYsiVkBw==
X-Received: by 2002:a17:903:3ac8:b0:234:bfe3:c4a5 with SMTP id d9443c01a7336-235298ef7bfmr26925495ad.2.1748573129870;
        Thu, 29 May 2025 19:45:29 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf504asm18767775ad.178.2025.05.29.19.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:45:29 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Thu, 29 May 2025 19:45:26 -0700
Message-ID: <20250530024527.3206724-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053013.GC11639@lst.de>
References: <20250526053013.GC11639@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_194530_847653_886B74D8 
X-CRM114-Status: GOOD (  12.50  )
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
Date: Mon, 26 May 2025 07:30:13 +0200
> On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > API and add a fat documentation.
> > 
> > The next patch will add sock_create_kern() that holds netns refcnt.
> 
> Maybe do this before patch 1 to reduce the churn of just touching a
> lot of the same callers again?

Makes sense, will do.

