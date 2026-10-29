Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5C606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CVtjrsCJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TFbRR8cL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=; b=CVtjrsCJyPap0J/xFgKT3ZDjbX
	rUFqYp2q+RyFs+/cDHsglGkBrpRlKiDytghODleS+1VjsaI3PWc0gSr3bEsoK6y88uTCYnx4qJket
	ON2NnKC2oebGR8QWMSb3Q/kEgKtIWNGlQO0RJZ71BVbbxypgS2tGouoCGTgwBwztmMcyRTwdpztir
	O4h/JK6oAwsxdHvYyUhtNfKbGpGaQZ19BM1UW15HC4zjLLz5Z1Wpy4wTGUeH7xNR2nfzIpLcpeOeD
	qZkB8pier5Z0a75weiTVKv+1BczPeCrMH43S9jgmglEAdZqDBQ+VfHPcy7p50K/D67QMW0KAwuN5k
	vNPOS6wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOOw-000000094IN-1qsZ;
	Thu, 29 Oct 2026 11:34:34 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOOt-000000094I2-02Xg
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 11:34:32 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso2494298a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 04:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793273668; cv=none;
        d=google.com; s=arc-20260327;
        b=aR3QIw38rUxu69NyaRfEWb3X/w85yfgLDLqiTPRFHQ3cUn9FK6sbKyAQ4XAWQ3OzO0
         cKL/Gr3rTyWIOr1L5aLFBPnPF5imPmw7VJu/lMi+USr0UtU69XTLcJKXh9TqQ2c+Or9c
         vLlXUi3p1IJ3r/b7PeJ+YImFuumoV0vhqgGLPxFswZTcNITvV8zexMF8RZKhgd6ju/No
         6mJYEqzvJ4e2DXRCAulsWqVjSoxKlNUOmUmDsx9oL16l1/hFHjlxf30e9pWleEiEQO58
         smfrQSsqxcEpwqwqjvNJva9dXUL55KFWTyxz2Qn55v2juV99aBGxL9PUacjLVDEMv23H
         5DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
        fh=/+EpCuyDBJxyWkL1lFlcIpcOZVE8OONFJeg/MQeTAJ0=;
        b=IXC1OHtjV/I5KmycMPCdXiJPzaiZkho5jqukiznNNNXS2nzpCLvOKo+CbtDhLoGyaD
         a8rZqqvhThA1kR7+nMX1nAr5xcY86YK1cNIVaOTaboAvXRAjh3V250iRihW35Co8TfZQ
         O1+TXNMG/+JY3VxDdQeyuf7j3EpD6Ii/uibWlRQeSSL1UPsm1J9C2QOBV/dpViBX6ODK
         ZsUvaTHkH05mOLfcu4LEAPV3QOnWRnN5PYhBNGiFkSzKoT7VRgUe03cvhy8iU7Ax08CM
         Mwvhiwso+0XWpKw8pwodS16RX7g4SDkLUdeUqauFsEisPh228Poe4oYJnhmOdDGVphOP
         gGjg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793273668; x=1793878468; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
        b=TFbRR8cL/fzTF9ANdb9ciA+vWcAKolif5hPwPF9zMKM7X3HXgd3i+OL0MJ0fnB+iAW
         Aq/e94tblmr33vdu7nMrGfwl7S4pD6FV5y+nB8GabM6J+X4/l1eOLTwgBmyze3HqPmyj
         AKxbgl0642uaWx6lqlta8ta1DjPjE/1nj7e0imW5tg8c/F86DKWhCNOkLLTYyFoh96Yp
         XcHyUVp+FiuJs0C3WqAWRX/RM2g3/LtJkNLvYuLrp501qmmyEyUnxSZJfDRPFoX7w1bX
         KtMekdfV/EaBgcz2sw4mJwFe6D7Lpc9pKtm1r9OmdtnYYTlRD0oc66/nYQgYZgIr5Hi1
         xtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793273668; x=1793878468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
        b=HzFXGdBnPXCy8ikv2OHVaMhtReP+9gzPLbQXovqDhy52S/FN6TovXmSpoGKG5Q5Cjb
         xjf2zBT7cCQSWAWD98dhwBozm7jKuC9xjn0H8V/I5tg7Eaw9khbJ3VDGMpOcOULyHQGj
         g8NzXCxtu8dwN2MhLRoorYQ6ZlM8G3AabtrkVwfY2emxp0k4A7QJQlfV58JsaWKYrzsD
         2cgtZBh7rkBVa7opvxmyrHSbOG1FDqfbJu5FdN/GEYvmxzCjzxq7JDAQhWhNkt9yEBPv
         UFPvhIk5k87T/RO6fdpRF+KD7+uvqTI8Yo5D9KE2wUJmAoIh+lD7U5OQapxFI1zpkavU
         e4cw==
X-Forwarded-Encrypted: i=1; AKwUvBwDKjwzA6qDk7ey5iG8gaqcqosTUcSKtfAQRajrkswfV/sneY8HeTNuITd+WvgSnp9Ui4MzGQro3W8c@lists.infradead.org
X-Gm-Message-State: AFq9FYLk2l5Pjp6ozltuNzHkBMORKz2VUd1jC2SFuJk0tTdJ7hO1XU5d
	tJOQ8r9tMxVlmldC2Po61tZVh5uxVQv+nfC4n/mYV2qJMi5oeT1r9ZiD2DSavhGXEWk3xVWLV1v
	lxuZb59xp6ASXwwmO6MLdo12SnlT69g==
X-Gm-Gg: AYBFou1zLa1WoE6lWrh8Y50ULkRWawWit4EnrNPUux8ZyQvuq0ZbBvzqn8s/ZFxTIGR
	4MiSlzqDr0GryfM3cmJqNwxhW3bG2xW5gdoFLimUN0RlfMF6epB/23eBKVQmkbFzLXrFRDKasne
	tWwC5Six8QVGrU5D+FKsOdwKMCSSZlP74my9elYA4pnQsOWndo68SJ4M5XqVK76ihRCZ0WJrfyq
	q3ainpHl6KR7kKIPLKvXSBhDOS+Bee9tcFC1PasJx74YuJ/VF3RK+KAp92dC1UEfj4ngAvCK2gK
	eOGsxs7zBGfJ4/CyTIUb0e+z/O3EkwFrTDvBUcWA2+anPGhF7rfux5ofL5RE/g0epV6KicmvbnE
	+Y8wuCID++AU0zYgnNJwqcYwo2wRLV+9Z8wGQec/3NuvRtA5kefdiIMIAU21CQPpSRjvwqxVxqw
	so3znk+WAmftAAIySALsjrVfCAJeZuO5t0y0IDAE3ZsYSa
X-Received: by 2002:aa7:d386:0:b0:6b1:bcb9:15a with SMTP id
 4fb4d7f45d1cf-6b49cbe4f13mr2485749a12.20.1793273668033; Thu, 29 Oct 2026
 04:34:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028181412.1919506-1-kbader@redhat.com>
In-Reply-To: <20261028181412.1919506-1-kbader@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 29 Oct 2026 17:03:48 +0530
X-Gm-Features: AclHuK80QgKYucRyIWXZZ12A-Bk4L1d3Sa54QPpy49ElFlJWi5EmglCzjpxKLqk
Message-ID: <CACzX3At39QvtmM=sGh13+uCaU9RWhKW8e8r1hPLMJ3LdFAsetg@mail.gmail.com>
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
To: Kyle Bader <kbader@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Kyle Bader <kbader@ibm.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_043431_079393_3AC6E944 
X-CRM114-Status: UNSURE (   7.28  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.8 (/)
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks ok to me
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

