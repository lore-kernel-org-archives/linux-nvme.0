Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351FC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:41:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D8164E29
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D8164E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tw2cq6n/Qn9r4roC5/J01Hav6dKKW0MhQe6xG6/JQvc=; b=bRwHQ+Zq0TZeUK09MSpmX7TwqD
	2iEbfmcV12pQ1wLzuvwpSIBqxMTwWwV7euwe09YgoAG5qoxPeQsTXh9BMryaL8gp446zdf7BGt3kE
	3lwy65XcK1btqMeotU2HMZlertx8y9HqVq/Pgah8QIZaavzmVWMVc5c891UdQCRJFR/nJMlliUT2/
	C75r/2xie0zMrRZMfAQ3duFjrzVdU23timQ9QgmEhzd1W9jLQ0FVt30CWXUmczf4jM2rEXB0dgRvK
	zrNVm/oLqRLsJZqgXWQ1KCpngdB3qGJY1p7ZF209sP/mEscN7lfVM6r1RmGIR2tWURsfogDTt56lk
	37lI+NZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6RyC-0004nU-3k; Mon, 01 Feb 2021 05:41:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Ry7-0004mt-1X
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158107; x=1643694107;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zWmjixSECJnn3dZ/9jG2y8sRBNLVyu73H0R6WkM6m0I=;
 b=qMyJ4tQwBQyfKCrvbeZ+lYAvslb2H9ezVj9bcpqyFGGGu9DwjIsAjDjv
 jgj5Imm9Pxto0woo7rzNkg3HwZWgjpMIXbGGqAoW2rWzg1jS9tkt1jsPK
 WAD5h+/577NVNUBw5YMbUnNGrMORjAYggRI25yIGki/31fBaqKGKVoS8w
 NsYs7/4788hf4DWcxHBcOBJrc6yycY0DdYv+FLDXgn4yBvm9raocDNySm
 PkjJjnjHwEOvTxibt4Wqx3OhpmhjFlmH0dnWFr43gETVQN5vXVeGk04u8
 9iNoNYgold5P5LZCQJRW1H0CABMFEpr0b/w9GERmPraUuAXylBhQoWZjH g==;
IronPort-SDR: 2KyvzSHmWBD/yYICuso3vy9YbyXQCNt+eQQRlYT7pQLM8TQwna+7AM/i77GzNm804DdeEpCY1P
 cucxsr2rR6NwOdiWA3+g0WWUpipCTJptzxtx0o+sdaZOq7eQLrL+Yfff/YpLmgKsSdVPUlJZKy
 P0/BOG7JIEQP4DMyoHoka7I+7estFphR9tTIqn/0o8y5rcHiwm2qP2D45UgzBp1XkUUMuv8Y6B
 Jp8xUosnGiVzQ99r5+tOy2HzEpgmVCOKN4NcXrkthnj5e2r3yQUbqDN3vTHp34sfh+aNfw8kgy
 crs=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="159967680"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:41:44 +0800
IronPort-SDR: TS6Pj8kR3Z3839yO1kClPSBKJmrmOFZzI23tbYUGvp3YKQrD9t3miUnGZBNueF3gdEgryzzKaY
 sU2NILjJ5Iz3Z0a8pHTmh8YeAOcsMSQFvt6dgRr2QUTU1t2faint70epxHVKmv0+gZaPP/hu2O
 adTw+STmvM6dbDAmufFSMQiUTJ0zHs1GzFxtxuFhDl702UqEkTzuf2nwcKcyOqwBnkRm7Dsg8z
 gXcrVO0tQ4G2Kz+1ON17CE/7trOB8WxfUcIpR2XKzZ9IlnHCPJDtX55IT4o+CuPEd/lPuHoZ6w
 8gIq4oznSI0jGX9VWd+ZdUjz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:25:58 -0800
IronPort-SDR: /2cGcGZEoBC8I9KQyronysZpgHf6yFI9iEe9RCeJeGlTvQ089Xyp2neQdmlxyvAu5o1GBmTB8l
 +doNQhk9WhHsghgTx/y0CWaOsv7uyz3GRcPkZivQJx9a8IhcGvrWeIr+RZ+mj2ZwfMGgVhh7IU
 pCWItgzcSTHQkcL/S8Vk/8De2D7LxfKGI8KQraVKeXK4gmLlHOm4yOnQ2dfbC3SHFQoPKJ7Fqo
 JpdmIE0gtyOYsZLaAlnzIjbpRshYe3rMUgXfKzYBlYhUrff/bagREhvzAY4l6x1dOEf9emuJGf
 Uv4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:41:45 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 00/10] nvmet: fixes and some cleanups
