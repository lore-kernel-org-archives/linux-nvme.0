Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47CACA1002
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gM3TMQ0WbfGUuMmelR/0TgQBGHBy9kRHA2KtDMurmyY=; b=r9NOUS8ZGMkfZEo4hVXdstBg0v
	OXmznJqgZgAje8jSlGITKCyzc4pio1diJVlC/7WWjV0keo/r9aciX4Z08xoUTebRwJ62NhK/S9JBd
	IOK6wiypJlcBryt+zB5DI/Xmk58Cfs1IhRJ5LjyuztRBxZzaljboOqxhOwjFh83U05c2e53eITos6
	X+J4EIIvnCJue3qAksaesXmY6QVH4P55d/M8z9X36z3EeatT6xizDEV7DUN91uux0OVcSjnCYRr8z
	mtb+2ertwzdZOOwaXyOAhenbmMu9qqC0Y6qN0Tk7NV+wJ78C/CYoIw+znE67/8i0WLwpe1EKsNSEw
	uRnb6jpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUU-0000000GEri-3rRe;
	Fri, 05 Sep 2025 02:47:54 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMTy-0000000GEcd-0jYT
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 02:47:23 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-772301f8ae2so1446031b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040441; x=1757645241; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gM3TMQ0WbfGUuMmelR/0TgQBGHBy9kRHA2KtDMurmyY=;
        b=DbKpNuO2O92sjHhFBfu0NUV7oFcpNyl8FMeeczM+EHaya/pAdo4xoeZmvj/L3wacbh
         saVDAOfh3yr8pQ1A7MlcFUGyTJd/PoHiZxVv13XwXnHropgoNKTPfhRqYUjZKO2nd2tm
         daBy/WqBxYs9a2HDCHZcyvSYQW9adj92djBaJUpxjfSWo/kwCzlhSL8nAqoqH5hL/nPN
         XdifmB75yk6IR3QIe/y8nqYrS1zwtSnQ3uVk/m/Vr5LBwiEwLjxHewj9lwSF1YMe0/nV
         6de1FYZ6ao4RlbB8AIFikiOkIQPZaDnO3WXVz+oPpu00eOL1CwXCutf+RmjzkC1TzIfv
         xeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040441; x=1757645241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gM3TMQ0WbfGUuMmelR/0TgQBGHBy9kRHA2KtDMurmyY=;
        b=koj7XG96buJu0nmzHkYpG8UHwVbsXMYpKEOb3/uTl0kQGLZOe8qDCBV6oPpZniztf+
         6tQHr2sdgpvrTbi0FioWcukOIcFFazZLBi9mu+Nfl3jU4ufHBNDtPlVKOWCOawWbesc9
         j6DYz3vyNXfDdD0JGO5GekWPzGhKjWqG5FsTyjGaDTwIyidSgJmRcHyodTLIkHk0NGUn
         /SIB2leo56NL/Cqa01V7lMLyI22ic8IIvwv6IbCOndAE7sVTaydIGaNthh/of/p0+Zym
         Yznv7Ho1706qx5BsK5OTEp0ob33vcM/Ven5Og396qCgtMBqLq4xzWyviXBvATDpc6+JR
         klrA==
X-Forwarded-Encrypted: i=1; AJvYcCUmx1cvmCqc6HAZ9bK1XJpuizlHg+fLcX0FwUwobCJhdkx8EUFa5uSEmwzKDHNuamFMPAmNYqF1cnI9@lists.infradead.org
X-Gm-Message-State: AOJu0YxrjqgHYSe5YAYgmbUk/pUexffiAUdSzAERrMPuHvsw0mK3iBYM
	xx/0BW7krdiBw5rUmoBqPpFcm0/pZONzmTg8bSe5OpR8rYtFHm2rBzQp
X-Gm-Gg: ASbGncthqppQLsOB+RE0GYBpo7eoKtThDZGZmUtwGwKgeTg3PxKTK5V0X3ZVc5WJrE3
	9fpH7+AOq8qqmCMxXFZr07qxb8JwBQQo+IfYoVEAx2TQ8YJBoVUJArc0RR46eXlqu1PwLLSLHMq
	FMXn+TkukaCxBD8IHW9vgizYXoWJsurGOFn3uz/8+1/jOqHvFlBS9g2VBMa/PTLkAJY2P84h9vX
	rZgDR47PkZQ7YIQ5ZzxB/i1+Y0A7yrMxochu+BW6G+CMZ4aL4fRa28C2UtgNvuxVZFJV7AFoWAn
	mRF43v9HZdTpKzxLJnOyoJd3MEWWp44S74bISzHPGH2xKVEmoH5X0XpbB5xJl65gMouDHWwKqXF
	67kwFrpYqI1Qi5JGMnmPnW27g9411/sULYG+mwRBxzyvgzVvY/vf7qpqnioOFRCePaTc3fzr+QK
	LoJU5iVRVmnc1dKe01avr9+lz+s6hgAeg1Wi5snJLKDXWyfKXn
X-Google-Smtp-Source: AGHT+IFnFUAgkSS6yBhBqxWiiAYRF6dBvxDDhPo+1WikDfiL7zeeqA/KVbZCbB5Nq6/UGRBPPZzeeA==
X-Received: by 2002:a05:6a21:329f:b0:248:4d59:93dd with SMTP id adf61e73a8af0-2484d59950emr12008405637.52.1757040441006;
        Thu, 04 Sep 2025 19:47:21 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:20 -0700 (PDT)
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
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 0/7] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri,  5 Sep 2025 12:46:52 +1000
Message-ID: <20250905024659.811386-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_194722_215047_F58B2578 
X-CRM114-Status: GOOD (  13.40  )
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

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

Alistair Francis (7):
  net/handshake: Store the key serial number on completion
  net/handshake: Make handshake_req_cancel public
  net/handshake: Expose handshake_sk_destruct_req publically
  nvmet: Expose nvmet_stop_keep_alive_timer publically
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  19 +++-
 Documentation/networking/tls-handshake.rst |   4 +-
 drivers/nvme/host/tcp.c                    |  88 +++++++++++++++--
 drivers/nvme/target/core.c                 |   1 +
 drivers/nvme/target/tcp.c                  | 104 +++++++++++++++++++--
 include/net/handshake.h                    |  17 +++-
 include/uapi/linux/handshake.h             |  14 +++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   1 -
 net/handshake/request.c                    |  18 ++++
 net/handshake/tlshd.c                      |  46 +++++++--
 net/sunrpc/svcsock.c                       |   3 +-
 net/sunrpc/xprtsock.c                      |   3 +-
 13 files changed, 289 insertions(+), 34 deletions(-)

-- 
2.50.1


