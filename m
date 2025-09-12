Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F623CA101F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMQ9UJhJn6NJ6YO0XjNRfud58VDObW+dwpThmQIOhd8=; b=CQ3C+4VI593Y6SywlFd/5LdhIR
	bbtEx6ZlBgCjmufwAkgS76rQ6rDTHOBchus+2bBfVRMYvXUNsfjuYE3u3lLVtYlLt6LwHxYLlOQYX
	674k+nTvdDnIaDJksIKAC7MVLqQfTNapjyt/Gxero5pP8ZHjlTDjEuqFZ0lrlX/x8enrAkRGLwBXU
	MCKSBgL/6U+ZtWNI5swztQgJBORVUe8ZxQaT3eXSkqBf2K9szJrHkGnKel6GQax8zOMZtVdi/QcmF
	J8/3TLpuYm6RXbu0Fh40Au+5WFdz2y4nP/8vMqat8EhwDrFmuZ4Qz7FM8iTHRVxjwV2LMw7+wc3KB
	PWRjeGCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwxeW-00000007UyO-0XLD;
	Fri, 12 Sep 2025 06:53:00 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwxeU-00000007Uy4-22Ip
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 06:52:59 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-772301f8a4cso2169394b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757659978; x=1758264778; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMQ9UJhJn6NJ6YO0XjNRfud58VDObW+dwpThmQIOhd8=;
        b=IS7Vq3TqrJtzR6wBaFd8AnM4bbut37hmm7EIaCSUiDGvAm3rL89znVVDx79miqe4JB
         wdHoLd5omiMxGvzZaDmTbVbatn0xk/kuTFqtKz9nrZiUKVtbY3AxL3BaxPsa1Adh2a3k
         +jAetBjRySwsIXQe2APHHfheAjeCSJFsvZXC9MvFTEUQ/sk3seOmrfPMo5pON3QMy8z8
         7esQgL4534HgYkppBCuWoS3ET8UP2KpHcf44jR2tTz4lP+SkA3x6N2Y/xO4+XxN+sU9e
         xcDLyWZcSRrgw699C5ETzEg7kCl8Z8BGez71EE1ZPrVTPb27wPlT534PwF0PsWzL/qAK
         ln5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659978; x=1758264778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMQ9UJhJn6NJ6YO0XjNRfud58VDObW+dwpThmQIOhd8=;
        b=QXVuLGI4VGo7MmHg/ryAURJeOi2TAklKIDx4eVBCdeGEyZmAN5Oh3cfIGgfpKa5Hjm
         LNxU/VPxCF/ocGqdm/Ck9szaxKSeMYuPdurOG6+cj6MDWPga7R+WT+j+sDaztVskxii+
         lb5dFkgJ0TzvzgCMuP7XiXeaCt81kgdwyBMWjDD5k7OTNHfqIkSx3SyxoJbsN7EX/4mF
         2RHJJtj2YB1ek6ObyFOubb8xoRijUZl6tSiqHw+qoMWq9hN9xXDAaY6a6yE3iNh+Idlk
         c580eVlr2dl2kDLUs+i7+9NmpP+FUbDawl4YXsLTukgV29yCAcVT0kRC9dE0bCw6WsN8
         B7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVR96pHIoc4CUiVEciYEfWF96tC7PAha1luYbItnwjr8ULlNxLuXXH4XknzUIw1alohi/roBl0Jqk0d@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4FCY/scfFznX0eUub3mwz5RPeDTUxNdzgToywtq/hbQNU1svY
	gg8xVzzYwjTP0/Wws9AXzwrljCANUdkAHuBsNwscu8AXiSp7GPY/kiG2A7OCqQ+p+kc=
X-Gm-Gg: ASbGncvU9irT4fqejOc7UsNsQKwtjRQwlGa4h3WZt1/YwuxX1x+VY25pP8lZ2T8eV3Y
	w7ow5h1aVhclAGex7+hy9w6W9YVPSkXKiN6XKxzc6dJIXROv5ybNWv4wQ6UGAxDIEznwrYO51KV
	TBkDuUCP3My1uIpMkU7lgpyR5Tk63Mhs1EXdeans+04rRLATZzkqYkAntf1TbJnsUGwqY+ZWPQ9
	1qpQnIRtMqzYj/MUBBqwunUEorDXu8UIPTn/3GoigOOndZhJg8yXyUepoCQrpB5waJwCQF7gzur
	sHDZrh6WHWzlmoxkaIujKDtmEboukPMKOJDHLqtkdEjmPGBEGrSx1dwajBbDHQoVlaeb1TL8Fxj
	l3QtxMcQh6Sst+ZejuzaaLnPSbx7oV1cgxo5vpGWACA3RuoY=
X-Google-Smtp-Source: AGHT+IFQKeePLPos3Wc/vCSrtfD9DK3M1OpdAn6C2aQwDSA3Qht9Qgg36mVj/vePp62ddGIi74wlig==
X-Received: by 2002:a05:6a00:2ea2:b0:76e:2eff:7ae9 with SMTP id d2e1a72fcca58-77612092482mr1980655b3a.12.1757659977712;
        Thu, 11 Sep 2025 23:52:57 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:9e14:1074:637d:9ff6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c49fe4sm4410985b3a.101.2025.09.11.23.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:56 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v2 2/5] lib/base64: rework encoder/decoder with customizable support and update nvme-auth
Date: Fri, 12 Sep 2025 14:52:52 +0800
Message-Id: <20250912065252.857420-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aMO/woLrAN7bn9Fd@wu-Pro-E500-G6-WS720T>
References: <aMO/woLrAN7bn9Fd@wu-Pro-E500-G6-WS720T>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_235258_521464_E2C2999E 
X-CRM114-Status: UNSURE (   5.65  )
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

Sorry, please ignore my previous email. My email client was not configured correctly.

Best regards,
Guan-chun

