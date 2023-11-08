Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E41CC4167D
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YJF6K6/IaG9+SbnQpwgXy06uRn/GOxH52PDwxV4cN4A=; b=NUnEPY5g8K46XmD1wgYvBWmWnl
	b2W0VERD4nhdzAv10CrhaR0YBC4vJUSsKx6ggev5VH4poRQGrV9QiFcFPe+aMSit8bMfqClOuyIeK
	JIhMhJkX9Ok/bCFsvZkSMhYShr1K3UGqAGbCnWVW6t0ATnklRTaMnY0hYab24QrtGyBx4VFdZrSK3
	B2qMKb7HReZKgc8LX1EU8nEI0N2Rq4ZmmBiRzrc4F8+7W0L5c2zfPtbF2WWi7raWbWkxxi9WF0GdD
	MYiNZEjbURr3b16g9t9O/uvo7+OivhEfWLxWHv31RL3dlehPYMJv928TNao3zlTVEvlR0D7xyOfOf
	1dzw5Z0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0cMA-0036vZ-1b;
	Wed, 08 Nov 2023 06:48:06 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0cM4-0036tB-29
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 06:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699426081; x=1730962081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AuLEQId7sKW9FEIAlwUYpzGQPwGNoby4mB8sQwyNPIY=;
  b=oYtxWQPxBAijN4Q/TAbVihzJPN30gd8qjI8hW1/KcZ6XbxV7+o/iOTf6
   HUhOnY98TxY+d34MfE0/Xda+DPmxiLgTUtDhV3LwWsT4BQoiH3mnH49cK
   0lkLW5qQBcsfdlG1ZGbzXAGNNqLAMh2+fa+aIzCw7hzGIzLYJVIuwGP9R
   TlQYgkgb/lFq/ye+PpV4JuGF578o3BaZ6+1lqyxaPwYynMk6VyseeE74I
   tbbt+3ltCxE0RtVB3TlZyF/C3wrjb+K1tb+2PelxVeNR+8NFV+y8Hm/G6
   6z7Hp/nw70JWUX+l8Tgl9oOeKkaUSaaiBq2PM9nlSRhT0U21Fck0VxEZl
   w==;
X-CSE-ConnectionGUID: 6A4S27u6TlGgLiOwBZRERg==
X-CSE-MsgGUID: FRMyU2CURlGYWYC+47X03A==
X-IronPort-AV: E=Sophos;i="6.03,285,1694707200"; 
   d="scan'208";a="1703146"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2023 14:47:55 +0800
IronPort-SDR: LGlTrX6cMzoT35cY4NAbko/3gcrQs/2lrGj6EiHOzruikk756fPK2kdWMSjmaljeWah/qM8jyV
 bONWAdRa6uLSOFPL0RvYnbjKxNTNPOdcyUtxoeCDEcD7ZTixkcOPEbNpUcybBKQc1sK/icFOOo
 fEUBNHoertDLENpkzkxPhciLqyL1bMA3JDMfSBh6GYMO+4b2EyTJZudGHm3/EDmXHNv2IUCL0v
 pXZbShK/xMIW5R4bHTACfhLiE/xxRWvt8wFKg7c6aQikj6wEVvcMGNQaHeYivSKagc6c/DHKi2
 ti0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 21:53:50 -0800
IronPort-SDR: 0fmUHDIK2utaiN/GvvQNaqUEXgo6Y94hM6jLmRgIsZ+BEqSHkM+O6PWzQW4yhxjQVgiBHd8O0F
 1kpOch6J0nLKnBgoAW22IzpTu+4OqkpnlaZr9OAiADWG4sqiGRfNtBb6NHFL68LLfIHF5tzCBW
 1YRTCuqCXt8EqzlCNAXDF/oE7rwyLnsvdjkG2zDEkPfqvNrSuTyQml7nV993etwyH8+TdYWkjR
 kr0X5F7vyb9EEzAaRt2SU1c/GGP7xsbWOf3A5jqU2NZ8FWkJ6A+m8pHeS+oqpXjJ5jrxakY7i0
 8jE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2023 22:47:54 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: Allow for pre-defined UUID and subsystem NQN
Date: Wed,  8 Nov 2023 15:47:51 +0900
Message-ID: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_224800_708414_6B44E2E8 
X-CRM114-Status: GOOD (  10.87  )
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

In the discussion to run nvme test group with real RDMA hardware, Hannes pointed
out that pre-defined UUID and subsystem NQN will be obstacles. To address them,
he created two patches in a PR [1]. I post the patches here for review by linux-
nvme and linux-block members.

[1] https://github.com/osandov/blktests/pull/127

Hannes Reinecke (2):
  nvme: do not print UUID to log files
  nvme: do not print subsystem NQN to stdout

 tests/nvme/003.out |  1 -
 tests/nvme/004     |  3 +--
 tests/nvme/004.out |  3 ---
 tests/nvme/008     |  3 +--
 tests/nvme/008.out |  3 ---
 tests/nvme/009     |  3 +--
 tests/nvme/009.out |  3 ---
 tests/nvme/010     |  3 +--
 tests/nvme/010.out |  3 ---
 tests/nvme/011     |  3 +--
 tests/nvme/011.out |  3 ---
 tests/nvme/012     |  3 +--
 tests/nvme/012.out |  3 ---
 tests/nvme/013     |  3 +--
 tests/nvme/013.out |  3 ---
 tests/nvme/014     |  3 +--
 tests/nvme/014.out |  3 ---
 tests/nvme/015     |  3 +--
 tests/nvme/015.out |  3 ---
 tests/nvme/018     |  3 +--
 tests/nvme/018.out |  3 ---
 tests/nvme/019     |  3 +--
 tests/nvme/019.out |  3 ---
 tests/nvme/020     |  3 +--
 tests/nvme/020.out |  3 ---
 tests/nvme/021     |  5 ++---
 tests/nvme/021.out |  2 --
 tests/nvme/022     |  5 ++---
 tests/nvme/022.out |  2 --
 tests/nvme/023     |  5 ++---
 tests/nvme/023.out |  2 --
 tests/nvme/024     |  5 ++---
 tests/nvme/024.out |  2 --
 tests/nvme/025     |  5 ++---
 tests/nvme/025.out |  2 --
 tests/nvme/026     |  5 ++---
 tests/nvme/026.out |  2 --
 tests/nvme/027     |  5 ++---
 tests/nvme/027.out |  2 --
 tests/nvme/028     |  5 ++---
 tests/nvme/028.out |  2 --
 tests/nvme/029     |  5 ++---
 tests/nvme/029.out |  2 --
 tests/nvme/031     |  2 +-
 tests/nvme/033.out |  1 -
 tests/nvme/034.out |  1 -
 tests/nvme/035.out |  1 -
 tests/nvme/036.out |  1 -
 tests/nvme/037     |  2 +-
 tests/nvme/041.out |  2 --
 tests/nvme/042.out |  7 -------
 tests/nvme/043.out |  8 --------
 tests/nvme/044.out |  4 ----
 tests/nvme/045.out |  1 -
 tests/nvme/047     |  4 ++--
 tests/nvme/048.out |  1 -
 tests/nvme/rc      | 26 +++++++++++++++++++++++++-
 57 files changed, 59 insertions(+), 138 deletions(-)

-- 
2.41.0


