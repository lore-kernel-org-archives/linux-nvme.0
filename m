Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C568CEBF91
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=onsK98uoUhT0XwWIqjQPKdP2gqDAphdg/ek+7mT4eqQ=; b=bLXedJotP3gQtBVCh2U0PxY3i4
	G8Sm2FZQtBh339AHhnWGcUWoJY7i6ee9PUlyE7m49xn6dprs9GLG41jDaw+9zw5X6fDcWLKzWmzLQ
	GUHw0H9PnkA0F4oO9AbGemrnKONFq+5pGJ221LYqpOgJW+iVHVgIn/8ezTbWbnQAZ1ggjM+oZMHg+
	PlTVP4eldAKn7kdNEKXZQR4ynT27FuY/qRPdYRpdDrH2J8ehUdaD8gFHsh4R0/hdKA2sXqi7WmTax
	BjPC5sW9ZdLr6qCDYOQLQgYQU5V7iDJFXorH0WGuFYT6PcFdhZLfMfkXHKeoVuAEHhb4qMzbOESO8
	4JwgxkBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL5mK-0000000GowG-1QOV;
	Mon, 17 Nov 2025 20:24:48 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL5mH-0000000Govb-0quD
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 20:24:46 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-bc8198fbaf8so2942049a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 12:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763411084; x=1764015884; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onsK98uoUhT0XwWIqjQPKdP2gqDAphdg/ek+7mT4eqQ=;
        b=TGCX2l+tLx79lHwkiQZDp54tKyPAFLVfYKsHPk6/1CRUflk8RLN/nLplfbGsq89NvU
         Pmb9OYKVMl1oU6MBDsPva1nKFIyu9yOU3XxGrcQA5ArQ7oYYEmRyV+7nE2/OxEts2q4P
         pgAo4PnnAEyXUTXJiOTxs4yFXJeJXbHcCrsNcGXQnBBUQxQ4j0BtJ17+e1tHpIDCJnsD
         sN2SwM4MOryNg2+04mozpgPr0WXIU5CmNfbF3To0GZF7B0vqKbyiylRPz+WYeHo+A6vP
         g/sidSNjtJBv56WUev7K9opcZdC5EFPE7n/aG0bIGuRvi33YZw2bD9ObPeYIE7sHQTKh
         HKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411084; x=1764015884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onsK98uoUhT0XwWIqjQPKdP2gqDAphdg/ek+7mT4eqQ=;
        b=r6/cluLZFDi36k24JlKtjwkj+2JVFfqnS/Omeoa30DqAnFRMvkJ2aVlt6LoBwIjcls
         yB0rsSEPqnr48mi7lUbao3RbJRIY9p9TQDUQ1n2BLV8WTRs8H5KooapEqUknqG4K5qMU
         jUrblzaJDHJ+AQsrItBmWxi42ec1Vhn7z+DyBvmGaxR5D9STLBkCyhTP+/Vkdsqm4pwr
         ifxI+Gnsz/sb0aBj9xnj6RJgl6vdcJTYF+7x6bC0DBRVpWzZXcMRIqBEAWEzdMt/YWD8
         J7k5J44JBWAM3ItHB0GrL1CfGKsbdDIjeIjbtjHEwh4kGJ+wF9XhNvvMFOSgLX9aih39
         soFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGXfCTxZNYBcfB3ESFZqNvu2td/TT2UqaU9ZJl6bN3WW/cEEK2VtJPbrM4GRnn/RffDOhz/ZwX9pkB@lists.infradead.org
X-Gm-Message-State: AOJu0YyuezznB1XixlSOWqvyJGk96DnH6CeYygLsL92hHY/+j5V8jEY7
	tdbhMP4vVcP/OcbZbXihHHtSw/mLQMfNpp0VkVnFwIUI5ie9JtnM0L0rDuLQjES3O+s=
X-Gm-Gg: ASbGncsnR2IaAjmKMHpOSn3D6OVC/S6OsHJ6LiYiuMJTCASZZ2OLPJFjH0GB7pz/Cvp
	FSXlOPJ0NJ8JrJmjzL+gn3lFJQJG0GusZwuaG1lQg663xCEWueyMwf9D+axmra2TX6jFLR0PEin
	GTY0lyUY8N9W8Hc1U3dilXpAFN/td/LU1jina0jwbP6vv3PvPWdKv9iX+yRcmRciyEimpK/1gB3
	47f5F8JIfRG1tOco4bhttb6Dz5vkYiyk2NdBdJCKnqtTOxDFhpbpLvmcif+7FE2LJF5IFi7TzUW
	MQLFuKLL1PeOY12geCNqIgOoM4i4G2nb4GShmNW/mAPDHv+O1JHJy30E7I5uFagd1DUSntxI+hk
	dzerSKuU/5p17sAfY26RH4cG1UROCFMmY2kv3u0k+QwVHbSblpoZDkTXDbOYZVodN5Z6ZVswK82
	T9gxWboNrvBs1WuVuBgW/YjihxDaKyj+xyu4vlIXYizxEs
X-Google-Smtp-Source: AGHT+IEdhFd42XGtdY73xnyG2hr/76Hbk1CjMiITvZ1VDOj8aki8ecB4bkyUXogqVL/y2/Mbq+4Cyw==
X-Received: by 2002:a05:7300:cc83:b0:2a4:3593:9695 with SMTP id 5a478bee46e88-2a4abb32b86mr5625538eec.18.1763411083462;
        Mon, 17 Nov 2025 12:24:43 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm49298281eec.6.2025.11.17.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:24:43 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 0/1] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Mon, 17 Nov 2025 12:23:52 -0800
Message-ID: <20251117202414.4071380-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_122445_310773_9398FE1C 
X-CRM114-Status: UNSURE (   8.54  )
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

Changes from v1:

- Keep existing behavior do not freeze newly added "q" when
  transitioning tagset from unshared to shared.
- Delete blk_mq_update_tag_set_shared() and explicitly freeze "firstq"
  and "q" and set their shared status.
- Add comment explaining why we are downgrading the semaphore before
  freezing "firstq".

v1: https://lore.kernel.org/all/20251113202320.2530531-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock

 block/blk-mq-sysfs.c   | 10 ++---
 block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
 include/linux/blk-mq.h |  4 +-
 3 files changed, 58 insertions(+), 51 deletions(-)

-- 
2.51.0


