Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23F606A332
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1iIyMp3F;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tQosMTsU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=LTUJ0JEm67/O1NvvxTlwEEPb8oRFqpA1lbxsVjiMSpc=; b=1iIyMp3FR/0ouSkwmuTIZtYCTZ
	VoukAmkxjAgvBo//bLmt8FcW0BJYrA22oOA+bShLl1CpeQsqmvWgWOWR4AQToK4rUhVbR/LY3U+bN
	G6a2AbfaV64mlOStCLdLAHIrNLQNKKXDyZhz2b8c8GKijqG9QhMCX/2B3GcP8e9oX+4REZNG4Ui0s
	YPyf4hwCzPCz6nshJ9I7PqonwmnJkvMqZvT9J4fVHX2rXrAtYrmaHyi5KB5EeVv4SCHe0s9XK+lIO
	Wkw2x6c+9Q4Mt8iuR1gw/y/ziYIitRZjaKRmhtPuHlyBBAKp8K/zxw0C4aAn+LpDNfwxkAw3JU3RX
	4+t0st6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlJc-0000000FdDh-3hAU;
	Mon, 02 Nov 2026 06:14:44 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlJa-0000000FdD4-1JzO
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 06:14:43 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-19305bcb72cso1785417c88.1
        for <linux-nvme@lists.infradead.org>; Sun, 01 Nov 2026 22:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600081; x=1794204881; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LTUJ0JEm67/O1NvvxTlwEEPb8oRFqpA1lbxsVjiMSpc=;
        b=tQosMTsUlOEc2ck+wbW70vKTbYiBqrZQmypSKnKLfcIMC9i8kmds7hKyMYugoT66oW
         N0gvMlErpMgJBSTKZm2CPo1yQEa4MxJDiFYQDO05ZePnuX6bZroiRcUpdDhEnSidsivj
         NCUe4ThRgcfRz3d5KUA/lgO+ZAUvTR1NTRfVOyMRiaSVIgGDK8xWWwlzVWkWdMP+ID3Y
         c7uTKZsUiFLRfPl6X7M8SKSPAjhZuy3ckKlCbt/FlcUb0x7/nMHpAsS1Pu+YpIlT1fqc
         T+28obN2QLyWA3Mb3Ed+ob6qi79NBXlESYBF1ezr5coqBricp7zjkXAJAZW7Ss73xcNU
         aK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600081; x=1794204881;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LTUJ0JEm67/O1NvvxTlwEEPb8oRFqpA1lbxsVjiMSpc=;
        b=C+Vv1PUEw3uZQy1WQshKPO9kFiWfxqP45p1SZJeYFiyRabeoforrUAXI7epkc2bYph
         7inCGM6LzNGuf2lDmGi2K+NVKk8PqSt4/HvLZ+o1iMpDSJhefZw66XyDe/jCL76ZkiB2
         G9Z0iOTs4VrtTc/n2joNVG97N2XDZzrSQ9Tgox7W5+D2T7S0soTpr8dT07SlfiUaIaog
         s26zTR62HOv/06mzK/jVhwuTKeB+sMenaZ5Z/wvPdmoQ3KN2QXf8FyzWhRemEDVJm4yr
         dOsyMqO7O4dQk25fQWrvly4nV90QgkcwIJf+35S+tqu1aq6VTax+AZWEq6uAkshBNUmn
         Vpqw==
X-Gm-Message-State: AFq9FYJlf9rvq7LabFPY6KkpXzLfyu4hAmDzutTRfWAtSGbZN2Z0WnNO
	ihqOuZ8zBxW6Yz0zLHlteER44+UZRHsMRgY6Jz06n/dvKfnkME7tKH0CXY9vJ/Wm1lE=
X-Gm-Gg: AYBFou13VIUa/aKQz2kXllc7QrHmTVpFmZVGwi1c9tjIqHrnYgAHMh1vdbcPrLcPhgi
	BDE58g+FxCWsVexYvi8l0uLiYd4AMR295Bz+z+nc40VADwhMUuyUjNGsgR7Euj3JJ+SAE08qE7H
	sZcon0RKiP0S5SN3jd223VJMYs8IuhJsK7Pw5u4gc/zSkoPio7n4ZflVVLfr1NO/XAKyhBarvEH
	rs8/3wG4BZfwLYO1QmlvKa+VFjfFxI/HPfkTr6FBLkJYQ5B/YR6DrUpGUbdYDuZfdT7uzP/oWGV
	q1tf/wY3PYe5s6MpHHI8TecQsBb2synwBcjxTspGA8nYd6mj7+ZgW6qh8QS7+mpAv6A/jTw8BEX
	t/jwAhjmZsLRzvsvubZPGhz0kQtNp29YAOlTsFIo5Zk1KP5Sx6U3ibRGC/AlIhQjoznDiT8vlmK
	qL+zrWsu0HH4dCB3WseKuBpeBPSw3pP0PgnzZOeNl/QPkTO4jyTDhD4fGUnFdFVmM12le7V2olI
	AEXH7TZ5gBmdDn3TAOX0MSI+CBqE2r/WlNis2o5vmDFeLI5IyGbGOX/SaVxXW7s/Gql5wgKc5/I
	xODkWNpzhoYs8Db0H1zyZHvZPA==
X-Received: by 2002:a05:7022:294:20b0:17d:7b45:f91f with SMTP id a92af1059eb24-1ac5c273f92mr13942725c88.32.1793600081035;
        Sun, 01 Nov 2026 22:14:41 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm30288043c88.14.2026.11.01.22.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:14:40 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] nvme: delete controllers with many namespaces faster
Date: Mon, 02 Nov 2026 01:14:35 -0500
Message-Id: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsq6GoC/x3MMQ6DMAxG4asgz1giGUDiKlUHN/yAB0wVq1ER4
 u5EjN/w3kmOrHAam5MyirruVhHahtIqtoB1qqbYxT6ELvLnt7CVDZyx7QVszuKHJU4QkYBJehm
 o5t+MWf/P+vW+rhvadFaBagAAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_221442_365584_DED36A27 
X-CRM114-Status: UNSURE (   9.48  )
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Deleting an nvme controller removes its namespaces one after another,
about 20 ms each, so disconnecting from a fabrics target with 64
namespaces takes over a second.

Patch 1 removes the namespaces in parallel, as scanning already adds
them. Patch 2 drops the write lock that del_gendisk() takes on the tag
set, which would otherwise serialize the parallel removals again.

Disconnecting from a tcp target on the same host with 64 namespaces
drops from 1201-1308 ms to 115-124 ms. Details are in each patch.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      nvme: remove namespaces in parallel
      block: set QUEUE_FLAG_NO_ELV_SWITCH under the read lock in del_gendisk()

 block/genhd.c            | 17 +++++------------
 drivers/nvme/host/core.c | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 13 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-async-ceaaa1eda6a7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


