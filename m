Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC72C36002
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=; b=m410LKNWIM77CIHFFDQfCHrwuM
	PUhJKR7chjUvi6BY59SUBxc8tpcM+UlXD7qIP8+UzdIfDIwlkvsgu++sVCyYJ4sQ+GeUz155unnCE
	mJQ24mZh0G79dgzVFA6Z6aJltlFMMo7rKTKDZqcW+cf0nQS7GMWSuYPyyXjiOe2BI14VMHjhypK4W
	mzqxKaVb1QAhRBs1Yi5pO9dc0r9yAPRAlDYqhfApkHNwGwYfE+nf8MVZodOperKxxcQB1rj8DwR9a
	r4d4zRyyYQzeNk3vYzzJ1EML7HzKB9z4XqpEdb6KRll+sFZrxcQU160bTQe2BfzuFP+UChOk10ph5
	QGZgqzww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjRG-0000000GH9i-0mY2;
	Fri, 21 Mar 2025 20:57:58 +0000
Received: from mail-yb1-xb62.google.com ([2607:f8b0:4864:20::b62])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjRD-0000000GH7l-1Gbx
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:57:56 +0000
Received: by mail-yb1-xb62.google.com with SMTP id 3f1490d57ef6-e638269b1deso288270276.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590674; x=1743195474; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=U17hp8zj5R1N4y9wfa73cqyrBN1wVUX0KJHC9Fg8WzQZcG4NvNvwrh2E+NAY4E/NrE
         vGrsqQSCWqWIYy+b+oJBj82hEd+QEQf2WIevIbpQ6EPboAt96C8nFdif83ysUHNpwTAq
         V4/tnxH/dyfoMFXJdGWgPxnTxfvI6p9w4sYS6W/YI74BFe2aSN2zratpJ4XNTFAJZFxa
         LzxUmLcFpLvFkspvS2c45mPEsjKGY0ohGF6uJd7mvsbOwDF6jXb8S2ASlzVIpBdIi3l8
         dj+eykszA41r/VelHDZ3BsR03mkAja30dv6l4saJCq2Nmb4runlcgzEHrRjH3QfL93/d
         tRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590674; x=1743195474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=nEbRxDYyVjhmnyoZ6kVI4a23JRcAOKWsq9iX83qmvwGWQ5bXhHNe9D2Ju/mkELuH4j
         NmW4Dq8lutd6PDgRO+xZcV6ustUt53lX5romWu1Vqs0PUOaarCNZ23BLvpQIuw+VfVwt
         XBrxnFp/tA8xYcX29z8ZbGXhaHsjl+XX/bfxYB1nxv4QIYESVfWQR8xOVZMLsaJ12j2g
         fSgyOL18ouLeRHnqJ0kdDZX5nDS02/kVQc2S2BLHV3Ox4z/KyzRAiEDB6fywwj4Wpgfo
         DPbNAcJbM36uqTpekhhHBRF3OW/GQ4jKWdsFiKXdzZm3BSNOAcIbuh52Bg7RmrPyAqGz
         7kKA==
X-Gm-Message-State: AOJu0YyFzUL1NiSCN3mJh5eKa0Vw4WSGdoPRg7I8Pn3vKS7J4SdG54uV
	dO6AKWbipCN3dbY1XnsKH7WhcKdEICFbAMA3jMaxJVUlL0LcJNpUV/3P8BqW5hbfBKdSjiwN85V
	Abel3G/g31nUTKqhJWU0bE72JXTvdijxw
X-Gm-Gg: ASbGncu4VXSpSm5sW9UB1EoU+83Qf3qMZgO/ctSzaawesVwr/EEFhLG3Y09Krw7uVgo
	aRfD5j8b79BqBo7qCPyVR7nHM9ynETNau6IFNuXsy6ifN830kfe/tYtxBYekpWtgoNI5LUb9EjM
	49wzDBqBci5/ZTME5VRKdo1jgRsv52YXr/WpjXaqFV7+Yfm7Vr+EArok9wyUsUkA56akV+vVCam
	YM5bWZ09LafNPqkDM69gJL3gOcPniVyEb7cUDl+vdONsB+b+11E2d+Zo0/FZLFv8Tpza7E64+sO
	I94mdoIAyCZjKo8wIr6i1sWktim3s1Wlj2XNvaLhOtgqfr0P
X-Google-Smtp-Source: AGHT+IHMsqT+tAJGNYKBkEfX1KXe23paMLiNTT5TUzRzsaj2BpFKB8j3BMLeHqAIARAiOCl6or/l0Rhj+2TL
X-Received: by 2002:a05:6902:480d:b0:e60:9821:3c with SMTP id 3f1490d57ef6-e66a4feab02mr2622892276.9.1742590674081;
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e66a44272b0sm53193276.21.2025.03.21.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2562C3400FE;
	Fri, 21 Mar 2025 14:57:53 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1831CE41952; Fri, 21 Mar 2025 14:57:23 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] nvme_map_user_request() cleanup
Date: Fri, 21 Mar 2025 14:57:19 -0600
Message-ID: <20250321205722.3947901-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_135755_337078_121DD6BB 
X-CRM114-Status: UNSURE (   8.34  )
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

The first commit removes a WARN_ON_ONCE() checking userspace values.
The last 2 move code out of nvme_map_user_request() that belongs better
in its callers.

There will likely be conflicts with the parameter cleanup series Keith
posted last month:
https://lore.kernel.org/all/20250224182128.2042061-1-kbusch@meta.com/T/#u

Caleb Sander Mateos (3):
  nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
  nvme/ioctl: don't call blk_mq_free_request() in
    nvme_map_user_request()
  nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

 drivers/nvme/host/ioctl.c | 63 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

-- 
2.45.2


