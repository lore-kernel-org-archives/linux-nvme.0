Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00510606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yZQtoZ8t;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PL47/ijl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=; b=yZQtoZ8tfN2rDd57WcPvXfMtEO
	XmBac6Scc6F6S7tvOeXom/kBixlvL6wCT76TCBBHj//eJcwxtJdvgwiOHaARqi/mbGKnu3wvPTS5E
	XORm0ePigmRm9/xpOraLqekosPanxQPXFMLoSjoYBvnNowHf/JWagKxxVgK6CsnpGdkkCmoOuW+uS
	lOQ2mLBdq0uKYtpczcjL9xi63i1S/NEdwxzq4+FR+O9Q7D5S86P2VeGMX3/f8Il+9QIP+UtbNO0j8
	ufV9PnfJSjBUqRIUII29aCFnLHBj441QUi1ZG+iamogTqd8Nn2mzJH1i3TnuTkRltg/N5Ii1gca0h
	PXEjL3ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUWT-00000004Q57-0THC;
	Wed, 04 Nov 2026 06:31:01 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUWI-00000004Q07-2ILc
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 06:30:58 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1b1ce85287aso363018c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773849; x=1794378649; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
        b=PL47/ijl9lVPLRNjU1/1G+jmjDt4L2di70a0gVl7UENEPD/0pcAVwpVMOfI1HGHaxC
         yEP6OCeMyPnQOZPq3ecpKPqK6HPt3j4ClpWF4EMZnTGAfvARyMR+q2HxfNWuUG+7jAIo
         /FsKiCtR4gjgWLLnRpuvY/lRuZL+6/o6lCCGNdbBsNwL8eGh6zjvMvOHdGGC9QMbdov7
         549SHh+JDuQmXOwXTvxxvZ+eg+HbfGb7oV5nflTU1wOe9VwQi3n5nx+vJsg0qcPoQIGE
         uHwwWYn7r33BhinxSFI9jnM1aPx+RnMFwBCZ6GBT94O8vzBvOFrPZckjMuw65yfKLs20
         t/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773849; x=1794378649;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
        b=ZPofISLW9gMmi9HNF3Kgby8nHQ/9nBJhMLscWfDtX2GeZpHFKOSocd9ykZ7u3t/z/q
         zt3QnwEW8ybhWrup3rpGIc1gQl8e2rsCn4DxN2HslW/xlGmVD3Us9Ywr7d1i7lfxHlii
         lidTwWBotBrf/hM2LcZz4OwEl3arDSEzAoeFLbOan9s+/MX8xk9riFMgpIeGgsFPNv+W
         Uquro976viLFAxP4y+GAreB+T4fBLLrrNUTltUBbEm5qGDpzxtBEGG/EA7NQDgD1VPaL
         +a+sph21mnlHHishgXnaASkzAiGOHt0d3LlCv6LNuaoXA2ejINfoEZbfvvNILasyD+gc
         19bw==
X-Gm-Message-State: APuU4Z8iIB/qDzKHCv/4XZSlr/6MA6nK9FUaBVocT/5wV8FvPrZ+3pgq
	sL1j4P9YcunUocDiS1j5wqUSp5zdIIKWyZF8Ix6qeE7BwBoFNHqd1TFG
X-Gm-Gg: AYBFou2XBmsnjPg0SZK6V6lFr3wL4z6qI0FJcKNnSArUVCTKOwmovePr/ABqlGVouE7
	IijmqJeX69renkUq0NZhhuEr++xOdNzjX5rRMOc5ndrHYdK6oybiRB2hakzP00Uhgx7TcA+uXo7
	iEefzubGTr68ri+pAFvvNH6wy/Z8fgLnlMb85o/Jrhe+QbCYQwHbJHM0wUVrHXxo0kpAxzkxc2+
	TUKjjCtDku0C0SGnWx2PephPF7/+WMz7Sw6JTGzUnxFW0/1RhHEShfELGsrKlZ6q3dtdGmBTgXM
	CtOWkA/WDRalwBVAljwm10WmFqNj49S8a8tQdNCeRMLi/c1VZYKilXOVQ7hE54LU1anBD5Kq39V
	SqIeY3hpTy/3g5ToCWCDU/wzQszRX0m+1/7fNVQP17iWq7yCrct/9tqgHjsDdDmZHLpe1RgjwL0
	pI5s8NGQW1mZKmjtUPmOcpK4P9oUiB1nG9LXS+DzzVsQ8ULgZpdVB6cYjTux506Ud1akXgGJxTI
	7stTijOyfPrCfB8Vg1pYoh/4y4t0gQHPWz3hEPNjI1QYUD/GIqFps3G13ZtCf/6r0TW6n6zk9dp
	4aSir7Ksf9/mKrzP/ppQO8ry
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id a92af1059eb24-1ac56ca0239mr24721522c88.1.1793773849198;
        Tue, 03 Nov 2026 22:30:49 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:30:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] nvme: fix removing namespaces under SRCU readers
Date: Wed, 04 Nov 2026 01:30:38 -0500
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7R6moC/3WNywrCMBBFf6XM2pEmwT5c+R/SRZqO7YBJJLFBK
 fl3Y8Gly3PgnrtBpMAU4VxtEChxZO8KyEMFZtFuJuSpMMhaNkLUEsd1RpcsYSDrE6GLGINZsVd
 Tp9uT7kcxQlk/At34tZevQ+GF49OH936UxNf+mupvMwkUSFL1dddOjdLmMlvN96PxFoac8wcuk
 0/JvgAAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_223050_595618_F1A5D29B 
X-CRM114-Status: GOOD (  13.34  )
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_remove_namespaces() splices the namespace list with
list_splice_init_rcu() and synchronize_rcu(), but the list is read
under SRCU. A reader still on the last namespace can then walk onto the
on-stack list head, which KASAN reports as a stack-out-of-bounds read.

Patch 1 adds list_splice_init_srcu() for lists read under SRCU, and
patch 2 uses it in nvme. Both are needed for the fix.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Add list_splice_init_srcu() instead of open-coding the splice in nvme
- Put it in srcu.h, as rculist.h doesn't include srcu.h
- Update the numbers from a new run, median of 3 runs per boot

v1: https://lore.kernel.org/r/20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com

---
Qiliang Yuan (2):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

 drivers/nvme/host/core.c |  3 +--
 include/linux/srcu.h     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


