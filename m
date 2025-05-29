Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A1EC5AD49
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=; b=EkW2o2yE7sS2KsjFEAFYKUd+xA
	HW6JFVlR5nxzICpzUbQZzG+nJ2VFuTfbllH40oNgQJdwHUtXo12qooIn2fCyr+inms/fSobyXLPZz
	Az2qhj5E/WEsjW3FIhRxMiI5C8BeXwR5LYScVQbHQWNOxMsGYziZTNCgEklaTmuUAwTmd3YebvHQY
	SN+x0bF+eRiAe84lktiVHMjQmaHK2Ig6spNBZBwcDNQYmhgLB/dLktPYbqc7Q7CmYE3vjKe8cwHxC
	xBXUQnYF3Gp+pYPrn6eMsX1rx265cPsDdQ4vNrx9Qls5uBTsYIjorS+9mL6xNjXUiFhnL/OS6lCNZ
	UbecZgfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKkoO-0000000GZET-3ayD;
	Thu, 29 May 2025 21:29:16 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKkoN-0000000GZE8-0EzG
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 21:29:16 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3a37d24e607so1321510f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748554153; x=1749158953; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=;
        b=ItfjWO9kce7W/dGGuqmJMPfbmyr7qljufo5nXE+c+6YbpCeuZB1hXbL+Rb7LCJ3z5O
         /9lSBv5oKBtjtaWjZld58dIVsKeVy3Ny3TtvDVo6c7ifN7BdvByjJhvz+tPBUgufL0BH
         76VMfpqhespcv6eNAYgejmaTVet2vL7BvEUxr9GZ3kYeSXSqIKskWTFHStGzZofjBhh7
         I4HwL/6IkNg19F6wO3BP/AdBN9db2kr8fm2IuPU6XlX34LC6KJqHjE42z/bAd/d8pkWG
         SZrBAEK4LHGgBr3gZ7TJmJK0cwlNDx6EoRAWkS85zOqRy2452cvSGjJdQyli3nyIn2sK
         Ehvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748554153; x=1749158953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=;
        b=KkEJSch4phogfVdGtjaagVjxjJxdLmHcXyjgsNMRb7WO35y39kPMdBPLINf7dHucZV
         rgB5H7RmkgPOdhqBNGJMjAhy4kIWffBuWk5xNbbd7P3fpaxx6PPJU1nYS0f21ulrgWbp
         MQZLb3cmZlPERvfKrw6CuI4+FwNOdSUM4vOADrEeYRNsWz8j7NYkG+6FplXG16f7CtqD
         C9duDDaf5s5Ngt6zv1dqG7dV8dgdfTH8hq2/ModH5ogfLf/KR23IkWEcoYO+EymCKaRQ
         2yTac/5x1QIZSCrHSQqc4+kxIJgJew8m7Lzjfy+Cg2zcDdt76IIDLLY5JYhXmGlg59XT
         OHPA==
X-Forwarded-Encrypted: i=1; AJvYcCV/2sHRsOg2iBtJUb/E7yCS6qd6kXQPSAqh/c9tXoZ3wM8m3L6qkPphqrH0B7HOx301jQ+TMfmfP9R1@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9ZjbVx/4brwYJkBNitySKCUs8CBcLtw/h8pFJo5WhFlxImNv4
	0eoXfzG7SdyY2//KOX/W4YEROrGiOfbLmYrzeRwmPNOmvMbJ6jeLGpMm
X-Gm-Gg: ASbGncv5YKylVPEh6bR6IMyfaXKzWvxvr1m3En2/5sOobPWoHpzSDV2j7G1EoLbWlk2
	ESvbnOdw6/KUFtMCbWlNm+c2BJrzsmINaBjbytNkNHzzndEh7OOs7c2uz3ZBghr3N+KsURljXEA
	xygZEE+b0TbHTktZvysX0qTwUI46gCsLIiJTo24ueCHJxl20PxbYkjxacbZlO4ZQR/wSp+9oHhh
	orNb5jEX2jfl5p11LqAXi50Y64DA+ac3xi5YzTR9AGvlywGAcCvwDsOGg/SCVdDxfL26lcmgro7
	4HkZ9WpsLVV4DO6LewPrm1SlLkIm+CHyx0g28MyziGniqsUjfWIOMvcLqA1ZXNDWqxetRU3Hg0H
	/GottEvKQEnp8dA==
X-Google-Smtp-Source: AGHT+IGT6Wwf7gVpUfM1Nqzr6escLgno2IMcSQrRw0Uy2H2YCSoD17fP2R1YZIFdVF1bLqkmaXgCqw==
X-Received: by 2002:a05:6000:2891:b0:3a4:e706:5326 with SMTP id ffacd0b85a97d-3a4f7a23e5cmr643811f8f.3.1748554152539;
        Thu, 29 May 2025 14:29:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972b5sm3085052f8f.76.2025.05.29.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:29:12 -0700 (PDT)
Date: Thu, 29 May 2025 22:29:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Steve French
 <sfrench@samba.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250529222911.37dc04f3@pumpkin>
In-Reply-To: <20250526053013.GC11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com>
	<20250523182128.59346-3-kuniyu@amazon.com>
	<20250526053013.GC11639@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_142915_107326_EC7719D2 
X-CRM114-Status: GOOD (  15.46  )
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

On Mon, 26 May 2025 07:30:13 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > API and add a fat documentation.
> > 
> > The next patch will add sock_create_kern() that holds netns refcnt.  
> 
> Maybe do this before patch 1 to reduce the churn of just touching a
> lot of the same callers again?

You also really want untouched source files to fail to compile.
If nothing else it'll stop backports going badly awry.

	David

