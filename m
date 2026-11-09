Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8960A381B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OybGr0tV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIJdbOp3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=61mQGdGCCPWlzC4QLyl5ytHWy0dP+cOspyXrcAUNIqY=; b=OybGr0tV6oUIiB8M4HzyAoH9+y
	W7R2eSmyYUMy8LyIs94C41qtBzqlmoD/AT36Sf5mLobHYpuNwYluMaxavgaQ3OP+RPQc6VQ+leBJN
	s7iTwgNeHzdph53K7xoigrehQrmcYRU5+gKNe1cnSMq5w/vJQeXPXT22kNL0sqgyOt0ip+DlMsZO9
	gqpE0n14ikZd+pgLt1LReqlbExrsQUK7vh+EsDt7z6t3T30FL7VH/8IFciTwMKu82l1063A55tem8
	mhyo7nVqxH4Ae719q5hR2QrS0ONzJ+b5U/RLhPohgy5ARuCz9AyeF69BHI3yGkwgRxiFFBDPh2Dgr
	FSVhTsyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUft-00000001Vte-1W0K;
	Mon, 09 Nov 2026 19:05:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUfr-00000001VtG-20Xs
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:04:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E5315408DE;
	Mon,  9 Nov 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251098;
	b=WDCUT2oQ//p/IZlV1v6j3pBdRivNvn9HZVcAcKdyEE6a9io9DLqRdFTcb8DAPAK6HWhb
	 uP4ae+WWDIEOFMwyjto55R378GgKVtjHxlUCI+nBCXLoJq5A+Ht2ZepJbw2tKD/NFoP4N
	 fmDBjefNuaQ+MNjFus7IDIV3fXoYol56+RFIvKfneSxzNA7TJynLFENqq5li0X4R5Ws5k
	 fASyviN7Y79xnbEYx5tgMGt9BSusKMXk6OpOUSrwtrG6oeHLbDnde5xFsWr3Is+yxQs4N
	 6glnoPJGmO97RhH1/J0OZ/tK3CH+ul1YIJoKiRNzn4s7hYpPWJNpQmzfvegL4Mna1qA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251098;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=61mQGdGCCPWlzC4QLyl5ytHWy0dP+cOspyXrcAUNIqY=;
	b=ObZ+LpyxOKnonFNS/nQ+W0jF11R6ofTQMdU+Pm0C0tAoyyCUn7S2QaIMEARAw7MCRaab
	 dAvZYGt2CWuz79i8aTvFzy/Dd4igjdC74h7S9HRIQ572/ktZ9FeMwuIiHWPfxk19FTcbT
	 HqXCZ7vVr8X4luJMlfQbAO6sLpreRwMsciwHL9sUUz0TuEHF6YcnxHrVUywgqoPzyy6k7
	 35BI/blweUCk5g4daeTuptuM1a5Xq8CeOKFfMQervUhq8ek3fx5E/UrOZfH5BbKxqIBDS
	 25cMs6shpbKt4bzCRTRqwW1C6E0RZJLjvBXt75mDz+HAkJ1YrX/Ih2E535B5tn1mf1w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 550621F0089F;
	Mon,  9 Nov 2026 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251098;
	bh=61mQGdGCCPWlzC4QLyl5ytHWy0dP+cOspyXrcAUNIqY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=JIJdbOp3Ppmhy3bbqyuNHfIMmn3MbTLXoV28gASAd5rlUybojQOKTRMiULymSTHY5
	 2hzCQsM8f+gghixxbTKGCMAmM80NxbCN484ciRDcM0JH9Gr59DckKAp4QiSJ3GMbm6
	 2Mu7MVQFtzO/MhHL7Gl40wbNZyow29mBfKF2qLA8ILxAgRmzosKItgMMIyDO9x9Tgx
	 GAr7YvfrcjfVMAHQNXZI7l3BdLWFK9BL8nT1A8Repq/NK31ypBNBticlRQ4iII/oDD
	 M2ClAb3a5EtXUnc20FHz+4XyHX+ub9It2bBGfmPEtoW4K3uUj77CQlth2hqOLGuAZW
	 7PDJ4g71J60vA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D8706485DF;
	Mon,  9 Nov 2026 19:04:57 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: [PATCH 0/2] nvme-tcp: consume TLS records without application data
 on a live queue
Date: Mon, 09 Nov 2026 14:04:52 -0500
Message-Id: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQNCrEq4iLdvzVkRrLJAah9
 O5GXX6L9xbKMEWmQ7eQoWrWZ2rwm47kNqQrWM/N1Lt+772LnOoDXGTmSStYik0G4e0uxDGG6IL
 z1NrZcNH373s8/Z1f4x1SvjNa1w8p+XbweQAAAA==
X-Change-ID: 20261109-nvme-tcp-live-ctrlrec-4539b9390301
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251097; l=2856;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=+RFQb7lReLCFe1adR320Vhaj1EAjoE628nMe1pJcegU=;
 b=KE7Dj2rsVobi2ZeWZ0BYkyr1AKi+lTSCDHAksQUcSkmM9Ui3OB1kf4+GUlaiORDKlQWhcd/1X
 EY3H4rS5EeFC3sNueTdsMS7uXdLOQNmkRvMcTTz3E+0Il3+uC+stlZl
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After the TLS handshake, a peer may send records that carry no
application data: a NewSessionTicket, a KeyUpdate or an alert.
tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
It returns -EINVAL and leaves the record at the head of the receive
queue. Since commit 288cfa187208 ("nvme-tcp: start error recovery when
read_sock fails"), nvme-tcp then starts error recovery, and the
controller reconnects.

TLS 1.3 allows a server to send a NewSessionTicket at any time after
the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
time.

Patch 1 moves the TLS record read loop into a helper. No functional
change.

Patch 2 reads the record with recvmsg() when read_sock() returns
-EINVAL, and handles it by type. Handshake messages other than
KeyUpdate are discarded and alerts are logged. A fatal alert, a
KeyUpdate or another record type fails the queue.

This is the follow-up announced in the cover letter of "nvme-tcp:
handle TLS control records at connect and on receive errors":
https://patch.msgid.link/20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com

Both patches are tagged for stable, because 288cfa187208 is being
backported to 6.12, 6.18 and 7.3.

Tool use
========

I developed this series with the help of an LLM coding assistant. It
drafted code, tests and changelogs, and helped with analysis of the
kTLS and sunrpc sources. I reviewed, edited and tested all of it, and
I am responsible for the content.

Testing
=======

Host and target in one VM (virtme-ng), on 7.4-rc2. A test-only change
to net/tls makes the target send records on a live I/O queue during
I/O. Each case writes data and reads it back with O_DIRECT.

  Records sent by the target   7.4-rc2     With this series
  ---------------------------  ----------  --------------------------
  NewSessionTicket, 64 bytes   reconnect   queue stays live
  2 x 300, 2 x 1000, 6 x 64    reconnect   queue stays live
  close_notify alert           reconnect   queue stays live
  warning alert (90)           reconnect   queue stays live, logged
  fatal alert (40)             reconnect   reconnect, logged
  KeyUpdate                    reconnect   reconnect, logged

Data was correct in all cases. Also built with W=1, with and without
CONFIG_NVME_TCP_TLS.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Martin Belanger (2):
      nvme-tcp: move the TLS record read loop into a helper
      nvme-tcp: consume TLS records without application data

 drivers/nvme/host/tcp.c | 146 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 124 insertions(+), 22 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261109-nvme-tcp-live-ctrlrec-4539b9390301

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>



