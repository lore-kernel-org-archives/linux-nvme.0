Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B2606A330
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TbHlaQg0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQJWkRdI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LDDJ93BkO849C2mhgv5WGiNanef8BM3ODaG/2JsNB5A=; b=TbHlaQg09CqT6o
	0rB9fqNL/ub+kTzckP5Bfj1LyCt5FC0IlZIx6d6Dfj39fvcBzUYL/utUyJsIamZjzom81vR+/7kAy
	kp3dJuFEEyErDkfRI/d1z9+6y1YBXWXpoZbr9N+o3Z8uA173GwR/Y3Tvtw2Nl8VR2otisMWG4hEDU
	FYQiIkZOcPU7mlol5kaz4wxosTTVJEN9vbQAx++/zUNhkYvD/L55jOBXoxApWKvXqJUNztBB4HPnJ
	rC3vUdIVwG7RHsi1xOC1D2vLZJ9QqsXFl50nBMSCKNzBLg9yuj7REEpnhDVkdKQM7jYb2l17OD91L
	7HIrxGir32e9TIyZ8eMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4nW-00000000udB-2IeG;
	Tue, 03 Nov 2026 03:02:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4nV-00000000ud2-2Snt
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 03:02:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id EC5E2404A3;
	Tue,  3 Nov 2026 03:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4FC131F000C1;
	Tue,  3 Nov 2026 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674972;
	bh=LDDJ93BkO849C2mhgv5WGiNanef8BM3ODaG/2JsNB5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQJWkRdIcjvAY4W8I1hKBDHFP+BiR81cLIPg9YWzvy4whukwNKfwQlFC/F+dnuBPm
	 JDC3INvVchW4+cTJRN2+h7MS7EQO36Gv+hlobgituZzhXz+FsnYY8xS37YUUrIhM5w
	 khhgdvxq2y9w7txWIVba/jbkE0Su7U/SGtn0M5Y5ymyBOcyBog1gw2rhvWFVIMTSqN
	 +gumTBvv7MMoXjxOYdkrOLm0R6FDzGqIhd6KeZJvGhT/BzHDlQSc/G8cLc4WZka+VQ
	 9V4MYyw/+t+Kz7ggGeNV32VYv2WhKwJJI+027cdjCdGvO9UDJKJhLttuTPZMYF6QDi
	 fY3Tfkd+cinwg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()
Date: Tue,  3 Nov 2026 05:02:07 +0200
Message-ID: <20261103030226.2685251-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Call key_put() before returning -EKEYREVOKED, as the reference count gets
incremented by key_lookup().

Cc: stable@vger.kernel.org # v6.12+
Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/nvme/common/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 32d16c53133b..87cb51e1f5a7 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -35,6 +35,7 @@ struct key *nvme_tls_key_lookup(key_serial_t key_id)
 	}
 	if (nvme_tls_psk_revoked(key)) {
 		pr_err("key id %08x revoked\n", key_id);
+		key_put(key);
 		return ERR_PTR(-EKEYREVOKED);
 	}
 	return key;
-- 
2.47.3


