Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D63606A32E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1oJR3Q9U;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la9R0RUh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=; b=1oJR3Q9U386kDO
	Cq8yRBVNsxo56fQAnKCFWIB+chhEZH5yEMR/SUH76dw4svThaHIqc7KGMx4Vsq57RvKCzSNALnFmx
	9VD6HOfTLzXSgsv9mimd908nqOIKoX9N4tgr2WaJnm+LZfrevGKLUAs7K0IkVrsUgTrr/rGhIhS+D
	vCTrQdKhJPQmbXh1V1Ohrof2GckBOeFr5CvbZNHPo0wqQ2gpG4JeKwxxzA5Bt9PIOSzsNkqDAlzSn
	cs0qook7MTQoKtUlp9HBB5NLgxGaSm7LbJZcOvnXPvwGfFbhlTFEUoArWqgfwRHJiNO/ETqLajK9c
	KKoS8Slpw1OytywvkjoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdWP-00000005suf-0L0G;
	Wed, 04 Nov 2026 16:07:33 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdWM-00000005suN-2jZV
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:07:31 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-35b2c599f43so1783932eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793808449; x=1794413249; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=la9R0RUhgOwHjnf759GT7UIqQ8dkrVuZ+CR7cnBXHmRTTfTWbWQT9yt8VVuDsVCjaC
         wHJ8gUjs1PQnb6cGYCqbHmKyeputrd5UOHu39wIkA8y0/E/F6BL6+F2p+Bg7wwk/YncU
         ZjJi0oj4vPefp+on2yTPArB1nCF7dSWHAohbTjmHewMXr7NaKZNJtHf3FvhxUIBIo0th
         SoK6qI7IiDMcbwRQWvwyXYoCMgArXlgYh28G80Xp9/yqWA4EziAgcrr0R1wUOw0qyC+5
         HDCOaLHEasA14OCXNvGWtVC3PNU4xMflS4G5WLLoiwWiGjblhF1rHZKHQ64Yk9Qu9xbv
         l6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793808449; x=1794413249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=NmgPeJhjRJmFUC70gp3tpsUS/vN9vnpt98o73efZMBTTIH+NF92ZJfQBl2hHIGIHSk
         TxGIFMTGos1zTF3VeghOjfKoFr0Pd2+n+JPnq2iOsb4w5+LSCosjX+i6Ihh67PU4wq3m
         pIqTWe5Ip19wZwDzTMLsditYZE9vSIJhE5w8FAD7kB27KmQz/QdBMfRpr+9NduSVCXY9
         HEptKItxue7v0Dy04eO4P/wJCOtWMu0IjMYmKupsudUsuwSg4FV9zR09kKVoruYx7YTU
         7/ud5VzFzD45PSf1fOhUnxWISFb8n65Y5j+Shy/6VNYeFFMUIFQJZPMXQ+3t0nVZ74ob
         MZzg==
X-Forwarded-Encrypted: i=1; AKwUvBwAHg5u7VJr5q6UGqYdrJ2+kpWkzqcpbaTiZZJ11++iqFsf/M/1Yy9hCv2BGeJjNWkXaWel51hnM6ue@lists.infradead.org
X-Gm-Message-State: APuU4Z91+eK+3Se9O18R8+Z4Fm/VXeZS7aOT1T3WKxfLpwckeR8PLiHs
	vuvtnM6WrXKvkGHHpJqweboyaXjiMvgOPRahzqDldP2N1x9w5xULRVS7
X-Gm-Gg: AYBFou3cNV4h1cwPpUUwVJGpLxonBIkSxXYwNCBwGVKzleTUcyGa7Fb9laTYTIFLM1p
	hI6VKMR+QZgDgM5fR+LnF9TwXGglT1armtd9a+eT3vTTP35Rsu/e6jWeQCW0nsglunXKQptja38
	ZJ51NKEvUCmp2EAm+Tl1JwUy/BUuQJfjAYVa7m7taVhpndET5Z41300C1V/Lmf5ffVirwt0gQaN
	3uwiNV0GdGVxL75UURjr4X56NZBs64bV3HxypQHtvQouwb0/NkJ1ziD5W7XvWPaF/eNU+8rCJVa
	Ep/aEe5VcuzVtQl2hzwUT0Tt1IUavUQ9Gjs0M9yMqpu3iJjt8GoarehHjWIMI/ts0A5cz+Tchph
	R3snoUsKH1C5l42DHi0bTG6HEyzoSwBFrRsNXQmy8kF4Hzg5Ycj/Au2kV/ylgTMY1Sm1lA9McXm
	W/8PV5QFaA65lyVdOn6rzqjulsuiPNxrX5FoQrvMZLmSccn0qNg7qb+blXuMEbWQTUjP4q2kLoV
	n6CRreNjhkHVDx4aMa/TXP8wqggNsaCrEk17rLDGk8ZKXglyprkbDddWZLN55sB4VPLRUDk1OGA
	9ZCKu40s+82y4rYHEcfJDez+Qu4S8jZPf5HjbZRzbDqevBonXds=
X-Received: by 2002:a05:7301:4546:b0:36c:a93b:1ba3 with SMTP id 5a478bee46e88-36ca93b1f2bmr3137939eec.20.1793808448995;
        Wed, 04 Nov 2026 08:07:28 -0800 (PST)
Received: from localhost.localdomain ([103.178.205.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm276249eec.18.2026.11.04.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:07:28 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: kbusch@kernel.org
Cc: hare@suse.de,
	hch@lst.de,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v2] nvmet: use appropriate types for authentication payload lengths
Date: Wed,  4 Nov 2026 16:06:52 +0000
Message-ID: <20261104160652.3603-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aun_15SXOxpzPZXT@kbusch-mbp>
References: <aun_15SXOxpzPZXT@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_080730_721823_9CE46E0E 
X-CRM114-Status: UNSURE (   6.51  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thanks for applying the patch!

Best regards,
Sreeraj

