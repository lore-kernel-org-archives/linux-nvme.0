Return-Path: <SRS0=uXiZ=6J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809EFC55186
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 05:59:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BC020728
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 05:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TwlFm5q6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eTcBNBFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BC020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z4lpSkXEUpyyKY7asv+CMUfTEm7Q8ckZoWR6VKE8zmE=; b=TwlFm5q6ZPoPtt
	iqohq0aur3DijmyEnaokh7bIfBSN6Xeaga31s2hwtx1IlTspLbrAeoSek0WkWF8cqipqRFR3aXU0b
	NM8oEXn5ZsEo3PW5kSmqnTkWzCnpVsGFt/75wp1UGqwRxq+AtCoAeQSHVthNu0WfkwZjaz2WtL5Iv
	SwqXH3kMgr7zoPkg0Uk11Ta7RbU68eZCtPcV7Wi0VxOqWhCi+JRZXfgE6gZ29CNHMvKvKjz0CpWsv
	a/7O9zauAgyv9cVzjWhE1qZrxnJ/jdNcL7moEFNp6AnRpOGFOUwQMw9aDUEgcJjtIBgpEmskZ5hur
	juCCjEUoBtmsJuUQwdrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSDqC-0005Qx-K6; Sat, 25 Apr 2020 05:59:04 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSDqA-0005Py-4y
 for linux-nvme@lists.infradead.org; Sat, 25 Apr 2020 05:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587794341; x=1619330341;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f88zJtz6qKg3ZbqWvWLwEDqecvtvWXr/RF7ttGsKQpc=;
 b=eTcBNBFJyFXesvus3geiU5KTGnsXcfTOxcH8R/tiAAFd9CRRJFXV97Kf
 7f44hNkSbfpEPnUqMmbW2jWhDXe/YyRqUNypMgALufwKZ08rY7Ss0DbMg
 FgOBIgohQzNjRf13ehUzn4/nFjqW2FwmMVxTftSOOX7CEWTZFfSw+FSAT
 Bbbywulj1QTgT0eL/xigV/qwyp7AOhnUrgR67sZsv3V6fcu2fVCEulV0U
 4/+Xyt4U1lEvppJTa4H6zmETMyhPlh39dqcuwtOp9bzhS+EdUWDN7ckqp
 /eyxw80ND3YWW5qcp6C/bE4y6+h4dxg32S75YAHwFRP9cNXvWU0D/0xXz w==;
IronPort-SDR: RtN0WxgufZF0P23sap+45uUR5d3KySCZk8QBB3PmqYyd6COqs06QzUTkP6BS49lfNirrKaqN7x
 cxhuEOIv/ptTdW9eSQiM7Ck7BW1Zk+78cVsr32zzQ017dnjDHwBs46V7IEZenWFZXnFQ9bjK6C
 ta34ijTbb7CI9RL/IdItuKSkI3lJF8ntqlORw5aM57G/J2jBWK5KtVsCLvA0IG4JeTu5d/6aeH
 XH2fRImvE7sE6SvOuYbfwYUsoi3hXdgobmw05fwF8jCXP6353aCuo3ReDgnnPdR7dtCE5fDFG8
 xoA=
X-IronPort-AV: E=Sophos;i="5.73,314,1583164800"; d="scan'208";a="136134435"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2020 13:58:58 +0800
IronPort-SDR: vFphpmEWM/5PM390Znw2OMsk/HXZmZAGKo8EojwbuozH+v1V2lQUkSu5f6+HmdQ3USO7htF6Bx
 SDmFRFaKwA9PL2dHjJvzerysUuyOfDGsA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2020 22:49:44 -0700
IronPort-SDR: gtELtMkbwknISrGRtktdLBaInrJbikm3T094hyo9YkAh9R3W6Igkg5hPLlmicUw/Xug3hNI5YD
 SWlAH3QO+Onw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2020 22:58:58 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH nvme-cli] nvme: fix asprintf return value check
Date: Fri, 24 Apr 2020 22:58:52 -0700
Message-Id: <20200425055852.2921-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200424_225902_279428_27BFDA50 
X-CRM114-Status: UNSURE (   9.82  )
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
Cc: kbusch@kernel.org, Kev Dorman <kdorman036@gmail.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The asprintf(3) function resturns -1 on error not 1. Fix that.

Fixes a032a481d74 ("nvme: fix compiler warnings")

Suggested-by: Kev Dorman <kdorman036@gmail.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 nvme-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-topology.c b/nvme-topology.c
index e938f23..4dbadce 100644
--- a/nvme-topology.c
+++ b/nvme-topology.c
@@ -357,9 +357,9 @@ static int verify_legacy_ns(struct nvme_namespace *n)
 		char tmp_address[64] = "";
 		legacy_get_pci_bdf(path, tmp_address);
 		if (tmp_address[0]) {
-			if (asprintf(&n->ctrl->transport, "pcie") != 1)
+			if (asprintf(&n->ctrl->transport, "pcie") == -1)
 				return -1;
-			if (asprintf(&n->ctrl->address, "%s", tmp_address) != 1)
+			if (asprintf(&n->ctrl->address, "%s", tmp_address) == -1)
 				return -1;
 		}
 	}
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
