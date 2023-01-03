Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6EAC4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:Content-Type
	:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5bTeRA7Wa+rMuUkDwEr19koGJ9Y1JZKX6IAbWnhONOs=; b=Erbz3Sh+HXk+fyEzpGTcXAsh4Q
	NcvLbUvv3CO33/4k2M1XH0U4bNWJn/f3EI3ZG5+qm4bc1sjB+MjOVlQPMErNAotCPPIJhsuSyD1zf
	6mJT1chAHz3xnYoRtwQGbbMSmOo5I/DzuI9ZmIoogoCAHTtw8m0xkluLPprcLJHl4PL7TMS77k8+u
	hw9Oif4dtK3MRf2tLffMbWzcfTsWekPiiyCdBKmNAZ7L3R1t9mqqLCka+ZaIus5W1VPep2BXtWe4h
	+DdLezd4JrbTUxMTuYCo5ByiwuuL5QElOv9Gjdclvx8qO6oKNN5z1Z+Qvbvl8u3q/CrUnm3Y+AoS2
	pIkC81Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnQL-004cCo-Km; Tue, 03 Jan 2023 19:58:13 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCkfw-003CRi-ET
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 17:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5bTeRA7Wa+rMuUkDwEr19koGJ9Y1JZKX6IAbWnhONOs=; b=buzyU+DwrFY83OetkEiJnc7Crf
	mtPoJtIdVVFzS2cfv8+wM9EJlpeUzfzzHblOsLlKZEpfXdqa5y4oJCWH7XOEipAZ41u2Am0NJyTck
	wE2q63qzPDE2AWatqJUD72A8Bw+t0qATOjfQLIOUYKqVLua1hOthLYUB4PERuZ3TYQ/HniKWkHZAO
	2+jeydnaCQ20LTpHLinIKyP18Hqee/AWWDK4gk7iIZ9XuGpfASHWEh0UtPrCoeZ85wK2ikMBDFNYa
	XmJVsnHVCiB83ajJ/oRXOpyxSiS/7OalPMeRikQYDHCi8mo7jge1yPQmcqPguNSA+gOypv6hLR0VQ
	GZnahUBQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51294 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1pCkft-0005dK-US; Tue, 03 Jan 2023 17:02:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1pCkft-004hzL-0Q; Tue, 03 Jan 2023 17:02:05 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	 Keith Busch <kbusch@kernel.org>,
	 Jens Axboe <axboe@fb.com>,
	 Christoph Hellwig <hch@lst.de>,
	 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	 linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
Date: Tue, 03 Jan 2023 17:02:05 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_090213_852460_F175488D 
X-CRM114-Status: UNSURE (   9.98  )
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

The nvme patterns detect all include files starting with nvme, which
also picks up the nvmem subsystem header files. Fix this by excluding
the nvmem subsystem header files from the nvme subsystem entry.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cccd40d7801..64cc6947099e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14711,6 +14711,7 @@ T:	git://git.infradead.org/nvme.git
 F:	drivers/nvme/host/
 F:	drivers/nvme/common/
 F:	include/linux/nvme*
+X:	include/linux/nvmem*
 F:	include/uapi/linux/nvme_ioctl.h
 
 NVM EXPRESS FABRICS AUTHENTICATION
-- 
2.30.2


