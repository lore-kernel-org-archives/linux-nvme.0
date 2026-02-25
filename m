Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DC7F55434
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYhhsa7kCZNvYr93t3sYKWAVnQ12TUikgigc7L/AwWs=; b=bewtU2C+NjjwkBbMY3BGr0clYM
	8YHtFfoOB0/6iMwvU0mWKHAZTBE304LB6MnNCc1qzEag8ViY2Oo5lkUlH9axSYlu1zeNNZztDuV63
	Ia6cVDk9EGI8Li8ePhu6uWciJEXOH6gsbcQYuyq+YTChUvtvJcrRwz8annLU/14DXXh3nD5Zsj0Cp
	ifHZ9ElpiDKTqIzMQWdhyqcV5e/Nv+zFn4bWpkKj8LSCg7myZ7GJeQWoqi1xG1NnJcpm8lpn/54i9
	Kmlj7z9vFxa+1wql6CKfkUbAdeK9mv6HUknM0CqRtM9CBP1V8ZSlucq93Gd2E7SOrcpQJml1qVGv/
	W6Wtt0QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv2Qv-00000002y2Z-1jT6;
	Wed, 25 Feb 2026 00:07:17 +0000
Received: from mail-dy1-x1349.google.com ([2607:f8b0:4864:20::1349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv2Qt-00000002y1V-1Qom
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 00:07:16 +0000
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2bdb5677170so1182351eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 16:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771978034; x=1772582834; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYhhsa7kCZNvYr93t3sYKWAVnQ12TUikgigc7L/AwWs=;
        b=ZaQ7uXcsFMPv0uZ/c4qiQDkjMOwejVJNKBYmYthO95tjOALBW4rVIL8wsApMQhMv19
         xNbxA1aN/syir8TBZ7YoCKnmCwTWxDmxXWnSDmx9AcP2Yrhvm5t4U3DG3GL0wUq1Tb7R
         owDnbohTvdWtlRhz8vNyJQok7IdnrIUUEFe9CeOEC8EzeevWYZylVLyVom8QBdCVkA0z
         mk0v/PRQn6eVkg6sRnhqMbQfjaiLYVazWY9hQSKYwnETOyyZOMrNXQ9oTRfpMvn+6cCk
         Q9H0pBjVXawZKM/FZFxLoRzsU9Uz7VSqJa1vjvZjhBj7ycx+oBVT2NFwGXQMKAnhgtVm
         ciYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978034; x=1772582834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYhhsa7kCZNvYr93t3sYKWAVnQ12TUikgigc7L/AwWs=;
        b=SL/puijIhY8/zPHB/XF9g45L3yFKPIe290lpInNgh3bMVrSVF8MA1ALo5LU0K6TPWQ
         2+d1aHNRgxI7sbgNOb76NR/NOzQIgxn012Rj4HWL4cxnCT0cfRDViCl6gOcNTckFAOGP
         eH2/l8X4U972DKu3nbtehERR6WHnTI/ADpIlylRoS/z5N577N2uvtBRhM8OXE8fzCYll
         j9mqUxgVFRrcAcaNWwcxlMzPpomEq1D9cpo3aLGEHbNpQRsLPqPpeYgasM/t4SDQLynP
         0vpY4d9Rx2O7svvtghOJf6EwqXU5lG/VG+IfdOMTNublk4m4iaqT8368ecIVg5uvCAFJ
         9Uww==
X-Forwarded-Encrypted: i=1; AJvYcCU0v5qsRYBUFaT5JxjjpyjB5Q5bw9SIHXLRhGPlJcxf4w5ktywRE9oht1K+j8+5KlLntKYCTV3edWY5@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3xGtEErn4YZph5tb2BT94+1l0yn1A8zI1Juvnk72LFvQP4Vcy
	gYUH1WN4/O+4dXKfenfbKWbdmzLB1zurCFa8sBAEKg557ijM2786u4HcNli5ADB8+5T91dBEaoQ
	vIPpmK6NMF1XlHy3dXfcOOw==
X-Received: from dycqa7.prod.google.com ([2002:a05:7300:fe47:b0:2bd:b038:ae2f])
 (user=robertpang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:dc0d:b0:2b8:209d:5983 with SMTP id 5a478bee46e88-2bdc33aeb7dmr127538eec.29.1771978033558;
 Tue, 24 Feb 2026 16:07:13 -0800 (PST)
Date: Tue, 24 Feb 2026 16:05:31 -0800
In-Reply-To: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
Mime-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225000531.3658802-1-robertpang@google.com>
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
From: Robert Pang <robertpang@google.com>
To: yi.zhang@huaweicloud.com, Zhang Yi <yi.zhang@huawei.com>
Cc: bmarzins@redhat.com, brauner@kernel.org, chaitanyak@nvidia.com, 
	chengzhihao1@huawei.com, djwong@kernel.org, dm-devel@lists.linux.dev, 
	hch@lst.de, john.g.garry@oracle.com, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com, tytso@mit.edu, 
	yangerkun@huawei.com, yukuai3@huawei.com, robertpang@google.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_160715_378151_DB1A078D 
X-CRM114-Status: GOOD (  11.93  )
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

Dear Zhang Yi,

In reviewing your patch series implementing support for the
FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545fb46e5bc6
"nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1]. This
appears to be intended for devices that support the Write Zeroes command
alongside the DEAC bit to indicate unmap capability.

Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk already
identifies devices that deterministically return zeroes after a deallocate
command [2]. This quirk currently enables Write Zeroes support via discard in
existing implementations [3, 4].

Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZEROES also
to enable unmap Write Zeroes for these devices, following the prior commit
6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I have
included a proposed change to nvme_update_ns_info_block() below for your
consideration.

Best regards
Robert Pang

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..9c7e2cabfab3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
         * require that, it must be a no-op if reads from deallocated data
         * do not return zeroes.
         */
-       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
+       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)) ||
+           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                ns->head->features |= NVME_NS_DEAC;
                lim.max_hw_wzeroes_unmap_sectors = lim.max_write_zeroes_sectors;
        }

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=545fb46e5bc6
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/nvme.h#n72
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n938
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n2122
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e02318eaea5

