Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531E6C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QKApX5AD9aIEi6uewJIQf4uaw0UGX/OqxGUTe4X6NvU=; b=vN3nUlHi3RPfmw50JhtXd83NCr
	t8Gi0lOQVFT7Apjf9VMmZ0DD7i655bky6ekF2j1y4muDMK5m6FafzxoPPORx+HJ9vFead4x9oOTAv
	iRg+JXnN9/XK2B9NjzwVOIRpCwFW0Rwd5tYuR/Z1xWAKAuIcY5vZvfF+UeWFnOzAG/kmeTf28tJNW
	z0xJVmTcXghoR6I/wNwUOsa+9WZKaj59FFGhVCRjtIvEDf41CkFBJvMiYiGjgiXOTzsFlujYFYIUf
	TbsGf3d5z+c/+bpdTHeDKYm5IYCsIScUCXPvxC2Z6xmUhkzux6GxSaES7Ms/5DgLj9oTc1CNYOS2C
	Mnu2ZpVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugezN-0000000G9T2-2sqN;
	Tue, 29 Jul 2025 07:43:09 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugaJj-0000000Fn4X-1P79
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 02:43:52 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2401b855980so14728835ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Jul 2025 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757030; x=1754361830; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKApX5AD9aIEi6uewJIQf4uaw0UGX/OqxGUTe4X6NvU=;
        b=bpo6dlEmJHtysAgdNmrxZC9vNEBcDDjLJ/Hp4CAMjsKbIOI0DOCR+zGR2nDsvAKT8V
         oEpHCay1RzbwKDaRPHGVRYCCrZg9V9/ZlOZvzkgBQG6VGDqWUODW45k6Vbntb7Z4D4B4
         OqFUyGI5ZZ0PMw/bil1qMJX3A+qLILOu0xbiSzDrdVrQjY35xVQRCsfaQv/wVLAGnAT5
         Ld7M1r4/vXAVqv2MPm1TfSX8hNueFExy3UDySVec753wCpy6nd8HvGfAk4z1FqhbkR0K
         he/mUfZIFgQxAzxucAxBABP1+TSEY/b8Tuj3K/4/f2OZt/0B5QMU7BjDDO4t54PQ0/gh
         +zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757030; x=1754361830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKApX5AD9aIEi6uewJIQf4uaw0UGX/OqxGUTe4X6NvU=;
        b=A6Iy6aGal0up4jIR8qp0XSC+rFJu2rCFhBAR7pXXwLJiXJPKGi6wDUmHMVkQioDUF9
         CBLlCvFmgxF60WkNjbNdJDnhES80y0DK5RzHTvJpVcBMQJOH1zTlvMVViP8Ui6ZukVDS
         F3Gkrj6Z4GKiXY9J2i3gd7zg9ZtlfyvvT7bF32V1JE9ldRYfOZjlTscfkErT1XX1zGZu
         N4EvkyHzdqvKb7V+9wVyWANfrIpGG1afIrZIAVygAEntWQs6PWAKcd3jLWoQ9zSy+JAJ
         LMl5iZp0LOEC3ZMaI/LBNNOeBnWmnDya8oAxt4HyOwqshHzNHtOg/FX639r3OenqIpf5
         j0rA==
X-Forwarded-Encrypted: i=1; AJvYcCVfe9n3844xFE+9eQ+W7pKtn+KMNEtsU+xbqDfP6Sd+m4ZQ60sQ24CCe/fjy54EU1E4GJBB95VCCjRL@lists.infradead.org
X-Gm-Message-State: AOJu0YyIFDDTDSzpkQ4JpMjRby7ti6ms8brRM2LSXU0PevypV6KSw4gB
	KyLR+3WKF4Zf9a+qOQUoMymtLm5mOrj7Vfa+zDCuq/Z3vr6bibXMuh8/
X-Gm-Gg: ASbGnctK0T181EkBItSEQ1lkKFI0pQeF97slJiGLff2LXRJw5MsNN1OIfxEkeMdC90H
	6QYe/EkRjUtVvCGcXt3JgoDM0d7WGNZRMp4xikh/TnpF2/vGBj+Mz4WB0nHhO+7v5cPtHgf4qJw
	uEDyLf8MxeZX3zk01xBBHF17omhwiTN/P/yirXwl98E5oPq8xWUlEzdZWRjALQtrg9kuWp87Zpn
	ZW0q4IK3QHDf9RqIEDyWACSFSRufXiNe78iBVr/kTlbY88046X1o4I00UBALdhBrYJOs/jiP0HD
	UxOIN4pfF5aU+kcjsozi5bPSCmiyB/VLQUx0tczrv9ir49WFATuz6+ckG8n07LmAbWEFpU/kikP
	cLEZrTxGPh0HzxRf6Sal2TTA8Cw==
X-Google-Smtp-Source: AGHT+IHdjXTtHTwMGQwZ9/tvr6W/g4hhHNiDFkExB3KA8O1wMz4OUmUJOvFvEzI8mjgHYmK3eABYWQ==
X-Received: by 2002:a17:902:ef4e:b0:240:b28:22a3 with SMTP id d9443c01a7336-2400b282b9amr114633395ad.29.1753757030520;
        Mon, 28 Jul 2025 19:43:50 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:50 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 3/4] nvme/host/tcp: set max record size in the tls context
Date: Tue, 29 Jul 2025 12:41:51 +1000
Message-ID: <20250729024150.222513-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_194351_371418_25DD9C33 
X-CRM114-Status: GOOD (  14.52  )
X-Mailman-Approved-At: Tue, 29 Jul 2025 00:43:06 -0700
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a tls handshake, a host may specify the tls record size limit
using the tls "record_size_limit" extension. Currently, the NVMe TCP
host driver does not specify this value to the tls layer.

This patch adds support for setting the tls record size limit into the
tls context, such that outgoing records may not exceed this limit
specified by the endpoint.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/host/tcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 65ceadb4ffed..84a55736f269 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1677,6 +1677,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			      size_t tls_record_size_limit)
 {
 	struct nvme_tcp_queue *queue = data;
+	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
 	int qid = nvme_tcp_queue_id(queue);
 	struct key *tls_key;
@@ -1700,6 +1701,20 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+
+		/* Endpoint has specified a maximum tls record size limit */
+		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
+			dev_err(ctrl->ctrl.device,
+				"queue %d: invalid tls max record size limit: %zd\n",
+				nvme_tcp_queue_id(queue), tls_record_size_limit);
+			queue->tls_err = -EINVAL;
+			goto out_complete;
+		} else if (tls_record_size_limit > 0) {
+			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
+			dev_dbg(ctrl->ctrl.device,
+				"queue %d: target specified tls_record_size_limit %u\n",
+				nvme_tcp_queue_id(queue), tls_ctx->tls_record_size_limit);
+		}
 	}
 
 out_complete:
-- 
2.50.1


