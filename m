Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439B1C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlJot7sx2YopdWxHyoyhohLl4TchU03X/u4osGspitU=; b=T336IlC57sweN6QuGgvyoBFFmC
	2kEs1oQ02o4x0noDJd5tyjyqowXWHPHEx/2yMXRnQozSKoNL3weCexITQJ1cF+e4HVesTJyr0c9su
	hOMBA2Ae3YrUzz2g1pxO6YemBbUWkj6Cu7DR4QhxgRb95lNSWO812y5BGYn2D23gQXlU1zJFsOY2l
	8GI1wPdQS+KnAYnSRrFQo0XRq8wDSZToklFa6a7s2rQ98VVNl2Qje5YbU6QuRcl4gu69kFbwsPQbL
	C2LzgiU6soXiPVWZyJaJx7+AvZQKxPiKGLvF3FIIJF7BbZCFabOfWVl/9WNy5N7xa/bCaAvNyKBIX
	mIIDHhCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVgW-00000004Igs-2Z84;
	Tue, 01 Jul 2025 07:45:44 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWV93-00000004Eoh-3ZF6
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 07:11:11 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7494999de5cso4165362b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 01 Jul 2025 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751353869; x=1751958669; darn=lists.infradead.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlJot7sx2YopdWxHyoyhohLl4TchU03X/u4osGspitU=;
        b=RlblpO7VVD9nTVVO7ga9T1YmyGPnjl+L8iZVUUiDTPRMNILJuVaVL8d1c1uHYKYwPk
         Bsb4D1/J9C23vCryXclpz3EvQVvwjWLkt5nw/b2tccfLMekDb+ySEz2umvGIJj0ZRZY3
         OoZXSqMudGJ8W3Yemgu7KBoHILIMLpUHPJsqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353869; x=1751958669;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlJot7sx2YopdWxHyoyhohLl4TchU03X/u4osGspitU=;
        b=htr8Vq6v66/9eZc5dwsw71fxgk01AeHqQwl+I7Nt/UUYWlrW2xml+wHELuTaaSrWQE
         NwLsemtYZXVcCUnen7VIo6oVQzBJ53FX2inRh3v0VdBiPYKNCvSHQhQ51WQ4kM2igMdD
         P1bMnSTuKHM1HdpChjaJpJryMgw0aCleSJwRgrUHeQ1IacAHnJevAMKNau1o2p47dPzz
         iYVP/Bd+wfnkwfir50RgYjguywrMJKX4fOLlrhJFDyZceOdXLQqiIWbF/BXOJq/4KAIg
         naDbEzhf/wlZRm6j2+KWK6yBibeKWEHLKJWkFlIBEfG+j20kK/EqXtffVH6LjSu5R2AI
         xU1w==
X-Forwarded-Encrypted: i=1; AJvYcCWIvlokFK2lWFWLMls68lQ7ivkyHmJ7CsOyLm3ij501w6v2SYuHquLKJhCUyKJOLsIC51aLljY9Ynb1@lists.infradead.org
X-Gm-Message-State: AOJu0YxOVDzNbbOcaJ2Mr6IpMDK9OKfUGUh1en20ZBpEtetgd0GUoX6d
	+Ijs5MmnmumOC1o2TiSdSOjpHKoaI2SInXkT3sgPG0Pq4Kkzx95hjQGh4EaGWkk0uI3TnDQFffS
	cGYCtvdDPQPjltAQxTF8LR95O5lG/jsRah2pzZxVkYS7gZqqymx+DKjk2VA==
X-Gm-Gg: ASbGnctJQsrpBzZBDrirN8OUdVqLawXvIPxYqB58VP5/UddkESWn1Lsn9B8e6rg8U4Y
	NdneP+alAPAKcPKjni0bmEweLAWdYxlYWLpbpmimPcTsHK/m3Qb4Xnp129sg7f3ZcV++nI6Pbuk
	q5pcHBThdTSrgbMN4nT2IUotLpg1AHIxZoBnOWB6BRRSwnfkMSqvaVYqZRoFUzlqBYnERqOtoLu
	yrTb98+CBxWA6BtKLFTPcUv3GkEhBBdqnhP5HruFEkvBwFdUh8eAaLDCDkccuThe4xVXewPx9xo
	qx5jpIH7foIb6FD8yabBceN19pcVTNOj94w5ejYPRBJVIXY/tyACF1ytbL6AYxaciBwwJ2bw0XK
	1I6xrTw5lARRKuKVaz1Mtdi67WvH5Y96pcQ==
X-Google-Smtp-Source: AGHT+IFjV6+RrH4+UnV8V5+50viki/aZYcrx5DBr5GFjR0CD6LtrULS5qzOc04+1tAG58NB1KrApAA==
X-Received: by 2002:a05:6a00:4b11:b0:749:93d:b098 with SMTP id d2e1a72fcca58-74af6fd7312mr21032262b3a.22.1751353869139;
        Tue, 01 Jul 2025 00:11:09 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a8f6sm11235597b3a.12.2025.07.01.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:11:08 -0700 (PDT)
From: Muneendra Kumar <muneendra.kumar@broadcom.com>
To: bgurney@redhat.com
Cc: axboe@kernel.dk,
	dick.kennedy@broadcom.com,
	hare@suse.de,
	hch@lst.de,
	james.smart@broadcom.com,
	jmeneghi@redhat.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	njavali@marvell.com,
	sagi@grimberg.me,
	muneendra737@gmail.com,
	Muneendra Kumar <muneendra.kumar@broadcom.com>
Subject: Re: [PATCHv7 0/6] nvme-fc: FPIN link integrity handling
Date: Mon, 30 Jun 2025 17:27:24 -0700
Message-Id: <20250701002724.1435361-1-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250624202020.42612-1-bgurney@redhat.com>
References: <20250624202020.42612-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_001109_940140_56AF344A 
X-CRM114-Status: GOOD (  11.69  )
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

Thanks for the patch .
We have tested this patch and this is working as designed.
This functionality is a crucial enhancement for Fibre Channel solutions.
This feature perpetuates the capabilities available in dm for NVMe in previous releases.
With this patch we have a solution for both SCSI and NVMe.

Tested-by: Muneendra Kumar <muneendra.kumar@broadcom.com>


Regards,
Muneendra.


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

