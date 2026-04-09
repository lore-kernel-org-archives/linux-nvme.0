Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5718DE9DE6C
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bB2Pq1eOLxCLI7nRjWKzens22kHSoMzRDRlyYpFHb1s=; b=GRD4emckrkJIRG
	1yvljRT/LLYiaJAD7+n3t9VvI2QNxEj9b0cWuIh4z7aMfTGSQh3PqCwTtSDd5+zQ9sgQSzi5XXOtG
	TAfKOje27TsMwlYdjH4ErH2M69YzRHAuaYI8sC2WPvEuzCqik6D2YZ0Dd3sf69dm4mhD+JIQ9ttYF
	OgsF3zxobAdRgOr7D6cnj0B35yBgvbNiPmGEpx3heAo0oXhUbBK+MW8WgB0OzTD6f8vSJF90H6HiI
	i+NJ8hg4nAvvLDZYPhMlRHefAv2UkiLy+uEnsz1eqV+YHX3aBRmuia/rdLbnGCPCoVbeRLV1q/QFO
	v7pVgTnFsSu2No5CHQLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAl2H-00000009yDn-1fdD;
	Thu, 09 Apr 2026 08:46:49 +0000
Received: from out28-68.mail.aliyun.com ([115.124.28.68])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAl2D-00000009yCn-3iCh
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 08:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1775724400; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=bB2Pq1eOLxCLI7nRjWKzens22kHSoMzRDRlyYpFHb1s=;
	b=TvoIZRGFhacLclYBYjEwcYQTYvY+DFAeD1kWJZdamKb8319dEi2rkXTU9b188qv0sRnANbJHwEX/tLu2xKPqLnNDDzdPylE6OkXqz24SCLl6VHkGNkHQXSyujRiTYn3uUvb/96uCH+JVRhOOcoV31xdzC4pM9MXzn4PflnaeZBCu6l4I30JgV4h4fmXI07E9M3Zcf2RARgIt7k32aGiOft2Hyj0SpcD9hrkFF7Y+EbWYMzpKlUjxFCQYghXjsB5ZLs+CNl5JkecFhjJNZrV52ZzeF8roaHau2KxpaKxIfJ+sAdcT8NG8ak0647ETPIoUy217FWQM9/khBntzsCZV0g==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2943183|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.012911-0.000131782-0.986957;FP=6357492757479346486|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=me@alancui.cc;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.h8By4l2_1775724397;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.h8By4l2_1775724397 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 16:46:38 +0800
From: AlanCui4080 <me@alancui.cc>
To: linux-nvme@lists.infradead.org
Subject: Non-SGL transport mode warnings are set to dev_warn_once will cause confusion
Date: Thu, 09 Apr 2026 16:46:37 +0800
Message-ID: <4770779.LvFx2qVVIh@alanarchdesktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_014646_112912_0F817CC8 
X-CRM114-Status: UNSURE (   6.51  )
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

Hi,

[   49.108397] nvme nvme0: using unchecked data buffer

See 6fad84a (nvme-pci: use sgls for all user requests if possible). In the 
kernel, those warnings are printed using `dev warn once`. This means that if 
multiple devices in the system do not support SGLs (most consumer-grade 
devices do not support them), only one warning for only one device will be 
printed.

This asymmetry can be misleading to users. If all devices in the system report 
the same issue, it might not be a problem, but if only one device reports it, 
it might (especially since I have two identical drives). Is it possible to 
move this warning to the device initialization phase so print it for each 
device? Or, since we cannot resolve the issue of consumer-grade devices not 
supporting SGL, should it be downgraded to an informational warning?

Alan.




