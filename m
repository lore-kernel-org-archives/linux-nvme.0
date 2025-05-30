Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D23C5AE59
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 02:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=; b=O4dJ+zvjdPTy2IXRJ6c6EE90om
	AzDIX3ynwI9OAYnwNk3Y1q07YasAL6M74m5g/olLfRKGX9o4xScCfPM2FOyaHXFpkE45Rr0GeuKPf
	4S+1N4lNymf/EF2b09YlEo68g/COnHar4ut9xqn81HJkqlwnoLbP7wYDRkGu8qhwC5xYbIXPB5D5x
	IZuDuIO874R6Nbyl1U/cIeIpKx7M+IB2Caon/i6SKi+oW0ulanP5IL1MznR2MFNeWRBzAmyoAYNQx
	zvidGBpMtw70J7hfCgL0ICdnPmX9PeuY8m+rzqFTBvblNogFbNIvU4nWK5cqjgbiF7F2x1TczQghc
	SqQhQCfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKphk-0000000Gvwo-1Kcr;
	Fri, 30 May 2025 02:42:44 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKphh-0000000GvwQ-3hUK
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 02:42:43 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1090050b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748572960; x=1749177760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=;
        b=llPOBvAnL1LYVyd9Zmy7uSnFhWYdzqmEC37/m0ftwfdSf6CfcpRfQDIn5Ude4FCuW0
         01pXRjhLM/lUV/Hts3HbcZ9P/TUTzc77pdgt3lIaTPs/DGE83z5YUrNvHQFGFWeVGAF6
         yk1HEkssESfAycy8mN8aiPgwGv0aCIBfXswc3ZrovjG1cZ/f3VNesCF2CrEDQ/NmTLN0
         9ZECxt/hPg9+DF1CgHnNz7v3nFORInX2cBgsitME4qtKL+3aiAXFmIgUWRHTQXT+uvcE
         cZdLM4hd4QjOyx3IuKmKcUBOxQ25SCPZ5EOuwVln+HnNMBR4qkZcAlux8pg7fJG/4qlJ
         ihJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748572960; x=1749177760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=;
        b=PD/P1pcBP5EE1abQaREGalq7Sr8RLvShhnkMVxUDeyaPGc4v0hNXSJYnSTiMMWB7vc
         jHsAnQiA0b5wXE36XntSvqSvBHlRtFU1DBofT3zy4ckbocTcFaX/p50a89fznXkxyUWX
         TdcANcPhIao6ui0X/2+GqUyzZtbdt03PeoV7kgBraRPMpzY8Dmq0IHCvWsHetZlXG/3y
         6ihZ3dW1tkPbvL4sCctPd6cOlQCMUnpTEN4x6w25gyabteH8zyPeBPjyd4ZaHuQEvo04
         8T3dTRuBJd0lUhoMl7IiAfYz5qmc73zSAIcBGKRQwFwXKfg2O0fSXly/aNFaL4omAJ6r
         D50Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8rf/ZKclHuRh4sWJY8dSArMMoVypf5EfqICCwwxs+XvuZrJVdD0kv2a/lNZ7nG7h7NWZqgXeYgmwd@lists.infradead.org
X-Gm-Message-State: AOJu0YwfScuyTpIOYefpppfzdxyMe8lfP9RvIiybEV0xMwriSKZm++cJ
	5QHV3KoyTGpPc8/CTe+ro8S8uQmO48svMBBlgh/77YaeNjiev7APa6s=
X-Gm-Gg: ASbGncs2DFRvEojC1VPYMxxz3nZtEsv7/9lwIXexXVSJk5S2zvly4NqtpHr7PSBkdYJ
	8tcfviFPQJsUn190qiOzyQejRa0tYuFcZVifxqpRAxJxZMaro3FBu9aTBZGZyiRG8XF0/zNRETO
	Mh2jDK8k1Lq9m21XXOEjDhER2ENXpkLkiemO9CYRtoB92dvddVn/lMhAqTo7wD3KMOAbosgbgiH
	ADQH84fSXKdYrV8s6+L3jJ8yudtGno4q3XUs9B5MIeisgRsRnmlGSFQydKyFGFQ9rU5FgCTkQyy
	BIcrbJqP6lir44PqxntH1CGwl9xn8Knfd4nfHLo=
X-Google-Smtp-Source: AGHT+IFkZ59DZl7jNU5F1Sz5H/4ysdqwbjBZOu4yMdNd5hJYzri98sUVF1rBQfHwd3ScQ9DgsM8UVQ==
X-Received: by 2002:a05:6a00:4fcd:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-747bd94deb2mr2658447b3a.3.1748572960442;
        Thu, 29 May 2025 19:42:40 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab0c4sm2019092b3a.48.2025.05.29.19.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:42:39 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Date: Thu, 29 May 2025 19:42:36 -0700
Message-ID: <20250530024238.3205130-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526052907.GB11639@lst.de>
References: <20250526052907.GB11639@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_194241_938178_1AA9A6A3 
X-CRM114-Status: GOOD (  16.98  )
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
Date: Mon, 26 May 2025 07:29:07 +0200
> On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> > 
> > Let's convert them and un-export __sock_create().
> 
> The changes looks good, but the commit log including subject line
> is rather confusing.  What you do is to replace all uses of
> __sock_create with sock_create_kern, which works because
> sock_create_kern just calls __sock_create with the last argument set
> to 1 as those callers do it.  This then allows marking __sock_create
> static because all outside users are gone.
> 
> Please state that, i.e.

Will do so.

Thanks!

> 
> Subect: use sock_create_kern insteadf of opencoding it
> 
> Replace all callers of __sock_create that set the kernel argument to 1
> with sock_create_kern, which is the improve interface for that.
> Mark __sock_create static now that all users outside of socket.c
> are gone.

