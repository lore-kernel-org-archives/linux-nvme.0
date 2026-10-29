Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B9606C46E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MoiKHvml;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=djJWiIcV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h3LMsbtIcJ0VDO1NfF8USKNq+9F4WgnyItWrt5X3yTw=; b=MoiKHvmlBs0hl0
	RVPy7KeAGJILKNiqT5fKSoo0lhSN2i/0rZQ+Zoue3ZHkpvzl1hvRva5nOK1JyA3YQP1556Xlgh8tW
	tAz0kRV8QFkqZXdxo7GBSviw1a7kRr5kaKz3/Mkr6tYODQKKXucuhYm+QRnSDjlzzwwa2yyMukL6A
	5w+jtOPEm5wgz1fRI961Yfs9Q+60fudK8aN9HZ92W8wacm1U6Drv4BE/A829ZP8c+zAXUBQDHg2P0
	SQU3spkNiShu1RIBFmLdJvABHLRmlTYTEfs94NfPFvWTK/cK23szP7/W7D24bTLIwT1e3WfdneMaj
	w9bjdutgO4sRETVfqvMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQyI-00000009VKm-2Ubg;
	Thu, 29 Oct 2026 14:19:14 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQyF-00000009VKC-2tzV
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 14:19:13 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so664653241.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283550; x=1793888350; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3LMsbtIcJ0VDO1NfF8USKNq+9F4WgnyItWrt5X3yTw=;
        b=djJWiIcV3WbK+3FW8M/3nlrlr2+jrlOXMlZbgkt1VLC78KU5aAohZ37D/UMZFqK/+G
         /0Ahk3wcGNvBC65SQtvPO4A2kRNVWAV/znbrlaViicBmgYcP/1OoiRwI7/37gK/KX5hq
         W+m+vh8T7Z4I5JKMvFe16MGGwqSEj3vJ99SWTIl+BqnFzZqRt3T9Ar9N73x1bmUB0l7l
         bsPyi7VGL6KfUy9lNMNSkS6RdViXeualQPOjX8wFv3jFvOeRJ28j/6CxY5LySX5tVqaP
         R5r1JZFQKuTuQC6ncl6mHkIeiKoKOjPi1URStXar9J3WdKPLFUozR4PJEl+fDbIt7M4d
         f8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283550; x=1793888350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3LMsbtIcJ0VDO1NfF8USKNq+9F4WgnyItWrt5X3yTw=;
        b=dkhNvYTsfTd/OyBNujawP38pr4B+llsjy4Opavbk8Agc0el7AnyMZKkY0E8xC/BTQ4
         FvMfe6Ichfaf+Olt10iHvcLdoHl1yEpTJhIW/Guhkwhq5OHB+9WDv//cq8ZwtjszukH3
         Q4PaNE8GzManJRl0PZkSH+Z+p5rQsOrdui6xIpv5UvPu+b6z4OKgNAtin6DwIbyBl1s0
         NYK1PF5ocNc3m9pRfZbcdHvLa9rBKhFrKOzUK1u8zrxi2YkpCatNj08FgTE487yOeqn/
         6aw/GiNYsK/LW3CBEWQedTP07aGa7RIHL6T8tF9BBxyXq9pELvUYsOjKULo7HKVy+eOk
         mxAQ==
X-Gm-Message-State: AFq9FYJZVJG5bXSHY2dQjusOQKrQj4Vr8f6L50Dba7svOSYlw3uCIagw
	S3qxm2xFQngkyWnCZf7UsmpCJBfAOB47okl+47k8bfI1nJsMso1XOP88a0PijGSVo/8=
X-Gm-Gg: AYBFou25hyChVIA/Vo3TOm6IfvmksAjqs0wYEB6+vD5jJBNetHhix9Bm6IX/qbxTuMU
	d3EzsA4NriLCs4cEfMEKwxqrptGaRdfTX2AobjNPxiMbQyWlGBhvDP4UpzQ7bbVT7SnThxGdN/Q
	0TOdhyTO+OQ/RrotEV7SvrwOAqR9awtSaXcK99YLZzWrDz5AAa9VipJDXDuRBpqKCLms96LECye
	8OR5Cq3Y18+jPkPymIqKo6SNbhmOrbCjitsae5/v5KvGLLnIXYNpjH8tezRQOhTwVqHVQpVwsJ2
	I9/SEpzdOL8QUPfvHYsvtBH8RMhbhL+HXvU3TJInTitCjeB1DQPfroN+xB7m5+kw7ENm571iX9Z
	QF+veQPN4e5dudlH9j8sXACU9IYF+vJ7v4kD3bAg+8CqdVf2bki3Lseac31zq/F+50PadZf9zQW
	6X2gc5fo9lsGlJGy4w/rhkENKQRUTPp6mLoYkimQr3VtV9LluUYkW34qx2QuMkJYT3qZciOI7gC
	8LLOxWBaZOtpNaQAtZ0E0HKtvNg9KhVi2d4RncP/dedxZZ67E/3Gz6tfopfd+aqKORK4VpsjQVo
	PgnY00zQeZtfzrKiG6VCtzrA0CRzDgKXUt2/LSCDle+ScLiCi7FzxQELn+4n
X-Received: by 2002:a05:6102:f08:b0:7ce:6474:7216 with SMTP id ada2fe7eead31-7d03a62cb8bmr2399258137.36.1793283549317;
        Thu, 29 Oct 2026 07:19:09 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:e751:b7f8:a4ea:bd70])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3d32a48sm9362274137.9.2026.10.29.07.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:19:08 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	sgogte@purestorage.com,
	hare@kernel.org,
	nilay@linux.ibm.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: fix NULL queue->ctrl dereference on reconnect
Date: Thu, 29 Oct 2026 11:18:43 -0300
Message-ID: <20261029141843.2066616-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
References: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_071911_731032_D70E638D 
X-CRM114-Status: UNSURE (   8.49  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 03:05:21AM -0300, Christian Aurich Zanettini Martins wrote:
>  static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>  {
>  	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
> +	int i, nr_queues = NVME_RDMA_OPT_NR_QUEUES(nctrl->opts);

Please drop this one, I'll send a v2. Thanks for the reviews, Nilay
and Christoph.

When creating the controller fails, nvmf_create_ctrl() frees opts right
after nvme_put_ctrl(), but that put is not always the last one. With
CONFIG_DEBUG_KOBJECT_RELEASE, KASAN reports a use-after-free here on
every failed connect.

v2 only moves queue->ctrl and leaves queue_lock where it is.

