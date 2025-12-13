Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C932ED5B15E
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Dec 2025 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16GhHfAKBgkwyk6D5SUQoVKoPzsjSLeKs8ujGxmonQs=; b=TvlvJvAYOG5Ahd2jOhSmp53TyI
	3FNheq0kxjBVa5B18iUIVRdmCszxYVmeHPtm8U57VYuG/aDbWRYU+FQF0qHdMP6mP0+1fBy1IUsOE
	75rq6v8EC6/TmKgjwEQKOdN0SA4rJffDyqzeGMql9CNMs3xgq7HFrESbN+K9m6zqTuRHcGYsEJM8G
	oG63PBRQ6BcXfpQs6yvn0om/OHTbE5JoWqsNLOvvi2swEV1rODYtviM3Xx8CnGTLrEmRXCuEfuDxO
	O527M6H7JLVObJQnk8IrL5tE6duw/oGCAX6Hi/jtmI4+n9bOJyOHG4eorpIw3ZE9ba47AzJ1pYQ34
	MzicpJBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUUoy-00000001qn8-1EEd;
	Sat, 13 Dec 2025 18:58:24 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUUoq-00000001qmb-2LUG
	for linux-nvme@lists.infradead.org;
	Sat, 13 Dec 2025 18:58:21 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-888bd3bd639so12116496d6.1
        for <linux-nvme@lists.infradead.org>; Sat, 13 Dec 2025 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765652295; x=1766257095; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16GhHfAKBgkwyk6D5SUQoVKoPzsjSLeKs8ujGxmonQs=;
        b=LBGOnZIL+WvzDJyQ8078BG3afBFNQYLXx4KLn689m2BVaJ8Aa0H+ItRcqFPuL8Xm0I
         E0P30fjcnYBLDhAsJqJiHOS2Mo4rRpGa9nEyB9UGwHmSrrG6jvknBNar8/cZKFY2VoB3
         1FU6cmMBqg0S+WmRpAsxQc2gnhkDnw74D123n8QF/t1gBZCD/gfG2SsREwkgFwjBeLxj
         4pV3ygTk/RRbH5TXvNQ7m975OU0kqVfuPeJwF4U5+gUuYCVMhLIf5ED5Y/orXuTnJ7mU
         XUlHFMkgwTHQLCEEbuz4aNfyT4wRpIELqIipQba4ieJqyNScSFMKkQF3a+e4gwQK1Jn8
         lVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765652295; x=1766257095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16GhHfAKBgkwyk6D5SUQoVKoPzsjSLeKs8ujGxmonQs=;
        b=sNlhOK6eYVOKNnENR10ZJmHYI6f24IlfGkEiIvdA/QeUq8GSGXlFaE6s/H6aOPRsWY
         QLzOaxtFn0qGXa1mvlmk39foyeF6lcVfynJCAaoIXBXmrZC79nq5steJZ+n2t6lGywfB
         aqG6HW5MDMi4lwtgp60msuogDoJT2MN/dIPwxL1gR/lz4WtnmBnr6s/4o1EgyRz1j+et
         phI3avKn2nYkp2sTNH8Ug5jhSwBFGbK5aBkUdzBtVi/1LXJIKXokLGkqJZuRwEEzhV/K
         HSyqxmxjWXMmmD3HXKhxGzU0K2K6W7XmPLswd4Bcie5y2/sTvfSKCClM9SR38yd3eXWb
         m11A==
X-Gm-Message-State: AOJu0Yy+F7nk7pyN1LOKZJWmAOj/1C++GDgJaS1q4WcLPLquNIHzv8Lf
	bon2WcNvOFAhaLGU0vdCTVR23ltKIrDA3Vezd6WJudClj1FgG0D5LXxrHZhHO/Iz
X-Gm-Gg: AY/fxX78xM92mMMTBPFuxjPYUxF+vt2aKOJikE9itjLQEJhc4dyO7kD2e8Ze92Ohh3H
	EJCfuRGcBtWzk3tXcDJBElvkbr7CTQzvSLm3h9yBzHUAxEbpU+ujx5tHFqhKb5pnQ3kWMHL32xB
	2XowLTIZ0fYg+zoIk0quoqrhzllxOgw+dfPx+gQcU+JgXuWqOWsEUQHOrg28djqdY7sArCTRVIR
	5+GbJrSq7FlT0d9l7MsnxBoiUH27TUt4J0zIManp8XFQg3LRlS08DseleZTW/9e3Drv/fWYctYz
	fltWpqzkkjdld7AiNO6TcGP4OFvJfeJz70ylV0i3rklOBOzQ0RWX9rkeezf6Q0YQdxP4ltfVcrD
	uGjHs1U0PCT4ywKk/t+Xt5VjjeTaA1Bxx/+CcIooSc2AptGp5T/VBGYUIdtuTbvoz9pAfJu2IwT
	X52MCI4uVU9rBuSOd+tebxHErmT4/Vryqeg5giXEOGyssXHb5Bpfyh9trO/gQ=
X-Google-Smtp-Source: AGHT+IFDwkMpYD7ToNpPJXq2oSbIUbGaPqyZmG/8VTWATTQI1w4nkCZ+JfcMd8iFzwltrCaOe+8GVA==
X-Received: by 2002:ad4:5fc7:0:b0:880:5249:be3e with SMTP id 6a1803df08f44-8887f239a2cmr99753196d6.13.1765652290916;
        Sat, 13 Dec 2025 10:58:10 -0800 (PST)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899e5713cdsm18366956d6.33.2025.12.13.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 10:58:10 -0800 (PST)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk,
	sagi@grimberg.me,
	kch@nvidia.com,
	hch@lst.de,
	kbusch@kernel.org,
	gregkh@linuxfoundation.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH v3] nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec
Date: Sat, 13 Dec 2025 13:57:48 -0500
Message-Id: <20251213185748.1060422-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
References: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251213_105816_778145_39360619 
X-CRM114-Status: GOOD (  11.21  )
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

Commit efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
added ttag bounds checking and data_offset
validation in nvmet_tcp_handle_h2c_data_pdu(), but it did not validate
whether the command's data structures (cmd->req.sg and cmd->iov) have
been properly initialized before processing H2C_DATA PDUs.

The nvmet_tcp_build_pdu_iovec() function dereferences these pointers
without NULL checks. This can be triggered by sending H2C_DATA PDU
immediately after the ICREQ/ICRESP handshake, before
sending a CONNECT command or NVMe write command.

Attack vectors that trigger NULL pointer dereferences:
1. H2C_DATA PDU sent before CONNECT → both pointers NULL
2. H2C_DATA PDU for READ command → cmd->req.sg allocated, cmd->iov NULL
3. H2C_DATA PDU for uninitialized command slot → both pointers NULL

The fix validates both cmd->req.sg and cmd->iov before calling
nvmet_tcp_build_pdu_iovec(). Both checks are required because:
- Uninitialized commands: both NULL
- READ commands: cmd->req.sg allocated, cmd->iov NULL
- WRITE commands: both allocated

Fixes: efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15416ff0eac4..d5966d007ba3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -982,6 +982,18 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
 		goto err_proto;
 	}
+       /*
+	* Ensure command data structures are initialized. We must check both
+	* cmd->req.sg and cmd->iov because they can have different NULL states:
+	* - Uninitialized commands: both NULL
+	* - READ commands: cmd->req.sg allocated, cmd->iov NULL
+	* - WRITE commands: both allocated
+	*/
+	if (unlikely(!cmd->req.sg || !cmd->iov)) {
+		pr_err("queue %d: H2CData PDU received for invalid command state (ttag %u)\n",
+			queue->idx, data->ttag);
+		goto err_proto;
+	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-- 
2.34.1


