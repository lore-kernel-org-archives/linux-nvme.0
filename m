Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D5606A32C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EZSBn1Gm;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=DvAHkUjG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=1z/aM03hr0IFRbAHonH6KNo37rpOIVOubHzUqF+7DhU=; b=EZSBn1GmIEzs9KkH73tu62OiJL
	Jgs0/Stt0TwU1Gb2WAj3sO/Ock6L7JHg5MycjKzipcXO7cTgVuIRejiwGUQvUV9EMTFbisocA75um
	j6Hfqkylk+VLmU7OCHWgKKrUhHp9Oqp928h6mjh4f3z5ID0yOSxpP8viYNalMyFzVbYXgE8TBSEXK
	fN344/P57L+dVa0pVwyLEl9h9MeEGm3y3ejcRMcRZne0xByJA7QCPjT2PDJgM7e+SIhiLEc/owWTQ
	2efup4N6+9YjfV0Ua9hIhfcpv1ORRXOkWGBzHecmT46SdmPjw6qca5U26DRbLZLSwcC9FkVyudj09
	5DuaJmTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV8rw-00000001DfJ-01BQ;
	Sun, 22 Nov 2026 14:48:40 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV8rt-00000001DeE-1N8F
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 14:48:39 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jXX4s4Nd2z5B7RB;
	Sun, 22 Nov 2026 22:48:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795358909;
	bh=PNrjjeQGGYwFBpiOY39LRC3DQq24ju8DGCOK4z6sWf4=;
	h=Date:From:To:Cc:Subject;
	b=DvAHkUjGAqymK67pME9oazGYu5kG0Vh7IqgOIIXJ3yu2+tl6WR0KmatqLw/g9GsYj
	 VfMMaDkuwqsU5LMIGJbG0ZLPHamJ0TZbDlIsBWHenZeTP+276fyQmHcFg/3+2ykNET
	 vBo8ddO7kHkJJRaZ8n2i+QSn4l2fJKA8vxk3yLzOt4q6XFM9EirJSo/gEMpG4qw+5Y
	 xUWZd/s+pR+d+6A9iCV7gmpWTUtV78+pvQCZPb0dAl3VNx9ctD2QGY7hwxg8tR+WLJ
	 kCz3R2BnsMd7x0F0vBY45aUo6y6bH7TTyaOn0zCD4gvmydMJUM9y0uC9ZpogmSA+uw
	 aAcs4FAoPltvg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AMEmQaF029170;
	Sun, 22 Nov 2026 22:48:26 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:48:29 +0800 (CST)
X-Zmail-TransId: 2afc6b0300bd835-4e3eb
X-Mailer: Zmail v1.0
Message-ID: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn>
Date: Sun, 22 Nov 2026 22:48:29 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <hch@lst.de>
Cc: <axboe@kernel.dk>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gbnZtZTogWk5TIGFwcGVuZCBsaW1pdCBhbmQgRkRQIGZlYXR1cmUgZGVjb2Rpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AMEmQaF029170
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 22:48:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B0300BD.000/4jXX4s4Nd2z5B7RB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_064837_517090_77639971 
X-CRM114-Status: UNSURE (   8.64  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
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

Two fixes from the [PATCH 0/5] nvme series posted on November 15 are
resent as a second revision.  The other members of that series are
settled: 3/5 "nvmet: validate the LBA format count of a passthrough
namespace" was applied as e52b8562e2ad, 5/5 "nvme: bound the reservation
report retry loop" as b80093c7d0aa, and 2/5 "nvme: map passthrough data
when the length is nonzero" is withdrawn, because reusing a command
structure for a no-data command regressed from success to EFAULT.

Shao Mingyin (2):
  nvme: zns: reject an out-of-range zone append size limit
  nvme: decode the FDP Get Features result as a dword

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/zns.c  | 4 ++--
 include/linux/nvme.h     | 6 +-----
 3 files changed, 6 insertions(+), 10 deletions(-)

Changes in v2:
- 1/2: drop the dev_warn() for ZASL values that are valid but do not fit
  in max_zone_append, as Christoph asked.  Such values fall back to
  max_hw_sectors, and the changelog describes the representable range
  instead of calling the value invalid.
- 2/2: drop the structure that became unused, as Christoph asked.  I also
  looked into the Sashiko report on hdr.sze: the buffer is on the stack,
  so blk_rq_map_kern() copies through zero-filled pages and copies the
  full length back, which means there is no uninitialized read and no
  separate patch.

v1: https://lore.kernel.org/all/202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn/

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726

