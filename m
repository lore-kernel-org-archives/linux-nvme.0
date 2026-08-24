Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEC4C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FXqUmYfP/1VeF9LNUTb+thDcnPb5yvMtvt49VD63p88=; b=H5Jf2WhZq9wZ/stSB8UcL1T2WK
	0cM2EDngHPaaDDjU3Lfwbyi4zeruOyqoSkd9mjzkAzp2z3kpwnfyL+DlYO4EnMxkzWwM8JglCLPra
	soaLGh02KZxcHEyPpkBA1AtZX5WnXaLurqpO0Eo+V9GrYq6wAzX/bTAH/q7Z6oIz8K+2OjCSREInX
	sbvxLYd+CSF2tDR0AZheyo1dkKzPHFI8/g9l2/3JxwMyqN02fcJFE0Mstdf85tbzZPBbMc2qxeBpY
	Ok9Rt64eQmtX94uT0vX364D7uFPX5JUVz9EuGdm+zr7kp18lapPlSo/EbHEoVHGsIHrlUKe+kj6y3
	QFbxGRZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydAz-0000000HSA5-28L2;
	Mon, 24 Aug 2026 22:29:57 +0000
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydAv-0000000HS9b-0sc8
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 22:29:56 +0000
Received: by mail-ot1-x361.google.com with SMTP id 46e09a7af769-7ee4399c3abso3766377a34.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787610591; x=1788215391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXqUmYfP/1VeF9LNUTb+thDcnPb5yvMtvt49VD63p88=;
        b=SufpE9qb0Jmmk2gJFiz2pB8/Y+s2+tvxv082V80xTRmekBaCxucfyhxc77vjaRjmLG
         Cj/Ti7JodRqB/T1NB9GYSgg+vBQvFHbz2bWwWqtWKy8bGNvAOxHTsIRWZZyaVxnHMUtS
         jrQpI8FnuqcI9yiVuTWT3Fx3+KDTQXoLJQAy4SwRlUVhULCghdA1kK+SZqFXVbTH63aj
         EcoMmHyhttg317ZqespBbLids1d5SsYyYt6T8QAErBV6HRweDzt8XcnP5JR9OmvqMrVo
         ofgCYWWX12ZllUX+xYarQx6hdDGMnUEzjAxSSgqnQfRa8RKUtywslV13qCSjkZl9LDln
         Wg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610591; x=1788215391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXqUmYfP/1VeF9LNUTb+thDcnPb5yvMtvt49VD63p88=;
        b=Pjnm66/tmc8M1TZc7xyIOqkEArCvoqGWgJmwfEDEsHwP/iB/11YTpbTxNczbGie4Co
         4Nvb6YTconD2RFgu4qjx+Nx2BrsWx3/M4JuXO5LCNSP+RPghBlA9RCsvmIEbsYqYtVAM
         ncrI/sapXPBZVblBm1PhKns3xnIGO8Xx6pOL1DiAnjUXGZ0xO5t/160Ck3uZJIdH51pn
         RkV4Zf8PK12uVv1SvfaMzoILLVlFg456OKE3S1o7i04RuQlgUFc8Hl1asoWhsp4bH3Jx
         5jo0au+w0GN1XXW5hR4FUFbWqTx5a13NacNAwO3vSQZJgrR5aikszCPOcsXscWTfLBaS
         nQqw==
X-Gm-Message-State: AFuF++kn57Dh0SqhA2iGdYIAtLPiaD9BxPeW6Kip9b9THs6482pJNmtB
	U4PfNVPnoqjTzc+FJqvoT4d/mAWvhx1zQg+ON0oqrEipwUEzhBbxytBJUT/D4M5OzY+eb/3h5wp
	sUKY942qw8c4e109FW0YKSHgUel1CDWxUz5HS
X-Gm-Gg: AR+sD10qKCA0k8qlvtY3USwKce3OrD9tlj6UPqLn/o9ywiK9E78cv3FtqLm4BU3KQC9
	P6t+nmsgc7DsdmKTR++Lr0OkohV8V0spUHg6HaEovxULLr03nIorZC3QCD+VkJ7fq0acHgMrV67
	mkdfZBmPkYZpBf6UUrxbGz3xMgyrqftvDHs0E6fi+hjhTXY5KPe9/bKlFtxayR3Nm8Kd+LwJ/Js
	b15E381ts3oe1WYLznuMzfnhibIe7CJZBqiufWzmqxjsWcx8UOYun3ea+jH+v8yWn+IAmsmxSNq
	SYi8LRSV7i9erQnJY/kwWN6vPLYYP2eQW9XsXrqYC4F78AYUBynsA3h2q4prJ1fubKlyPw5v6KX
	vmNmu4S7vhuHsD6BqXnpKq6puUhrldmM=
X-Received: by 2002:a05:6830:6111:b0:7e6:e162:915 with SMTP id 46e09a7af769-7f4af75f1dcmr2252155a34.5.1787610591507;
        Mon, 24 Aug 2026 15:29:51 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f48fc4ba4bsm827273a34.6.2026.08.24.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:29:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 139BE402B2;
	Mon, 24 Aug 2026 16:29:51 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 0E12651D15; Mon, 24 Aug 2026 16:29:51 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH 0/2] nvme-tcp: parallelize I/O queue connect
Date: Mon, 24 Aug 2026 16:29:37 -0600
Message-ID: <20260824222939.301887-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_152953_409797_7B20A213 
X-CRM114-Status: UNSURE (   8.93  )
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

Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
allocation and startup"), I/O queue allocation and start steps
(including authentication) can be parallelized for nvme-tcp as well.

Patch 1 is a preparatory refactor: it splits the queue-count
negotiation and TLS PSK checks into helpers so that the individual
steps can be called directly from nvme_tcp_configure_io_queues(). No
functional change.

Patch 2 has the async implementation: it fans the per-queue alloc and
start out over an async domain, serializes the per-cpu queue-count in
nvme_tcp_set_queue_io_cpu() that can now run concurrently, and
switches sock_create_kern() to init_net.

Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
time reduced from 61ms to 11ms.

Surabhi Gogte (2):
  nvme-tcp: refactor I/O queue setup path
  nvme-tcp: parallelize I/O queue allocation and startup

 drivers/nvme/host/tcp.c | 143 +++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 47 deletions(-)

--
2.55.0


