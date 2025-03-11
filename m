Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B44BC28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=; b=yMYfHqyAZq6xXYMQf49dRlR5oz
	b8c7JX7gUSP6S3vyHQl4NDUKTyfIKyLxJB78c0YSev2ZJayoP+jeeAQoM9CbmKErRh+wHs7G1vfT/
	1Vomg+vzg1T0tjqkEzinHhEqJJomZBa9WsKdeo3AHaqUpoJXlolb0p1ZQi+zkzwcfj6mHIPHvewyk
	ogl5aernX1o74m9hGNZo5SwfqlhjM9Cv99RRt5xFZRrEHYHINmRhrcXbfwdC6hW+FVoJ8piC0nkTO
	0wc4I16oClR6XI8OFt5mrUolX9ojcYTrN0Uo71Ncxc+j1R5wn071Mxyp2ebIOAiJivCCeAEyxzlg5
	QA8TvgmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts00m-00000005snY-0EoO;
	Tue, 11 Mar 2025 13:51:12 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts005-00000005siF-3lHJ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 13:50:31 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3d43c972616so16621915ab.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Mar 2025 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741701029; x=1742305829; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=;
        b=BIeCEFm4DptBTkBIc00SrydXXRKNS1i0b4aH9+mGwYOY0lw/I11+hSEACzpSmJw1iU
         UK5ofczyjv0d6s8/K8Yyc5ngDOPlKR02R0POb4FCoGOp/zW190cvh86xyB6iBcX7otqW
         gAWcAdMZPqeUfXEs3Txc1PZyzx8ZVMDe1J9OETTbkyZ+l2ATGFoXebf9cRQ9oGK1ofmV
         Op8mLODnCKh1us4k9Q58UCKs74dY5ecoyQhnmG+rj0avLobLaiqwhCVSrGs9V1B6cSUN
         rRTh0rUb0zsv0HR822Q8zU5GohFgHpEiAN/aVINJUIw5vKwDr1GK15REM34o6Hg3Wp7b
         SdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701029; x=1742305829;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=;
        b=SScRFPvypxzZZgFCNeyjL1ndWX6Duek1+92Z6vNT5Qd47g11Im5LbOWDvz13JuKytY
         BJXmO9rWiR6oXi4LQ0I4JiNPuL0F7rYB6f808TkJWugCHVMpDgXzO1tG+OdfMOxsGnAW
         LeNs7jjNFE2OM415kzr/32WfQeIGQYwSZXBR1n6S7g5khLZhduPKPW9D9DeGeoIKXh3N
         OCTlQHU9v6ZIQeCzxnXjyyQK6LPd2gUORH/Y/xYAiL08Bi24OjirsmWC1cUyijnCpRWQ
         u2wAwRaL+BtyrbvNbMeiHMwBqMc3TnsKBJcPd7iRDhDDgm4xwHf1r3gBC9AtNTS0km1T
         c4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU50ncTQxy+WLIDOVhCLZWxguehQ6EBwmRuku2abojCsgf1U97/tyzUeQ7rujTwe2xS4rqzpc31UkES@lists.infradead.org
X-Gm-Message-State: AOJu0YzinHZzbDYupck6qZousjkLJ3nFPeps7mLS48Hp2k7qhqlBbpKv
	Tbl9h33MX/k+0MY/JGu8tasZVW22KFhBR6ZKgJH/9P9/BdStCVWJOynrWCzxB5M=
X-Gm-Gg: ASbGncu/8lwWxDlrvr6wA/UqeGt20hNWOxMAvhq0e1VZJbVyCKMf0TcWtKhCvHCilVw
	sLya+zt5M0kIPLovBFdUsgeXOKu53fZtuh8usMYF28hPnGddiZ35Fa2RBJzdGvgbjUG/H2tkMUX
	3ujSrM2usOegRS5ykDMMO64QxaxlFMAAlSKC/sBtZlaE3aLmYvMSKk7X63pABgPgf3fkIDcXu8H
	9Ef1c2xezJFRXhQAGiDgvyrXCjxh4DS4dTjyZeesJRFtF+QwQL6djyleqqDyTOu8PasIQg9t8Ie
	mC1+wOwqFClJJ7T5Gh2GDkkZ4urxRqmF8tTQyDEuAg/h0Q==
X-Google-Smtp-Source: AGHT+IEJpumqHggfcCQNZSUxuoyo1e+nAm1OVkr94r5e5qCv6EQWmunFqyrvyE3JGQqty289x1CA7g==
X-Received: by 2002:a05:6e02:3389:b0:3d4:346e:8d49 with SMTP id e9e14a558f8ab-3d4692159fbmr36048055ab.9.1741701028951;
        Tue, 11 Mar 2025 06:50:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f24ca8602bsm275068173.145.2025.03.11.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:50:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
Message-Id: <174170102773.320314.5830688529132236537.b4-ty@kernel.dk>
Date: Tue, 11 Mar 2025 07:50:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_065029_941984_62A5521C 
X-CRM114-Status: GOOD (  10.23  )
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


On Tue, 11 Mar 2025 19:43:57 +0900, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
> failure [1].
> 
> The test case injects errors to the NVMe driver and confirms the errors
> are logged. The first half of the test checks it for non-passthrough
> requests, and the second half checks for passthrough requests. The
> commit made both halves fail.
> 
> [...]

Applied, thanks!

[1/2] nvme: move error logging from nvme_end_req() to __nvme_end_req()
      commit: e5c2bcc0cd47321d78bb4e865d7857304139f95d
[2/2] block: change blk_mq_add_to_batch() third argument type to bool
      commit: f00baf2eac785bba837e5ed79d489f16520e7a6d

Best regards,
-- 
Jens Axboe




