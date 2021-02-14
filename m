Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC8C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 11:02:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A439264E4E
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 11:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A439264E4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcjN1RNiR146f4TqSnL3mzttxTuvnBRPrsy45tSUq94=; b=u/IzSCkFNLAKAhQLdbGJaPPlea
	WENyPeO8z82wNxw/WYlv+eIf1c5pBWnQZh2WeqDNg8sIqCBMPzGTvRaoR8HFh1qD5OdujCk8TlRrJ
	o5LYS/wr/ZQ30xK6IVOwtlRDyoiS5giigYpwqxxIZyG8ixwYcUtGpzHIn5dDY0M0qyAW9ncCvqV2t
	2PUZ+tB84MhWwvafKmj81OLtGL8zCMkSRDLeRJmDN4rtYO9hDPBfGBX8Y8KSf1cLUd4DUOs0L9PG+
	dGKZv4NygKP3/n7YUu/m3dQomrlVmtpL32jRE1893qeP5gycodJeniV2Rj+5LWiL7vpgT66nVOB9t
	nxyKyEMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBFAB-0004i9-TB; Sun, 14 Feb 2021 11:02:03 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBFA7-0004hD-QY
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 11:02:00 +0000
Received: by mail-pj1-x1030.google.com with SMTP id e9so2191051pjj.0
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 03:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2tQVlhPB2LuXdQ8Xh3LoSoyxfsSd3ClVfkaDI40DNoo=;
 b=NjBIYVeKjicMBVUR6cnPtzYLuiDkiNTPJhsXnOdAo89Tz2JbyyD8Ydm7e5OERwpTaW
 40703aZ0+U1KaIhsyZs/0yUiN93h7YNwvAxa9/5vR48v0hIhxVlzsz/E4MUIVnNLVo9X
 SYc7h/9dd0ALNQRevLFDGbDc/AnR1NKDy16LZJE8v8uHyvnliitPAxq0mGFrzI/Rekgx
 3UwcENz4qUTxOPnulac5Im0pMn00jdIe3asP+bnBJ6t7InqGZitR1gOfYfdT0tbcHB72
 TPfhm62sNHCdJAR1OxPI74GMQ1HBpMhBJF33M69c4J5uHc2sqnnJ/RCLw1+/wu6vIp+l
 PAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2tQVlhPB2LuXdQ8Xh3LoSoyxfsSd3ClVfkaDI40DNoo=;
 b=VYfHJw7YeyihI1wInbXkPYblBnR6L22moZK91lrZgJ4rzojAqcRxIyiSabeTzwyKHL
 wrTxL9RS25IvJX07YhZwGFqWwtDArIAK0/m7eS+UlFodPXZOVheo+lxKMMSp5c8jvKER
 g38l1t1fNY38QWU6nOchOCrssRma0ZVwjevfC3nblQWmK84iiGDUn650HiE8sZcj7f+v
 VzBa+6J9gcRTgsC/TwS0dqykf4jQSbZroeGu4t8WrKdbZgXONWigw+TAEkvZNhPPXUWl
 x4dXCqdR8NtBNUVl3ABTqzVNnlyJw57wpNiTX/gsZQBXfIsGBWxkFGqLImtOnAcYmVN7
 fheQ==
X-Gm-Message-State: AOAM531SV2IxOatIf3cBZA51iwWy4bTKK2JRferJBhGYmPdKY3oBG05i
 xdUz40BlFUX11hTLLZPzBCNzZfrbQ2j/5A==
X-Google-Smtp-Source: ABdhPJxSGQC6ZkIIhKZpxDOeDha4Q9xR7MDwJ531dm+NcMEhPyoCFtMRHGwq6ILhCA4+NjhFOCepRg==
X-Received: by 2002:a17:903:22c2:b029:dd:f952:e341 with SMTP id
 y2-20020a17090322c2b02900ddf952e341mr10500292plg.67.1613300517516; 
 Sun, 14 Feb 2021 03:01:57 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d5sm14223514pgd.86.2021.02.14.03.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Feb 2021 03:01:57 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [nvme-cli PATCH] nvme: add [--mpath|-M] option to io-passthru
