Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB24C5CFEB
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Iav4WTWDleih3gHxTno0V0co2oSjUMUnY8kA1aXPeZI=; b=HFunyM4Q3imq2+
	ksRZHRE2Mmf8/x91h2sdb6FFu3N5XxFKIvEVJgYKTboVWWDsuk1h22f57/oYgm8m+4IxBDFivlbP0
	vdJB5RTAlJY6NbCtfHuFZCA7uKP4ky1GevFSRwO5tedrhKlBO7JTajKr3CPg3wA5QrIutnsrILxJ4
	R3+mlUwIjUhE6DZ+W8dfEH6UpiKsDJKbJiJ9ZYGm18UA+mWxR0AmtmkLcpJ13uzW+TP+ybQ/dVyhF
	ncXtdP/zCwCHKlKm4Q3g/cSS2TQOeqXw3fPFkOaHBk4uuFz1/4WoMAeckKIa/KG219U3TuipvNUgr
	d7xU3VRri7pzO3YC3gSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWvY-00000000tBf-1r9w;
	Thu, 13 Aug 2026 15:01:04 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqf1-0000000EhKT-0bpN;
	Tue, 11 Aug 2026 17:53:16 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 233321300113;
	Tue, 11 Aug 2026 13:53:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 13:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1786470783; x=1786477983; bh=Ia
	v4WTWDleih3gHxTno0V0co2oSjUMUnY8kA1aXPeZI=; b=plN4WIN66oKr+N0kUk
	2oYGfm6IG+USP95UKZYKre4gL5vw96GnRsSeUVN67WcCSYWDYPhrpU0e7L5bD9qy
	gA4wsm1+/qeXdLcoy2f3wLDJr4QX97KKqXx7HOA90wcYc9uhZaGyCKG53vtLHxGg
	kcY9lF0mCh3p2ciUTeu+xegL7hm7ET9i/htAAEItFMJthcHbnggW5IUnFj2AXz3R
	2ppcq8XOjyG6ZeJWIIGx46RYRWdatEHATvRd3bFHqMOPA0Kn1joq0rEDv3/P+yyC
	WRdThmI3j44B8oerB45LzGrMlXt9IeJtbTlUneIHdQ4IsQBIBxZ3XolH5h7JDWi6
	WymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786470783; x=1786477983; bh=Iav4WTWDleih3gHxTno0V0co2oSj
	UMUnY8kA1aXPeZI=; b=gkmc9E1YuJGNvus/zaOK1QanaU3Yfw0ZBUPzzAdMfG8D
	SIAb6FrtNfWhNz1Z1xo4IF+i6tMvALyAkK99KOvDpcm/VGM/nhuUezjGsMC/vkjc
	8+GT+qVdLS+z7MCpGUX/tTrCidoFvJqDUxWx9s3TOtvOP15/HaJYaCn78ChLvgXT
	pEYVM0WqXQqlY2BtlmFhIJWUX746GdCIHdqc30fVuMmtOszwxaP+4wXF1aDv8KQh
	yLzce39LNDdjm4UXPB1OPWzqF2ydq4NmKu09kQzO59/rq3D+FNh6isCSKrg7yxCN
	urytTLXzk33+N7tgAieIX/Hg3ZBi7g7rs7xD+F5Ygg==
X-ME-Sender: <xms:fWF7andINlwQPOaCI-XUVarJ6Q7DMNpS0V_mgD2MyV3bQkaIaPUmLA>
    <xme:fWF7amDTRlhBHnq2w7JfOKHD2O1DZEMAtqss_c3v8WyfuENDg4Igabqn-JK5iT8d-
    Ol1vd7oCVVTcMg_uPkezsMTiG8HYmROGgE03r7dmHnjDUfNcDrF>
