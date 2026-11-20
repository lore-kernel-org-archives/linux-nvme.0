Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBED606A330
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eG5mmYbc;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YrthphA+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JKVDcVP//zHkOXKk7Ur0sLupEhR21nn2onJ9oD0549c=; b=eG5mmYbcIH45YE
	mELhcEJqNTHJSMQ9KfAHcxFAGq2ufgMVQJPid6uATrLdlZ+hQaCIz5z1i1VkLP9jfQuJ44MOylAtW
	v9+4nwZSxJxBp8dWhKOLG1hp4D5c1aBSBYvyocfT5XQTscdLeSoBLGvEZ+Da5ptd2zvVygnqr8Uzu
	HpaVMMfr2dks0RvLVviJP/AlM1hlaF2+HhqjHBtLFVZDnZfRseNuNhxa02cxlaLk0gEsXLJ2Ceb6G
	11iadQX00MaRrzBsOvirs/d8rTyX4GDGim1WQQ6NHJcHzl8wAY3x3pt5qF7JrVbAObGf5OJAokCue
	X8Zn2noPwVlPbiFl9HhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUN1g-0000000EqrA-0rXB;
	Fri, 20 Nov 2026 11:43:32 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUN1d-0000000EqqC-0jQj
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:43:31 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so480493a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795175007; x=1795779807; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKVDcVP//zHkOXKk7Ur0sLupEhR21nn2onJ9oD0549c=;
        b=YrthphA+9Qxy0gtVU9ElEbtmaXT7xyYA6dvuj8D+wqWqP/7HYAhHzMySnr3LEJeuDo
         ckDGWbZbvU4ds6aYYSRl5TJ3IGIYmw8s+5sxFs1y2poj0LcZp1xvmffzkVoJPKZpj0dr
         ZnW/XyFwlCwPaxye5knGBYga9qS2UmPCMyRttQ3IIZp02bkYZnb6Y2vnl8DhX01Ws6Td
         JZnSygQU5zDwU72WnfeFZxBMvxlBFl+BvtlRU4/Bao7ODOYpWPQ8qTZN9oIvN0wog1qV
         aZ2tOe9a97CBMpHVFq0RAF21ZKe4dPkPb3UkeCiGyiv7LHhFu9RxYo2cYmGPqE8z93Ex
         9pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795175007; x=1795779807;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKVDcVP//zHkOXKk7Ur0sLupEhR21nn2onJ9oD0549c=;
        b=d8Rj84bfD9ncN0QKS/drhWs8N392nw3hJ/QmPwCIdd5n+WkcfcXCPo4yZF7ZgyDKYJ
         wnT/BOYws5GUgJB+9yk+73DnfinLQ1Cxt/B6tNujaL3A2mp+ViXaWgrjS3Nft4Lne0zo
         hD7mOaDtdWq0xpVMmYOP2DfigNzvEdKEzBoPX+n5jGuzKOHD46gqITbDpS00AkLGMJqq
         uPmClVoIX9i62rtPrzFy5WaIG5tsHN0FOmkTyqaEMsKRaq8j7aMONjBJT+EU3wbiAWmg
         tE3DNbf/j3ufs9xI2GNw7a4AYpR83EsxrQN62Q0qMAv+AJMElcP+NgPqp7YafILhIbpc
         IAHg==
X-Forwarded-Encrypted: i=1; AL+hErEuK70UNVOTid92+vYeIXvuI+j/2Za0QKQOAfuFwV9lPFEfNEVs2cD9UrUFDRCtbY/Sbglg1mLnX4SG@lists.infradead.org
X-Gm-Message-State: APuU4Z+BbHfiL8Skqs5/9OFUaS0c4Xxj+ive7u5oX3IZwPqe0zcBC4QZ
	eJRDBKArqxN8aZ8SSBKTTpdpORymYwStADcbVjUcGtcUmJLgEqPUN8KRb/US+Ht7R4Y=
X-Gm-Gg: AZFdTZdUco2w91AmxHxIM+rXwt9u5RYaXfQF4+pIQPmwCjttX/DqV0ismAQ5AX1N+Tu
	2YlA6wl9dJTvtrgc4hVAKibNy5pbN5vifL+g/c2FlbLBYXOEbAoBGu/J8lE2NREzuK4t3j3tqF4
	L65Bm+EQ6VYTrH2ZNejxwMqcH69JB2lO8+k1fN0rhnkjicnB1lW8gpraCt5g6buFFW4M6GehUTZ
	YNHMudITPFD+Gl/I+Azve57XkYkoQnKByYCBL38gPVA4VnLJAFDjHAH9mcIgB/hvpx4TA64WKBE
	VIqY7ch50lybi8+1fpEuSVZIglWhVVrlRyRLpkkKYgd5LNIY7dcFBdpI6Qb/XV0osijlISGAQbJ
	qXW3M4T15CcuDa5BI+1zRwIIkYMQYCpTIxNGBRZVFRWX1qdWz7o7ry4VCNVJLLtMDvt6/W7Fs1c
	pvZQz4urqrhiGCESriEDDSX7bHtiZ297Z8jPFSnJcH/K6pzsyCDwt/+2Vo1Sg1qaxXbtMbNganN
	KWtmrIyv5Tf8f3wnT3bKdAFyx/mzSLKjf7HFkIwRLB+RZZr0fTDlNDloXWILA+9+om1p8i2e2zU
	85+5Lr8ISW8kliZXz9wbcgXgFXPTAqB6d3Xu/R0nZI+jJmhD9KO/UOUqYsNomfv+3icdxQE1QTC
	06Af5jupnjgqS9hhz1BMArcyMZhXfBZZi5gY2
X-Received: by 2002:a17:90b:4ec4:b0:3b1:7329:a127 with SMTP id 98e67ed59e1d1-3b41c8fe148mr2267683a91.20.1795175007508;
        Fri, 20 Nov 2026 03:43:27 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:8b25:951:ad8d:5cc1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40548711esm7500917a91.0.2026.11.20.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:43:26 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: justin.tee@broadcom.com
Cc: hch@lst.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	jsmart2021@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: bound the FCP command data length before allocating buffers
Date: Fri, 20 Nov 2026 20:43:21 +0900
Message-ID: <20261120114321.3072318-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
References: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_034329_215341_816056DB 
X-CRM114-Status: UNSURE (   5.35  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.0 (-)
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is superseded by v2:
  https://lore.kernel.org/all/20261013153316.3178656-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee

