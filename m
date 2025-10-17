Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AA4CCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=; b=WPs2+pTx2zJDE2Cw5294WHrkSQ
	2HP/dzh9v3SsfbuGdglzULDbD2R3YdHmU9QOGhLWBFc7nuBdm9FgvodyIXk+zlo7ropDck03zIbe7
	ObjHKb6/vYRBFyDRKMx/ft5Z6Hv2kVWotmuDdiJNosRG4aZY/BbQavsLMriuEUG8eNSYaEOPtCc5r
	buLJVJTuntCcpfn7aZ+usigR9KraXUiZhtqYsFAST4URDesaG9ea7ct+bi4nPf8qoI5aYoRhu/3g1
	lIFzfPDaFqNmQxmAfbiv90KPTKL3+g4DZKbhoIHrV6W8BeFnToDaemKgcQHTNXvg+tLx5m2jLOVEI
	TAf5j4mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c06-00000006W5N-3409;
	Fri, 17 Oct 2025 04:23:34 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c04-00000006W53-3dxB
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:23:34 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-33292adb180so1486524a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675012; x=1761279812; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=;
        b=THWHem98vfeEIkAPNTzzyg7DDbeGJjs4MZ1sKYStiL36vKx5fBUqz864I09OpEn3eb
         C3EPVZJHLiGuomO4NHCeSLeR4ZJecXo/9hD3OyD8lJiMKTHxlLchgbgu3tZtDr0QLjFi
         iqbaSNxOIdGLzjYOoHJ9PGl02kRkxmmTWVaP+KunfwGBH3xv6Rw0GZQqgLbKyiMXIU0L
         dzLfFnH646IV4gqisA1bgHIUCCvhlpHJt6x3JqA0i4j0wm8+WsNLT1zTvsiGVN6pZ4Np
         +JFr+ZyVxzCUEOTK/bIDUwxoajHx+4M+eZmn/LfQuz1wMR5qT+gxDdeq9N+wtCdVTf31
         +bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675012; x=1761279812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=;
        b=uod5lgFLDJmhqyvGnH/Ziv2AuPiEsebTV8EMGPIUmw8cr/ZCLsW61Vq72Z16AAcVhk
         idsUSdjELYCw1Sc3IHUGPJWZZ6Fx9HAdNxCfdwIEs9GGiUWuXSQoRBCT/l3Uy9Et70mX
         5VLzwQ8bCldQ1fjxGxNVJJ5SQyOM4c+xxKyqoinFnuXg3K2BqhahQkjiD3900Xk1hU5+
         GuKs7B1eK8GCgII0LnL69yttNHuwFybr2QCCv2Q9GAiv/Grb+yaeIS6yoTwDdOoUucAt
         ygtcgFXhJnA9HxGc7xulSvsI060dCtOzfGq4jaxX005GuCUQcwNtmjm0PrLMceU9nU73
         Y0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUODf8+AshGk3fqy8aH7kEdD2JL8mb0LIX2ZUKnMUBUjnWqCBNOC5qIXUvmdGWjlrU/fkXWvvqr89eY@lists.infradead.org
X-Gm-Message-State: AOJu0YwmeNONcGACtVdGo+e/CXA7lECddkMP7Hh/Y7FNPn3OvDwK8kRG
	hGwokuptmXIGfLutgVLp0tDwbSZYllczoO0qR0L2D3BdMlGh6hPZ/o4vhpwDpA==
