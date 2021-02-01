Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F7C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E90B64E15
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E90B64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JJIzVrhz6i5N7FbIUON81FWEZexBQsuoshtdQ45su3o=; b=jKqfo80LxDFrodWdzzmgIqF47
	oOONnqj085fBYvL3jnS4eSkS9EXmxw4vF2630lAK9y7Sg6Je1tctsL11oRzrrXZ8BRlEbIf4mhHiu
	kifomkLn9J4X3sjqJY1Y3xjyTh1nSATyNRqCTasvp3Ohnq7OzQ3cHQ5RGDbxjaO//oqQZIXPD7O4d
	sUho2dvbhJMBmdj5XeUSqcSETwC+zPdL4Hf9KTDNq1N1Q6YqdC6VvcSVvqU2qU7VChGj1+U3q6l+y
	h1Of6qegKYi0n3ZZqwJ8kl1e613mgqxNw0cGAKueu8pGNO+8TST3iSkDIGhqSkOMGJDc7O6ERoCLE
	ZbItzFTow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Ryv-0004zy-I0; Mon, 01 Feb 2021 05:42:37 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Ryt-0004z5-Cj
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158155; x=1643694155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bg3R1rWLO35WyKYY3Buo3HOjMqzJFRMc/OIHvh8ow/w=;
 b=hDMFQk9v+k6ITBn5oNeLmtd0IOBneGMJ+Q7UYcEB+HDcsOnNvCu9LCad
 KwOzDWW8qQhG5nJznhtWMVS0xU7TH/HavQhxwmFz1C9Qa1S+MbcDse/SH
 EzK2/KiV/TU8B/immCf4CeuQ386JATWZ0vaHtQbhMy6WY/lmTg3v9qeQF
 kFe+Nek6cqnxnNRPNhtl/UMN80QrWtfP2V4mVdY2qpy3QibjPjiGdaAco
 rbWUEGiYABVQa4tAA3mIgbZXUmbS3khhtVlI/hjUyYSdTH5y0DpQGptaS
 gYodGKAQNFPYv9LVyDUYX7paEMBrRvVKtgaaMGnliGXz4+5POOfKhDB4k w==;
IronPort-SDR: 1iQJ1q+/WxuV6XVXRQ9L83Z/M3WCNtCGy28AgoBXRoggQ3jKttxcmfMEMnsB4kE0GJEVFCczM6
 B8H+kTv/5M5fZFu0NDmpsZJxvkinYGU1djYdYB0ibSORCNG4h4wpRSowz0R32oIPpO78FU98Jw
 wz7Pt3u4+tbzwaWNS0MOrOwe7WDteMYSpmzFcZbbkVWn0Wm//LSrFuWhHowSC7i3JDe0vRP0KS
 gqamKlyKH7G8e4VKGoJkbVOizQyOGC5f9dy7PSvm84aLnGRud1eb8w+TW48z6RI6SECjKCwtSR
 /3Q=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="159967720"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:42:35 +0800
IronPort-SDR: 3PPi5CtyHGuspBvs4O8T1efeSrYnmxBr2lChrEyWM/ym1WnslGDERvojpxWzd/KNWez5kgBi2P
 vFBMt+VPZXa1IRCSkCgu0aZh+aQWHZWLhGKb0t44p3w758C9DC65tsGK4vJMygAKQ1tsSxYkvN
 33k8fOU8eeH8m9u/g3b6IgPn4w/LQVNTRRR1yoV87K25kSSFPXIzlJEP0pWtkdarIiGNkiEiYZ
 FCnZDdQ5FWY9iW9WOEqR/Y9dIkoBG1xBn4XO/Zsnnap5Jtci88oau5OHQvCXAIeqqfF31zqViV
 cp5+0XgKt/6laOz2LDD45iwa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:24:45 -0800
IronPort-SDR: hj1/vzM7du+6+YJj/hXXOrYuwaJRXeSl16hERWoWp7mwne5Ke9h4yFaJ/ByIHEJShTXxZnJ6hs
 dHEkXyb6QvPAzJ4EAwmU1Hx0u6UhSszY3oZvI5cV3lPefzQ0YKVBTRVrYoJ831cJc/j7+Dzjk0
 jgM4FU3akbjIklkPtwCrMzTlnNpHzlsSocG29QGO65D7eYCwGKlcAgzw+YFWVttKvXMfiodaTv
 b3s5WHx/gVAD8B1wxXpltr18HUlJupIn1hxr1Bd3cisi+duyJhA9EjyKDJUoPXd3moWbQglJRQ
 SDw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:35 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 07/10] nvmet: use invalid cmd opcode helper
Date: Sun, 31 Jan 2021 21:41:35 -0800
Message-Id: <20210201054138.34324-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004235_569390_65D77523 
X-CRM114-Status: GOOD (  14.06  )
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

In the NVMeOF block device backend, file backend, and passthru backend
we reject and report the commands if opcode is not handled.

Use the previously introduced helper in file backend to reduce the
duplicate code and make the error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..715d4376c997 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -400,9 +400,6 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd for file ns %d on qid %d\n",
-				cmd->common.opcode, req->sq->qid);
-		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
