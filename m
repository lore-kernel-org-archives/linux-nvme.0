Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ADFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UUI8pbSCmu2osnzFJ28wD6Fqn5O6qnR6iqA2EOS5sPs=; b=HogLtGE0ukvu/zqodBENRMyGcS
	bGVr+aVbr9Y8HaMiEMtwNTeKGmwC8Iv75MH/wiYqZT6CI78OjHTGX9R+VUfw9/JUClcXLTRqtnyj6
	pvysO2nc9/VAzlKfl0FZfuVRjH7Ea71k9AuKjSmp/raBFYO6zydQ4MPIBSyf0bRNsOxAqZ1cbAHAB
	NlKiK1ed/Nvcxlzg4pnCnRpnLNFpfAvcwSb0qBtdtnDyjM/5j6IOcTiFMFtSrzcFq5oSzl2Zt0Wky
	52A48fNKlu6NLptoDFfXV81pVRdqhiv5rNhBgvZ+Ddi6ZHxzKiPZmCH3nwoeQHjFxOAMb4XGhm53X
	AzugF8QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPrpK-007fJO-KA; Thu, 03 Mar 2022 20:13:30 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPrp9-007fE9-J2
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 20:13:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3C508B826D5;
 Thu,  3 Mar 2022 20:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F49C004E1;
 Thu,  3 Mar 2022 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646338396;
 bh=ABLdWJrAQW/8RUZhNjgn3CF1lBXfUSvESej/WFPyg+U=;
 h=From:To:Cc:Subject:Date:From;
 b=SnSqinzexpa9E+Lxi/xlr1Il5+n7c0NFqtnAb745hk2p0v/QK24gXGOPUkD8BDrYR
 MR8SXFYaq+KE8hnbzi3I6THzwOIP+00Bwlctfb0sgsG3vCjXmSKpsCaNo/viPFeHgZ
 PLZbFoGHjBzGx4aualGnah2uMU/8hKeW51slGn6YLgKrwQZqQtgwpSCTPQ44+BQw4I
 TL2wLqSEtu93ExGJODfi82BR+y5OnE3dl6vX6KLOVyrbuoucklkrl5lYCHbsyXEpUU
 aSrWCaVc+j5cgXmUiSrwohQE3/x2CJnMi2OOtu4thFXyXJTrdDNZaKWrY2mo0P+xiU
 diKG1JVr8J7lQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/8] 64-bit data integrity field support
Date: Thu,  3 Mar 2022 12:13:04 -0800
Message-Id: <20220303201312.3255347-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_121319_932796_F9143970 
X-CRM114-Status: GOOD (  14.68  )
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

The NVM Express protocol added enhancements to the data integrity field
formats beyond the T10 defined protection information. A detailed
description of the new formats can be found in the NVMe's NVM Command
Set Specification, section 5.2, available at:

  https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf

This series implements one possible new format: the CRC64 guard with
48-bit reference tags. This does not add support for the variable
"storage tag" field, or any potential hardware acceleration.

Changes since v3:

  - Replaced lower_48_bits() macro with inline function, and replaced
    0xffffffffffffull with the equivalent (1ull << 48) - 1

  - Replaced crc64 test module with new entry in crypto/testmgr.c

  - Renamed nvme_ function prefixes with ext_pi_

  - Placed bit inversion within crc64 calculation rather than rely on the
    caller to pass in an inverted initial value. This is necessary to
    update the crc value when its buffer is discontiguous, or updated in
    chunks.

  - Removed 'inline' from nvme driver's ref tag setup.

  - Added Review's for unchanged patches, removed reviews for the ones
    that changed.

  - lib/Kconfig dependency fix

  - Dropped the x86_64 PCLMULQDQ accelerated calculation. This task will
    be completed by people more experienced in this area, so expect a
    follow up soon.

Keith Busch (8):
  block: support pi with extended metadata
  nvme: allow integrity on extended metadata formats
  asm-generic: introduce be48 unaligned accessors
  linux/kernel: introduce lower_48_bits function
  lib: add rocksoft model crc64
  crypto: add rocksoft 64b crc guard tag framework
  block: add pi for nvme enhanced integrity
  nvme: add support for enhanced metadata

 block/Kconfig                   |   1 +
 block/bio-integrity.c           |   1 +
 block/t10-pi.c                  | 198 +++++++++++++++++++++++++++++++-
 crypto/Kconfig                  |   5 +
 crypto/Makefile                 |   1 +
 crypto/crc64_rocksoft_generic.c |  89 ++++++++++++++
 crypto/testmgr.c                |   7 ++
 crypto/testmgr.h                |  15 +++
 drivers/nvme/host/core.c        | 165 +++++++++++++++++++++-----
 drivers/nvme/host/nvme.h        |   4 +-
 include/asm-generic/unaligned.h |  26 +++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   7 ++
 include/linux/kernel.h          |   9 ++
 include/linux/nvme.h            |  53 ++++++++-
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig                     |   9 ++
 lib/Makefile                    |   1 +
 lib/crc64-rocksoft.c            | 129 +++++++++++++++++++++
 lib/crc64.c                     |  28 +++++
 lib/gen_crc64table.c            |  51 ++++++--
 21 files changed, 773 insertions(+), 47 deletions(-)
 create mode 100644 crypto/crc64_rocksoft_generic.c
 create mode 100644 lib/crc64-rocksoft.c

-- 
2.25.4


