Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24F0C5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=; b=oTsFLmMjARBUEeY8Cukhb7d0T4
	A1ucwk3wpWhBWqrhn/zhycutqT0qQ/0p2dJclCuRf3DstYPGnm45LQ7reaUVvmauvi059QnKkea0X
	mykxvxCnClAgG07CMEBQ7cNvnzjlXSCToTYpsZoHzrAVT6RxoehUNDIfjEirTIv3zZYHGillq9l0E
	oPLdfK5zx6OpW5x1/XTOAhezJGK+zoD/pmt0vE7wps/gsmGM/zWbDWDMimx6+3fVgIBzuPdbzz4nT
	cZ3s1im/qBy03d0ukH1CXVZ2cTl3CRgoof3WAVyBkmxfmlDu1v0qOKLi0O7UNU1cma8wuZXOyaBL0
	opdxkJQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMD5s-000000095zD-3eKy;
	Mon, 02 Jun 2025 21:53:20 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMD5q-000000095yj-2xOH
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 21:53:19 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2351227b098so33371605ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Jun 2025 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748901197; x=1749505997; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=;
        b=COlYOgTUm6oO70R1pi3iyD4/qFa4s34dtIZ+3DDlV+7X+m98dBPsbkFwTNRx5I+TjD
         2l3jooyGVju+4Kka+KNvRRr7eOZON9qezsgDga0KaertExu7H1h3lVEkJkd1nGyQ1eoJ
         ziiXUMOE15/ZnzBvQ0aUFiOSwd5dycmFuP2iryIy/kDEIDwGhhe/j7bBdGrp9gFj6Jdt
         xI5auW5G0ksWz39gEQ5W6lgD6MaRmSo1O834QBgNv1rYMFD+/0MDA2Rk478Res+VBv80
         GC5PtzRqEDZGEZuvoTyTCcmO/grHAWjrxgEtrxTEUxNBiE3SHzLjNqwX+LQqNJD7ibZd
         Q9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748901197; x=1749505997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=;
        b=r9IWc/ikSzoUqnZaaAJfpRVCj/RgZPxJ41L5BGW9TisSL6ncV8uNrRn7Cxo2GMOavd
         GtnRLCi/30MHnYnNqkFk4ryIRqKW4NX5VhgvJgTKUDROwZQ60GLwTRRzbkvGyX0ggh03
         MVr29UIvx3EGbEnF/JATNBn9zV2Hlkat4gvDY03k5T3MoEBPOUd0eTJ1U9QCura1OhuB
         wQc3i88MPN6pSjrXbhv/qUyhPFtI7750dlG9sgwuHN2XQlwJ8pVw/bckuZBhPs61ZR05
         0/nR0DtQV4Uv0NYVX9VTG88DJdccZjJM/iGUKuOr0OunZhhl2JOZ+FIL2b8fwAyNKQxW
         iXig==
X-Forwarded-Encrypted: i=1; AJvYcCVLDh/dohBerii3J8+/BxwqyO8H1hn7N/3B7vsWRkQ0fBfzjM2LV8zd9mqfRWvsXC23XCh09q4XI19x@lists.infradead.org
X-Gm-Message-State: AOJu0Yzik6Ua2H/EkeTz4l8RPBdU5MpOis3v1k4Z5oIKGtMe+YDi24R0
	0WGF8O+5QUPHnm6zej+Q/YA1ZfvFkNnnTbKcrhVPbj/JsOBQcRbgArk=
X-Gm-Gg: ASbGncsoI+To8WP90NfljU56dYrojA0uEIP5q+KDOWZ//22ZXNIgNmK+qOgcN8tvA2R
	KJ6Vn0X85cYAPQ+1NdRVvba6sD4PAPmaWcdNFzxCq3PhEzCQFg43+0c35fBxlNDCURhFQon2dZn
	1qmGzbrr3C1zsuipsUEVtinqkIEFbDRuDJ4wcXWtb3o1BZ5mF3zx2F5k8kli+o1V+EnY50WEdZ2
	Xh3fMG8tz+w/yQEXdo8wNupVB7iGIOgOGosa3sAjq/kd39UAqHarALQuuffZFFLTwKiQi9QEb04
	nvO5BdEWYe6b435D3U/p/bpjavcZ
X-Google-Smtp-Source: AGHT+IFablHnOD0Qjkeg3PmBrfl9McO7L58/0ECQc55ZulNN/C+wNm8xqlIMyGBLFl88nguN3OKykw==
X-Received: by 2002:a17:902:ea06:b0:234:ef42:5d65 with SMTP id d9443c01a7336-2355f79fb5amr139393815ad.52.1748901197133;
        Mon, 02 Jun 2025 14:53:17 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf954esm75552875ad.210.2025.06.02.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 14:53:16 -0700 (PDT)
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
Date: Mon,  2 Jun 2025 14:52:47 -0700
Message-ID: <20250602215314.2531309-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602050949.GA21943@lst.de>
References: <20250602050949.GA21943@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_145318_743813_7DCA7211 
X-CRM114-Status: GOOD (  10.95  )
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
Date: Mon, 2 Jun 2025 07:09:49 +0200
> On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > I actually tried to to do so as sock_create_user() in the
> > previous series but was advised to avoid rename as the benefit
> > against LoC was low.
> 
> I can't really parse this.  What is the 'benefit against LoC'?

It was a kind of subjective opinion whether the amount of changes
was worth or not.