X-ME-Received: <xmr:fWF7anEtt-QxHNfZhlUt1zUdr1-qcuuLprACW83lq8JdERZnlK-J_HVH7CP3rwVluKgQfhWtSHJ8FodTsKLmszs>
X-ME-Proxy-Cause: dmFkZTE73aHpthgNDQ7JAN/bX2pVOvcoXVlWiDobTGq+5a5b5odiVdF/tSDtAx7lftbkw2
    G1AApVxOdPA+fYXSUMWnbeGK5Z2Bmw/3dLdFRwUiwcwXOE4rDlv0+ipGkdzZd923IWFSA9
    n28Zs9HqHQErokcmBYG/uCcQkH2/AZM7ymYb+9KKAG+yUDdABGSz2SC9YRCJK2duI8zfwp
    nhdxztlKonApDZ1bt/2wVZALEOU9flq1JhqhoQBSlZWFlpj1lRewkSGngNGK2cjj4axDEZ
    RzbQBBjJdOFzRH2klLXcWdQhkl4X1P1G8PLlK+oGPyYzc+a/+rbdUmRqC5vAZs/qOJqhRc
    fLeLLaGWcwGYbAq2UL1Wq35AiyPEYxSPXchJJImhUb/5Mg60xfu+dfZ9wSeaOGbt2dI2JI
    SVAeym+x33NQQ5B2p89V6rpMCuk0GE8SM6y3F9dGgEnZ0qWphwXxBpUIOme4NHQRNZUyM7
    1fUCA+iYIfpVOu2arbNioWF/cJ3Mj74RP3OPqc9m57O/836m9e8lEL0Vsulna9Y8jFKLBo
    OB+jZOvUk9acBiSay8z3aKzin1FfdOTwt7y8OMyJyD8MFFsXDsfBuHI6TI/QtW1IaP/keA
    pzLQb1l/CvkfUBlvwiXROgMXtav6YqYwZeHude0LqZG8WweDasIPZmffShxg
X-ME-Proxy: <xmx:fWF7amV0AcfL_-DyhkUh9TkSBq37JiNfL0jFIn69f2yZcwV98H-obA>
    <xmx:fWF7atY3sI95yVsC9BNWWqQbF6L9GI5un2IIavkwRnX7q32oalvarA>
    <xmx:fWF7agDQ-x48MABx5S-_n-0KJx4-Kt3SWJo0zoGgK1rwIEODyGWI0A>
    <xmx:fWF7aiEnv80wTiZUwjv7HHMUFrX8dTlVuHn5oEP2A6qYC4M7YLUJtw>
    <xmx:f2F7agKFrdaSXvJHWFcZ_AeCUyTDVQwVdIhKDmzmIDQA1PI5a9OUhyrc>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:52:54 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Subject: [PATCH v2 00/13] CRASH_WIPE_SECRETS: Wipe secrets before kdump
 (was: CRASH_ZEROIZE)
Date: Tue, 11 Aug 2026 19:52:49 +0200
Message-Id: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw6CQBAFr2Jm7RB6CAy48h6GxQAtNBrGdAMih
 LvLZ1lJvXqLEmRCUbfLohhHEvLdBuZ6UWXjuho1VRsrE5okTAF0yU4aPSN7mlEzfj2/dFGAi6s
 MbGyt2qYfxidNR/aRnyxD0WLZ763daEh6z7/jd4TdOy9sBJAYG2UBxGlkQg36Td0w3VsnWAcVq
 nxd1z95g2YptwAAAA==
X-Change-ID: 20260811-crash-zeroize-rework-bb1a5d917577
To: Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
  Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>, Lukas Wunner <lukas@wunner.de>,
  Ignat Korchagin <ignat@linux.win>,
 Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Keith Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,  Sagi Grimberg <sagi@grimberg.me>,
 Trond Myklebust <trondmy@kernel.org>,  Anna Schumaker <anna@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  Marc Dionne <marc.dionne@auristor.com>,
 Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>,  "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
  Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
  Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-afs@lists.infradead.org, 
 netdev@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_105311_954376_634F8EC6 
X-CRM114-Status: GOOD (  26.70  )
X-Mailman-Approved-At: Thu, 13 Aug 2026 08:01:01 -0700
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

I'm using linux on an embedded target in a Hardware Security Module-like
application. One requirement is that I want the system to be able to
quickly erase its memory when it detects physical tampering. I'm
approaching that by using kdump to load into a small payload that
instead of dumping RAM, erases RAM from start to end. However, writing
all of RAM, especially on an embedded target, is rather slow. For this
reason, I propose the mechanism in this patch series:

Add CONFIG_CRASH_ZEROIZE (default off), which when enabled makes various
subsystems handling secret data do a quick, targeted wipe of these
secrets before kdump. This behavior might also be interesting in cases
where you run a normal kdump kernel but you still want to keep things
like fde crypto keys out of these dumps.

CONFIG_CRASH_ZEROIZE is a best effort, defense in depth solution. There
are circumstances, such as when a panic is triggered after memory
corruption, or when a panic interrupts some operation that mutates data
structures under locks, when the kernel cannot safely wipe some memory
areas. The handlers proposed in this series will just print a warning
and skip the affected areas in this case.

This series introduces handlers for the major locations I found where
having this sort of thing makes sense. Notable omissions right now are
the Ceph and CIFS subsystems. I have WIP patches for these, but since I
can't easily test them right now, I omitted them from this patch set for
now. Currently included locations are:

