Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D40CCD184
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SN1deIXNZW5bvtN65BpG//HqL2G8KaJftXgKpSOFfGA=; b=nGP0/ne7D3gKreKeRYQV7MplEm
	XB9O3fLDh+hcbhXietOqjtR7iOwoIqj7XXMAXN0y40R8hioOit5xw+X7iK3af7aiGEAsN+LCv3cvd
	qqLQG5G9OFWKO9injNAtHYizEEJ/t8A1FgB+Njl4yBOIm5l9s5BF6BQ+ivnMi5NWd6lHciO7oN1uV
	XWyMZd+fkS3h16JytTz0ltI5x46lvm+2WHiOUfKStJJ4dV2LLVw6ddn1KdPviV1oZSVV1XX4J0mLP
	lRJUXDGU9KqwfMYjQcoGI6nh9aH1NWHpxJBrrB6CGnxFwIW3/H6lY/b0K6A7W0xXSGwAUYLJCL+Rd
	u0GU44Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6tu5-00000006juB-1NY3;
	Thu, 09 Oct 2025 16:54:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6tu3-00000006jtd-0Sul
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Oct 2025 16:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=SN1deIXNZW5bvtN65BpG//HqL2G8KaJftXgKpSOFfGA=; b=EuWQYfKWN22p+qnCH5EbVBvMjt
	ODYDvN/EVgj8T6/MyhSXk+6y3PkH8SEHuJ3wve0oRFOO0+9CtmbtkP/iTJKUKMDVFRdZ3+G0vjQSU
	/+YV2SH/XuPcmhgZPZF7Lden3GGAUw8f+nx9udF+Y42XJCiQTHAAEzgeEfiPVfyIYL300FWhwRpOl
	dGNExVPxj8D+2MiTMJYYtDqKLFSJ2ji1P6niqY/JNipLNz8ePKJfd8i/rsZ2jJTywL/Bn3KIsocCU
	I4zUufGvxrWEe9JR5EG1ZeKSc9v/lz9+IVSF97sfb7rp1r7fjYrGPAdyGWppxd7LMrA0ZR7ISus6x
	g1L/Cj6A==;
Received: from phd-imap.ethz.ch ([129.132.80.51])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ttz-00000001Zwc-3yyi
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 16:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
	s=2023; t=1760028314;
	bh=SN1deIXNZW5bvtN65BpG//HqL2G8KaJftXgKpSOFfGA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZBwmUczs+pNjhvT6l2iTN2VpV3UuoawA9eEGuLf85mfKTAYx/18fM/r/GK4/V3pxJ
	 i7V+Du3fyH1p1My26edWv8lbDkyD7279IecIB+mx6xccDBpciu4OzGRYNriWgGxA9F
	 jBto4vKUMEbjttBDQqeO2L5yYGKvvBYsMAwkRKBgzvK+y+b5BgFO1ojY2oDzbFwJmC
	 Qg9423h0DPH0sZ3yml7rAbdZZcrruU82tCS/BAsGfi1TFO7XBvQdln2wfyqDMsKDpi
	 WZ2AKcBrNpCVP/eoYzBqpXQxQNAPDdSOq/BK9UGqOmyZVa25vV4VgUs4D5gdon45je
	 yVv/xrtm2rrtQ==
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
	by phd-imap.ethz.ch (Postfix) with ESMTP id 4cjG2L2dq7z9H;
	Thu,  9 Oct 2025 18:45:14 +0200 (CEST)
X-Virus-Scanned: Debian amavis at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
 by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavis, port 10024)
 with LMTP id bz1po6tzWrFu; Thu,  9 Oct 2025 18:45:14 +0200 (CEST)
Received: from dumbledore.ethz.ch (dumbledore.ethz.ch [192.33.96.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by phd-mxin.ethz.ch (Postfix) with ESMTPS id 4cjG2L1rZTz7Y;
	Thu,  9 Oct 2025 18:45:14 +0200 (CEST)
Received: by dumbledore.ethz.ch (Postfix, from userid 13394)
	id 4cjG2L1Js7z9srq; Thu,  9 Oct 2025 18:45:14 +0200 (CEST)
From: =?UTF-8?q?Stephan=20M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
To: linux-nvme@lists.infradead.org
Cc: =?UTF-8?q?Stephan=20M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
Subject: [PATCH 0/2] Fix usage of configshell-fb module
Date: Thu,  9 Oct 2025 18:45:02 +0200
Message-Id: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_175404_107818_44522FFA 
X-CRM114-Status: GOOD (  10.77  )
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

Hello

These patches are necessary on Debian 13 with configshell v.2.0.0.
Calls to "configshell_fb.node.ConfigNode" are no longer possible, when
importing "configshell_fb".

1. From configshell-fb v2.0.0 on, the module is actually named
configshell. This already fixes the Debian issue and also works on
Debian 12 with configshell-fb v1.2.8.

2. They now explicitly export module symbols, so we should use
those instead of referring to file names. This is more cosmetic
thing.

  Have a nice day
  stephan

Stephan Müller (2):
  Use preferred module name
  Use exported configshell symbols

 nvmetcli | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.39.5


