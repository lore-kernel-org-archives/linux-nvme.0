Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D98EDEBFB
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 05:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=; b=wBy4ycXE8P3mTvXzXajdALg8Fh
	OcVZuiGRGL+19V+Bqj85o4KF+yBKC6Zwy0R/H6DC/v0pLffQxAin8q7eQ5zm7nhYfd3bYdRjQSEsM
	sCXpw+GqkZNsMln07g/kzj5Bozm8JW3vXDxGdMhuj0SgK+rPMGyRaijVYM5pvzK/8K69yJbdWIEne
	k20CFZMO9tRvQLd1EHx5kTakLum6qGjLtV3QCy2CPGqxPQC6fWrn2sOMQEz4JzSb3UxKDqVp55J6T
	e3+D4vI5GhYi5yAIBzQ39QPSO0zOZWMGjp6cvCWgyxYAS7N4l/vZnWYw8hQ1cygwnL69uxaGbqLHu
	ZguP/lcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeuN-0000000GTdd-34zb;
	Wed, 04 Mar 2026 05:36:31 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeuK-0000000GTdH-2rcf
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 05:36:30 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3598c008455so1777109a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Mar 2026 21:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602587; x=1773207387; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=;
        b=c7YuwLFglFtUGdypJQwjdw0OBm6tzuFg8Wl+PC1y9uOi6LTtVbp5fTwrka9qa05gr/
         10+kadnCw62N1GVqsntcDtF5oXtBbnhgKWH/70VVT3TzOw289QOK+kaW49v/ujp0Cikj
         5Fjk5P0/4stq6fbCY7R+HjVOE52rVYIveoOH3jand9zGLIJZiBwQFQ2e5g6pCoOoWdxp
         6RRgzTgPffhAgkH/teJZzt0H1ZeLyo+IqMpF5ezrRL3c5NZkg86xNAVU8anOceJ7fb0B
         9p6HtQ2ek4HEN8i0sEGtrckqKR+bRr+5RL13895J9LH63xbuNbQXpRbddIUG0LjXzUBk
         GBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602587; x=1773207387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=;
        b=LxQznT3HFFw/D94n00vtEFqykRQpVM8tfvWWSWwBgQW/7o4d2T8oBCox8wmRv54NIB
         2AESjE8hCHajtreLCBTMqJkh0fw792wcihuhTL9nAlx5PNNb222OhAuAT37bhWIeSb3+
         CA4sIgn2mVcuUei1fXcokoh+Tbl9geD7rDD/axFcRlqrRVYeaSLVS5BapyeY3yjx0l8n
         mGuMyu4AwryTHvXIO5iAp4GsYgP5bIhiyrd5UgZkZWZPJjH/SnyAf3HSj18PfTdUZa1x
         qcQyt7j0pDqRT9K7QCrM3NR/yGFGAM00YbvVkr6XDZTuaGvuVU8eU0JYIf/aiL2Jmp9T
         5KOA==
X-Forwarded-Encrypted: i=1; AJvYcCUAoI8mdVUmb9WVwCTS+V7gml+1tB/oiUcAyoWHVP0avMX7byc5viI9AtbL9neSev3w0Xw9MZMe6j0z@lists.infradead.org
X-Gm-Message-State: AOJu0YyK5MY0qXRPMeAzyroDxqyvDYXZvVaXlXwgvH90l8ILpNFoZFZg
	coHZu/ha3erdlvXIXVRi0M+fUQs3RLq4/FtJ9GTeE3fb+FoDyi+PHxH3
X-Gm-Gg: ATEYQzz9Yk1cU0x/Ll4T6HkssWGdJ6od4LWL2tjwAlWZfVV9u0b50v220tbm7d3bTSc
	60rI3o/jeb7E8Re2tqaFJPBXQ62A2Rteu8+3PaSJ9ythF+VIYHm1pbJNkgNxpZjn9Gf/UnTT4i0
	ccZIldJAE4GX4QF7utuEUiZnDQrlu4VGcMxcBpY7RrjGO6rw6CJ1zXz/MtaDmZmSChs8Ox1khHo
	oa23hRwb61e/KPqO6B7ZeE+1t/PeYxcDLCrFOCOxYQw2kLaeJs3hPLYlj46vonNSe9Y70SQm+sa
	be5Zd6ZROz7Wdg7up9Ij4jWUD4Hcjq4BCfYM7++epy1jp6exh8ctqjtjLnMFLvBO2zvloqTakCA
	OjsFRnErXqtmaUSfDLTYKsruqJTuP6B0AYtGxFjwMkPlKF8fnSLwkWesjltwtBVehOFRLgCtuwK
	YDNFf8s41g6S5tyeWdhPlosCkS9MXDue7Er11jPgt3Ng==
X-Received: by 2002:a17:90b:3952:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-359a69aec32mr1042348a91.6.1772602586933;
        Tue, 03 Mar 2026 21:36:26 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:26 -0800 (PST)
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
Subject: [PATCH v7 0/5] nvme-tcp: Support receiving KeyUpdate requests
Date: Wed,  4 Mar 2026 15:34:55 +1000
Message-ID: <20260304053500.590630-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_213628_750351_8F225170 
X-CRM114-Status: GOOD (  20.77  )
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

This series depends on the read_sock_cmsg() kernel patch:
https://lore.kernel.org/kernel-tls-handshake/20260217222033.1929211-1-cel@kernel.org

ktls-utils (tlshd) userspace patches are available at:
https://lore.kernel.org/kernel-tls-handshake/CAKmqyKNpFhPtM8HAkgRMKQA8_N7AgoeqaSTe2=0spPnb+Oz2ng@mail.gmail.com/T/#mb277f5c998282666d0f41cc02f4abf516fcc4e9c

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Based-on: 20260217222033.1929211-1-cel@kernel.org

v7:
 - Don't use recvmsg() (see [1]) instead use read_sock_cmsg()
 - Remove reviews from patch 4, as it changed a bit to support read_sock_cmsg()
v6:
 - Don't free handshake request on completion (handshake_sk_destruct_req())
 - Add handshake_req_keyupdate() which reuses existing handshake request
   for a KeyUpdate
 - Other small improvements and tidyups
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

1: https://lists.infradead.org/pipermail/linux-nvme/2026-February/061252.html

Alistair Francis (5):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_req_keyupdate
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    |  80 +++++++-
 drivers/nvme/target/tcp.c                  | 213 ++++++++++++++-------
 include/net/handshake.h                    |  11 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   2 +
 net/handshake/request.c                    |  97 ++++++++++
 net/handshake/tlshd.c                      |  97 +++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 467 insertions(+), 79 deletions(-)

-- 
2.53.0


