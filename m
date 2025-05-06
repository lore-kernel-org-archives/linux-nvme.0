Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E637EC3ABBE
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=; b=W7f10UgUxKOsugt0Zn9Pc2z51I
	tj8xdyj3WpC2lKSzH+B4wipeB5BPZsaqTyNouIEr5XsfhQwFJiXPuC2aB5XTiFDhxF8TndTbJ48pP
	unnwDiNKyaP3vZDLxEY/6JG+PQo5XXHYqEu7ox/mCY73z7U85r1s38xjJr/94n8qvBvcST8bRaQCI
	s0yZxXkCthR1Uff77U6k5G5Zs8Vz8jMPAT5Fe0q7Is0NUYJDrv06HjsBkmWUyNauyTcon4hLvz+2D
	e0LxZVsZeIBJxd2s88/LWkivsUtPWKHBxlH63VLmCkGctuDrdzAGmENVDkKiclPZvPGUDnqciH353
	2ks9ShIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCUcR-0000000Dxm7-2JGr;
	Wed, 07 May 2025 02:34:47 +0000
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCQEN-0000000DUHj-2u1d
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 21:53:40 +0000
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-e6582542952so4914671276.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746568418; x=1747173218; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=Cc3rZqusB4VHC44NRuvTDsZaxfxKVGHgoKN5LLwTTxFWzxtuZXbmAnz/2B6ipzPUcJ
         5qdJY0kGJm66w1GJi8TnRyQ2nZjaURs7iUJOXuDc2aqifzg5FZDLc+FyDNFRsPV+wWL5
         TS/HKeYTZBOUacslIu6YoEsGAdxgbYiZsn6i8frPbCuIehEublWHzNpsH2c1bvKuEtLa
         g4f6aU9KQKUiQY6KZJSvDG9OejpPGpZiF8a0sT4Es2SiKuoyQ9bQUg0YmOQqT3rS2Dv9
         YZp0V5VcvBJJjEYCgbCS3INwMsgVsLZZx9JH3yE4Tj/AUM12h9UNYkY8mLWsGwNrCDlO
         lmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746568418; x=1747173218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=srChnEhxaafX25DowvrKNJ1J6nA/GGTd8+TAzfUpLxXjJNeZbA5Pfu73gxYufVvSNo
         8rCUtM92v/8I8nx6qZ494wquZAAbeebajUJjV49t7dvtx4FRWdJ2JrREiB65UkrnOyz/
         iEB8baXw/wGGujQT3zKIFaUy+RIPuV56UmgLw/bzxsOc6zyFXe5hR5BwXDFp8Yti0Dbr
         bYJz5iDvKfX38n+pH76ljHV/ZIZ3VNbJS57yrW/899Q4jX7SsTOY2WN5UhH29Wpgumfp
         h7c+fPk7Q2U4A6I8/9nfxxS2ukgU3ZcmFazNgXazV1hIpPhZBfTu/cWpb2DodTQEus/r
         EVaA==
X-Forwarded-Encrypted: i=1; AJvYcCWdILG0hEp+Yd/Gz92bPnV3qT1ItJJqZD46m+MR2hzRd39iLMd+FKAkJ+YQoUxQnlrwIe8TX1fHumGi@lists.infradead.org
X-Gm-Message-State: AOJu0YykC8HTi004hhJvmkm81YkQdGFfUf3DudLQGOW/ippG4+piu4cU
	fMGyjmdhU4Vj3M7fV17MNd88CgS1Pv4Vg6aVepZfavZtFXInFDk3c77IMS9tu+/2TqYxvqk5+Lm
	+lPYIwNTr/xOYnEF+6HR0X1qvCVE=
X-Gm-Gg: ASbGncspv1S9u8NFE7qnqMmaA+5WAdq5H/lj1r39rCdhfv8eGo2ejEzOBGPVkdPl7h/
	cKlINJbYOmZ3Pq0kDNIcDRXFpkB1tpN7zrXqIuWtfn2+llWzGynKHvUbuu7M5+sC8rhdVF95JMX
	Y6Zye/CEhpuIYa2IsCDYdNB6o=
X-Google-Smtp-Source: AGHT+IG/tlXGcO318oUAyGSMPMDDiCB3QetWBywTXrKn6j8T28103Wfq4J5CuXZ9sr2mhoW6CSUwpdd2oGek1YDPQw8=
X-Received: by 2002:a05:6902:708:b0:e6d:f320:7833 with SMTP id
 3f1490d57ef6-e788089aa3emr1357392276.5.1746568418645; Tue, 06 May 2025
 14:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250506153507.83094-1-hare@kernel.org> <20250506153507.83094-2-hare@kernel.org>
In-Reply-To: <20250506153507.83094-2-hare@kernel.org>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 6 May 2025 14:51:39 -0700
X-Gm-Features: ATxdqUHIWYEodymDTUYEBeBePbnFHVWJkp_LB6AFcseNqv8kyogJy_7zL2MTuDA
Message-ID: <CABPRKS9iWuOSHx=3gO50e1CoWbQga-F6_u8ZJtEWzuWVOfWXuQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fc_els: use 'union fc_tlv_desc'
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_145339_725639_821F9F7B 
X-CRM114-Status: UNSURE (   6.79  )
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

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

