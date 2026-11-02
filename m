Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D260A260B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NIVyrcFT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6CsIcoq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U4e/HCkTNylRsmi8X4W/UinfEijmoIExq4OMj38bBYY=; b=NIVyrcFToRjWvR
	aiWD8HRg8YAmRWE+l4VNu/aP3UcUHSaTvKratlRZFWkAszNKNQItY2U4EvQ3K9tYha8JdGvAYqyot
	Y+Zi3+0/tERVEE38GwIOBmqGGNoP37F36ONrBd5f1Gdf1oefOwFN9FwaKwbABnXywvYQWr0T4ONwf
	oTCNenZc51SWZoFEOICLIjjD6KA5poQ8ByZd27OQmRMVb7Fc8sizYkRJo8/9vxX0FxYL7cojZ6z2i
	ADYmwAqEkQ6HUtrbzfCGvPC1qGCogqwlNzu5/XmNdG4qDOdxdOt2fu8l5Pen9/sSNQxXi30Q1lIUw
	YhOw0CDi6RbdLBoTLAIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNoiy-0000000G5sE-0ucu;
	Mon, 02 Nov 2026 09:53:08 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNoiv-0000000G5rP-4B7R
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 09:53:07 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2eac4877accso9072015ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613185; x=1794217985; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4e/HCkTNylRsmi8X4W/UinfEijmoIExq4OMj38bBYY=;
        b=Z6CsIcoqPEdg59KAJCwqtT4hzaX7j042Vxw/MANEojKURwRdzCcW0tgHobsJpETLYr
         QuhzahbdzfPqnW1wgeGMeQimOKAKb83fCDPG30ebek/VIGHtf+/9UZ05OmRLdn9R/8ca
         /2KtoTEVcnD7j3+MhMh1fDv9ZTWj1NCiBLP0S1PE033eMmGdewl6i/ZCcHIDj1k2UK8b
         JysWKkz/VJGRStCSVecThBmDmayj8BHlYiLR62rLfybhSMUaClBqvWE6QOpj6IKJX5Rp
         g7S4znw0X/Efw7ZW3PXp5eyfCRpHphyKVHSeHiSEjBLrxTl5mWWI4W9rtSunJ5QMBwZx
         5rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613185; x=1794217985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4e/HCkTNylRsmi8X4W/UinfEijmoIExq4OMj38bBYY=;
        b=X1wNyiABgxu2sCeebo0K4v+bgoGS5v1u+lpRZtouAAa2vY001JqQL0+vSE4xz5IrlH
         RGPC22Ek8H8+3/NiX1PB5bDnNoHqD7wrtM0Ot26JFlIjv2b/XTc8RKmWgqjHEkHSgMiU
         pznykRzKDwmIsR7/5IK/Tb967rTA9OaJfVf0JBYtQ9YJ13kSuE+pN6mEIcgd/QzFUARZ
         39rXzp0W64RHCcLY+a5z6vfgYkU5wtUkDplGKqqf6lqrXMLEhqPzzPd1srVX12tG9dEO
         K7xHfaIAzRZ4uTGLzQXdRrf/wnx5JRMZD7W1Qd2xO69Q0L8tjVMR9YeYZ1HYSqfzc89p
         A4Xg==
X-Forwarded-Encrypted: i=1; AKwUvByRioEXh5WPH8X0b0lvsxjSl7+tqqu1nhHCIR1ZeMRjZP2ooDhM3VCinbZ6JvoRo23aMFbauiwK+j/w@lists.infradead.org
X-Gm-Message-State: APuU4Z91FCN8dM/pSsTOomMX1nbdlvfgvvfBmNkfeEblvl9rManO02Nn
	7zq2f/gCRwOXH7/UMl3QzaB8aiaOSPxvyr1b78DEs6qd6GJjc1X4dKZE
X-Gm-Gg: AYBFou2bNerA7LhnW3SoqfuxYkyZ70Fe8Qckwpo0FysA95VWk0DY43AxF1aqZZNYzCz
	Awc/I1FYhPvScVO9RVqNPHGAT6uPCu7EodPTtZ15FLd9V7zN/uw49NY96UY9jqym8lpB3t44r+Q
	4bMb4ASZ3QSZnokdOk3AwYIHMlKHsz3IapgOi9FY4qZeq1H3aKfJcFJDQYQKoapLlUCD0d5jTR2
	4Zpvnzj14JCGgWiaW/2bPxexE/KZvJ+9VAlscyjWJAUlqoIxCOZUsbc+zAKw7jf8Bjfd3b1P6Rh
	vjvQOAM+e5SfC6mqQGpAkJHrv65yLrNbbqGDEFUUcBjaLItRJQfKfSJgBgy8I1sxWYEFnzPfBnS
	O6Kc1qB99M0k4pWqK+Q0hYod2+T2BGpEqqM7HVkMglS7Baj+ol62q0NWtQognJM8go12Z4BVbS4
	/jYDNJ2auiKTPuerJbAsZbxOk6AKqbXfrDGGJGYMUkX6aZZqRQD0wwqevF2Rkr/jVLlm3n+p/QS
	fi4K8uPXZmgs5vkmHkcFrlgBKe0MVC/CXvMnu/zmrf1TzqghsIx9JXvMYWa+R0MluGxILc7iUpQ
	BbWoq+IfJCCWXQhbNNXXiZwoKGG98tGDMiZbOSF/Wu2BXAqg0lhH+gQ=
X-Received: by 2002:a17:903:18a:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2eb364de913mr93536715ad.47.1793613185064;
        Mon, 02 Nov 2026 01:53:05 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922fc4bsm26472485ad.12.2026.11.02.01.53.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:53:04 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: john.garry@linux.dev,
	nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Do not drop the cdev reference twice when cdev_device_add() fails
Date: Mon,  2 Nov 2026 17:52:57 +0800
Message-ID: <20261102095257.37287-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102095015.36448-1-izaiahsun@gmail.com>
References: <20261102095015.36448-1-izaiahsun@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_015306_036030_00E8F40E 
X-CRM114-Status: UNSURE (   6.70  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I sent this without my sign-off, sorry:

Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>

I can resend it with the tag in place if that is easier.

