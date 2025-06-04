Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BDAC5B543
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=; b=EbB4HXIgiOqOYvW0/5lC5l7unE
	JeJckMQOXBYjq0yrG9tzihzBejD0Wjn4aqFYd+hoig/8ra4JsGfYqxQOiW5e1GTdZra/B+D8yKB7B
	z1qdm3PfE1rS1KKLrhSUIubvIqV3B05Q2Xyn44Tt4mpg1t+N7GZCCaPU+0dGOY/nX9QZInMU1vxMN
	SeB6Yjq6aHhcB+qxPmfR/sNnDkadLmF1FjHKt5tvqng+KYTgEXu2VLdSCKfQt3FURoCpNt2s5i1mR
	90Reg8VSkIMOyQIfwDg9SUa/+LXIcRCrZxf1UuMnGEHT/N665jZYUyRrAlwjxwNccb0b0RJgkSo4w
	9+UXYnpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMsj0-0000000E09y-3g0T;
	Wed, 04 Jun 2025 18:20:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMsiz-0000000E09l-2nDO
	for linux-nvme@bombadil.infradead.org;
	Wed, 04 Jun 2025 18:20:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=; b=qok3itK713iMGWyF9il1NQmqtU
	UUhrPJyhNsKvfqPL5zqHQoqT5tusrH62/jVTAsNr9T3BYUGCHwNJeSs1yyM4nuSqlOhxY7Qz6++Bq
	aXp2nG0yo3DEPN788nyBrUHoBpuBO8Udm5hypjKhlJsIsIANn7QO7l++ElvuFbp0Rz0xNqdnLXEAz
	CSYtOcJnK76eEYg03+j4o04vD3oMEEHwtGb08c5+23UECQV9YCqxjaBZneOzlz3uSXfjH52y14/NZ
	WPlnAK0p4NmGPq9nnsjkEQrWXv90w4XRkPKPVLn/VzFLMDESAfFRwETUVDW8pFLJ/F8NveWCjUbTu
	/nJUnuzg==;
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMsiw-00000000yNs-1KUj
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 18:20:27 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-234b9dfb842so1870915ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jun 2025 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749061223; x=1749666023; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=;
        b=MmYjKw2b8h6e+gEMaAxYzcO27Chqb7tg8rLvm6sKCqadGFY+jXzrj2FWGeHqA5+pVS
         /teLbXMEIOI3v1duQXfywPYrv+uNB6oG0gElwJqmRZQ92ovJt6V3y8+aRdC4WBvc9sBl
         ex/LcwCKVOGhiIua1RzHjXVg4AfIFKkI4zJ+G51sizxPLtNXY4BmS/6Edrp+cdK7dpCc
         HNt8KtDvIIxOYM6lsJXNKqkGYq7XTnO43/FqVSAzClJLmF9zd625KKlU6FOhiFbjxVa7
         vBRodDckbA6hfRoGkzwp/3sXBjiilmX6jXM10xwjKln8XLq5PPf4nFtx+IsXxw/cap10
         T+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749061223; x=1749666023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=;
        b=n4tifCCX3BReixhlYuPde3MJT6ObDxmMSTEb8VjsOrPQlI8LKVEN+PTaoH5UQI6UnI
         p8nm2zMSz0a/F5QPaBLW3SACxClsshITE17PuSFE9THUfjyLJhvEJud8ozmWzvH98fjx
         2B7iAJHNKCcPyTNyjH3LrdwwavWVGriDQ9JrxBOeNxknX1k/Dfx72hNSsmUUVj72H43e
         nUl8JBr96pmBWMZahxRlkoowLJpVWlAJaLuY121U04kAaD2MLw2Zz6HIC06vJJkYjWDY
         QcO8VxxaJ3upimXNY48NuSanJOnr6X2HGeiIEBdl6oWnwLJqJe99yGhUdo8MG35uKghn
         lzmA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvWSjUbm8LtOkHEGVve7H87mg4rH3GZwjz2v0WBWL2y6mZG/8wSMT55Jkj2yCdyMSyo1aR2JamAIc@lists.infradead.org
X-Gm-Message-State: AOJu0YxklJ8xVrurcKBTu9YpcRfLAEpe/uMMXX9wv1hKPrBfGtJmYqwW
	5aNjetB2xmv+M3LV0mq/DShWVczxuxYrvfGjj5XfOJtLcgXI4RfeBDM1ZN+1ezAaZw==
X-Gm-Gg: ASbGncv2cxcZyTUrXLtS9qZ7ZTTLC8jit1LAzheGPtgO8M5dL+NWQrvGQwiE/LmLe19
	Sg/QOM6glpA4LkIWnCzd7Gu6SZwm54hnj/SgE78llDcLuqHEJmPauLts2M//OklkUDi+ud2uDxM
	8BazA8KqFg2BxNF8ylugSWfycI16bBxBCbUBxxH8nU+yYAf214vyUwGNjpzZnz8d0ifcBqEL5Yv
	h8d0g+l9QDUcRD19oZzg5CV3JqgH2F0tCnrk2r7k1TCExEBPPkvh2LDXJyIOUZtDeJlOlR9+ulC
	nTMo9YQo/x8lezZfSavNb7BKkHnIMGxhu6NUZAs=
X-Google-Smtp-Source: AGHT+IGIouN/nMiCxvNDy5Ikm1iFDpXIIVrGTTraPYBI83jtD4OKXOtjOvlar8/eWBmagZfZh4sDMA==
X-Received: by 2002:a17:902:e74c:b0:235:225d:3098 with SMTP id d9443c01a7336-235e11fef9amr54068335ad.46.1749061222816;
        Wed, 04 Jun 2025 11:20:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb9a5eesm7841454a12.53.2025.06.04.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:20:22 -0700 (PDT)
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
Date: Wed,  4 Jun 2025 11:20:17 -0700
Message-ID: <20250604182020.126258-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603045021.GA8367@lst.de>
References: <20250603045021.GA8367@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_192026_379463_A89F4A5B 
X-CRM114-Status: GOOD (  18.01  )
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
Date: Tue, 3 Jun 2025 06:50:21 +0200
> On Mon, Jun 02, 2025 at 02:52:47PM -0700, Kuniyuki Iwashima wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Mon, 2 Jun 2025 07:09:49 +0200
> > > On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > > > I actually tried to to do so as sock_create_user() in the
> > > > previous series but was advised to avoid rename as the benefit
> > > > against LoC was low.
> > > 
> > > I can't really parse this.  What is the 'benefit against LoC'?
> > 
> > It was a kind of subjective opinion whether the amount of changes
> > was worth or not.
> 
> So the simple scripted renaming was not worth it.  Maybe I misunderstand,
> but based on the reading we should basically have about a handful
> callers of the non-__kern variant left.  Or is it a lot more?

Yes, after this series, only 2 sock_create() left, one in sctp and
another in core.