* various key types in security/keys
* rxrpc
* fscrypt
* dm-crypt
* crypto tfm instances
* secretmem (which I'm going to start using in my application)

I've verified this patch series on an ARM64 target using the helper code
at https://codeberg.org/yasec/crash-wipe-test . This code stuffs the
affected kernel subsystems with keys and secret data, then crashes the
system, takes a RAM dump and verifies the dump is clean of secrets. Note
that the helper code is partially LLM-generated, so read with care. It
passes a positive control test with the config option disabled.

The patch series applies on top of linux-next but should work on 7.0.0,
too. I've tested the patches on a Arduino uno Q (Qualcomm QRB2210,
ARM64) embedded target.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
Changes in v2:
- New keyring key types
- New handlers: rxrpc, fscrypt, dm-crypt and crypto tfm
- Renamed from "zeroize" to "wipe"
- Add ARM64-specific cache flush logic
- Link to v1: https://patch.msgid.link/20260731162739.158320-1-linux@jaseg.de

To: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
To: Dave Young <ruirui.yang@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
To: Lukas Wunner <lukas@wunner.de>
To: Ignat Korchagin <ignat@linux.win>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
To: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
To: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Marc Dionne <marc.dionne@auristor.com>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Alasdair Kergon <agk@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: keyrings@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-afs@lists.infradead.org
Cc: netdev@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: dm-devel@lists.linux.dev

---
Jan Sebastian Götte (13):
      kexec: add CRASH_WIPE_SECRETS to wipe secrets before kdump
      crash-core: Flush caches on CRASH_WIPE_SECRETS
      arm64/mm: add set_direct_map_default_nosplit()
      mm/secretmem: wipe secret pages before kdump
      security/keys: wipe key payloads before kdump
      security/keys: implement wipe op for user-type keys
      security/keys: implement wipe op for big_key
      security/keys: implement wipe op for trusted and encrypted keys
      security/keys: implement wipe op for asymmetric keys
      rxrpc: implement wipe op for rxrpc keys
      fscrypt: wipe master keys before kdump
      crypto: api - wipe tfm contexts before kdump
      dm crypt: wipe key material before kdump

 Documentation/security/keys/core.rst      |  13 +++
 arch/arm64/include/asm/set_memory.h       |   2 +
 arch/arm64/kernel/machine_kexec.c         |  20 ++++
 arch/arm64/mm/pageattr.c                  |  21 +++++
 crypto/api.c                              |  78 +++++++++++++--
 crypto/asymmetric_keys/asymmetric_type.c  |  11 +++
 crypto/asymmetric_keys/pkcs7_key_type.c   |   1 +
 crypto/asymmetric_keys/public_key.c       |  15 +++
 drivers/md/dm-crypt.c                     | 151 ++++++++++++++++++++++++++----
 drivers/nvme/common/keyring.c             |   1 +
 fs/crypto/block.c                         |  10 ++
 fs/crypto/fscrypt_private.h               |  15 +++
 fs/crypto/keyring.c                       |  68 +++++++++++++-
 fs/crypto/keysetup_v1.c                   |  15 +++
 fs/nfs/nfs4idmap.c                        |   2 +
 fs/super.c                                |  29 ++++++
 include/keys/asymmetric-subtype.h         |   5 +
 include/keys/user-type.h                  |   1 +
 include/linux/crash_core.h                |  37 ++++++++
 include/linux/crypto.h                    |  11 +++
 include/linux/fs.h                        |   4 +
 include/linux/key-type.h                  |   9 ++
 include/linux/set_memory.h                |  17 +++-
 kernel/Kconfig.kexec                      |  16 ++++
 kernel/crash_core.c                       |  52 ++++++++++
 mm/secretmem.c                            |  53 +++++++++++
 net/rxrpc/ar-internal.h                   |   5 +
 net/rxrpc/key.c                           |  34 +++++++
 net/rxrpc/rxgk.c                          |  11 +++
 net/rxrpc/rxkad.c                         |  14 +++
 net/rxrpc/server_key.c                    |  11 +++
 security/keys/big_key.c                   |  17 ++++
 security/keys/encrypted-keys/encrypted.c  |  13 +++
 security/keys/key.c                       |  43 +++++++++
 security/keys/trusted-keys/trusted_core.c |  15 +++
 security/keys/user_defined.c              |  15 +++
 36 files changed, 808 insertions(+), 27 deletions(-)
---
base-commit: a0dbb7d3457bdebe2dbe198bd08bf9690be5f1ec
change-id: 20260811-crash-zeroize-rework-bb1a5d917577

Best regards,
--  
Jan Sebastian Götte <linux@jaseg.de>


