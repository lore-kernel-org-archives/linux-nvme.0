Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A5C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 04:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q274hdt+3lzJQxl611FpL7GitXNb6dClZwbIcVgOXF4=; b=B6ZiDw9KOCbnaa+OJXehSFpQLh
	RTKfA6fw/20Vtm/Rh8+6Qihw28bLaW+o/3DI1DdwmHavChdFesCGktv1OQiU//CEl8B8sMfDJaGvL
	Bvwxf04TfOwdVEwgPwECYvSsWXRd7qeIvz4pTfG0WqSV95LqR5LwiSq7jBJ7WhQHxIUZ6Q9Zv+sIP
	Fw7FwST/D55wWK6THCmztB42l+AT/yrsCjbXjMTG94UE0TSDLFXybnJNYKafNUdU2/EKObyMGLWEr
	Fvlcj1oQ9Ao3FSc4JbUjid0D/NI6cm9QC1ktaI9qMPfnf06hxJfLDz9W8HI1zW2vLzXTTCF+R3Vw7
	HS8iCRKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXQ-0012hy-2U;
	Fri, 26 May 2023 04:58:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXN-0012fW-1b
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 04:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077129; x=1716613129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dw+3ft0rCDmodyiA8tBIGwgNNkITfIvh+8gj5H6vxL0=;
  b=hHMHZvcx00hu6iYdowLV2L5I2MKPzVQsysuI8iEjTKWfGaT/PvIC3C0Y
   oUYuKEML1yqri+/J8ZUg/XN3jeY95Rehtdfv59TLfppUx17J0DL+JfKVG
   XoJqzXh0jjTCSGwgx2wIRHoyvzVnYZ8QfGB7wjmkxMjIZFf9QxLdSlTJU
   bpXCDsD//WpZ1mm38eIJ5HYrpNV7Hh/bSQVv9XrV8kyugiICGsC+CLVaD
   CA/B60P7A5OodHPPAMu67T+HDVebcmBWbKbAkB0Ll5xDw53CWcP0h9ily
   BhTwnN2hRVW6KbBf6ckjKkFYLZZqwLzKFPisLIo0bhaUzhv+jlqcOUXrG
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231705014"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:44 +0800
IronPort-SDR: ZwPGODegygfD+hVQhmXCjFrp7jF9zftyzMqVm/9gmyTjTn7q5y7OqmyE1BKmHSLCKpfO30meWL
 Y87pW1kJGVTJ4dMTNAYH2/EOcRy3nh1BvMXhCJPp9/9gVuRFLnCgdvD3ojrk+90MQJDoZWb0ze
 YNKQNg/rTMIvQy4DGmgRde92jLirmH+x7E0wrGtI1yMttMp0PmOpY8XrQQLQZQ2amb24Xy98dd
 6Wo4NoqxxCdLOYvSdaDnwQFzToQ4wv9hZj+LBTl8+/16q7IPqxqj56lfEpviqOJMWFtx7RLswc
 1zs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:02 -0700
IronPort-SDR: sCsLGdU81bSulGE46siMQbYwICT92ilrxqWluoKYjBkv0bbeUmjb44FFNexCKHVdHOKtncbl0V
 pVMgCPvokU/RMIqQ+Vp+v3AjfyLVX0wUBMkEbggLCAW+K3sJkuLgOyBlZYSSanTwcU8qY3Vc6J
 HlmrCeNsHZdEHLmC0uL1C+DhoxlbZ2xuE1kQLoq6bmD4Gzw76D/cPjacQRlrBlHJURZpmYOdDx
 tRgd/9pJu88wKw0ICc1ikrQEW7JazH/dnqd86tkZXT9aVNyJm6oFIwD+lulmL5AzaQa61G0e8Y
 /VQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:44 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] improve block/011
Date: Fri, 26 May 2023 13:58:40 +0900
Message-Id: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_215849_627447_24AC2480 
X-CRM114-Status: GOOD (  10.17  )
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

As of today, three failure symptoms are observed with block/011 [1]. This series
addresses two of them. The first two patches address the disappearing system
disk (Symptom C in [1]). The third patch addresses the zero capacity NVME
devices. (Symptom B in [1]).

[1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

Shin'ichiro Kawasaki (3):
  common/rc: introduce _get_pci_from_dev_sysfs
  block/011: skip when mounted block devices are affected
  block/011: recover test target NVME device capacity

 common/rc       |  8 ++++++--
 tests/block/011 | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.40.1


