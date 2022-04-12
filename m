Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23278C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:
	From:To:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JJtIRzBfNpDrJ/fFtvW6vi1j9+8vDctIDP1NHWiTvOk=; b=Elocw1g2uWhvG3
	YPnkrutQaR2Xv/ZvkiPPdwrWMJj9TuU8no11qvHU7TUTOARNs4n16NvVdrBjUS1ouINAKs2n5DU/K
	Wxh40R3Gbe7s+4oYD3fLzJq6A8V5dPf3b8Bw536lOA3y2wcZklKAZfIpENZ0/QG6M4dEOLrYf7CV4
	f8ht7S4VmYKOEuQqbbR8DK9fD2KZ7QUYnBcNLNOPBy9Z+wfI7I9V/OOooSTrweNo295JeCAMXpweP
	kTSZtU9yZLicMwshl4N/9rQNh8vVaS/a/oL4qfNJzq0eTxOvyADfygbbyq/WlDk1bs+kD54eAUDM1
	2bJS7OaGNEdyfgPoYpag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neOXq-00Fuco-A4; Tue, 12 Apr 2022 21:59:30 +0000
Received: from mail-4322.protonmail.ch ([185.70.43.22])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neOXm-00FuXo-In
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 21:59:28 +0000
Date: Tue, 12 Apr 2022 21:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail2; t=1649800761;
 bh=JJtIRzBfNpDrJ/fFtvW6vi1j9+8vDctIDP1NHWiTvOk=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID;
 b=M2J2L0iK2Kc/JQTIjkwhDUkVqWiZJr3O/27pjBoOkV0WQ7k3QLKoWiEY4P8AO2cMT
 OApMkeZx7jZ147jSo5zdtUJ4MYUQI3LZGgFLt5lQy2IbjAyfDr3JdfIat6WFFXrrpK
 w6L6qXuzVppbmyai1QnXQf3zVPlwQmukLWSYtXStunKKc6w2+Je+8XmI1/jRXcuKZM
 ugzbjMCdqaBj+SICra5VB2NALMPCUFd/dOxLuvqDVK4p7PmM55sl91uTxRYp3lYwIP
 Wplktu5ck2NSYZL+AmRdzhMhpS9KKb3ZVDMPNH0oQPlAk2NVHCT0SYTlSBPdbNDOXO
 jnYDIIyAsO8UQ==
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org
From: Alexander Lobakin <alobakin@pm.me>
Cc: Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH RESEND] asm-generic: fix __get_unaligned_be48() on 32 bit
 platforms
Message-ID: <20220412215220.75677-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_145926_812307_B46EBCF1 
X-CRM114-Status: GOOD (  12.04  )
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
Reply-To: Alexander Lobakin <alobakin@pm.me>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

While testing the new macros for working with 48 bit containers,
I faced a weird problem:

32 + 16: 0x2ef6e8da 0x79e60000
48: 0xffffe8da + 0x79e60000

All the bits starting from the 32nd were getting 1d in 9/10 cases.
The debug showed:

p[0]: 0x00002e0000000000
p[1]: 0x00002ef600000000
p[2]: 0xffffffffe8000000
p[3]: 0xffffffffe8da0000
p[4]: 0xffffffffe8da7900
p[5]: 0xffffffffe8da79e6

that the value becomes a garbage after the third OR, i.e. on
`p[2] << 24`.
When the 31st bit is 1 and there's no explicit cast to an unsigned,
it's being considered as a signed int and getting sign-extended on
OR, so `e8000000` becomes `ffffffffe8000000` and messes up the
result.
Cast the @p[2] to u64 as well to avoid this. Now:

32 + 16: 0x7ef6a490 0xddc10000
48: 0x7ef6a490 + 0xddc10000

p[0]: 0x00007e0000000000
p[1]: 0x00007ef600000000
p[2]: 0x00007ef6a4000000
p[3]: 0x00007ef6a4900000
p[4]: 0x00007ef6a490dd00
p[5]: 0x00007ef6a490ddc1

Fixes: c2ea5fcf53d5 ("asm-generic: introduce be48 unaligned accessors")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
Resend: target linux-block, expand Ccs a bit

 include/asm-generic/unaligned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligne=
d.h
index 8fc637379899..df30f11b4a46 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -143,7 +143,7 @@ static inline void put_unaligned_be48(const u64 val, vo=
id *p)

 static inline u64 __get_unaligned_be48(const u8 *p)
 {
-=09return (u64)p[0] << 40 | (u64)p[1] << 32 | p[2] << 24 |
+=09return (u64)p[0] << 40 | (u64)p[1] << 32 | (u64)p[2] << 24 |
 =09=09p[3] << 16 | p[4] << 8 | p[5];
 }

--
2.35.2



