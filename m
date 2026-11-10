Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C1606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Tayw2hlP;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maR1XQFS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=61QcDSDsSH5n6LCVlJAKE5htGdjtvYorgYiqBUo3mWE=; b=Tayw2hlPgvZICO
	xbyAoLz11SDk/6LgghHdWo66Sw3umsu53At9wvTQ/EUqCkdiBv/m62wetIavdGIUxqDyahWEWNime
	JefDqbFxbqDOwQ8wG+ydVfW62JNeOEYP0d/hD1HjYcqQy1oDiGidOaN0imbxesDWLPBcEEmtmE6+3
	eQDQpJtM8tQqG3AapBrY3LhKzNmRv2fktCzakJHHQ2U6z5ja7lX30nJDXkKvFHrRLG3swaSar19Ev
	S3f3lTuIcChk/2jAgJzI6tigHFr5FXJhE0zhVgJhELDmIcQmDArHttFdhubtyL8yy+lLMxBb1W0O1
	s8xdBpxkJptB510KPHpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQmCS-0000000476Q-3EnK;
	Tue, 10 Nov 2026 13:47:48 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQmCQ-0000000475t-3fpT
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 13:47:48 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-3704d30b84fso2571589eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 05:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318466; x=1794923266; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61QcDSDsSH5n6LCVlJAKE5htGdjtvYorgYiqBUo3mWE=;
        b=maR1XQFS+joUOy8z/pv9qymdqUYqmwGTA2Yll85YrCtqVGz35lOH61rOtndg8K6Z0Q
         ID+MLSiN4/iQMKtf4WugVYc4zhk3gNpVE3n8ES7uZRB6/WDTr8aZt9f4WOe0woOOdbkl
         kwC96nmO4wAfWyQcK5ktDaR4RF4cspG9T9Scy59jWttc/QVdgdyg2ZRteJZwac4gT51r
         N1r95ef6oIatIRnt0u+sMmWk5yDQ7KeBCeYU52/joTeLE60xYN6B01wP3tEXpFE1sKHy
         4VMlf97HFjHNBladhN69g69ua+rNsuAaxOgcVLJcUVyN4DWgeKyiq+m+lWIrLbpv+TpV
         4M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318466; x=1794923266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=61QcDSDsSH5n6LCVlJAKE5htGdjtvYorgYiqBUo3mWE=;
        b=wGX+7EcCtWrsVBfzpR0kXOHoBfm+tqG6RkyhnUpRHFFpsPiFAM5WMYkWnIH3nhXrK+
         Q5gEMIMnzHEDyC4hgkjdQ3D0bDZiCDdJ1JH1z6QDCL2vltZWnFxc1/q59YDt4mErQjvR
         Dyk4j1+yuEVbC5IQLHVuN8AaJgBVVM34/c4/Nn+eDMBRrhmwtNmH3PkR3nIuUSyeci/v
         BzZTG/oIFX97O9tqD5klx2y1+s48tS8cCFVwk6zMY4UcnNsXN2CQn4ve8itd2cJkpmOz
         eZ8/flN/MLWg+OiuogD7a5dQp3e/uCT4mVJDAp7bp4ql6KX//xcOdmpq9rsCNrKNUBr6
         uKLA==
X-Forwarded-Encrypted: i=1; AL+hErGlKNWUoWyEiJlQaYyEn1swlKltGuzeHusD+J1N92BHB3SNx56Zh8qpqIKp6XTr5w7LHW0IfzkUQR8y@lists.infradead.org
X-Gm-Message-State: APuU4Z+ovB2wyQH/SQ3udj5++Exw86R7HQF/Lf7cyxKpd8F086QSjvfE
	GcE8cd4I5Pmx/qw81Iiylp+WW+fCVMmYXA1S6ZFBEnKxZMlo1AtbnoEg
X-Gm-Gg: AYBFou3znA6ILyWeLVn9RB69Vesy7CTW3CB+ldTaD5jduBmHkkWD0iPB64F4SlhPLq8
	Tp++kRRJI7FPnetqsZ2goTcTKKT1j1RGgVUoJ1RUy4gVeQ6cGtv48SAF5Do+81ZGrg1lbJwcBOT
	4upl2o0UURT8NYw4M21oBQq0N1+UGnFbp0/+VBoSfnmViSsYU73GyuYydBwmTfh6lzqHXCTzy3L
	jV+Lqik0nOGAd8sdBB3nr1IBHkU6gFw24gea68RGqIf7LBdk4GPekKZ3nW2kES/K8E3LtfEtl/u
	uGCumLJJ9l+HXW24Z+IqSySV08SJU7yj8F8kUk/wjlOg/WlGuQ44Jnd5OB/5xLM5TOkf+zVYf/n
	/xEpDkK2rCuRkdCLTXag0YT9wamklMybREDHhKuRsshGX+KU2nZR09Cz4QEitefHLWsM6D3m3cZ
	7/9x2df8K0Uz6/2UEUGTcCO5/pCTaqPM0aXKamJ2AeeW3mOANlRAwfmPZmBupZevWbKpigvJcIb
	SPRxrqefi1MKd8VDnvC8rCfaWKAXgmJxmAnBbJiX0ChZnQjqOZyGzJZ96Ol/IJ4QwW6rTix6sP4
	9LX4jbD8L3B+KChXtadjyxbSliaKMn69sV6hlh1IF2YtanL1kw==
X-Received: by 2002:a05:693c:87d0:20b0:36a:1e0a:accb with SMTP id 5a478bee46e88-37520026b83mr3535881eec.35.1794318465405;
        Tue, 10 Nov 2026 05:47:45 -0800 (PST)
Received: from localhost.localdomain ([103.170.54.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm8350319eec.24.2026.11.10.05.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:47:44 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@suse.de
Cc: hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v4] nvmet: clean up DH group state on initialization failure
Date: Tue, 10 Nov 2026 13:47:20 +0000
Message-ID: <20261110134720.3500-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2f0e8fe5-42b6-47d9-9bcd-c549544e099a@suse.de>
References: <2f0e8fe5-42b6-47d9-9bcd-c549544e099a@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_054746_913762_97814F78 
X-CRM114-Status: UNSURE (   6.69  )
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

Thanks, Hannes.

I kept the cleanup in a common "err:" path to avoid duplicating the teardown 
logic across multiple failure paths.

The diff looks larger mainly because I removed the existing "else" block after 
introducing "goto err" for error handling. This allows the successful initialization 
path to remain linear, with all failures handled through the common cleanup section.

Thanks for the review!

Sreeraj

