Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AC606A31B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=biCtoAp9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OEdcitpZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IbtxibXdI9zyqjziQv0IxMo79fhmOdo8yS+ycPfz4Yk=; b=biCtoAp9a/ssiW
	Lt0YJbcbkr/2scAF4MZkD5kOLr4mpbVJCv+YKgQzupFqx9nJu6mpKKAhE3TIkC2WRWW+pfgZw7d2K
	Pa4JtQ9NRq4k38/XfosdtkNIZMRGk1s3e8nIJLeEX3ghJFicSD14ZTNF5M3hiPUu4LAvfaetS+Tpd
	WdzCub5JoY1NolO8+zV4+QsB0k91pcMAgsNz9HMsKz5aepTMnUSCsdK3W8e5gkWjVhvnmscS6W+xe
	/Et+2wJHeunlg50Wftousfz6reVQvZ2XiD6G/yuWdP3EHq0PqBfr6PlXMdS4cwpEu7RN7oYzAu1lV
	BnDpDzQ7inTkPBpFR68g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsy0-0000000EDPX-44X5;
	Thu, 22 Oct 2026 13:36:24 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsxy-0000000EDOO-0XEB
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:36:23 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-487049569b6so1287760f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676180; x=1793280980; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbtxibXdI9zyqjziQv0IxMo79fhmOdo8yS+ycPfz4Yk=;
        b=OEdcitpZAvENhfpd/X4gYTraR6cq+JCxz/DdlO+lzxMr0xV2ItxWzT7GhHnrEcfxCG
         sa8bHa7ljLJBjTFQhusHsJ73yIianihYRRNxchezSPbI4eOePoypc3bL5jpjLadRUV/d
         MmM1dZTthI3K8tP/GiLOtT70MbdVTla+7i/L5inIYcw3q8U2QPF7Z52b1eHQMrOoqOrH
         KszJSBo0QefQdiu9iuey4ieYEHra2yyQsNfpOEhJeSSatlplxD1wm3P/vo19YIloTY4t
         uetBU8fsMkE3SAJgCMBgoeV2mcV333WFGDdnVGg7g0v3aO4RmvAVdaVBYB3GmnIffJuJ
         3uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676180; x=1793280980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbtxibXdI9zyqjziQv0IxMo79fhmOdo8yS+ycPfz4Yk=;
        b=O+ogy106MncD18rmhmlAv59BRdxLA6VY4jx+aDvXvmF9/9vZUF2nsnQHLw/FVLy+SM
         um6+gYWHuoh9Mavw4o1a8YNZxPVRVE3EGjEXE5MMpa5UcXitV0AHcmsFaQlhpGUNMj2v
         1ZNwxYQoBBFzHLNuSOtHtKGMJFmWoLdnsTG6tgmPLDhmcU3MMdEv1HviTC1sTmiQty0/
         PCgkywaFPszo3KMd9+UCGw5uAV4rYRUqNMfNieNgwtIaOTZD2Xr3bcPs3/Z1/Pji6OP7
         1/MeP80euLXTlB8OlGi9d40Mn6Ki2UAI2KRdXFs/BdXWBty0Ys4vaJhjhyOhnhUxu+T3
         4FPQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2EoIEc+dawj9HmBB72YFmf1NjVfwB1kjzx9hoYClPboBNIaxzx5Q9ZMuF7fdYdgrcbfFqb+SJdJLJ@lists.infradead.org
X-Gm-Message-State: AFq9FYIiIXzJM5Y3E5889JVVGC33pvX2A1LGZlqsQt6r1pQPsIkt3Ff9
	MjblI7Xd2AwlurpCsz5lWOKxF5jsS+rXp7MB8ce/PR8q0WbL2eSS/VSw
X-Gm-Gg: AYBFou0qZj+finI4T+pkoYcdI2kdSZ9ennBnEpSdbP/TVNn7I/Lmf/ZKrL3TN29J8hD
	Hrg+JGLsth+15Za3Ynvg6CFGtn4tHMfXtLTw97SUh91j+dScmeIJ+arBckUEapwfk5mbWHrc+1l
	vFAYo6d/uN+LlYTIMcUleUPG/258hHOe1JkJDRGaJbtPhDDIhC2FwEajTyi6yYdeliNg0mabJqj
	6UwCfDoelaLRLIoFxHBV3mmeoAkYe6jmOQ+V2tUH3TSjw9kjjuwEI2xI1VuAVi9QhGhPuUMx9+e
	66P49PsXxHRqKEcZ7jRJLo+pcbJuIQsajzJXV7Vos0OBRADZEpQWz65FM/Ve/ENJZvv2ghKSC5e
	ucLdYJeeStmjcWTg+xQ0y4+MAK4Qk0C7x+bghCu+vMa++sYE/PhzAmSXWRdSje3FML4fkPUnWGX
	x3w1wLFpafeVjLTWPLGesIMliL8ZxVdUxTQgMc2uB94eA88LctL52VNLA1k3XxZz2ocqCccPugn
	QbnupekOlMx9TGT7b8rgsdDwr5ey1xAarf641Ukcz0hp1kc4Lj3KsM5hAlJab4ymjRyxNbXxp8A
	MamaXpkFHQoYDX0y1MnSarC8
X-Received: by 2002:a5d:4573:0:b0:48e:e2a:4093 with SMTP id ffacd0b85a97d-48e264ab3a3mr8726545f8f.19.1792676180147;
        Thu, 22 Oct 2026 06:36:20 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0d4sm12645777f8f.13.2026.10.22.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:36:19 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC regression tests
Date: Thu, 22 Oct 2026 15:36:04 +0200
Message-ID: <20261022133605.3593484-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_063622_170098_0E088FF8 
X-CRM114-Status: UNSURE (   7.28  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel fixes that nvme/072 and nvme/074 test are now at v2:

  https://lore.kernel.org/r/20261022132934.3592924-1-parri.andrea@gmail.com

nvme/073 tests commit 31b8a6af19b7 ("nvmet: zns: don't leak stale
memory in zone management receive"), already in nvme-7.4.

Andrea

