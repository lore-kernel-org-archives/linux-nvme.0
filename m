Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEE5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+S76o+lU5f8Y6L550JpPm+xHI7UPiFEDOIxOuBfHgB0=; b=tR+q1vfNczZ90Br/FaOgfdG1aa
	Vu51Y9ejC9uOHdUqU5wZcY7QxaHzo68E5Gke/vR4gxFqUY2CxyJalz6VUFHZYu9aWU0qaCr1CC+IL
	kAvPAGCdv/iJW+kedR02BCoXlRp4eo7wYL1CnrcUjt5BBMSGeK/jTnInR9nP2Pl8q756tXDml+x7s
	0dbtEaL7FjqP1s153Kqb3ca3RLU6zNTtHLR5YY0cAfHDWFvtaTQKIPF7SPykL5klpS4n0V1uXR9KI
	Rg05a7g8H+zxbjF+mHloOPpLMzaT5/4s1ZyS/HcTLTlzoiRvb/4R4GK99QSEaG/1nbJkjFzwGcwvd
	3+TyRy/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxXPF-001pPa-Ru; Wed, 15 Dec 2021 16:45:30 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxX4r-001gpI-7U
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 16:24:26 +0000
Received: by mail-io1-xd2f.google.com with SMTP id z18so31057450iof.5
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+S76o+lU5f8Y6L550JpPm+xHI7UPiFEDOIxOuBfHgB0=;
 b=eeoTCD/lXC4ZHgBvmLhuznfU5045cTL3rZBg0aucp9SwMeHfDr4LaOd6y7iDeiZGUv
 psVwuGV1538JFC9lVJJEFmIQVpQ/jWQko5AFv+GII/Vbr1DsSlG1QHMhnm1A7kpTa5ya
 uSZsePJed0yFhPR1AfQopDFeU+iVtafKjDFcQ2ZlW89tBQT1C3CEadtFwtZwqM956aSE
 tzzlzlq5OngmA+MEc0YZUfKnD6H6cwcy253tRlPjfxhUSxlpVy6RMeq8on+KbfM+gBj4
 cgPhBTu6N+pMyxqy6RTEWqVGPIrBhAZxH2whW101yMpTYJx/KJe3Ktq3UWjfz0CbltrO
 TEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+S76o+lU5f8Y6L550JpPm+xHI7UPiFEDOIxOuBfHgB0=;
 b=EWPA6zpLviWn/4/+wYRCSV+bPz86jw4D1XCeUOj4/hmboPa5Fz2IpJwSw7/qgC4Qvo
 YqT7mUF+BdUqpdcsEybbUHxaSYXMpGFD5728jzWqM1qb7X6Jzht2iBAJFCO4eiD0hYSA
 plZ5f+rr73TBEkSatTubGIJhiT1WOu/HcTde4lFd5ZgeDyZnOj89dOe6X0IHqxxhmr8f
 pKhB+ksUaChSncMIsS1pkoxum9jjmLEzPWIgehu1ORXp+JhC6CPJBOrtW9HZrIZmTM9K
 0fqLcTPgjzUplRPkxEkMujrB/O7G6D+WLETDiXno5tb2ZpY+ueK1GxETfgKxTbGa1F+1
 4eUw==
X-Gm-Message-State: AOAM530IMiJJaEMyI+8GrPLDJr7/UDnAut7qGULoxHdUBcYiQNG4dlWv
 Vo2l0PsF23MbIGMxVYiZy4MhW/2JXW2ctg==
X-Google-Smtp-Source: ABdhPJxFcatts9sLXYdkAle2BfEi6ILJixpQxLDbxTgbcDO9VpviBfTNuiW4VHa7ldCY9PKRGgFbmg==
X-Received: by 2002:a05:6638:140d:: with SMTP id
 k13mr5935052jad.37.1639585463015; 
 Wed, 15 Dec 2021 08:24:23 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id g1sm1153170ild.52.2021.12.15.08.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 08:24:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCHSET v3 0/4] Add support for list issue
Date: Wed, 15 Dec 2021 09:24:17 -0700
Message-Id: <20211215162421.14896-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_082425_330276_C9257FF7 
X-CRM114-Status: UNSURE (   7.10  )
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

Hi,

With the support in 5.16-rc1 for allocating and completing batches of
IO, the one missing piece is passing down a list of requests for issue.
Drivers can take advantage of this by defining an mq_ops->queue_rqs()
hook.

This implements it for NVMe, allowing copy of multiple commands in one
swoop.

This is good for around a 500K IOPS/core improvement in my testing,
which is around a 5-6% improvement in efficiency.

No changes since v3 outside of a comment addition.

Changes since v2:
- Add comment on why shared tags are currently bypassed
- Add reviewed-by's

-- 
Jens Axboe



