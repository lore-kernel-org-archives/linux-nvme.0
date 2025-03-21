Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBA4C36002
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=; b=k7lXEZEP0xC+yDUtJZI1Ybjd5o
	dMh61DWU8q5lKVCB9EhiHsnxBtk+XCPgKuQvfcadaVXiYOnyMZJAYfQEFWq+m4q470PC/VhIbGuRL
	Ri0KGJLsgq4mPxn1T1L5XotrO2Fp7zqux/BQb3Tgm9tq26yQySrqikgKnNx6AwR59lSDxuuTTHZNL
	+RJGp+xhVUestmEVanC5xHkSOQDgJipDsrhNTyntKCyXW+N7R9SqGgwGOYfzd575UNticVtLhhrGc
	CToxRVE444YN6XUOU7AHE+oBQIdbgujkeHqVYLfPHnG2DeFZvfwkBL2Txd0huoVf/4ZjR7emgY/AI
	vncJl4eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6o-0000000GClv-2xoG;
	Fri, 21 Mar 2025 20:36:50 +0000
Received: from mail-pl1-x663.google.com ([2607:f8b0:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6l-0000000GCkT-3Vpr
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:36:49 +0000
Received: by mail-pl1-x663.google.com with SMTP id d9443c01a7336-223fd44daf8so7186705ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589407; x=1743194207; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=GTvw+Ba6wBXx8UxDtJSxGWEepeSSdHsDdfTAAYG4Ts2zfgEB8M9oBUkBkv38Kn1rF6
         Ct7vESm06rOxdSsR0zxlS0sBpUZoa0yIAYXi5VX78SX9d1AwWO7LeXjZTZIYSQ/5xcAO
         490QjO8o2X0ipcclvjX+kiP1eAqgXoEJRIT6fFQYaljAt20RjCAXFnpz/45urDA8kUeX
         D7lTIT1BkkNnTfUKnptETj8n1zka4qvZWF6q7qfnhqD0xa4r8OhezjLQgpyZuAioH8rm
         YzMZvxC5KzV1i9t+Q3czDBml+QYBZqnoEcBK0lTdE1HaWNC8IWW+dMmBlPmYA9Meli9X
         uD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589407; x=1743194207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=XqjFRnvY/3NDYze9Sm3AwYFsO+Ic0MWqaA+3VuxhoK5mtewmIsQpQ3X5d3zkHPswIq
         kRhxSyKNUXIqvOMpN8JGLURySP/wyrOnSnLy2vK1bVjSW78epWZdRM7EUeL/c2pEq+JS
         Za1jgOLCt6bT1Ap8A4zwWcaF0fBfTfgl5O1Eh7DYFXInzVcGsMwiF4KJH9JaWKnOk6F9
         UJmvJvJBe3dxjgL07h3/9i8adqIdEqZr9OhA3k46K+WzxEJBgq9u/6ublRXjtl6ffiLL
         LYUT89BNj37X4sB45Lgu9Bh4ynTi2rIsI+N+rrrRISNLvBbpXt6LF6SmbcfdCBt2/oBB
         XuGA==
X-Gm-Message-State: AOJu0YySs0x1YuSxxFS/0IqlMw3BddgJA3AhgQNNOY2tFTStahlXEAYF
	w2LkIwdzQ511TCFl5l/5QY9YNTRWfe5mnyMPoVslGjGekcPpbmqwdZm096XCxvRUpu1qrQoQ7ci
	uRBGmQDJvyd6sc+C52ZPl46BzGF9ZQH9YFZ0IKHHVzV8IXN4U
X-Gm-Gg: ASbGncuzNYLgHKDS/lnjMn60IFMtr3Rb9+WiFHMziw55GhWfYFsmuXJ8SWDRt9xg/yl
	R1tzbtaztVITeEfhR+DkSzyxkqsDsiK5Spql9+8tmnnjSGFfVbvwthOtqScELaRM2Ri2QN2XgRD
	Ly8Sem1MfkWlggQkLkZHv2qJR3otP/289AVQIGHthmHEVb2lhnpA3K613yKUijPx3JVqlPFGf2b
	k7f62lEyUBCY8gx1VQeRvqwF1oJOWeouh70GCP6OujtBc5Uycy7Jr0oBAV3O05uDlruHeY0Rxq0
	b0xCIynnw/vYiltaDxhfjwjEQHO9y/HVbw==
X-Google-Smtp-Source: AGHT+IHIlCrPC63kG4FZ7I8NTyIsbgX90yahqg3Xui6KexGNSfTMzvp3/NM/3gPWtxvwIO5KlRHxc+uTqm5K
X-Received: by 2002:a05:6a00:190c:b0:725:f462:2ebb with SMTP id d2e1a72fcca58-7390564f629mr3047420b3a.0.1742589406597;
        Fri, 21 Mar 2025 13:36:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73905efdaa4sm133279b3a.8.2025.03.21.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EFAF63400FE;
	Fri, 21 Mar 2025 14:36:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E2ACCE41959; Fri, 21 Mar 2025 14:36:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] nvme_map_user_request() cleanup
Date: Fri, 21 Mar 2025 14:36:01 -0600
Message-ID: <20250321203604.3911446-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_133647_871263_E49F0D87 
X-CRM114-Status: UNSURE (   8.13  )
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


