Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A42C25B74
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AfiMrOmL/NLn0jD5Eo0+v0FxBVb5PRQoDtcuAVb0CQU=; b=1KHIhB7wvQ/RiGFLcOTOkJ4Cnc
	Lafz34mkP9LhJ4edjb0EsOds/zD0KcRlblG6zjVLE3j29zZ1306xILR5wO2Xt94AYdLrebYAwDu09
	sO9cUID6FtTUnlgFrbybUrZz4mulNto8ZNFYY7SyzhHMT2EBZCthEE5oYl3K+3XxHrOQcPmNyVezs
	TOV+hCcMeQj2O0Lq42GQ5hn7rnJkIBDvElh+Ocf9XdAbOIexyzte7JHp/CjbP8AEoizjZiMeGkyRn
	z3lMLgIFMHSJ23bLyIuv6xHpUk2FuQ7yUPi8b5rxAWTDaawxC35xAGMO7lSyjbGcCKBjF2GV9HydH
	RUp1G8iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4btz-0000000EQp8-2gPn;
	Wed, 08 May 2024 07:39:47 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4btt-0000000EQlf-0jaR
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 07:39:44 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a59b58fe083so667484166b.0
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715153977; x=1715758777; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfiMrOmL/NLn0jD5Eo0+v0FxBVb5PRQoDtcuAVb0CQU=;
        b=z3nN4FcDgju0qeNyBzkqm96xgyO1fSdK2z0bVeqg4fCSHij0Tx8kD8XLNfaBJ+iZn8
         4UPB7sBDeSm+W6Vm629TGUyeyLhX/n4G9BMIfUuefvmiDxhoP+psZGUFkZJsEYagene7
         jYTL6gnryT6YrB99iK2//BfXEVlxvlcViRytbtugm1dzAYjACmhwOWnXAjTFQrTisg7v
         UHs0taHE1bCDfFEPk6Szo40ItwEMufJ3SAt0RBECsdSAlIpeea7rLd7uBlmR7CvyxzHs
         zCTICYiAQrk9S4WBaYqb03wZsc7RIohgIn5gVbL+RoXZf3+jzC5nWgeTK2brLQ0M4LB3
         34Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153977; x=1715758777;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfiMrOmL/NLn0jD5Eo0+v0FxBVb5PRQoDtcuAVb0CQU=;
        b=DIJx+RbyhdcF0e2291Cc0N5IAKi7397KSPfdB3ZyKsvbfy783Wi+5lQfZBo/H9OkxQ
         XurNAEVfCvw+YyZRn1zwcoA5m4NfHIZWZjO5AmKcvoY7lo5yx519Y8H515sWwD+hMGJ/
         pcT/WgG+olE5AM41grJFMEWhWqaRvCRF5oShHqKu2jRnhVBGqbBJBW8ZcZT0JDHoj9dd
         Ur0DBLLalgvVFW+H4UoUqaV2WDBZrffvgoftRZVt6zEHHvrIQBR379/pu9kaMKyRHOpY
         bdPv+gef/6LmDUXbH7s4g4bJnuvqygRzPlMTbiLc6aerEILYNex8UWh91KhaJorJXDal
         0fMQ==
X-Gm-Message-State: AOJu0YxN3FS2qcbc/WnETq6Wk2NOF4RaJo1m0VRuH/HPqYsDG3I+gK2O
	km/bt2pBGCjQej6l7CSErKtquOFWJGqjT7Otm0ivcSed7p0eoJze3hx3psatvSLcUJPsYdgFkXN
	d
X-Google-Smtp-Source: AGHT+IGkAZ6305qJzPCr3cgOnwRcMHW509OeX38Q71gBQpJhyb9KSmbPZYIB1bHDFPWLwPwvETD/dA==
X-Received: by 2002:a17:906:e297:b0:a59:a7b7:2b9e with SMTP id a640c23a62f3a-a59fb94b8d7mr93830666b.8.1715153977043;
        Wed, 08 May 2024 00:39:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id wr5-20020a170907700500b00a59f3e926c8sm1382409ejb.152.2024.05.08.00.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:39:36 -0700 (PDT)
Date: Wed, 8 May 2024 10:39:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: hare@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvmet: implement unique discovery NQN
Message-ID: <1c9918dc-9df2-4cfa-b157-b1184dddae6d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_003941_246626_47FDB856 
X-CRM114-Status: GOOD (  10.03  )
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

Hello Hannes Reinecke,

Commit 95409e277d83 ("nvmet: implement unique discovery NQN") from
Apr 3, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/nvme/target/configfs.c:2206 nvmet_root_discovery_nqn_store()
	warn: 'nvmet_disc_subsys->subsysnqn' sometimes too small '224' size = 256

drivers/nvme/target/configfs.c
    2185 static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
    2186                 const char *page, size_t count)
    2187 {
    2188         struct list_head *entry;
    2189         size_t len;
    2190 
    2191         len = strcspn(page, "\n");
    2192         if (!len || len > NVMF_NQN_FIELD_LEN - 1)
                                   ^^^^^^^^^^^^^^^^^^^^^^
There is some kind of mix up between these.

/* NQN names in commands fields specified one size */
#define NVMF_NQN_FIELD_LEN      256

/* However the max length of a qualified name is another size */
#define NVMF_NQN_SIZE           223

    2193                 return -EINVAL;
    2194 
    2195         down_write(&nvmet_config_sem);
    2196         list_for_each(entry, &nvmet_subsystems_group.cg_children) {
    2197                 struct config_item *item =
    2198                         container_of(entry, struct config_item, ci_entry);
    2199 
    2200                 if (!strncmp(config_item_name(item), page, len)) {
    2201                         pr_err("duplicate NQN %s\n", config_item_name(item));
    2202                         up_write(&nvmet_config_sem);
    2203                         return -EINVAL;
    2204                 }
    2205         }
--> 2206         memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
                                                         ^^^^^^^^^^^^^^^^^^
    2207         memcpy(nvmet_disc_subsys->subsysnqn, page, len);
                                                            ^^^
Which leads to memory corruption.  The nvmet_disc_subsys->subsysnqn
struct member is allocated in nvmet_subsys_alloc() with a MAXIMUM of
224 bytes depending on the input string.

	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE, GFP_KERNEL);

There is also a harmless off by one.  kstrndup() is allocating up to
NVMF_NQN_SIZE + 1, but at the top of this function we're subtracting 1.

It should be allocated like:

	subsys->subsysnqn = kzalloc(subsysnqn, NVMF_NQN_SIZE or NVMF_NQN_FIELD_LEN + 1, GFP_KERNEL);
	if (!subsys->subsysnqn)
		return -ENOMEM or whatever;
	strscpy(subsys->subsysnqn, subsysnqn);

    2208         up_write(&nvmet_config_sem);
    2209 
    2210         return len;
    2211 }

regards,
dan carpenter

