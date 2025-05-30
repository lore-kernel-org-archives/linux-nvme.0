Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529EEC54FB3
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 03:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=; b=XWCZhQRSXvpOtwzMIowBgyJiBh
	7XdcJoLlURjTX5okvyIGudZIdSkFg/tdmtnHwRndHTZGT2c6yeIdjXz7c7Lc4XieZiBDnYTCJDQ4/
	xPA5mSW4lMFJCd0XcmW9JlvZ4/q7d3JA8fpWQrlB5J6jHDzBG5Y2bV23hqxoALbg/6t+UWO1lQIs6
	IOJ316Gisgkur7PvG6GLPjrvSYHYYGhZquAUWbNKtceBmBpdtJcoqjC3mJmiLLZsDptB7aVFhWxUD
	l84EtpOcyUUNkOZMs8d6pfbGoHYDrCmnDoTMq7sWeGNq/7zIFtMW61xGRxilJy9jIBP4Qpp2Mn6Su
	sG30gylQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKq48-0000000GzwL-3FbI;
	Fri, 30 May 2025 03:05:52 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKq46-0000000Gzvw-1Zqh
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 03:05:51 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-310cf8f7301so1302010a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748574349; x=1749179149; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=;
        b=RtEoEBD4yLULH0x9qIYNXHmIai/UQIyYOqDr9p3WYucs1lGgvHWk4CODf3aoqAaC1G
         92aPEmo4q73/a/cQq6+XYdcdAtXJLa65GsQBVreK7QzVKsfkSf+Ix9ekd/XNq3ydYpCt
         OTmk4vS/zxVBzbf97vdrPXsNz8tj89qaGak30WpCB09zjBhCdzqAcLXacvQV6PjmxPjL
         i2MgNB848KUeBoegHNq1nt8dJfK7hf5cNThqnDa2BpYwA5pXPoeKrSipptO6hneAgt17
         QUyVNiLIu5L7PdODXZ450rw8awY6caq+mPvlQXcjEjrGC3LRtTp5sH6vVdOAc19gsS18
         jt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574349; x=1749179149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=;
        b=hyRyhyDe+0xkDk2pBZxd5T4wjY8jNvcmZqAPtdugfEkkTRgqoTOlKmgZoXxGi34kki
         CwQNr/5MRXIB9TH3mLLKUqyeRMn9Xa+Jx+truYpDQglSMmAaXS/YgFjBL4Sfuz3TqGz+
         dkk1UuJT6MLLQ5SImLxuI1RSCNhyOXis4DGSjnn+V85ktYQ9F+6dDAJeIfhxp7XkNUiB
         UQVplP/K1ClQo4i/F1bXER0sP4qBZ0bMkh39rb+qXUDcz6xgMwb/s7nQuuAC3MGOf+ke
         usYBHGQfft54eRZ39ahcLun5JHJyOah32orgqCknuNsdgyfKuV3SKVgyAxgA4pa8wmSp
         Umng==
X-Forwarded-Encrypted: i=1; AJvYcCUZMx85Ftvg4JG8gpux1ySu6Pkpswps77l7c071arxt5y6YvBa4yFmtokfxaaABmvyIoE/UgWnW9Nye@lists.infradead.org
X-Gm-Message-State: AOJu0YxfL+gcOeJOXYFqDuYyGDAV5prCQN2vGYYKQlZ+eubnk7mM58nE
	mejtWjSKCrb/rEPGtVy2ew7e5tsgn8hFekJV2L1OCtuSwg5lgbrmeDU=
X-Gm-Gg: ASbGnctswdPRId+2mg5OM7t9cZyMP7B+sj9j4oKZFuIxsays+fPwvDSZbgyzPLzJpDW
	tJG8nIg1g0c1U5wf3XUpjlH/H2SFtepPVGGe1QCCoJr7zy5IEXmIPb7IifPayYsC/lqJbUpUo4/
	BnUkc6HHU59sRCigJKAtI6LK1IS7i2qM4WuBG/xfcLE3z56rOjRjIeOjD3TgExmdOgLT4bBFcTY
	Npe2evxScdlb3eGMY807empDwD1ZXOO9HGrsOzM8/cVeYzLJFY0HYOV0YjArvutz9EWzHcJqTLk
	GrMIyktfH8RrfwdskuyAlKRQg83n
X-Google-Smtp-Source: AGHT+IEcl2OlOzz1UB82Nu7h/Z9cH4Jj1R69n+B/6JvMm9cqj47inVhScwG6zaOc33eUuhbAG+o3GA==
X-Received: by 2002:a17:90b:2f03:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-31214e2efabmr10028386a91.8.1748574349270;
        Thu, 29 May 2025 20:05:49 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e30c705sm244715a91.37.2025.05.29.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:05:48 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Thu, 29 May 2025 20:05:32 -0700
Message-ID: <20250530030547.3218450-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529222911.37dc04f3@pumpkin>
References: <20250529222911.37dc04f3@pumpkin>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_200550_414942_E87898B7 
X-CRM114-Status: GOOD (  15.59  )
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
Date: Thu, 29 May 2025 22:29:11 +0100
> On Mon, 26 May 2025 07:30:13 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > > API and add a fat documentation.
> > > 
> > > The next patch will add sock_create_kern() that holds netns refcnt.  
> > 
> > Maybe do this before patch 1 to reduce the churn of just touching a
> > lot of the same callers again?
> 
> You also really want untouched source files to fail to compile.
> If nothing else it'll stop backports going badly awry.

I didn't get what you wanted to say, but I remember the series
passed make all{yes,mod}config.

