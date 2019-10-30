Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7ACA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1385020717
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="crEW7ovs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O1BJxm2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QmDRNS0LBgkevgCijCT+Ks9Flpby2bgdS/a7+3ALqvs=; b=crEW7ovsdckspF
	Alz04bHEzI1NV8vsYDox83JiATUAqDHby9H3ph4mfVQ1uuhJZ81jwV6EK9b1ISv46yvsgvI+olu0G
	A2Jpr6/REz+v1etP0373web0d9hi6LU6Sj9wHtoYA8fTSeOLKD3zKoZAH8MCz6WziCsxXCk2yoe41
	hQqvMm2npCM879xHF1wEUKDKKz9RZbnUxIH6zR6wGn0asDcUo43Jk6VnR8IEw8bX0D9NBnf3+osAs
	+aM9jRSxYbEDvGLz/wBXi3lr8zOxdxfDoymb8HAkgjthAn8ph6do0icKlEKUtVDzwd7ESmtxc5YPv
	vr/a3dEnHokz9wWGaRXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPu1r-0001nN-2g; Wed, 30 Oct 2019 19:53:15 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPu1h-0001fv-Oe
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 19:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572465185; x=1604001185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7W8UQyH9VKozvCDdJfCBpq1x6IqZopmBHKyNCZoGU6E=;
 b=O1BJxm2AJmnQ83dUzuEeVJbE/fPaO/4nwI78IhrZsKfSa90lZP5c22b2
 iQf4FtxS8UASR3yVSxMU8VYEm6YLL1sv1Kvng1+9N0kMg4xpIWZuh8TbG
 SVVFhBvf7HTV8pjmrbJrT6BdJvK7Ud3T3TRR2Saj/uTorr2jqu4WJifpO
 YRp1MfXEjXXJYC1QrB84qyD96iPjZ9/dQreWOA4HbsGQFtUEO7XS2KBQJ
 D26pSuP3qzQLAJn6Ruw6V0hUrHrtVHzwv6d9/pFoc2G4lfzMJAI43djDw
 NlKzAWAqarS3w0Ode6liG+LV280Lqp5UveoWpcDm02O16A/QbmpHytP2+ Q==;
IronPort-SDR: dQTWW4+2mx4koh/Z5Oj09j1s9SvBslVHPiqJqSvaTlwsKfPCONZr4pA09wvD0gvHjrZwaZmUOQ
 kSFZUkT3cae9ECojRjSiuPMGQ1vdb0k3+OEQIA5J6qZ9z6/SdvEbaZQs+Nw4VEQ3tWooc/kSoB
 zT697G74PmGzEN3z509sJLEoykunQY7+HRHgX6vjc6pHps46YrHy5fbb9aMgxxIU2/tHEoruYY
 fYTEStOZHayp+dONZorsacwW5mmVKsMwDOYtUevXE0VgrTy+mpAJFAlTAVAUzyT2odCZzKAJA7
 HHo=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; d="scan'208";a="121731710"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 03:53:04 +0800
IronPort-SDR: q6b8Nfxlb4z4oAWNft9nVEbqPahiG/RIom9t7eHBejR0avs3R8aYw9WoFcvS4I8o3jjg8vK8sZ
 7YdoJDZYBm8XNunzPR1Yb7p3nTOSgGiT9pTyCX8wyMXEtHh76VbL1/l0A+pi5BBO0yv1rx0XuU
 vP+cba3WffvBCV+tOvC2TEg/+80ZiC37cwNrmBJefeAdf3e6kkGR0w3BK9v+lRVLzS8pD1ezdh
 bMKBCJTer4PcH03+5hqIMzFsX4EdDYrbql9MJNzvban+S/00hI/K6na8Q9B14OwCoIT6/QHDY8
 9Eh0FFTaHSKkX13OuZXeZQIh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 12:48:27 -0700
IronPort-SDR: ycSuKK3J0jDjgYw8W0XWpmrdY7HzS8Lls+QUuuV7fIgEUpyTGqYNR9vNtsF5AdiR4y5ZnjB8GC
 zESwco+E10/WUhhH0O6JR2cWTfvyH8/rKNETBQn7vLREfp/tv0yWqaJnRLv66tgYYp+rx3Kkbu
 ELUu8oyXkpEZG1EycgFjIgzC3kGkD8MtPYUrmH/hdI7k9e0MK653uVpwYnPR/cYA6ieomVZiFd
 W+sFA8pNBza7efbeeZqlJU2Ouh/8DcfLvw+OfqQTrQKzvYuYwfgyu+EdEf1cGojUTvsvcTmpIp
 hKc=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2019 12:53:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [blktests PATCH 1/2] nvme: handle model attr in subsys create helper
Date: Wed, 30 Oct 2019 12:52:57 -0700
Message-Id: <20191030195258.31108-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
References: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_125305_838021_DE3CE7D2 
X-CRM114-Status: UNSURE (   8.23  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch allows _create_nvmet_subsystem to handle and optionally
set model attribute for the subsys.
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413..2d11e2e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -121,10 +121,14 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local model=$4
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
+	if [ -f "${cfs_path}/attr_model" ] && [ ! -z ${model+x} ]; then
+		echo -n ${model} > "${cfs_path}/attr_model"
+	fi
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
