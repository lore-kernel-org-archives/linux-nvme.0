Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C16C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wjOIpnDYV7Sx8cVEAUiMEL/d05beMTX7gDFISAMVl+k=; b=KBB4zsZw+OlsJuB8s5DljEe5vD
	zvV6QjMuVdOzasACiSwbVNTALJY0Z/ZU3PX4cQo/FjWEXqWR87r3OvcnruZWnOpTMlVVcZyV8pQT8
	p+Tb+QjlaYNKs8f8xyWb+Gop8LdB6XvQ2ajl1fdEjajWAFMQtPeNjrjtlB/yQmnwZRQLmXCZJuO+s
	QqCQfpvFxElA2KrNPG7fR6kT5jlTmW0gE7Zu/RoG/FzhuH01mRvb3Xs0zqaJqjpek2tM1DBiHiUst
	Cv3UkIwHo5e4+0r1okWj5zBlH0YroXA7qy+Xn8Jwk9gm4B9U4LmAgx6PovjrIvJcmImkhA58ECTIL
	dkV231NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9uj-00GmZY-Aq; Mon, 22 Nov 2021 14:03:21 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9uf-00GmXI-Sn
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 14:03:19 +0000
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HyTSS2BZ6z1DJd1;
 Mon, 22 Nov 2021 22:00:40 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 22:03:10 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 22:03:09 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli] huawei: set the default policy to round-robin
Date: Mon, 22 Nov 2021 22:03:08 +0800
Message-ID: <20211122140308.2245-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_060318_151787_0210767C 
X-CRM114-Status: GOOD (  10.28  )
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

add udev rules to set iopolicy for certain Huawei devices to "round-robin"

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 nvme.spec.in                                              | 4 ++++
 nvmf-autoconnect/udev-rules/71-nvmf-iopolicy-huawei.rules | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-iopolicy-huawei.rules

diff --git a/nvme.spec.in b/nvme.spec.in
index a8c4486..4fdd78b 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -38,6 +38,7 @@ make install-spec DESTDIR=%{buildroot} PREFIX=/usr
 %ghost %{_sysconfdir}/nvme/config.json
 %{_sysconfdir}/udev/rules.d/70-nvmf-autoconnect.rules
 %{_sysconfdir}/udev/rules.d/71-nvmf-iopolicy-netapp.rules
+%{_sysconfdir}/udev/rules.d/71-nvmf-iopolicy-huawei.rules
 %{_libdir}/dracut/dracut.conf.d/70-nvmf-autoconnect.conf
 %{_libdir}/systemd/system/nvmf-connect@.service
 %{_libdir}/systemd/system/nvmefc-boot-connections.service
@@ -62,6 +63,9 @@ if [ $1 -eq 1 ]; then # 1 : This package is being installed for the first time
 fi
 
 %changelog
+* Mon Nov 22 2021 chengjike <chengjike.cheng@huawei.com>
+  - Add new udev rules to set iopolicy for Huawei devices
+
 * Tue Dec 17 2019 Simon Schricker <sschricker@suse.de>
   - Add new udev rules to set iopolicy for NetApp devices
 
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-iopolicy-huawei.rules b/nvmf-autoconnect/udev-rules/71-nvmf-iopolicy-huawei.rules
new file mode 100644
index 0000000..9fe5af5
--- /dev/null
+++ b/nvmf-autoconnect/udev-rules/71-nvmf-iopolicy-huawei.rules
@@ -0,0 +1,2 @@
+# Enable round-robin for Huawei devices
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{model}=="Huawei*", ATTR{iopolicy}="round-robin"
-- 
2.21.0.windows.1


