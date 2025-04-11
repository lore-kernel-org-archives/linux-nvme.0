Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC64C369A9
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9KRkDEvc7TMn+BzX0T9birIBPHV4NaWt5YIRVjgsZSM=; b=hmkIkqmGBnllM0cClMPYG2YQ/L
	phPjJjd+f/KsVgS+H81fHwYh1YhdHWLsDNoikjdJEpbMNhQ7bRg8ZngOw5cxwLxWVod9Zo0RuNhp1
	jABaMlbtCo8mOFmWyYUUeXM6Nk1FR52p4BSWxw2PxZtyamwW1CLbMaUjxxmhCW+Y0xIS0rjOPFBSC
	rqWlnVTs4WHPA6OOiIpi+XNFnYfJTF4LsahkY/PRTApoo3VnBhhuVU5qbWkKMnBStSUINRZ2P9Sys
	4oA/Igwh5+vAfl0kzl371ORLyDKZ9jdzkKVmCfnqncmJf+GK8OdhjiXvo0g+3TX7m2lHqHVhcdMDo
	2dP1uhnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3CQ4-0000000DVe8-1gTz;
	Fri, 11 Apr 2025 11:19:36 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3C3n-0000000DRiY-2Kyt
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 10:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744368948;
	bh=9KRkDEvc7TMn+BzX0T9birIBPHV4NaWt5YIRVjgsZSM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jaTfAY82zKF05cJhA/t38WygfLp5pfHoISMaJX8ueIT4QYhyB9y9aOpjiDbb6BiWB
	 p6SUWwCmyfGXH9bB0UztDDXw/u8MLLLbIU9PRgzA5dPjeoa/toWypZF3azpreLv/9x
	 P5rAKl8JBPX0/o8PiNm7hLBks+K2DpuaKUBj8JYs=
X-QQ-mid: bizesmtp23t1744368921ta5c660c
X-QQ-Originating-IP: y6XDffOa9VCdiTTbmBMiGZAntBVmbLMe7C7tY/zlyb4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 18:55:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5873114534741564998
EX-QQ-RecipientCnt: 8
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Winston Wen <wentao@uniontech.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] nvme: add __always_inline for nvme_pci_npages_prp
Date: Fri, 11 Apr 2025 18:54:49 +0800
Message-ID: <8E10021DAFBE47B5+20250411105459.90782-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
References: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nwz8Cs33/LprLV9bzlLg9s//LwPGS6Z5d8wITrM/fnWYKm1JiyeWpte9
	R+4nR/zTYMTDtUIawaFd/hYaCWmNr60mgGOl5flw88iGgQQ++zHR4VV3KCksyAGP5eRfICU
	0KcqVuh6mjujOF0KhblmEKnHe7Dd1BtXG5DKqKUK2Ia40UQhPo9kasruuoiWK7hw9AictLj
	VqE6z8bsDdMqyJZhfuLMJOmKaBHduD76LjaN4peuQ607kww60cksjipgHDN/Hf6QTkG+Yjo
	xyCji8GmZttpQpJJN/h06J2VcnQT+qZ5ma70iNZeMNy0dCiRODshoMoFkaEbA4nWGaKy2qY
	4uaEQWmTLbI9bmDLeWIGv/9ENGdE4MQxrRi15cKGEka1oV6xUBxsPPlgAWQW+vgwNinbALN
	0v4DOiERlKCJbUMTae6tkS3UNU2uJvRck6X0DNIW9nmt1aMbYyjM+aK5Bh6ocKaFMZEOwLW
	3uXcWeNpuX179+rXmijKuv+z8uj/9Qb5XZSzW946ryYELgqCnjZeTyh8TSX1s8kvuASlCmh
	/JdJef67LyTSg7/DQVLiUrOC2lNZkLe0WAyq6m5sStYrwoWsdbHI8aAgWzO3I+OfXovyfI8
	Wh3WkXLsO34bTPKLK1B7K6RO1owUMgGK2fhg7AMlOGSXTDph+Vg0aORI6a3EdYx/01d0asx
	CGImwnME0NSEgs6u9GWezsFDBYE/Syk0+TaE/20pjfFJuEk7DRuk+868DQLFvOdwfZ7jRjl
	Qad4VKfBXZwxF5d5T+hLWvuIDZOoqc7wUl/ZmXiZl4FK3S6/mx1LavyndYIMutw/BQIezVb
	OKkvAhIakIjDPlI9zDwrJszghKpiqR4MpPIw+TcMojaXMYH/ftBJEOBt2LCCG4CjtDUnvyR
	QO+eyRCsuN+mwYZaRtP+RSefvBaIoKukBT0lxRc9F729/s/6fq9d/3+vGgJ9gWk9sa2TkhC
	8KcjjOawrus2Qghj3eyKh0qVVDpnqmiznIz2skGBGPcEOJjZGOxeLhL8+3yyPyOXtq1nP9G
	+seejhp3p58s5WFX5b
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_035636_123433_423A0978 
X-CRM114-Status: GOOD (  14.59  )
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

From: Winston Wen <wentao@uniontech.com>

On x86_64 with gcc version 13.3.0, I build drivers/nvme/host/pci.c
with:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_BLK_DEV_NVME=m
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
    drivers/nvme/host/pci.o

Then I get a compile error:

    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      drivers/nvme/host/pci.o
  In file included from <command-line>:
  drivers/nvme/host/pci.c: In function 'nvme_init':
  ././include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_878' declared with attribute error: BUILD_BUG_ON failed: nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS
    557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  ././include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
    538 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  ././include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
    557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        |         ^~~~~~~~~~~~~~~~
  drivers/nvme/host/pci.c:3804:9: note: in expansion of macro 'BUILD_BUG_ON'
   3804 |         BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS);
        |         ^~~~~~~~~~~~

Signed-off-by: Winston Wen <wentao@uniontech.com>
Co-Developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..9ab070a9f037 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -390,7 +390,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
  * as it only leads to a small amount of wasted memory for the lifetime of
  * the I/O.
  */
-static int nvme_pci_npages_prp(void)
+static __always_inline int nvme_pci_npages_prp(void)
 {
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
-- 
2.48.1


