Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB353C5AD49
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 21:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=; b=JWCfGcMYAPyPVVb2BS/x2GYA0q
	w2usSnjE87te/XVPzERI8VlbBF/dStN6IdibuNZ2F7atD2uC6LIb33yFEELSmtUI6CRubli0R+cRH
	k9ZthRhhO7wdupHdTENBQq9UHrGuDSolEawXtKY6B/IsUCXHq4Xkd7IXdtgL9JbR+6ezq3tqr74xY
	FfTkqetAaTfHdxwH47i4mgYBmSdQVY9oqb6w6xI+1U1L/sZQLSmtRsn4O1cnVIayDD8Ad4ldaQEcn
	MZj0dIoAIqSAF1wv8k9k6eHce9txZmOIoiKumKeeDy76izaxAN3IRb60djXaimZghQMaKIGrU1BPu
	THayE+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMZFe-0000000BsvA-0E5a;
	Tue, 03 Jun 2025 21:32:54 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMZDL-0000000Bsgx-2jzY
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 21:30:32 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so2269513f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jun 2025 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748986229; x=1749591029; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=;
        b=a8LQKu16puWN4H+TnAkfN8qfswD7JnMHtOLrhsJHnOKt1jH0ayw8EmssZKKxMrEJxU
         jWWA+zETYSmrr4kh55MNjY2E0UmQkpcIh7KKxdXV6h6sCI+ySXTFF2Pq1XsUwEBj/yq4
         HveG8uT8vaeOrxNzOYTmKihV17ZJ+aZ6K7+mRr48PdgbcrqkPHeSEwiLPHRlBUtvGi07
         1q3/BMTFV6IHOYmGErR1XqW0J9pqu/SccCl8fK2f7I3w44X/l9/X0iG8Byi6dOUPymUw
         NBOZNZQDqC03Xma+r83JUiOpzEmCwzdtkBlkl5mU7wJ9LTlomewNjOjwYV0SL49IXBMr
         kY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748986229; x=1749591029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=;
        b=JuITWkcI19gUkFSDn3v8C+miDZP9eXdFSbZVLqzuQvhLj3EBWGWcSHDQOpCQl+394O
         ADnlqsh9pyt0Oq/9SJJXCN3N9EoBtUiRBynsisgRmnq43kCi/rl0WUMwUfx2fME0SBok
         Lq3yP+MhFTmW4AYkwPdyhWxS8bIAAgQQ33c+4rAb2cpOaRIamGL7PTLIH6IB7KDmQscI
         Ip95xH5ZR74SvW+WHoz5vn41gCgHoEjF5nqlyG0YJExoKXxbddtP1oxw6JRI2jaZ9ZcD
         1a2XipSq33Ud697GqdY+1oA+8n+fM2G2YirbaN+E5deoGxrdESGF+d2JzDQP2ShSajUa
         vfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJViDtKrtaXueMDKxlBG417oRrN2lKdz8steIeXtYKzdoUM5503tE8e14755B2X4OQ7/8bR3xAVsKu@lists.infradead.org
X-Gm-Message-State: AOJu0Yz04tQEadjRtdf3A2NR0nEm2Sny6UcMPbxrhEOjD3EoPm/Q85UR
	HBNG1WIq0yANUV2EJPj1iAWMV15iI+yeGBLNloS1dqzS9g6s63SZ675B
X-Gm-Gg: ASbGnctvhoJUmSWvpv1/DU5pgldZ68JrXoObwUoKP1WDJnZfWMThD+DdKRcdFVBLX8p
	IgKosSN91gr+lOfbB+mTKclwQ+YmjbTTara5IOpwu+XSnts3IIBxeURz97sb2fI50uMABvrtdi0
	RxwqgOvv2W1l4iP4lYuVy+WaxO4dPv6RLh58SaoMQ5DmMmZ8R1vQ5ctbr90Xz+FbQenCqyERyuG
	G8+rqt2xQI7eYnXb1mkl0V+0roPdgXo4QnSHrRJWI/VxZ9VwvdF6z0VO1G7Lwxowy/YwhD/CTAP
	XQDJiQi0Ihs5ySo4FVrItsna7H9GXBLD07uwRugU3etw8DAuofqYjA7LqQV3tnHa8v3zqmLp8QL
	Zba5Kr0H5vHilWg==
X-Google-Smtp-Source: AGHT+IH1NNz0bB48MnqJxgA4wHuK4JMchNfQmyjWht3RVt89c59AQFv32k+Eyv977zem0/zoGPmy8g==
X-Received: by 2002:a05:6000:2303:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3a51d92f833mr253946f8f.24.1748986229347;
        Tue, 03 Jun 2025 14:30:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b79asm19084051f8f.2.2025.06.03.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 14:30:28 -0700 (PDT)
Date: Tue, 3 Jun 2025 22:30:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, axboe@kernel.dk,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jaka@linux.ibm.com, jlayton@kernel.org,
 kbusch@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org,
 wenjia@linux.ibm.com, willemb@google.com
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250603223020.3344d362@pumpkin>
In-Reply-To: <20250602050817.GA21900@lst.de>
References: <20250526053227.GD11639@lst.de>
	<20250530025401.3211542-1-kuni1840@gmail.com>
	<20250602050817.GA21900@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_143031_707460_C32AD3CB 
X-CRM114-Status: GOOD (  19.96  )
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

On Mon, 2 Jun 2025 07:08:17 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> > In the old days, sock_create_kern() did take a ref to netns,
> > but an implicit change that avoids taking the ref has caused
> > a lot of problems for people who used to the old semantics.

That must have been a long time ago.
Was it even long after the namespace code was added?
(I don't have a system with the git tree up at the moment)

> > 
> > This series rather rolls back the change, so I think using
> > the same name here is better than leaving the catchy
> > sock_create_kern() error-prone.  
> 
> Ok.

Except that you are changing the semantics again.
So you end up with the same problem the other way around.
I can imagine code ending up with an extra reference to the ns.

The obvious name a a function for general driver use would be
kernel_socket() - matching the other functions that were added
when set_fs(KERNEL_DS) was removed.

I definitely aim to end up where the existing code fails to
compile - just to ensure all the code is found.

	David

