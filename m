Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D1BC5516D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JL0FoHol+YpZow26X8VmCVV3SyRMBT48Kw3ZdoulJ9E=; b=VftEyRQz2xXtR1TacdfGF/uDKN
	qdIB96PeIGFNLmFS8P5qVqeHc3MUVKlBq98s0E4kOChfN6k6Cdtt+mMRsepLIDpgJoP+x/PLozgQh
	ivapjHDDh7f1SmBjZRaVZlXCdCkqLrw2rec7WQyMzeVtL5lI4yaI9syPndDZ/OophfPn5isw1wI87
	upgaSlWzeDzzl4nvhopbTQuUvKFb7EA/1Spd9Q3l8Ec14SQ5Lb8Q15ba8ijtMS9b3wyXNor47zpDC
	iLbEPrQRkpKC6ERnKDZADO4HmJGxoHS/l0T9tRTkOU5z5Ik4CUHl39c5VXABH5vJk65GVS4S3KuN+
	IWsf1rTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoH6-0000000CiUA-25zz;
	Fri, 31 Jul 2026 14:31:48 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoH3-0000000CiTe-0ixG
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 14:31:47 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2caced6038eso9529185ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785508304; x=1786113104; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JL0FoHol+YpZow26X8VmCVV3SyRMBT48Kw3ZdoulJ9E=;
        b=qr+Ymc4s/QqW7T/ESbCP7IbEFO3FO4IV0DP0Cwzj1kEqu5nhxB4zOTJ+hBhJ8xJ+vi
         OzkUZEQppunDXZtIO6BFgNHOgnupmBgLk5SilOADSIsk5jFGjiiZJ/AMWXdniNBvBW4s
         RSW+PCeyiAhadgI2i8mzVWM3kFCGHuUeMCInkUyJQMoSDWVCkygU0chlCp9xrCRDuSLo
         Uls2PxLO1pw6XR4sO0+HL1deNlr8EViP99zq7cPNmXpezxzYfS6r5XeQb4bbCa5ID+AA
         vTYzFIqdgSmmFquDgtuvPzmx8XUl0Wcr1GAmF314nNPHQ+k3df6t84DuzLANebv4yjDO
         3GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508304; x=1786113104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JL0FoHol+YpZow26X8VmCVV3SyRMBT48Kw3ZdoulJ9E=;
        b=aQ+u/FxPOaPxH8fa+16SWo22jG+sUSF5d8NRFw0xwq3fk6C04GbXB9cUkK1U9DBJq3
         deZD9j1xcfoW9ggt+x+7t0YiFh5aFC949Meg23AD8ePr3J46nEzQ+b9414+oDaqsGG1x
         bmN4wf+y13vqt2tHq2VI8FmZWo1bCAYzRnACHHc81T5DUqtah0b+Jbx4vUHfqRRsSmSC
         iozldaHKEf7f/OdoqBIyDMf6ZKC2Tpn5HNM9Z++Kntsv6Y06ntZcXW4ltUAjin1DbugL
         xHvp/ZML7p0xeS40Krjw/+/ccYH4oG/qOGlpZxDA8Gmctddvo6hkyF7viWvxHI9BeI1T
         6dow==
X-Gm-Message-State: AOJu0Yw9i+xGV6a8tymHRJQkHQBbXuZYmBNF4n1C60znWDcl44eWDKcd
	6d98y++bHfGii3kKULUnlqDn+OiT1plyt9Ib5wgPkr5VZjuWn6KUNI9B0lgCvovofk2hoEXxptZ
	y+As1jltJZA==
