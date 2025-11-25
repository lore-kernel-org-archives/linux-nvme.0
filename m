Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E319ED1036B
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=; b=spDZC3qFBiAETOzgiPERy3uM0y
	txUvlAt48r7ruFs4riY5kpJ5VXqVRHE/oHffD+JrNxmV0KvxuSSfGxsyfIS/qc3f/v2CZMzdEv0EW
	k8Fu68spLNdatfw59cFdXXSOJfXwJwVr1fHV8hssUXra6EWHFLmv4uvcBE4B+lx/BWJy4quCclCDP
	uu0cJ0f+1FWSNu8YkENgo93gmKaNJFaOcfZiEVdecbMju9uDIp+ZnD10lNjMR1NZDGXZjTRardW/V
	fxVXMgEeg0h1ZL9iWCk5M6C0PWtwRZvQvCQRz90SQ/HzY68r5sURoz5/PAAIOsr18DjVBWuR0QZDx
	6EJNXM7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO2XS-0000000E40y-3tEi;
	Tue, 25 Nov 2025 23:33:38 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO2XR-0000000E40A-0pUe
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 23:33:38 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3438231df5fso7943891a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764113616; x=1764718416; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
        b=QPyL/bYzgqanTLOQgFQGtznC9e4C60Tntdxmp52X7/EChQDbXqwCErsIVMj8uYwqV7
         y1P5ubduU4VuZr0wwoiJHsx0hj5h+vNpV0eY3DVJqzwloxi6XtFvvEU8zxsTsItCLGaK
         aqGPtUmJadZM7m0l3zdx81eoUBrqKVn9yNQN2OSUDtrGhS/KEQmqDD7ZpwNHCWzTWNqL
         Iuk8qvxDqZasfifcQ50VMJzX1XuPpIGnM5pAkXo0pRkkyTkfHc04/da6t00Av89TwXIk
         MIWfXiV9e+j5f4CGa2tNvRHdcGoBassn3/ZajaY/aJeDKPmbNcKPuIMV7ojZ46V5n6YH
         iitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764113616; x=1764718416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
        b=A99mYtsu55K3Nl+17fhnT/tEk1WV0gCIlKL6Q3XnA4P05TOdJY3na2dtrw54wNtIYS
         PUE8lJphHGtxQgtZmY0K25+U/hF0rCzHpfr6rzkaNdLYc7vHEm8YxXa1MIpfD8tOsx7A
         jE9Z8kAO8t+TBZqxHJWhRBxlF+ocifLsme9Kvli59Q02oBIIY8YXi49M4P3z8rbvwrSz
         hSm1YhKMXsrSImpQSA9hvSJJjYSAxsmHqa6FnkBqpW3B6H/TgDH/LxhXTR6/PrPvqsm+
         JCqCW8yooKkK7Yt5M/HvaM2/nnGjzQs0sP1Z2dees/xgx71xQuC5fDKxUIIQAXxm6OCS
         wXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS3nELoFil6spoP71wVyNd1px7seG1Lba01HqdaHQ34Vv7jlcL1GLVVggBjqYtH31456Z3pocjL5cq@lists.infradead.org
X-Gm-Message-State: AOJu0YwRsDFjb15nlB6wRhkT11ro3nEDsZyi8b8LpyOPPyQ+VVMboA5U
	vbjpsKqGU8LcR0UEANrQdr/jGO+WmxPxwRXdMK+FMgaRlIEoPqO9eULE
X-Gm-Gg: ASbGncs6rtyWJwZmJW7D6CXrpOZX2e/je3t3zf8NCBrpiXzZnFryaGeeTkKIBSHhXV7
	H3mpTeDnQg5lPk10/csxWjEtLWQicZ3ZNFgsuClT1Nboe2SdupJCHcM3mUp0YtynpaOlTjDIR4w
	qkfesBNqZrSgNKC9eQbLvjTj/eG6/ThfJdpQkPCqG9lzehURdgb8mu2OZXBxiSOYccMHIk5Suwi
	QX414pMud0ebHOSsg3olsGSrTXCSzAUHOlMe1xS+048I6Qt4lee4UsW8QMeOjKjGxOZwjUBWsyO
	vJtXAuXQM3+slEtA4rU0LynO/CApf3+CFyJv3fca4nJ6mLHTGsq0LRAhTDuIgf1PfBmLQUpYMdq
	PwETZ8v8vyqkEAkPtOlCsrvhJwwOgJDYlSyLCP89AxlkoE1fhVGa4q0m5+IWVlD7lmGMoDq8FS4
	DKbT+ljIchh6cPofjDBzF1ogMI5uU=
X-Google-Smtp-Source: AGHT+IGN2yQvKPDnQSI+rfi8GFgwmIi2Dp/WjRDvh8wa+7M3RBmYm0POoYwrQhejduq1ue9sQHFv6Q==
X-Received: by 2002:a17:90b:3a4e:b0:33f:ebc2:645 with SMTP id 98e67ed59e1d1-3475ed448a0mr4374100a91.20.1764113616140;
        Tue, 25 Nov 2025 15:33:36 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff0eae4sm1654152a91.4.2025.11.25.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:33:35 -0800 (PST)
Message-ID: <2146e663be965ee0d7ef446c7c716d1c77a8a416.camel@gmail.com>
Subject: Re: [PATCH V2 1/5] block: ignore discard return value
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, 	chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 26 Nov 2025 09:33:26 +1000
In-Reply-To: <20251124025737.203571-2-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	 <20251124025737.203571-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_153337_258999_8DFBE900 
X-CRM114-Status: UNSURE (   4.66  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred

