Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426E1E9A03B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K9x0gs1Uru3r95Lbv4iqUVCP85SqlxE0xVGVRZWEuqY=; b=41R9bxtYQQOSclD8NclYbbNpy+
	6x8es6W4RaYLWse91o3KIMWIqyJtMcAgCaTrhJjSno5UAVqsNfypeyuIurHK3Kl8gDw+DmInVHCMD
	75J62hSA6eonZJcouYjoJtyByhzANfjZ7oW3gjoPBVi2jGJjEbMhvibbuNpxKG3lUobz558cHI+ta
	BB7uAvQARVqusplMnGUFZgYFhcohvKcTI8rG3ME90RXfPEACn8d4IYWOCnxz1wQAMYZAukwQjenL9
	j7P21KvoHbliHCF4qJSirmsanTIhgIXVEx+VUHNrocmAqFTPfgRk5Fgcyx2PA01YoQd2HCd8+3kSL
	obUPlNvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt3Jq-0000000BLRr-2ENB;
	Thu, 19 Feb 2026 12:39:46 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt3Jn-0000000BLRW-29Xm
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 12:39:44 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b8f86167d39so131576466b.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 04:39:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771504781; cv=none;
        d=google.com; s=arc-20240605;
        b=iYO44PSQl862hC9/ZfSyWKw349hr0QNzRvl8Q69tF113O8Ev01N1rX6QxrJLVhlmUj
         9DiyXWpJiP0QHRzy2pJPPZWrSneYovXh5UB9sO1ctJN0g6GYcUCvYQwksWrpg15sKT7J
         EVb+MY9C1RUwbAsjAX1G9ry6+g9atHa4i9S2gBStIO1NYK4SfE3MRhL3KUg4m8gZ8ek5
         uCoJsxL/DN+gAme9elXe+/Y1Jb1aGvcBbC72Syf3g69NlQvwmjf4zu2Wc8RGZyEBbLGd
         kuiR0FBG1Grt6gMLlo8zEfYhJEWsxHXOlrwdIAFkwdbZUX7iHTST8zQzDbv/qj0Mbv7t
         GdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K9x0gs1Uru3r95Lbv4iqUVCP85SqlxE0xVGVRZWEuqY=;
        fh=mgXd4eV4Y0nfFHSQNjGpddAf2Os/hVsumTfqPcqO4fo=;
        b=T3osWqUWgv1EJI/HN6x4eODefvyGOe86IwiTpvcyjMMZKHyOC40FB1/RirKYR3+9yJ
         cU5njhLdz/3CIkUYf2Le92QMutTTc8YvdI6wwzW2EAh4t4mlThdpZ3J9QxmANW3jJ8V4
         BQfl0UTcLTZ4T618dJcnmRQXtCIRLAjJwFzj+yFfbu7Yu0pgx9yyAEkhlzHExHPCC2Vu
         uCXKmVNrP3lFltQfIvdU8UFzDKdscFCHpyXk4pbdu5FBGUOQ5VnTp60booO93vtfEJzA
         rm1G65KB513zl3Fa4WvNXVjLzCDzew9EY661x0uP+9RvkH5lm0bNc2RihUCRUqogyUW8
         BAZw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771504781; x=1772109581; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K9x0gs1Uru3r95Lbv4iqUVCP85SqlxE0xVGVRZWEuqY=;
        b=UKhmSOZOxcQYDxFcLe88V+rXrrAN3tz9AWZ9gS23xFkoLJM5cHttdvp/ncelJKEdEl
         T17RDAInZdVWTVcLIycKV45PEd4CEhjO1A4hybtlmLat6LgmefUNLrkDdZFB4U3f4GWj
         LKWwW9pqw61wZ8Rlchr7GQo7lIOJ6pn58+PNty5zzfOgRNRGSrkjgRVy7nKC1cjd1/1t
         lg1aiO/rv3emynzroWXeV/2XikKMS2OmsF2OTry9cCec3aYdXLVrOwMsnETs6e1LVv1G
         CnQCtejLWg/GtceWxEX4Kavft3xo7Ovk+phekS/P2ZlL1PQW17D2d4t5Vn2sZG75Pbvv
         U/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771504781; x=1772109581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9x0gs1Uru3r95Lbv4iqUVCP85SqlxE0xVGVRZWEuqY=;
        b=FX9OD71JCDy9qNy8n+fhryOGryZlsMVYB0JqPy8ApcqTrU5sp7hWwjV1erUcLvDO5L
         eKuojqkTIaNyW44KN80wkbC4Y8+j7mBiI741IxukXXiGlZmXnmOLSbPnUWuaLtQrzXHU
         Gnsayj7r9YWFxKefPtEQ54olRgCtB1esnV/klc1Phs+U+t7hdBsPK0RJa596eHguSgT1
         FFeh62m1hylLnoi5xmaNHhc4B56gUbIw/vMUNN4xfcq72/7CvqDJvOkUG5wVabRXgNsh
         XMXsirbLPahrrPBqJmqTZ6aQjaxrn1nXkEc8cpUCZlML5HNvKipK7yQxefQKdO+LFFKA
         dtbw==
X-Forwarded-Encrypted: i=1; AJvYcCXMAKbmpgcpYY9rfd5w3UczOatwNppI7E3JBDimgMjdv1G4rBdtcxpmwazJ42sSEVkHNU2ZpuwHDOw/@lists.infradead.org
X-Gm-Message-State: AOJu0Ywv52wc65uv2JQ6XOFY+qpFgxl8hI2m14+sim0D48il5COM2GZV
	RINxFR/Zi+o439Ln2KN6WBJvous/UIEFU5o0Krm9yJqHSKMhYkm85lwwxhUvknrHYOZLZsJvSPz
	ZVljaSL5gPoT7/WE3yTO/XNmGNgVpzQ==
X-Gm-Gg: AZuq6aLTqYzV6CKpc2ubKFb5NCg3zgY99YEZHI4kQQ61ANxbXUkyyJ2H26An5regN66
	vslmSN5mgZsUtcm+Bp9GZgte2hgUL5JBWzIa+CZUThg4ZWWuM6SFvKWKE8PGSbYpKI2/DchjB78
	0Jxwd4byFllR7y0YHYheepOeDLbwgt+9Q++fqpl10l+Ns2WycwG7XJAmD6DRYulfMxfvuAadAtQ
	ucpMktQWJbc5Rkdgbq4ConurhZF+uucyYK0ee1pLwlT0Ovim+LBxynqxgIIUHi2QE+AgE5Dmafd
	OxTraPOsgFBceXD3Wkky5ODUK3WH6nSebunFoXr8N5oRbDjEJl6SxZVRaIELFBhVVk0=
X-Received: by 2002:a17:907:7216:b0:b87:206a:a241 with SMTP id
 a640c23a62f3a-b903daa63b4mr311771466b.11.1771504780476; Thu, 19 Feb 2026
 04:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20260219014335.9061-1-csander@purestorage.com> <20260219014335.9061-2-csander@purestorage.com>
In-Reply-To: <20260219014335.9061-2-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 19 Feb 2026 18:09:03 +0530
X-Gm-Features: AaiRm51PRTbuDOBVDD9MKNI3CZHgijGXXIV-tUiGHC864mQz-p1bLHnzuo0b_AU
Message-ID: <CACzX3AvpBv_vM5DNFmxBcMoCogC4HK1e0c58PA0kiBQ1wMacow@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] io_uring: add REQ_F_IOPOLL
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_043943_583059_CB30B4CB 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
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

>         REQ_F_HAS_METADATA_BIT,
>         REQ_F_IMPORT_BUFFER_BIT,
>         REQ_F_SQE_COPIED_BIT,
> +       REW_F_IOPOLL_BIT,
>
nit: should this be REQ_F_IOPOLL_BIT for naming consistency with the
other REQ_F_*_BIT entries? Otherwise this looks good.

