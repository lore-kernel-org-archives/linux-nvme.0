Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E61D116F1
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 01:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cOcMvyPGMcTIjq6QNdUg0HCwNMNqed1s4YiNfKDSxyU=; b=PYfw5hUJbnaVBJzzPAKm+xecGx
	oxO6iANxNT/R0fCDx1hBupbyu4FXT+LKgDvoNWyB0YXffd2WhsoHogVONW4pDkJrmiZnzOxN5o0h0
	Ji9YYUmASRuXRmz1rXqnwHaQqFtm26NKo8qa4lAEzceZA3vGMm8eqX8wy0b8Brsse+wa7tQcxhZgG
	P27n6ldusPtoO/O/KjgiE2DWU5sp+vRX3MOfm2bhYj4EKT9qTCNIRkjMme0ciruPsn+SBKA2Ap3Mn
	jN+M2RRRfjce5CIWKM2GqAtHIjkUHFISUcgOHuKQHKMaaw0UOdantm4a+tMXdO7yXoErWq0H/8yib
	xw2sWFsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFIK-00000004gDk-3X65;
	Tue, 02 Dec 2025 01:35:08 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFII-00000004gDO-1GH5
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 01:35:07 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2980d9b7df5so58216055ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 17:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639305; x=1765244105; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOcMvyPGMcTIjq6QNdUg0HCwNMNqed1s4YiNfKDSxyU=;
        b=QvfdMQQH/UePbprRllrhmZs2XZrmkHMFD3DkWU/6ww10PwYZyT9d7MbZFgDyiNL5k+
         8F+m5rjk0FV5iP+9qJqL5N2zQL+7tZIRzo55R2kNpbBo4uDjYbxDFJWQcITrGpZlhEFp
         rWc9zxJvviDrmYsDMHrJ2773Oa2PFc490VxYPJ6nUga+wtKm+27qeJCAUxxueBIQ9s5n
         cGJTCpZzIJYiH7IU9IyT0nZvqdCD3Im2lSxtF22VRHr7zkbAp3RzoqZhqqYxi2ihmVaf
         G8LXEV8H8mwgc8gLlSFESAgAYOdqKk9yus0z7bvX1v/VCnyxw+0nss2kYB2K9F6c+GV7
         J8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639305; x=1765244105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOcMvyPGMcTIjq6QNdUg0HCwNMNqed1s4YiNfKDSxyU=;
        b=uamIEX7ODFXnGaRZRekpf/hDBylR0t4ICmkNYydG0djpwjigAinA+pYZr+Nzo2F4Da
         2KXA7L4HkSMJPfE15qRUbMplZBiEDhbeUAoLxgaeTvq8OWOou4EIlG59avi1rlGEgYeg
         fTYZ7hMptPcGfDgxRC4xE/o6i4Oxs09m9eHJYcImCPhigWGsqoX8CnCqSKRkhz2HqPl2
         Kp7LvzlUXx2MwryJkirZJwWyr4wBALt9kBczDgC0BMXXZwbdlIKqgln5iawdKzTeaMEZ
         04V3/eWOMP/aYexBhLofE5lUZEWfQ8yvPKzeVZBdOfeBBfsvQ2W1OCseKujUyhlK6225
         CSOA==
X-Forwarded-Encrypted: i=1; AJvYcCVN9FFeqbJ8B3aJvEcmKKSM7PsqXARAfMdYaszXzZ6lUGHZBfjNJuUI1sgaehopoQZszI8NW6xzJwoV@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6OTG8/SUzjuldcn1NyMmHlgqwwCJceA9d5atIE2QPmVzHNAVZ
	fivSMI/Jp+Q4zdSDrDP6k1oXQiWdeiPERkt4isE6u9ydlmla95UHeY98+DFHMA==
X-Gm-Gg: ASbGnctPcLmaqTTEFgkA649fIKoID+gm03j+pIEUpWaZclB0ztCvVzEREhZraM9Vl8u
	J3g2esEvoUeNCmxOaNS2orBjFLW2IKUU8MgU38nEUIAJhrDTzpvBah6LZ1GW/5//1c/UUNKgVM1
	vj9cxwHbEjkKsW1X6Fvg5KpANf2QvKOn12YMEP8FKazMu8l7Bc7kAxzo3Hxlh6y0RgVtEZkAP2s
	N1+FYJ4JyRh/Dvz9I4ZDVYtIUenOZR0VOIXZQqvGa353ItnHqg6PiMyGNrXrBwqcqHeY2i4nz/3
	u/joXrKvyuvDGt4VTyJ1FoivPC5jkcsU9KaWo6Q9ETc1mrLrorz5j7uGIuZN1qJIuOduOxXYsUl
	1qeV7iO6BCt+JMQAF2peNanpG2GHdm0CwUAP1YMJ9+oz75bd4VmF65QVocNZmoTgShpB0eONXS+
	0crKTK2Z4xDBgmgdxfPmNFcrEvNoiK5BrB2IyVco5YrSX8c8S13PHdHohkfz/gKiR/N1ZFc6rDs
	hcttly+tOwDCVwzxAU=
X-Google-Smtp-Source: AGHT+IG2js8otbv+uQSAe0fNFhmo5Bp5ciBaRf9d70pDhultX+GW+649FyeVTJlTc0iOHCrbLvVJdQ==
X-Received: by 2002:a17:903:19c6:b0:271:479d:3de2 with SMTP id d9443c01a7336-29b6beac7fbmr426147885ad.13.1764639305257;
        Mon, 01 Dec 2025 17:35:05 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:04 -0800 (PST)
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
Subject: [PATCH v6 0/5] nvme-tcp: Support receiving KeyUpdate requests
Date: Tue,  2 Dec 2025 11:34:24 +1000
Message-ID: <20251202013429.1199659-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_173506_348949_20A0000C 
X-CRM114-Status: GOOD (  18.97  )
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

Alistair Francis (5):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_req_keyupdate
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    | 111 ++++++++---
 drivers/nvme/target/tcp.c                  | 213 ++++++++++++++-------
 include/net/handshake.h                    |  11 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   2 +
 net/handshake/request.c                    |  95 +++++++++
 net/handshake/tlshd.c                      |  97 +++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 480 insertions(+), 95 deletions(-)

-- 
2.51.1


