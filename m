Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6BBCAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6iRWbJphARTg9SH+UGYwTi095jj0E6vFAKoyN/er2gY=; b=OdycJteglC62vTjstMrfgFYE4J
	HkW4rJMk5S7GtME9S/JVkD26LMrfpYU/RNcZ6ujHaJeOncLrL1Bk2/F/DXBdZ8u+H8c4TR1mpADmd
	G51qrRNz8qIC0c18EAxz/cvyrB3m/MB7zIBe/C5G1z9XPEwdVCsFPnFh5/rWtxRR091Qhm7IyMsIT
	ZJOmEPPDkQ/KR3ku61bNeYRLx+szsUluHdGTfmVLpJICdq4/+gjeRticlVq6ca+O+SREb6AXt5Lv7
	PvlNLQx/+HuEFSWgVGrHz5Fncz5O3pBqXOWR0IxzCgflQUWmJfbWetInef+WwcY5gNq8H0jVXuhqP
	lywFinSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XSo-0000000Bdm5-0mez;
	Fri, 03 Oct 2025 04:32:14 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XSh-0000000Bdlk-0CDH
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:08 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-336b9473529so2404976a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465926; x=1760070726; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRWbJphARTg9SH+UGYwTi095jj0E6vFAKoyN/er2gY=;
        b=k7tdzrl55ztA0W3ptTUjB2uM2LOiOVs++c8yGvpOUAIsnBZ2O+bzZLKTay0L7QAO/U
         XjmCbNkXm/fliortKiXp5ny+uqUHCZ1uX0onf1Mq1yz3+sTQPcYw8hnS64noGL6sdXLR
         CdVsQDgUhW5cwBtO2MXadbzlrglgnO1SzfjXry9i0Ln4IP56rTEYAvvbIlJ/PCsjsM6P
         iZu9MqM0twegT40QSugSyVIcWqgEVq96f2ZBHgRzErXw+6O3o9u5gRnuzhZD57sDSZ9a
         T4wFSiRqPRvXTC6aQf63JamgyYRHKg8IA82MJqoxrb3X875frWFd1SBGSdD1016tnp9W
         gj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465926; x=1760070726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iRWbJphARTg9SH+UGYwTi095jj0E6vFAKoyN/er2gY=;
        b=SbxO0cE5qumDkndnqrzxON0hXRDman3AmfGTLUKc2BjDVHZcXwQM3JFqO+sMeRtdRC
         BwLvBHMjiAQYzJfnJt8hvv9FrTldcuinAo+8viNFJlLnJpDr60eC8Q3Nmo9vwV+DKNnZ
         eyYF0sRv6n/z0+d+O7rwrE1jAGeja/WQiuqpdYoOPBhOGWjcSWqzw+P0zMPveOC/V0LE
         uvTYTgO6qUTQmB7Q88emUiKGKhU57/TFJL0wAR9Ss9JLrwEzn5oU9U7gfdSb5JM6Rt0I
         iTTGnIIkP34oKD+L9D28LYpFPEK3Cg191gxV4nY1MGM0lBosLdv0WARBpLEvqmhO7LNI
         PJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJYi1rBUYAWPw4SefJR5RNNoa46+e3hnvdPGBxPnSpbTXMn96pDoU8qVxohwVwIH1T2EzKLyNjLhMg@lists.infradead.org
X-Gm-Message-State: AOJu0YzrlroZoCTv6iT7ETU8vRR0Vb46KigvTTz5KZs4vry1Wdrcr/Iw
	ROwC6DRYA/xLvIbzSq+LwbnAA1wn2PUDvI1eSQQSBss3IlF+86SJ+J4x
X-Gm-Gg: ASbGncuKxGhq2N1IWSFLmtW/yS8fd+ds3hNMdsPfUqa9HEObkp8CetWuDLX5qInGKOo
	Zw7X+41I0R1+cTCeNq2Qvbxl+Dzz4CMlb1xEYxhJ0oseAlQ/+JZyy8fMtAwheLNMS4M6PH5QAt/
	6TbaNulAndGAKUd1T/o4IHZPF/6M03ZEv0r/7j5TejF7gemAV2Knchf0pvhkKEnwBOPiMO2sw7A
	5ClJuc1ziqemx6dCquIqWif45n6XhKU9wjAHUZUiore5VnNn1wncpamuJlENKRYSKRqzpB8R5dl
	ADxpKWuOB8+nw+7NzSUXylbchRpptrG71bsJHIdJZ1CT2pNEgPX2Tm1lhQ58lqKZyh5GP+lWRIn
	utxCXtNqjl5yCyVyhivNnw4eGyeqCs5KvtZ3LD1bobDWvhTxWwgOmD5hd2yW3Jr0xfiQzwbELUq
	Mq9R2xQdJvY0HjUg38ZAWfu+Y0YAQzhyQMgDbduvrVl26TZ5S+m854
X-Google-Smtp-Source: AGHT+IHzxGQNHei00u1+ginjgv2orHJOxfjQE4QOoj8gcgp7Hp+3jzZDnna3Wuw+xDdTBAA6cpxSvw==
X-Received: by 2002:a17:90b:394d:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-339b5092b52mr7933152a91.7.1759465925666;
        Thu, 02 Oct 2025 21:32:05 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:05 -0700 (PDT)
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
Subject: [PATCH v3 0/8] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri,  3 Oct 2025 14:31:31 +1000
Message-ID: <20251003043140.1341958-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213207_095921_D732E0BB 
X-CRM114-Status: GOOD (  15.28  )
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

Alistair Francis (8):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  nvmet: Expose nvmet_stop_keep_alive_timer publically
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate
  nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs

 Documentation/netlink/specs/handshake.yaml |  20 ++-
 Documentation/networking/tls-handshake.rst |   6 +-
 drivers/nvme/host/tcp.c                    | 147 +++++++++++++++++++--
 drivers/nvme/target/core.c                 |   1 +
 drivers/nvme/target/tcp.c                  | 104 +++++++++++++--
 include/net/handshake.h                    |  14 +-
 include/uapi/linux/handshake.h             |  14 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 +++
 net/handshake/tlshd.c                      |  47 ++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 349 insertions(+), 35 deletions(-)

-- 
2.51.0


