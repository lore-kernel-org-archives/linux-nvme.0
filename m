Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657FCCCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 04:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HWcPwvpyGHeQ7Te8LbmgWrzKDF0qH1U1PIJiFE/G1QA=; b=eFtcj/acK8Yg3En64/rBIgNUcT
	gI8vgRSL2AXbAZoxXv6r/bnIJpyUBKXzKcr6by3wuW260RylQn1O0NRoRTsVfiYFD9q7sfGJ73rCd
	oC+0xsckAPV72Eh62jh8TeEs4yXuJdB7aojbCU7+zK3a2wm/r2VEIZ8ca6qbFtlcXiBfxMgAYVWvv
	q72Nhtn0vqsxHDlQF2NQ1g83LyhvUJLebsExSths/vYhRY0CFAEXY33HQbwYmQkFT8G5YmtXDRKuz
	X3AXIvWT/Tw0XomspqDo0p8d/CTi7rUWhWVC08lJGbstCB8dy2MxjCDum4+kbuFOcP0m7qO5Oqbpg
	s+yFoWNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2So-000000086Vj-44d0;
	Wed, 12 Nov 2025 04:28:10 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2Sl-000000086VM-1oje
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 04:28:08 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3437af844afso436421a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921686; x=1763526486; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWcPwvpyGHeQ7Te8LbmgWrzKDF0qH1U1PIJiFE/G1QA=;
        b=GeO1Nwoity9VtaE46cI6hYPO9nPYS2nyAJevJMeMtKfUgffL9IqayVAvJw1JfYmjtH
         TiSMpdrg0U34yMHTYeyl/Fe/jzcE1Lvm6JwZqJrbJh8/22miHzNPNH0FO4bYsoGS3nUN
         S8l8RYZYsYdAtxtYXPlQYqA60v0MSdVH5oToC9SCrYCiORi28sRjN0uukVi+o/wXI/z/
         w0CQV8J+/jELXd7mMxOmyYVfGbOcEbj/UBYpC88DKS2mPvpCfZPSGTQ4CvZNWtjR8otO
         Tl9I9dVB8Le5VTfpifU3bZOb97NxMtIo9xTg3OUQ4tecqVm5GYaVzLPMQMdmu4Oqd1s1
         1ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921686; x=1763526486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWcPwvpyGHeQ7Te8LbmgWrzKDF0qH1U1PIJiFE/G1QA=;
        b=J/xR9VKuIOf7xz1L5zrmYUEbTbV1ztJb3H1MY2nyY6hocNHsmVJrklW1ddiqmKJVcl
         70E+4INuo/4zKrGU0qqJrogUyw/XOsACp0b7RFhD7xtTG8HgWfshrljuQmCVueFZeoI5
         D1aFlOLw6jzAAIR/TziM/dLlxXpFyqRwYCPFBJ9+wDZRgQsve85jUOlbYMQL3LLh0E/U
         SC8r23NdEnirNv7qOxtrLSzNiyOfsDgNYa4e2a5mR7Qao9/Qfoym1Dl2Aj1G6k+jVEx+
         /h0Nbt76j6sHSCU+RrzKiV/HnPAmsU/8oaFJLNKNQ44hukkN0+en+N/N3hllsbzjSIWP
         KyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSk5HYk6ukm5e1+kTz1zkbHykwtG5bDsfXZJFeA5ins1EwpSV9UX1yZCdhNIxL7BV9sjIik70+klc5@lists.infradead.org
X-Gm-Message-State: AOJu0YyIpQ+SKvxdCXT5sfw+QnKWa+s+Y7gsAnOkNN78SK/lqg0o86gp
	wdAYpw8eAIaUkwed3+prZprDo0790SY23BksZToHEcz8c3HDtRHx/4cl
X-Gm-Gg: ASbGnctL0aRo81xHKG4JBMcKD/DDIi8SY9cdVc5Baao/BIOqgXxZYfvHU+1tqec97Wn
	pyubN8toRBd+Qo3xqcB9Y1LxSsbU86pz37hTDsEBSg7gHx+p9PnArrEeol3EGhjwlsUijIF82D4
	7jdXhqSC0fdOgkYxl9kao1ZZ606OO6PcZwB4FSvdWqZsoVDWVfY9sjNO2TjiD8StXxzJHDHJS73
	VrpgOm0H77lsAI1kv1CJByWTO1B+gjNii5aBKh6J7/cStsoZAbap46MV0iQtHkFFFBUpgzKkwQv
	IE4VZhIvEgjjIThrJEA4bNCvQCzZC3co9KfUvYEusoM8qvAg5FPMsJ2xkk831ztLIOO1erGio6x
	dKKeLZBzseY4jaNRkZv/5pzD0MnvcS3uZTRq9uRNFwDw5ze7AX+TG38OnP9YAh5hZ71en/BMAUJ
	C1PxZEjxK6B948YalIRKvfXqjUi/FW+oYe3A9kTAlXgtYYWA9Qy+JIsUxEL/c6BBxWE6C+sm2Lp
	shZYVFGFg==
X-Google-Smtp-Source: AGHT+IEW77FvieM+vtVkbmhzlz0RFLk71+mgtXTKXN86kZaDWUH4yy9113DxeoOKMAxSWBEyakVQSw==
X-Received: by 2002:a17:90b:590f:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-343dde8b46emr1933248a91.24.1762921686366;
        Tue, 11 Nov 2025 20:28:06 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:05 -0800 (PST)
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
Subject: [PATCH v5 0/6] nvme-tcp: Support receiving KeyUpdate requests
Date: Wed, 12 Nov 2025 14:27:14 +1000
Message-ID: <20251112042720.3695972-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_202807_487215_3519EF20 
X-CRM114-Status: GOOD (  18.28  )
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

v5:
 - Cleanup code flow for nvme-tcp
 - When using recvmsg in the host code first check for MSG_CTRUNC
   in the msg_flags returned from recvmsg() and use that to determine
   if it's a control message
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
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

Alistair Francis (6):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    | 103 ++++++++--
 drivers/nvme/target/tcp.c                  | 216 ++++++++++++++-------
 include/net/handshake.h                    |  10 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 ++
 net/handshake/tlshd.c                      |  96 ++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 11 files changed, 397 insertions(+), 92 deletions(-)

-- 
2.51.1


