Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD063CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QZD6lVcxYxA9BVfi+MXOuA9u1vCnrZMcBnWGmwFzWk4=; b=Ih+2O0DoVpXuh5/fSBoyHVrFEI
	Gya317RXOd9FPGhDD36IlPkVjjM+dnLODl90J8pXZDyPkVsVfQ0G/NeovUxosSewcqdUEbLQ4bWFE
	VkGNBRFnJd5EeSAyvm5gSJ15MPYhub5EIX2euTejAIqq/3y26W2c33XPnj2LXb39usruyWtxwVhd9
	cN1rkdgPkx1FqZbLkeXPDdntpKB5U8nC+VomQe0GLaXIYpAJvPn+jIXamf75s8y51UBpriclYa/ku
	bXCi4Y4F+6Fo5xdBW9rl4GYHZnbPdisKr0ol9Zkd1ogTCPy1yeV2V74ntmbW02MqgjiYX4m+ALBqV
	J1D1qAng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWZ7-00AmR7-05;
	Mon, 16 Oct 2023 23:00:01 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWZ4-00AmPn-0B
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 22:59:59 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6EEA3240101
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 00:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697497195; bh=ax3OYaNyzb/CAjT3t3j/wT9jnoQetJ33Pay44iGgCeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=ACe8QGUSNy15LMDWTIuMV2qaJvByVAf8C11B+2b2L/41j1Ur9MjxGI9htS4YUC36W
	 j3u7qIY74rTgiwAuQzc6BGKKFutew8ymKUhmPW1HFV/VfR24s+1gLctlmA9zBSTTQf
	 t2TeoiWaXtCdab/nfjXTXCkaWYD63qcOnETvRQfd7ax8r530Uyldwewnmu7JRfTwcw
	 KodApjtx56KxX68KcMaAIysjnUIBw+9NZCsyeHBiFr+hIyFEnRFwMlQej3euWdg9mb
	 re5R+VX4rKLWYz6Ik+kXwY7BLvWAOabl8oJyunBRF5+m6sx0jDj5+TqSn3IKKLjv4s
	 TuL5ruXTb/AfA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S8Xcl6Mlbz9rxK;
	Tue, 17 Oct 2023 00:59:51 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 0/3] Remove secret-size restrictions for hashes
Date: Mon, 16 Oct 2023 22:58:54 +0000
Message-Id: <20231016225857.3085234-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_155958_242096_C716E8D0 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
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

This relates to the hash functions used to transform the secret.
The kernel currently restricts us to using secrets equal in size
to the transformation hash function they use.
e.g. 32 byte secrets with the SHA-256(32 byte) hash function.

This restriction is not required by the spec and means
incompatibility with more permissive implementations.

With these patches the example secret from the spec should now
be permitted with any of the following:
DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:01:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:02:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:03:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:

Note: Secrets are still restricted to 32,48 or 64 bits.

v1:
- Initial submission

v2:
- Added transformed_len as member of struct nvme_dhchap_key

v3:
- Return a struct nvme_dhchap_key from nvme_auth_transform_key()

Mark O'Donovan (3):
  nvme-auth: alloc nvme_dhchap_key as single buffer
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 52 ++++++++++++++++++--------------------
 drivers/nvme/host/auth.c   | 30 +++++++++++-----------
 drivers/nvme/target/auth.c | 30 ++++++++++++----------
 include/linux/nvme-auth.h  |  5 ++--
 4 files changed, 59 insertions(+), 58 deletions(-)

-- 
2.39.2


