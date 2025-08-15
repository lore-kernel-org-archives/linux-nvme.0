Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62ECCA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HvJ9vjlQgWj0JGVdSmCK4V4OH1FNmLUxKe8JArbwI44=; b=pOZklYGIptfvL7o1RwZvHIMJa3
	ZNNUT8mvUYMUEA5G3k0OIIpYA3wgY5DbBARLqNkbS0e2zX4XsQsgiro8A+Vl2Q/XfRS9Yr7wUMw47
	8RnYL1ooy2y6Pfy7z9nCqJwi9QbWAaMJODHKPfIW4A+VXyUzel9l0LAcDO6ifs1YR1Ha9n1QgqgS0
	BQ3+ShnzSwXFt2xYa7UczC3vVp4WiBbtoNUxPwSpFBrdnUy6n2i5KoKu0MqEeNsW+x9w0rO9XcVxP
	oeobIFn8m6rzsTA771lKv1R1PfG7F721zKwc0uXJNAmmCLkqexldgCFj/3XbH+HFStpbiua+38PeW
	Y3JbS/AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaB-00000001SbK-0GHE;
	Fri, 15 Aug 2025 05:02:27 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umma5-00000001SaY-16Ek
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:02:22 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-24458298aedso15837535ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234140; x=1755838940; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvJ9vjlQgWj0JGVdSmCK4V4OH1FNmLUxKe8JArbwI44=;
        b=P7IlYojnGGC8yVChPOTUEimy9262Wp9vbhOvwlCnfih0BVzCXf3uf+rrQ8IJNdoIKZ
         73wMX/9Gl6M74XpHtlcm5Hr/HfnZJhnidmtWCsjCfFv/6uFvVrYcehOShrN+5Z5Hr27J
         hI3qjMrVrg/nw6gx25qklDrP7X54/+/h00uSwXJ9nVuRF0q/UUtTXSNBAKygdHDFeTqS
         ySUJYwLpykR1tYn22+rwRumw5t5p37I8OC8uvR0ntWgsxdKYE26T3zWR0FYW83xYg2KA
         LvQ85HB06BpK9Gu9q8BIbldcBhTEXvW7sWltD0u5EmjCR6TvGHHisarPlwg7WYQ/OaUw
         693g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234140; x=1755838940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvJ9vjlQgWj0JGVdSmCK4V4OH1FNmLUxKe8JArbwI44=;
        b=DDsxnbaNYfmtJygEk8fV6kkVxgvXpiZkkWuVbm1YdSxFSFKSuMdAa4kX1KvQSbd7eK
         KCrE++1gPivvRtPn4GNPD4umnj8Cy1EUGucMg1VRm6Y/h7jnkWSqQ8A7YkFuxIoJwXjX
         XfUl8W9sGyPdNv9FhV9SAzwHWpi0Yc6iWv2ivKJ0WIjOUmTHdh6GQkKbb7ZuGOPMQtWQ
         dTfbvOsZ9KIviV/Sh4jun7dNv2fwAQUYy4RKP5aEBW0NIX1er0cWomjgYg80ZNF536xf
         0slqvvo5UtQ3zolzQsa4avZ4/IYB4QEo8QRZaN14crjxdxBu0F8FXJQtLbQe6XtBK1ir
         0NlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaYeGuRfDVp6oqCV42WgF5G+D4x/0GAjD+7c2alaYx3DJYBslxJAfVu1zwZZQ89eLkn94JAJCjJSv8@lists.infradead.org
X-Gm-Message-State: AOJu0YyrGgFvyVqmxCg7MwgDkWQiqqXqSPYR+a8HEvKAGdP39paEolv+
	3PNoLGSI51kkC7GTzygMdskqjfy1G6L9++apeHfTWQ0faWtJ5SUMkmpvfGSUkw==
X-Gm-Gg: ASbGnctPg5Pb9g/55XoqgLVrk1oHU5MRCLkw/3+vdu7FDu/Iy9HkvB0nL9KvQyx/e0a
	ue3QS1nH6k0HX7G6Nhe1qYc8t8tCEe/tPiWSF8l2oXiwvDvejvrIwl67a25uxX8Ay4rJd9tzPY/
	ioJfThzYbtonJtaARQKVsxwqhVAInT+Beg4asrN0ChG2gsvwlaNj0bugu02xlBcrzHLwjtBbGN0
	yKHTPwziHFFychhJmzljiVHz4XutW6Y8dyE1zcq4wr67gWGeFmV4+KOywIDeSJAP++FB7vIRyOY
	AsK1PBQX9ZJOF1EApZBrRUDRmlywRIzyQ+xSR2/GKWetrWyowKK2gUyrRopzbkmIbVNUCF1NKxj
	dVliQ9c3ZqK4s2Vqom4ORqxWElUhrrcUEiplL9u8vzAs09VrGxWLo6vznCsfs23gkuBDps/lDu0
	YL9Qg8o5M3en3Y1O+thhyOeGF2IBr0sAo6clvwiA==
X-Google-Smtp-Source: AGHT+IFc/j6gSSFssjIPr1g+lc0GaAJwz273eKQ4JRPcXd+8ZTYMotiRajoz1cIteit3jJWFjwumvg==
X-Received: by 2002:a17:903:41c3:b0:242:e0f1:f4bf with SMTP id d9443c01a7336-2446d720275mr11691175ad.18.1755234139897;
        Thu, 14 Aug 2025 22:02:19 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:19 -0700 (PDT)
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
Subject: [PATCH 0/8] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri, 15 Aug 2025 15:02:02 +1000
Message-ID: <20250815050210.1518439-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220221_306379_DB7B41AC 
X-CRM114-Status: GOOD (  12.84  )
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

Alistair Francis (8):
  net/handshake: Store the key serial number on completion
  net/handshake: Make handshake_req_cancel public
  net/handshake: Expose handshake_sk_destruct_req publically
  tls: Allow callers to clear errors
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  net/handshake: Support decoding the HandshakeType
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml | 19 +++++-
 Documentation/networking/tls-handshake.rst |  4 +-
 drivers/nvme/host/tcp.c                    | 78 ++++++++++++++++++++--
 drivers/nvme/target/tcp.c                  | 71 ++++++++++++++++++--
 include/net/handshake.h                    | 18 ++++-
 include/net/tls.h                          |  6 ++
 include/net/tls_prot.h                     | 17 +++++
 include/uapi/linux/handshake.h             | 14 ++++
 net/handshake/alert.c                      | 26 ++++++++
 net/handshake/genl.c                       |  5 +-
 net/handshake/handshake-test.c             |  1 +
 net/handshake/handshake.h                  |  1 -
 net/handshake/request.c                    | 17 +++++
 net/handshake/tlshd.c                      | 46 +++++++++++--
 net/sunrpc/svcsock.c                       |  3 +-
 net/sunrpc/xprtsock.c                      |  3 +-
 16 files changed, 300 insertions(+), 29 deletions(-)

-- 
2.50.1


