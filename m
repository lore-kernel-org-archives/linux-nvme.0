Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E21CA0FE7
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 03:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V1C+xtJjkdou4BkLOq+e3Vy5dXdG0NO7lu35hyMhmRo=; b=EcdtWinRm/Z0zoFwxC/N6sonSN
	UmbeLJmjXj8Jv5jk9bmMTgKBTMOM8UHOFhuL4JEkcGEaiaPjjcW0PU3JGIT3LQC1X3ZlGbhj0x3CW
	GqjqpdgV7MAEeKe+CS3NFAE9x6sRdSvXU4Ac6KOe0dPVFbM2QlCRUkYcDlgCOZwPASi3hKgs/qehC
	yHWOd6fjaurruvdzlbj4eLovKOV8w4kNe6sC3oiEoily6p5Kq3RjdDgDOpIe5Esw3kBbIY5yPaGWt
	e9UBwf2tm+gm+BG35yi1NMgvpd7J+xAFNJKt6rOwN/4tpFTvG+9wupyg6uBq4TfxkUyDqxNs3Kop2
	ICP8rOaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upIJ6-00000001MjC-1P47;
	Fri, 22 Aug 2025 03:19:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upCDT-00000000XvK-38PW
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 20:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755809337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V1C+xtJjkdou4BkLOq+e3Vy5dXdG0NO7lu35hyMhmRo=;
	b=bF5sAMZGN8pOQA3/ORSTazKjWk9wAk1ddDyKBM572dsTiBTw77M1YVd8VOlgTwoPPwgKAi
	4sz5P6oiin1oU7fddgJ3G50VH2BQO+5td9GacOTkRRKcLD9rVp37VjIbmGdloyqTSZDxOC
	EtSA39ppdMb5LYf127axu2/2Jc19EeQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-3-fgJMAWPQm5LxUHAhrhfw-1; Thu,
 21 Aug 2025 16:48:53 -0400
X-MC-Unique: 3-fgJMAWPQm5LxUHAhrhfw-1
X-Mimecast-MFC-AGG-ID: 3-fgJMAWPQm5LxUHAhrhfw_1755809332
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5517019560A0;
	Thu, 21 Aug 2025 20:48:51 +0000 (UTC)
Received: from my-developer-toolbox-latest.redhat.com (unknown [10.2.16.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 263201955F24;
	Thu, 21 Aug 2025 20:48:47 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] nvme: fixup HKDF-Expand-Label implementation
Date: Thu, 21 Aug 2025 13:48:14 -0700
Message-ID: <20250821204816.2091293-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_134859_855873_1F780D73 
X-CRM114-Status: GOOD (  14.13  )
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

As per RFC 8446 (TLS 1.3) the HKDF-Expand-Label function is using vectors
for the 'label' and 'context' field, but defines these vectors as a string
prefixed with the string length (in binary). The implementation in nvme
is missing the length prefix which was causing interoperability issues
with spec-conformant implementations.

This patchset adds a function 'hkdf_expand_label()' to correctly implement
the HKDF-Expand-Label functionality and modifies the nvme driver to utilize
this function instead of the open-coded implementation.

As usual, comments and reviews are welcome.

Changes from v1:
 - Moved hkdf_expand_label() from crypto/hkdf.c to nvme/common/auth.c.
   It's not really an RFC 5869 HKDF function, it's defined for TLS but
   currently only used by nvme in-kernel.
 - Fixed kdoc label_len -> labellen
 - Replaced "static const char []" with "const char *", it's just
   clearer and generates the same code with a string literal assignment.

(I've left the crypto emails on this version, mostly to make it known
that hkdf_expand_label() has been moved as Eric asked.)

Chris Leech (2):
  nvme-auth: add hkdf_expand_label()
  nvme-auth: use hkdf_expand_label()

 drivers/nvme/common/auth.c | 86 +++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 20 deletions(-)

-- 
2.50.1