X-Gm-Gg: ASbGncvwojyP6okrk2t0aYHKsF1wVCWf5vo61eQI/4hHF92+u751hnDUIGbuv5wqBsF
	N3s9g5xQcg4fzBKZfnYDh8Y+ub4MdxOqyz3UNnLhzPX+Y3eaDVjY+XyGAs5ySs0N+hY3jfA3zsO
	iU+pVLk1uR2ovoX6tf9U+NELARmg/QlfW/TygTinvX9JjER8FqY9/N4g+HCeOFcME9TVR5nhdT5
	EZDruzjfhB0M1OO52QJpqyNyXVghAIqUlFMuH9/VDK9HgKWycXwEUF+xX5S5MzGvIIC18GU6qW4
	gC3PIM9VKUUjjnU3smdz0V5qb+PtHOYMj7qOn2xrOc/g3ut7t8LIrSws/rzOWXoZ9886WGGzmqG
	x4NOsz+YkQmDbnqk5ctk/TRWXGmlndIo/2ENo/G+x27ARRUDMUM8TnAz/V1fOpTt2hqS3x2ojqu
	QKjMrxDZUklvEnHtc4/VFGrXiM6IcB5QV9nbkfhH1FFhJcHrntdrSTH/28sHy8JJX+2MNqnAQ39
	XPH2c0vtg==
X-Google-Smtp-Source: AGHT+IHf/fkMawdLEFWrxmlDZmQ5xGwA8hncSDzmuHZwevx77yhLGUBDFp3M4+pUOvAJ23AfWMIQvg==
X-Received: by 2002:a17:90b:4f:b0:335:28ee:eeaf with SMTP id 98e67ed59e1d1-33bcf8faabcmr2469604a91.29.1760675011886;
        Thu, 16 Oct 2025 21:23:31 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri, 17 Oct 2025 14:23:05 +1000
Message-ID: <20251017042312.1271322-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_212332_950618_5C362FB1 
X-CRM114-Status: GOOD (  16.01  )
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

From: Alistair Francis <alistair.francis@wdc.com>

The TLS 1.3 specification allows the TLS client or server to send a
KeyUpdate. This is generally used when the sequence is about to
overflow or after a certain amount of bytes have been encrypted.

The TLS spec doesn't mandate the conditions though, so a KeyUpdate
can be sent by the TLS client or server at any time. This includes
when running NVMe-OF over a TLS 1.3 connection.

As such Linux should be able to handle a KeyUpdate event, as the
other NVMe side could initiate a KeyUpdate.

Upcoming WD NVMe-TCP hardware controllers implement TLS support
and send KeyUpdate requests.

This series builds on top of the existing TLS EKEYEXPIRED work,
which already detects a KeyUpdate request. We can now pass that
information up to the NVMe layer (target and host) and then pass
it up to userspace.

Userspace (ktls-utils) will need to save the connection state
in the keyring during the initial handshake. The kernel then
provides the key serial back to userspace when handling a
KeyUpdate. Userspace can use this to restore the connection
information and then update the keys, this final process
is similar to the initial handshake.

This series depends on the recvmsg() kernel patch:
https://lore.kernel.org/linux-nvme/2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de/T/#mf56283228ae6c93e37dfbf1c0f6263910217cd80

ktls-utils (tlshd) userspace patches are available at:
https://lore.kernel.org/kernel-tls-handshake/CAKmqyKNpFhPtM8HAkgRMKQA8_N7AgoeqaSTe2=0spPnb+Oz2ng@mail.gmail.com/T/#mb277f5c998282666d0f41cc02f4abf516fcc4e9c

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Based-on: 2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de

v4:
 - Don't stop the keep-alive timer
 - Remove any support for sending a KeyUpdate
 - Add tls_client_keyupdate_psk()' and 'tls_server_keyupdate_psk()'
 - Code cleanups
 - Change order of patches
v3:
 - Rebase on the recvmsg() workflow patch
 - Add debugfs support for the host
 - Don't cancel an ongoing request
 - Ensure a request is destructed on completion
v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

Alistair Francis (7):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   2 +
 drivers/nvme/host/tcp.c                    | 150 ++++++++++++--
 drivers/nvme/target/tcp.c                  | 216 ++++++++++++++-------
 include/net/handshake.h                    |  12 +-
 include/uapi/linux/handshake.h             |  14 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 ++
 net/handshake/tlshd.c                      |  96 ++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 11 files changed, 455 insertions(+), 86 deletions(-)

-- 
2.51.0


