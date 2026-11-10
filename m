Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB260A260C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mn2DmtBk;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Z8kdV5w/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=F0CMn0G18tWa/Iz5/6L3Q85B7oHt15XFmTZTtpw7n8Q=; b=mn2DmtBkecmhARM3tDOHr6EzUD
	HcIk9l4lS3vWTEFHf7pYyRmFnp9/Va5k+Cp7Kr1BZt5Brj3+hr4KaR23R56Cj2rQTTM/vWIXqUh33
	qE4ENYC3WKpkIQB+Mug5ZSiikbg/CpGoQziTeKH/e/yUKBrIZ7A0eK5bL/Ltlnu6Cy03EZvd8oJ3j
	rtjdGb6s6oWDdS1GjSdUxRf61PvPddXVGp/5Ox42xOeIsMV7NJfy3+QTTWUXl2S87Ui1f4cEcjnjz
	0XPkj4NOkaGS6/vjDevvcB9J6OCGCy9/Wtn2nNJLoK8A5lDEFosqzWE1npuca0xCyQnAgiXxkyRoF
	PHwVAZmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNT-00000004J68-2tnN;
	Tue, 10 Nov 2026 15:03:15 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNR-00000004J5Y-199k
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:03:14 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zJ5lM4z6FK1f;
	Tue, 10 Nov 2026 23:03:08 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322988;
	bh=7X663BhplGetURYCfC415YTYFX63LQtL9sJ7Cgul2HU=;
	h=Date:From:To:Cc:Subject;
	b=Z8kdV5w/6bExDk7KHO4RMqUob0T2F56lmdrJv1yHH78vYH6bBmpepHXcC7xIeB/ao
	 A4o57fq2obescz2XaI9UVcsyPGNZkc1M6naxzsLEveF1G+b0LZwXv5ZnEk5b4VYkmd
	 0ViQZrPAZikSXJUHFWbzwQcyW1OlXXy9j+BmxSXc1LAXX722R6fIh3WFnOvDVl5Ypv
	 DQlsMFZ9AE/oZxd9bJuzEYSMLx+24zmshKKF8QXS6QK6WgCVNhAVpkHXkXfqdf5FKH
	 gaaOD0jBGq1GLjnyWcBCWk/Bqj7weFtxFda6W+fHRBDOfNRGlnobnfR5ILFwdbUf7l
	 wjvbg0xaHhrYA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AAF30um030610;
	Tue, 10 Nov 2026 23:03:00 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:04 +0800 (CST)
X-Zmail-TransId: 2afc6af33228054-01698
X-Mailer: Zmail v1.0
Message-ID: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
Date: Tue, 10 Nov 2026 23:03:04 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNl0gbnZtZTogZml4IHRyYW5zcG9ydCByZXF1ZXN0IGFuZCBxdWV1ZSBlcnJvciBoYW5kbGluZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AAF30um030610
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3322C.000/4jP8zJ5lM4z6FK1f
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070313_505471_7CE81C9C 
X-CRM114-Status: GOOD (  11.02  )
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

Shao Mingyin (6):
  nvme-loop: release the target request when SG setup fails
  nvmet-tcp: only wait for in-capsule data for inline SGLs
  nvme-tcp: require the R2T offset to match the data sent
  nvmet-fcloop: free the LS request when delivery fails
  nvmet-fc: reject duplicate queue IDs on Create Connection
  nvmet: roll back queue bindings on connection failure

 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  3 +++
 drivers/nvme/target/fc.c          | 13 +++++++++++--
 drivers/nvme/target/fcloop.c      |  2 ++
 drivers/nvme/target/loop.c        |  1 +
 drivers/nvme/target/tcp.c         | 35 ++++++++++++++++++++++-------------
 6 files changed, 40 insertions(+), 16 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

