Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B6606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hU/ltUqV;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=jCPfXNDz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YoVjGUFXpjQMcATtlpzVSprfp+MS50wgD3gLJA7JasU=; b=hU/ltUqVc+WJdx
	C75ZfjTmFTr+xJVNrhvwdcWL83kvacNMVxp/+niTX9/9qpNhsNwIzWz4yKn5iGNy+D2x/tR3XupR7
	cgqin6tayFJScnEL3c4CNcizY/bCMmjVAHdCUrwBHIhig48qPyww/9MAdgYPHz+DiC2zw++uzj4gd
	7QcJzpZTsyoO+OZrdkeYP/KBN+L0GPwLMf8YqFbnC95BkKxFqwjatlUM6iqh9I2Fy+KK2DepSoHGY
	7umQ6QHIWx0uzcBEfQ6//wgHRzxsKjnW+uQ+T5og92iyvRxtpaBev+mV9fPBax8C3RnpTm9J7bRVa
	75Z+COBeRGsOJWD/jvrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPCQf-0000000BGat-47Cr;
	Fri, 06 Nov 2026 05:23:57 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPCQd-0000000BGaP-3x6J
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 05:23:57 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso817224f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 21:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793942633; x=1794547433; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YoVjGUFXpjQMcATtlpzVSprfp+MS50wgD3gLJA7JasU=;
        b=jCPfXNDz24L6ugbgust+0qJwdEvh2BdCon+b0H2J83XocAriOJcy1AwGmvdo7N3ZYD
         gN98+HUX73Xv9/u9+3kL88bGG48e9E6/KMq/sao3cP4X+DW2NNe38XPnnywJj+pewmwx
         YuzWvMWq9Hm118jCqDAMdfvrKlWu910OR6SBSbht4SkO6CKsKXs91xwW1Ivl+C0Ya5TG
         tlaIyCRf4E8Cuy2MEEoZDdXBH4MfyX1l1XNBBzGrNHedF42zmVIXSgTMRb1vNuyBouT2
         OOVv2AW4MwenOR/TBiBUbFB41bD5Ifki8JabT9DT6HYBPdA7dExEmhegurpz+ak65oQv
         oX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942633; x=1794547433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YoVjGUFXpjQMcATtlpzVSprfp+MS50wgD3gLJA7JasU=;
        b=ejnNdNcLmxBO9WF0vt890aVp2gxoP2uyjxKEArLCT/0SpqUCT4OefQaAB+lgJxLQPh
         Nug3o/Gj7NH8OGO3a3g4y7vOK9tOxwd4GFdfLe92jlhq7T8y+m8BaxFeE5luBp/EhvlU
         6XGzsvdK1ppwGqwwqN7jk5V2N3apfx9Ble5qI2k0WfYfdnETCMj32lf6HakoQE9EzmM3
         9+P4acHH3IH1jhHdYwkIZsmx9LjIOXmSJQ9lUIc9KlE/RYEh4ukfG6KheFuwIDvQ692P
         icXJ/QjZM2Tjrt8tL59PFt4WDweD2FOT98BGulGNWML8z1COvGqbs6YKm7lN5DV23i7/
         OePA==
X-Gm-Message-State: APuU4Z/Vx7Fep/sGCEtKnkAbU7W19IT1HozIHEXmHvgwNB5r90vtbWl4
	ZogVwQZGEJ/fVcpN07ix+L+xkb/BQlGrcu7scfFge+8QWYp8XgagJ4iM1g3cTkHn8Ak=
X-Gm-Gg: AYBFou37u0esKl6gUvCXlm+6jkgNW07g6CKCbJfnOn8G169YXc6ypjxhbxiiBp2HBka
	Mvoh8zolS+kw8p8W2mJ78PA4JYPLedTz/WC4enTwkd7exkQlLuTQf2v260/lRhp4vq1r47R7Zcy
	LN86ViVLMoAisbR5nV2UR4N1YmAkIrbPwRd1wW4wmSC8rAjJC0hKErpXkfeIBH9Lzwl6KdFT1W9
	hc8Il0asPgzAD1LPvospH2hFZuVJR7SMxRooggzLwusr0gS1yTMNtaYbSKCMXO42WldyX+hRx92
	uUL3FLj+W/yyEr56FgAfYLzjO2EgB2Pl71sAPK9gIgltsTe8k9aZresORH0m9Kl1vmtNcKiHv9j
	ZQOslLNja7N36v44BTQ3pG6pdnQ6Cf9SrEhx9ZaAmVmC/JKBT4KZdzp+VVBOP3H0SVLezAKZ8AB
	TOthI0bxeXuQkjNr9wDUMqasnJJh2FNA1cOUnBqzWLA5reiySPTzShB8A0iOXY8olB6q90Q0cJP
	rI16/yWZAuP6zlZZx+GK/P1vj4jF/P623nzy2TSVA2Xj9JVQx11q6G46mbuGfkYERoaPqBdCtzx
	Gmw5puQC4gUh8+TiNM0bKM4RFa7jgLMf77K0RYSrV3rC3B+X2yd6IwnN8QHEjaqnK75a+cWD2g=
	=
X-Received: by 2002:a05:6000:2284:b0:48e:678d:396e with SMTP id ffacd0b85a97d-4911906d313mr9445010f8f.9.1793942633454;
        Thu, 05 Nov 2026 21:23:53 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([185.57.101.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm1456239f8f.11.2026.11.05.21.23.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 21:23:52 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH v7 1/2] nvme: add per-queue sysfs directories
Date: Fri,  6 Nov 2026 05:23:42 +0000
Message-ID: <20261106052342.12808-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <23f41537-23bb-44e8-84e3-7069138d151d@flourine.local>
References: <cover.1793800758.git.saravanand@crusoe.ai> <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai> <23f41537-23bb-44e8-84e3-7069138d151d@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_212355_993713_463DDB30 
X-CRM114-Status: UNSURE (   9.50  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 06:30:56PM +0100, Daniel Wagner wrote:
> > +	ret = sysfs_create_groups(&qinfo->kobj, ctrl->ops->queue_attr_groups);
> > +	if (ret)
> > +		goto out_put;
>
> Don't you have to call kobject_del(&qinfo->kobj); here?

Yes. Sashiko flagged the same error path.

I will send a v8 that adds an out_del label calling kobject_del()
before kobject_put(), so a failed sysfs_create_groups() unlinks the
<qid> directory before nvme_add_queue_info() returns.

Thanks for the review.

Saravanan D.