Date: Sun, 14 Feb 2021 20:01:26 +0900
Message-Id: <20210214110126.24023-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_060159_902413_EAFEF68D 
X-CRM114-Status: GOOD (  21.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

`io-passthru` command is to submit a I/O command to controller with a
namespace specified.  Kernel driver does not allow userspace to I/O
passthrough in case that controller has multiple namespaces attached.
NVME_IOCTL_IO_CMD will return -EINVAL error from the kernel driver.

This patch added an option `--mpath|-M` option to the `io-passthru`
command to support specifying device namespace id to I/O.  This option
will make `--namespace-id` option to be used to find out the namespae
instance to the kernel side even it's a hidden blkdev (e.g.,
/dev/nvmeXcYnZ).

This feature can be used to debug or test the broken path for ANA case
by specifying the target namespace of a controller to I/O.

  nvme io-passthru /dev/nvme0 --namespace-id=123 --opcode=0x2 --data-len=512 --read --mpath

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 linux/nvme_ioctl.h |  1 +
 nvme.c             | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/linux/nvme_ioctl.h b/linux/nvme_ioctl.h
index d569414211d1..578faaee62b6 100644
--- a/linux/nvme_ioctl.h
+++ b/linux/nvme_ioctl.h
@@ -87,5 +87,6 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_RESCAN	_IO('N', 0x46)
 #define NVME_IOCTL_ADMIN64_CMD  _IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD _IOWR('N', 0x48, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_MPATH_IO	_IOWR('N', 0x49, struct nvme_passthru_cmd)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
diff --git a/nvme.c b/nvme.c
index c79edbda17ed..9dea66edcabe 100644
--- a/nvme.c
+++ b/nvme.c
@@ -5109,6 +5109,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		int   read;
 		int   write;
 		__u8  prefill;
+		bool  mpath;
 	};
 
 	struct config cfg = {
@@ -5129,6 +5130,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		.cdw15        = 0,
 		.input_file   = "",
 		.prefill      = 0,
+		.mpath        = false,
 	};
 
 	const char *opcode = "opcode (required)";
@@ -5153,6 +5155,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	const char *re = "set dataflow direction to receive";
 	const char *wr = "set dataflow direction to send";
 	const char *prefill = "prefill buffers with known byte-value, default 0";
+	const char *mpath = "multipath I/O (valid only if io-passthru)";
 
 	OPT_ARGS(opts) = {
 		OPT_BYTE("opcode",       'o', &cfg.opcode,       opcode),
@@ -5177,6 +5180,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		OPT_FLAG("dry-run",      'd', &cfg.dry_run,      dry),
 		OPT_FLAG("read",         'r', &cfg.read,         re),
 		OPT_FLAG("write",        'w', &cfg.write,        wr),
+		OPT_FLAG("mpath",        'M', &cfg.mpath,        mpath),
 		OPT_END()
 	};
 
@@ -5184,6 +5188,22 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	if (fd < 0)
 		goto ret;
 
+	if (cfg.mpath) {
+		if (!cfg.namespace_id) {
+			fprintf(stderr, "mpath should be with --namespace-id\n");
+			err = -EINVAL;
+			goto close_fd;
+		}
+
+		if (!is_chardev()) {
+			fprintf(stderr, "mpath should be with chardev (e.g., /dev/nvme0)\n");
+			err = -EINVAL;
+			goto close_fd;
+		}
+
+		ioctl_cmd = NVME_IOCTL_MPATH_IO;
+	}
+
 	if (strlen(cfg.input_file)){
 		wfd = open(cfg.input_file, O_RDONLY,
 			   S_IRUSR | S_IRGRP | S_IROTH);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
