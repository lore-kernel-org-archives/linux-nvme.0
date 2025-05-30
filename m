Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D016FC54FB3
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 02:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=; b=UDye5164E4+4YdD0p/aF7j65u4
	Em5J/KjkAlTIpD2lEzHZ0Ho2XA9JLCMDAeR7LzqYJjdC9kB0WMpLGLtqIXlMUazdTXFlKd05ukyeQ
	cfXp2jvAPA4PT1R4wPGWg/vNAoSh6kxwlxoAmOwc3j9+JvJSN375ZMfSCraysoiBg152BRrO7H9zU
	kKfUmwB8tW9gFnw5oi2Fn9iy48INPYzkHG/Jjmi3PEnBct3OM+oX6RHlH57S5seoZRhyDEWmdbE8X
	pWKEyjz75yWWBr4OXXTwg6ZbWEZNwx1pyQBLQMKZbQr29V+s+GYnO1Hc4tq3mJ4QgunCfWbsKO4Kx
	LE4UhLVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKpyA-0000000GzHV-1wEc;
	Fri, 30 May 2025 02:59:42 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKpy8-0000000GzGc-0TL7
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 02:59:41 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3116db72bd7so1627559a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573979; x=1749178779; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=;
        b=e7f73DQuNlrojNtkPa9LLoHZD72anFmmI4djTTe5Cd3bEHjXe7tQbkYZjSGmvmvSzz
         jcOUfIrfFXswEb1S+QiNZYbu4L0s82EpSDDnZnBmnNqM3dbzSuIhSk4cXCklv9w+VPeO
         8dWrH9wNlT4Q+HyHcnmY6gDRcE3851A8+lsmO4GCX4EzcfdnpY2LOu/KuEI6yPfUGQBf
         VFV4wW8KVMFx3IM6V/tU9hkhKp4a1flzDHQLO9Vkw8wP9soDgw6f1dzPFdiuRt5YKHPx
         MTZw0qj+c6Nf8B2Xk+U1WqO844rPP0SroXY/+Vg5L5UMOYEeCqkNaCCa6PQO3wl8T8J4
         +uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573979; x=1749178779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=;
        b=u8sX6mnACtdR7SPHdWcx/YAuzzObdbtgkFfaavX7BGqYIj9Mf5q8NwHFkf/UjPESUH
         uO63ULlQjdEIb2t8jluC2fqSPZ8lfkgc1ALqn5Kfhicj3b+y2uMOajxrxV/2ym+rx+ew
         GsBxWo8soHfUWrdwAPLdpt1ObRBrD6CabecUZjMtmNQSiz6eS/3DF78e0VNup98kj6t5
         LA0NSrgWu5i37IlSzNEoweLZ3omreAq0WMZn8hkU0l651k7ogy+1d88vC1sT33CA9/Pr
         HxrCClUB7VLt8+V7MQemZFTDIr7Dv0/VG5HBwpbMxFbUMmAJwilB5hReR9fx0nCgywqM
         WBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJSqDzSlpdpaf95v1vFryrLdXcdz3AQED4BmHQ7R5Iiwica8aXzsIybVogzTdY5zwn4nzcnou+pcgJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2377ms7sf6SU5uhdUtdFKhTQtawmAdbqZmG99so8tMMJ7+hOn
	Fsx8APlcI0Bxl0+Wjr9xSh51v3lQ5Ulp9ClZSAiH9IW+0cTuppxZCE0=
X-Gm-Gg: ASbGnctJnMg1ot+m6WuyedUW9LAI/gkD2huA4iChutRD/TgWAieyHmfLlwVQPhoL8le
	cLQ3wU/RXuXWjYS7sfDmcMoFxmm+/ySvt0JEA8qnh7AhJ0QphE6Tf2sRJwxRF9dsdb82mERZXKZ
	JgRRhO35Sr5FGqe8qdOb4ynqyU5s1GYUPKlZhFt3dMHTn1uUhwl2HA2viwKC4BzkkdWAt2BRUEb
	J2Mm2lVBjoCoikl2EL6aE1M7ednmwi9Fnn80QfDqi/VPqdOTNKHMGsNcpjTFraP3cQnsRji40FP
	DBzA2DnE2uL3SGLh8KXc/6lFCPNd
X-Google-Smtp-Source: AGHT+IHAp+B0ti+QnJpuPvLDos14gktvJbY4vx5x1X1dIQardFp/ZXV7fELwwD6fMQPTpZOdVEzadQ==
X-Received: by 2002:a17:90a:e7cc:b0:311:b0ec:1352 with SMTP id 98e67ed59e1d1-3124152772cmr2869665a91.11.1748573979187;
        Thu, 29 May 2025 19:59:39 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f8aasm280977a91.8.2025.05.29.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:59:38 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 5/7] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 29 May 2025 19:59:33 -0700
Message-ID: <20250530025937.3214873-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053321.GE11639@lst.de>
References: <20250526053321.GE11639@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_195940_149627_12398C68 
X-CRM114-Status: GOOD (  13.78  )
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
Date: Mon, 26 May 2025 07:33:21 +0200
> On Fri, May 23, 2025 at 11:21:11AM -0700, Kuniyuki Iwashima wrote:
> > Let's drop the conversion and use sock_create_kern() instead.
> 
> Please send a patch per subsystem that is converted to make the
> commit log better and help with bisectability.

Do you mean splitting this patch into per-subsystem patches
within the same series or sending non-netdev patches separately ?

The former is fine, but I think this change should be done in
the same series as the main goal of the series is the changes
in this patch, making kernel TCP sockets hold netns ref in a
single place.