Date: Sun, 31 Jan 2021 21:41:28 -0800
Message-Id: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004147_339549_BF153FB8 
X-CRM114-Status: GOOD (  14.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch-series fixes behavior for id-ns that is against the spec and
does cleanup for nvmet_find_namespace() to get rid of the duplicate code
and remove the inconsistent error behavior of the host, Also this adds
an helper for unhandled commands to have uniform error message
reporting for the bdev, file and passthru backend. Last two patches
fix compilation warnings.

This is based on nvme-5.12. All the blktests are seem to pass on this
series.                

-ck

Chaitanya Kulkarni (10):
  nvmet: zeroout id-ns buffer for invalid nsid
  nvmet: return uniform error for invalid ns
  nvmet: set error in nvmet_find_namespace()
  nvmet: remove nsid param from nvmet_find_namespace()
  nvmet: remove extra variable in is-ns handler
  nvmet: add helper to report invalid opcode
  nvmet: use invalid cmd opcode helper
  nvmet: use invalid cmd opcode helper
  nvmet: use min of device_path and disk len
  nvme-loop: rename variable to get rid of the warn

 drivers/nvme/target/admin-cmd.c   | 63 +++++++++++++++----------------
 drivers/nvme/target/core.c        | 23 +++++------
 drivers/nvme/target/io-cmd-bdev.c |  5 +--
 drivers/nvme/target/io-cmd-file.c |  5 +--
 drivers/nvme/target/loop.c        |  2 +-
 drivers/nvme/target/nvmet.h       | 22 ++++++++++-
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/trace.h       |  4 +-
 8 files changed, 70 insertions(+), 56 deletions(-)

# gitlog -11
6eb10edb698e (HEAD -> nvme-5.12) nvme-loop: rename variable to get rid of the warn
d94df0995f71 nvmet: use min of device_path and disk len
a98b4f9e46e0 nvmet: use invalid cmd opcode helper
a3ca782d82e5 nvmet: use invalid cmd opcode helper
102c6698b403 nvmet: add helper to report invalid opcode
eed0b3baae83 nvmet: remove extra variable in is-ns handler
4b47817fab94 nvmet: remove nsid param from nvmet_find_namespace()
68a97104491a nvmet: set error in nvmet_find_namespace()
e4079ffeb06e nvmet: return uniform error for invalid ns
5102bfe49832 nvmet: zeroout id-ns buffer for invalid nsid
ab9dbdb20926 (origin/nvme-5.12) nvme-tcp: use cancel tagset helper for tear down

blktests (master) # ./check tests/nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  26.465s  ...  25.746s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.135s  ...  10.134s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.677s  ...  1.708s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.120s  ...  0.115s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.071s  ...  0.069s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.691s  ...  1.693s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.667s  ...  1.648s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  26.581s  ...  32.500s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  274.955s  ...  256.070s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  45.972s  ...  39.458s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  274.262s  ...  285.493s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.649s  ...  20.740s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  19.500s  ...  18.742s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  14.570s  ...  14.262s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.831s  ...  14.774s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.646s  ...  1.654s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.689s  ...  1.708s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.638s  ...  1.651s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.659s  ...  1.685s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.089s  ...  2.078s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.670s  ...  1.680s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.640s  ...  1.644s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.646s  ...  1.655s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.654s  ...  1.637s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.722s  ...  1.655s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.641s  ...  1.679s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.999s  ...  2.016s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.305s  ...  0.290s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.488s  ...  5.596s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.043s  ...  0.043s

Tracing test :-

nvmet_req_init: nvmet1: qid=0, cmdid=2, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_admin_identify, cns=3, ctrlid=0)
nvmet_req_init: nvmet1: qid=0, cmdid=3, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_admin_identify, cns=0, ctrlid=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=10, cmdid=81, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=0, len=0, ctrl=0x0, dsmgmt=0, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=10, cmdid=82, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=1, len=0, ctrl=0x0, dsmgmt=0, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=113, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709104, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=114, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709118, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=115, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=0, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=116, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=1, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=117, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709119, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=118, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709087, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=119, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709112, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=120, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709088, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=121, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709070, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=122, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709046, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=123, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709035, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=124, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709028, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=125, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709006, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=126, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368708998, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=127, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368708996, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=113, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709001, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=114, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368708734, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=115, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=256, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=116, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=3, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=117, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=7, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=118, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=15, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=119, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=2, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=120, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=4, len=2, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=121, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=8, len=6, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=122, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=16, len=47, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=123, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=64, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=124, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368708992, len=3, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=125, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368708997, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=126, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368708999, len=1, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=127, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709002, len=3, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=113, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709007, len=20, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=114, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709029, len=5, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=115, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709036, len=9, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=116, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709047, len=8, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=117, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709056, len=13, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=118, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709071, len=15, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=119, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709089, len=14, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=120, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709105, len=6, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=121, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=5368709113, len=4, ctrl=0x8000, dsmgmt=7, reftag=0)
nvmet_req_init: nvmet1: disk=/dev/nullb0, qid=23, cmdid=122, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_cmd_read, slba=512, len=0, ctrl=0x8000, dsmgmt=7, reftag=0)
kkjkj
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
