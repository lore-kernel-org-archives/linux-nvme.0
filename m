Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BD0C54F30
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 06:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=; b=dO9J5/34XxVeuY9WS9KW9Pzzjm
	6tHgx3C0sa2H4Qx2AuQgVsvoTFKTpxldI706pIBIoQsUxggYD5YKDZewUo3NdU9gL1UaaElX3JgHF
	MmLKWoqf9K1BBMcwQYcd/xm/k30UFEVJtLFcbqQHBL1MOG2kNH05DU+E/FMMf2nPaVvNA8dFOMyp0
	2t1cRZuzhMY0iMP3z+lmcN8ud6EbTbvH3mM80/yxehD/Gu3fwxVuSCmDmbiIlL2HOOVnGZTTlArCG
	o3+Fo4dL845f+TJ05xgmIiPxdw6KrKVu+hMKXgBaWsyfdEodB2b7ihaSuqNelqZPtwqwaWQ4qcJAz
	er5dDR5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKtXg-0000000HNyg-2q5l;
	Fri, 30 May 2025 06:48:36 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKtXe-0000000HNyG-3RhY
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 06:48:36 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso13261605e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748587713; x=1749192513; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=;
        b=MlZvRh4ZHIdibwODbpdzyBwsndHvwsCgAZKv5nFn421PcjXKplzzl2R9vYtyNYzUJs
         VwErAfMvVQRgecwe0uq2YTz8Siy3We+U5DDFXwWD4pc2WgMwXiGS4d38tvMSXrtJVyWT
         eX39ZwV9JsG2PwIDTAqhlbMvgM+OPTx1k1nsslSTPmXNCSDlJpfp4hR7lj8ZhQ9iiJZw
         QiCaF3SJazT8ElVkKd9eo2A7JS2TpyylMNzWpm3jyUXr/1kPd0n9wJWsvxw63iCqkm5m
         lWLiSj8F5p+gVHbwBz403ki3IqfD0jYXxhnzcPnfmagwT9HdZlmCkjLNRbEeXzg/61gg
         1w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748587713; x=1749192513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=;
        b=JbglshUjaNVhSMMbaWUXRjJCjL3cb28xigVigi0T/h3mQ8QS61sulXtvwmQqeCMQwd
         aShRo307qyjAuIcamxA/fS1QQFPDivP/jqYJAjiJfC812oOxYq/Yv97Sw0wfZdVfS4Hi
         o27vQZurOAsRDGcYDwbUsSMBcC+6NT51iG+WkXqWeSN9DZNzXADcTb8lU5nsylJXxC9p
         6PIVNmRFWEAbpC3HS/cAtm85LCSiSdp7SvrVYiFuRLEzXhME67pEyGu63hVYW0ZcwBEq
         +ztX7UUUqHXDiT8EodUZ05/Edb82kXd8PvLGvQXfFSUD9YjZXB3Zprd3YDsBZE6cKekU
         cEpA==
X-Forwarded-Encrypted: i=1; AJvYcCXOGmIma+1X5Tp2IRi+YfxWG7684wdcq8oDdU4p7ES+jhBivJir8DiGialVklPLIRBdgtKTjxZiRMTS@lists.infradead.org
X-Gm-Message-State: AOJu0YxrD/qSjtJ8Y4wvkfbtHVWkiAAshdlP8nCxdlXyAMBveGu404BT
	3A4dirZNMixFASRrF6pyoU22bdyhpMlDfZFppA+v3OK4f9IX317EmKT6
X-Gm-Gg: ASbGncv90wGQY0uIP2QC7cres2+CB0UQaVRpjcCUZKmabMe4LCQ4bfe8xNpNKPERGKB
	UP0pE5oYd+cw+TZ6UWu0556SHL+88y7V+w9Hur12S63+f4JVg+9PZ8tc8fixFITVL/xjGPIkBPW
	/DwTpfhSeN4PcfJ8uKPUl6HmB2ljCCTfA6IlY7xcMBapFH8V6OQFHR8zAy3QcG/lxuFt2IGGnIT
	fluVI6iYyL30qp61sTGsF1DOFafNFQIFUI/9oT3Gi8eC/uphhFJbbrt4XRTogaP357qVAVglsjz
	hO0u02EPuIP8n4od/ObjbR8r6SYGxlgyCmGuC5wOWXEi5d3JtsWTVNDFk7SGXmkf+9304YDf6wa
	RNEaHV/oeid7W/g==
X-Google-Smtp-Source: AGHT+IEaRQdrIbq47i1uTvqrOh3GYrjs1EZb1ZDSE8bNiRbo3NGeAP5Bc1VED5/Muuf7IvDxzlUr8A==
X-Received: by 2002:a05:600c:6219:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-450d64e0553mr19893275e9.11.1748587712835;
        Thu, 29 May 2025 23:48:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edf9sm9120305e9.3.2025.05.29.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:48:32 -0700 (PDT)
Date: Fri, 30 May 2025 07:48:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: axboe@kernel.dk, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, hch@lst.de, horms@kernel.org, jaka@linux.ibm.com,
 jlayton@kernel.org, kbusch@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org,
 wenjia@linux.ibm.com, willemb@google.com
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250530074831.76fd3931@pumpkin>
In-Reply-To: <20250530030547.3218450-1-kuni1840@gmail.com>
References: <20250529222911.37dc04f3@pumpkin>
	<20250530030547.3218450-1-kuni1840@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_234834_869169_A64EA042 
X-CRM114-Status: GOOD (  22.81  )
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

On Thu, 29 May 2025 20:05:32 -0700
Kuniyuki Iwashima <kuni1840@gmail.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Thu, 29 May 2025 22:29:11 +0100
> > On Mon, 26 May 2025 07:30:13 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> >   
> > > On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:  
> > > > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > > > API and add a fat documentation.
> > > > 
> > > > The next patch will add sock_create_kern() that holds netns refcnt.    
> > > 
> > > Maybe do this before patch 1 to reduce the churn of just touching a
> > > lot of the same callers again?  
> > 
> > You also really want untouched source files to fail to compile.
> > If nothing else it'll stop backports going badly awry.  
> 
> I didn't get what you wanted to say, but I remember the series
> passed make all{yes,mod}config.

One effect of the series seems to be changing sock_create_kern()
so that it 'holds' the network namespace.

Now if I backport one of the changed files to an old kernel version
it will still compile but won't work properly.
(Maybe you've removed the call where it acquired the 'hold'.)

So while the patch series bisects (assuming it all goes through
one tree - and it really needs to go through several) you are
relying on any backports picking up the changes.
(And also the changes to sock_create_kern() not being picked up
without all the other changes.)

Now backports ought to pick up the required dependant patches,
but it is much better to generate compile fails when patches
are missing.
Obscure run-time backport issues are annoying.

	David

