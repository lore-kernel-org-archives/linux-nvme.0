Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652F606A890
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VHO/OGbO;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=0oLsZefA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ANh5UK6noVZGLD9w5kx/R7lFUKUoFzVmCcNxyJmNIX0=; b=VHO/OGbOwLwaSW0WuYCcl0pz5i
	mCnx1YtihoM0IbhnfRs96Jp1bv0xn8t14auK/pwk8WK6dyLn5pfkpLFeAiDW8i65eYLXVAxJDGnXu
	LUUER2Db4apaSYjkGxz3rCufHKpEJeeZlpVqHEpczSGQdW4zkqNTbzMrnVmLtlsK6/+tP+MYiHbwi
	sd38a+kyxVTYWvqFmRes2mWwbhdnT26eXKZ1gC+4pJLnz4U0FCOE12vrL/gD2w34xhMUmJTa//vGj
	ARFnyWXKvzOKWbStmDTt+aFrQiLT1fq3eBD9vkA8KDUaMXO6vS+6VuG6M422z/WgBwHHhlPWj+hQ0
	kqlfjIBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc8-0000000Dp3Z-1fE4;
	Fri, 13 Nov 2026 18:03:04 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc4-0000000DozE-2lko
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 18:03:03 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qJ2b4Jz8XrrJ;
	Sat, 14 Nov 2026 02:02:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592972;
	bh=/mmJp2/7ZvLGi0H7DjG+tOzdug32dAenCcTvKKU0me8=;
	h=Date:From:To:Cc:Subject;
	b=0oLsZefAeUDYxoQY6cF4i9jH/jQZfmI529malpsK33S9T76uU1z5tQweJTjvaeDI6
	 esKV1+XlR6b7vOX/v9PV7Wnu/1N1KU2sMK1UbDZAfJS0zBt6tVTliQVkcqeLg67H5k
	 7v6voQ0Tb/5H0igxcCmcV9HYJoIc4kSFb2Em6eJb68lko+vC1Wg/+HBljSeVfgMbbn
	 B6SITDwXMze+IqDrCnlbGkxzTTAl5QxsieEabrHiGrkk5FqgKGIg/mTJehxyb7Vong
	 9ODykUWB+Iy2qf7+7LBQEOzp6v/2kP3FsgvNNmcr7sEmfBixy+q25JFwg8/zgkUMv4
	 xK1LlrWCQNgIw==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ADI2hYc073469;
	Sat, 14 Nov 2026 02:02:43 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:45 +0800 (CST)
X-Zmail-TransId: 2afc6af750c5e97-1bdd7
X-Mailer: Zmail v1.0
Message-ID: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
Date: Sat, 14 Nov 2026 02:02:45 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNl0gbnZtZTogZml4IHRyYW5zcG9ydCByZXF1ZXN0IGFuZCBxdWV1ZSBlcnJvciBoYW5kbGluZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6ADI2hYc073469
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 02:02:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CC.001/4jR4qJ2b4Jz8XrrJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_100300_882655_62D8E9A6 
X-CRM114-Status: GOOD (  11.93  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The six patches fix independent error paths in the NVMe transports.

Patch 1 releases the target request in nvme-loop when SG setup fails.
nvmet_req_init() has already taken the queue, namespace and reservation
references, and blk-mq retries the same request, so each failure leaked a
set of references.

Patch 2 makes the TCP target wait for in-capsule data only when the SGL
is really an offset data block descriptor.  The old check looked only at
the descriptor length, so a transport SGL of the same length was treated
as in-capsule data; the same check is used when request initialization
fails.

Patch 3 requires the R2T offset to equal the number of bytes already
sent.  A larger offset let the host advertise an offset past the data
that its next H2CData PDU carried.

Patch 4 frees the fcloop LS request when nvmet_fc_rcv_ls_req() fails
before taking ownership.

Patch 5 publishes an FC target queue only if its slot is still free.  A
duplicate Create Connection replaced the old pointer and leaked the queue
and its controller reference.

Patch 6 rolls back the SQ binding and the controller reference taken by
nvmet_install_queue() when the CQ is already bound to another controller,
and destroys the CQ binding when the transport cannot install the queue.

The six patches are independent and can be applied in any order or as a
subset.  All carry Fixes: and Cc: stable.

Changes in v2:
- Patch 2: split the inline-SGL helper into separate conditions, as
  requested by Christoph Hellwig. No functional change; a compiled
  comparison of the old and new helpers found no mismatches.
- Patches 1 and 3-6: code and commit messages unchanged; add Christoph
  Hellwig's Reviewed-by tags. Existing runtime evidence remains v1 data.
Previous version: https://lore.kernel.org/all/20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn/

Codex assisted with the review changes, descriptions and validation
scripts. The updated code was function-tested and build-tested.

Shao Mingyin (6):
  nvme-loop: release the target request when SG setup fails
  nvmet-tcp: only wait for in-capsule data for inline SGLs
  nvme-tcp: require the R2T offset to match the data sent
  nvmet-fcloop: free the LS request when delivery fails
  nvmet-fc: reject duplicate queue IDs on Create Connection
  nvmet: roll back queue bindings on connection failure

 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  3 +++
 drivers/nvme/target/fc.c          | 13 ++++++++++--
 drivers/nvme/target/fcloop.c      |  2 ++
 drivers/nvme/target/loop.c        |  1 +
 drivers/nvme/target/tcp.c         | 42 +++++++++++++++++++++++++++------------
 6 files changed, 47 insertions(+), 16 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