X-Gm-Gg: AR+sD13ho1ceXKvBMYeVxKp+D+IepERgggrSuiJRCGjcnrv8fGbnttdHSCMby7wAx6v
	QHkp1jBIoW68/CHXTg/uYqCqdMZf6eeYbbH0C+WFd86hSh4KADkLZGlfkN51GxOTIqh3VssXzR5
	7809rqGKb49dXCWlJcqHfqILrQdwQzfuB1V/1RC1AcJKr+rGzwdUKSNugXGCU2/h1+aIuVEhz27
	BTz1JV0M4BfuL7COQ930IxBdn+66CbVkvR0nHOZrRrW6bMUqfcOAT7zvfxqf3+had9AMFwhbWgY
	qvQepw0X9jfMkgCpeye0pxlu+X8NWvn8xMwconNd9XasSUQgDg+FvX5LWHkS2ofbhgnnOvOODlo
	hgnBjrJH5rGdcC3+c9IHe08KFoP16gifPxiO+wpFx/cAmSjCLuE3D9pBBEnc3OcgJ72O9m8yr1N
	XS6mwp+kMP4FjFgHO29qyw+FSgbCnr2XdFovsY65MVvnvCxgcnEPNJ4QTaJNAm3c0HFDWc
X-Received: by 2002:a17:902:e947:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2d04832d89bmr17392655ad.11.1785508303549;
        Fri, 31 Jul 2026 07:31:43 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm6203185ad.6.2026.07.31.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:31:43 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH 0/2] nvme-tcp: two checks on the C2HData receive path
Date: Fri, 31 Jul 2026 23:31:14 +0900
Message-ID: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_073145_359790_A3115E66 
X-CRM114-Status: GOOD (  15.53  )
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

Two independent problems on the nvme-tcp host receive path, both reachable
by a controller sending a C2HData PDU that does not match the command it
refers to.

1/2: the host never compares the total number of bytes received against the
length the command asked for, so a controller can answer a 4096-byte read
with 512 bytes and have the request complete as fully successful.

2/2: nvme_tcp_handle_c2h_data() still gates on blk_rq_payload_bytes()
without first checking blk_rq_nr_phys_segments(), which is the rule
established for the send path by commit 25e5cb780e62 ("nvme-tcp: fix
possible crash in write_zeroes processing").

Both were reproduced against an unpatched v7.2-rc5 host using a test target
that sends the malformed PDUs as ordinary wire traffic. The same target and
guest program show the checks holding afterwards, and target arms that
behave correctly are unaffected, including a controller that splits its
response across two C2HData PDUs.

All measurements are single-environment: one QEMU guest against a test
target on loopback, with no real controller and no independent reviewer.

Patch 1/2 adds a dereference of the request at the digest completion
site, where nvme_tcp_recv_ddgst() resolves the command id with
nvme_cid_to_rq() rather than nvme_find_rq(). That site and
nvme_tcp_recv_data() are only reached after nvme_tcp_handle_c2h_data()
has already resolved the same command id with nvme_find_rq(), which
does check for NULL, so no unvalidated request is dereferenced.

Two questions for the maintainers:

- 1/2 returns -EPROTO, which nvme_tcp_recv_skb() turns into error recovery,
  i.e. a controller reset rather than a single failed command. The rejected
  request does not hang: the block layer retries, pread() then returns EIO,
  and the command completes with NVME_SC_HOST_ABORTED_CMD, with no hung
  task reported. It is slow, 688 s in my measurement, because the retries
  are spread across reconnect attempts - which is what this driver already
  does for any receive-path error, including the "unexpected data" -EIO
  sitting next to it in nvme_tcp_handle_c2h_data(). Failing only the
  command would be gentler but would diverge from the other
  protocol-violation returns in this file. Preference?

- 1/2's direction gate is rq_data_dir(rq) == READ, which REQ_OP_DRV_IN
  folds into, so passthrough reads are covered too. That is deliberate,
  but if a device returns fewer bytes than a user-supplied buffer for a
  vendor command the result becomes a controller reset. Adding
  blk_rq_is_passthrough() as a fourth gate would avoid that at the cost of
  leaving passthrough reads unprotected. I have not tested a passthrough
  read against a short-answering controller.

Yehyeong Lee (2):
  nvme-tcp: reject a data-in command that transferred too few bytes
  nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone

 drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0


