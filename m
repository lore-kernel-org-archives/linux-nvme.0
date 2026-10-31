Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C691606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4oS/ISHW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqSl9aJD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9bOAqTsOXodJ3DV3e/3hRQIH3+U18bEo6K95SKJR4yg=; b=4oS/ISHWXtcYYU
	z1qVww11HNYz+q/jzTW+qNRQx8xT9mOsAkXwoDFKBNTtPfV9F6kKOgRPKb+EVI25/RZ6XyOPbeXbo
	GjPy1N7HrvrH9ERr8MI92zRW9xPweuwmOrd2i87Wwirwjj6EAmkQ0lm/77KAZP/ylupMAinMVBsmn
	ysCBm3qJrjnJnYpzxZyT9IrJ6On1VlmAbG80kNAGQM6KSgaBPmS2MI8VXI3I032qyFzjEx0yZQUpB
	XtTnM9/B8UEb9020+Akkx6Sv6rYBflemKYrzNn6raQb0v21ryrt5qoInudo6kbjNmXmWe1jSg2hWS
	a5pGkNsOq3+Wu2P9ktRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN84f-0000000DIhc-1BeT;
	Sat, 31 Oct 2026 12:20:41 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN84c-0000000DIhJ-2w89
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 12:20:39 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1931ff67a29so1506611c88.1
        for <linux-nvme@lists.infradead.org>; Sat, 31 Oct 2026 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793449238; x=1794054038; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bOAqTsOXodJ3DV3e/3hRQIH3+U18bEo6K95SKJR4yg=;
        b=qqSl9aJDJygWm/S4ttDAqr3rZuoITAZg6iGFnxI/r6nX+oshQbl6ANM6/2jgySbHKo
         mPSaiR5Kyb7bOG3rBl1zMT7nkB0IAOhh1luOKFZaKVrdOlyljqs6U9PUuhS4/5o0Z+rt
         zOIoJSFQm2O1IhkK+9AcJN4m3W2gkRjaMVCaATqZkwHIW5f27jCkPmIilN9xSZ9cn+lh
         lO6E8+BuKOaR4Hq3UEUeXVtGEB8AhrUdtcA2SIGWDZ9Pegux9w/WUUBr1J5qLlXNqam+
         4SwOsWF8HXX/rMOkysIjhkymF/DSNmJtw7UbgPyKIn5R3IkOWRNpkoR097Qac+E6luB8
         1L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793449238; x=1794054038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bOAqTsOXodJ3DV3e/3hRQIH3+U18bEo6K95SKJR4yg=;
        b=MGDHGTJewzVO6Z8jh2osEifWhIHyV+fCJKL0HI7+Kd7EUpbIyG2ONHQsl2MFAe8GoI
         RpswnttWOnupg/EqBz1b+a4V5sChwRYqsQ+JCBClpz4mac3obDfaWqJRZX6RWzmIHA80
         SILmkzf5eq4l98YEdGx6TnOAbRgMN9hSFLlf7C/yrzF59Co7KULaz9CS3IwOBpsYckwb
         N1+K9Fw5y2RQJhzZPlP9jAwAFaAga09BQVVtDmRg9iocvApe2iF4XlDEtqevR0KRB1sm
         zicfBXxahcs7+UgmQ8YhlSG5SsXRpi8MwkrSaelwNa/jMPwXxl50C7UiWDk+XPTx5TkQ
         DnaA==
X-Forwarded-Encrypted: i=1; AKwUvBzE8kz3LoRNqkztyx6BIFG+n2i7y0F/ZmBRl4wonAbVzYiPBtu/jMwy4km7lnMk71pZYXxGor5T5w3r@lists.infradead.org
X-Gm-Message-State: AFq9FYL2ncRn087BjutDu8QPLQqmutCkX/YMQGNC2jBKQs7R447DVRhD
	gVAuh4euX/+jgoZmTkIHdyyw0FzsE86565oQEW0u2D5HuGTLjW3wN/FY
X-Gm-Gg: AYBFou0yliT/ZY+DHxsWoPl9MgDZc7oafAao34VpmFzU56Gto+af0hrUIYuxC9iVut1
	G6+FMdhrxynrQT/PxJhQxImvrfXoTGMTNTFGRBzzEbuu8wJzecF0/BM7B2lCgA0CD27qgNdRm1k
	amQCrLuvhUHY+ubNvDxfpOgi32mPs3WG/xTR6ukbA55xCfyS05/Z95mlY298+jg1GfsWFbxDS68
	qsdORVL7BDfkmH7XTAf5YUB8Z6m+fDMsSIcjFO9rWBR7LI6/saGIBl9UcN9e72DDokbdZy+LpD6
	dKekdofdAVtUdVea76BZYf2mW7a4aFI1FRKDoFvBvu0263ATNVwtDmTvEbHztULgPkagHbnEWXv
	6mSe+LmTXWatpfA20V/mR8OrkKUHKVjrdZUerW94AuvMuDrwd5dk2UzcXGpB0/l+kml0bIFRvVG
	z42aOkTgkaxZnwPz+lvJWCrFflZ+27oscEN22nfGI3bvu7R4cLDLmHNI3KreQM7hX3tYcScSREJ
	RKjaTn3BiLL8PNpVS0YuMSdOgqTaZY6iaHyLjZiWnlfbFsW2wye+tQTIvZfa/KXVYJhmrL6IGgH
	SunrVR+ozMXQxOh7ri4QDMNo8rEtqycCPZOuwN8c+tmubh/pKQ==
X-Received: by 2002:a05:7022:ea4b:b0:1a7:979f:ecc0 with SMTP id a92af1059eb24-1ac5b7e1074mr6738341c88.27.1793449237687;
        Sat, 31 Oct 2026 05:20:37 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm26919177c88.10.2026.10.31.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:20:37 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sreekuttan2156239@gmail.com
Cc: hare@suse.de,
	hch@lst.de,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet: preserve ANA log page copy errors
Date: Sat, 31 Oct 2026 12:19:57 +0000
Message-ID: <20261031121957.2808-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
References: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_052038_765748_17CBDE19 
X-CRM114-Status: UNSURE (   6.04  )
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

After further investigation, I found that the existing header-copy behavior is intentional for short ANA log-page reads. My proposed changes do not provide a functional fix.

I am withdrawing this patch. Please disregard both versions.

Sorry for the noise.

Thanks,
Sreeraj

