Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA1606D80E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QmPbgCJe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pPBo8tnNZskBWdcYk57vjkMabC2vizbpChaQ43BRYoc=; b=QmPbgCJeJ2PymiS7EQQfPuf8px
	n+7l1LPZbt+Ok3YfjuEs6L0FMwrj8RhTU8yANro7HDmj/8p3IsJ6KVxo1Hu2Tq0FGvibZwewpKInP
	FdoZ4Pdni5NFS2Z5dYtY3jJj/RSsdrJO/GIjrVJYI3dQj1KoD2RuuHpSGTKPCcilGTE0XMCC7SFdh
	1kRPAOPUgCHvyKdOWLdI69f/DhCG6aEOGNyrKkAuvRfpSn8h2G+NCc1JDX8f97xNF0oBCOVURata7
	474KDVhfuJh5jFNdaZ28HlVWgdG+vqDT+VaiIcTU8zx/pnjpI8G+rTnghO6Y9aoHDUv+x47/Tu4aW
	d9bQlZkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxyo-00000009CUp-3Ckw;
	Thu, 05 Nov 2026 13:58:14 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxyk-00000009COu-2N9d
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 13:58:12 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3mM0nMZz8XrrJ;
	Thu, 05 Nov 2026 21:57:55 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A5DvokP060217;
	Thu, 5 Nov 2026 21:57:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:57:53 +0800 (CST)
X-Zmail-TransId: 2afb6aec8b619db-d412d
X-Mailer: Zmail v1.0
Message-ID: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn>
Date: Thu, 5 Nov 2026 21:57:53 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IGZpeCBzdGFsZSBsb2cgcGFnZSBkYXRhIGFuZCBhIFpOUyBJZGVudGlmeSBlcnJvcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A5DvokP060217
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:57:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B63.000/4jL3mM0nMZz8XrrJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_055810_814756_90D44153 
X-CRM114-Status: UNSURE (   7.51  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two issues in the nvmet Identify and Get Log Page
paths.  Both patches are independent and can be applied on their own or
as a subset.

Patch 1 zeroes the unused part of the fixed-size Get Log Page replies.
The transfer length is supplied by the host, and the transports send the
whole buffer back, so a request larger than the log page used to return
stale kernel memory.  It covers the Supported Log Pages, Commands
Supported and Effects, Supported Features, Endurance Group, Reservation
and Rotational Media Information pages, and clamps the Error log ring
walk to the requested length while keeping the most recent error first,
as the specification requires.

Patch 2 returns the namespace lookup error for an Identify command with
CNS 05h and CSI 02h on a namespace that does not exist, instead of
overwriting it with the status of the identify buffer copy.

Both patches were runtime-tested on 7.3.0-next-20261030 (QEMU/TCG
guest).  Patch 1 was tested with an nvmet-tcp target and a file-backed
namespace, using a 4096-byte Get Log Page; patch 2 with the loop
transport and CONFIG_BLK_DEV_ZONED.  The Rotational Media Information
and Reservation log changes of patch 1 are not runtime-tested: the test
guest has no rotational namespace and no persistent-reservation setup.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

