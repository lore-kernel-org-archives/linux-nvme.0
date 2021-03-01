Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13EAC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D9864DF2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D9864DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QLEMeQPMS/rBKanevzwGAw1YDXROwRIf+sYv5qdq0wQ=; b=Jsy2xtxkKNK1SG6e1WD6bQLvO
	5egSouarc9IgW8UwE/ZzvlpUl181OueE2lLCDK+zhNqB1iM2K5lBkWSfnGPF3/PLymzGLZleK2JBs
	3fkSsDFKb5kMZzeXGyunTft07v3BJ7qJ381+CBLt7dQE9fWGIzOl5emEPScMG8RrDOHFW32aj+ycS
	KhT4k+Pd/FPnUYDUsaYRdUJjINURTQ10ZbJgM6bwtDod81HmYjLnH7Pe11AR8rylj2bDgSHrzAbnK
	O74sNolJ3bFH+dxy/dR8wgW3V0t6Yq29KORaivJSP1+weCZ6p04heUUpcgx+40ImUkJT28mw3NWt2
	LmelUFzNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxk-0004Xp-4Z; Mon, 01 Mar 2021 02:07:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxg-0004WR-Me
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564424; x=1646100424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0a/KO9SOh+yv49Y9iynx8d4+GVkqR1iHilHcSCBLb4E=;
 b=TNlzoikhRZh6jqi+ZU/0Bk/hXha0KQlo9cyc6zLbRsXUIuCN1gZsDLTo
 2at+Os87Tx3sqoDrAmqyIm0kFgqKvi4dUHrEHzdwSCah2i3Mt8Wl5cp9W
 /5LMJCH0mnVOlb0NmkIW6bG9RzmCJNKmJx9dv8YHaN4ZPIsZM77gVliub
 gEF0tOevZM1tzSxxy2KudUUdv1w+fyrIx9UL9PdqiTycqetyBHUIkexO1
 rOw6HRnVvTlQ6WAPW3c1DjFQkZ88xcZJVoeOY1xPoVkj6H15vtYT3NyiJ
 awkcKCVFx2QRvs3iPL27g9OjdC75ctw4/u/cW6R+x/vBKhBM5hHI4vQ+3 g==;
IronPort-SDR: BAZYjDed38zEOatMZ1K9USVeDiVXAHyEwLyD6w3AfaAcBuD4wCsas1YDqz3iwonho5CewsM+jE
 CYdXXM5xB7C7ruKg1N1MGz54Fp4Kzp9CELcQzX3GXluPrW6Fry2utDfP8Z6sgA0Z018ZJ7H7EW
 jSfBqQ9IdR+exepl+9xyOKC58HAn6FJPTJucVDUfZy1/MmqguMHNbxcL1G2VsQzxYmqQfDg/RT
 Hmhgqo5eX9lU7zYo01sZigY63Wx+2uGzZf81ziDJVJ1d0nmAmKTyJANMQewDDKf8lvbxCA2RPK
 P5Y=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="161012166"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:07:02 +0800
IronPort-SDR: BU0EqKdhhNy9/SSa+luKDeJRSh+TSdR3OLEUrva+0LtMUtP/yJyRifjGEClA+qO2nhq6zAjJDN
 wVzNYK5EDUIWWNQ4n9ritazCbwIKLvYs2Q+9zShtYkx+qT9Gicf6uKR9odvq6kRJmW0FddA9O0
 0rXi26liTzM5uHVeDcfNoYe4PK/KvfYX/m39VDfuT3llIH6dvlpKG4+x+Fvm2+iFemrXdZFj63
 yHImF7bIPgGEhgCqw8o2uacc39b6cIogjakxBU6PKz0e55EAiQqMFVUq8j+mS6ge7cC5V1H3IJ
 JwAI4tT5dG1xrfqIkrfvaWOM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:48:19 -0800
IronPort-SDR: v/pW1IRcvXQQPgzFLPE/pM52+k9bxxuNA2XYLPjspY0a5y9+s2euMdGAPObZj6uavDj/MWweuZ
 G+mhg6FPgSSauczaaDIYNX/HO52q9JbdU8sUFrwj1AIUEcUqFe37DMf0IAO1SQ2LGi1ZCWB5mj
 7PlS/dQCVa+un1TxLMx5r+Diiq+TXOTvPzGQ2DMSyLiKO+TktUqVajyT41EBgurE0D1vniPmHJ
 RM9knz8yr1HHtunODDG+HcxYzMP5czOag2xGt6Oi96INKJIGSfFi+2J5DPsbwdflhhX5PINIHO
 Ct8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:07:02 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 6/8] nvme-fc: fix the function documentation comment
Date: Sun, 28 Feb 2021 18:06:09 -0800
Message-Id: <20210301020611.18669-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210704_889773_86BF97F5 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme_fc_rcv_ls_req() function has first argument as pointer to
remoteport named portprt, but in the documentation comment that is name
is used as remoteport. Fix that to get rid if the compilation warning.

drivers/nvme//host/fc.c:1724: warning: Function parameter or member 'portptr' not described in 'nvme_fc_rcv_ls_req'
drivers/nvme//host/fc.c:1724: warning: Excess function parameter 'remoteport' description in 'nvme_fc_rcv_ls_req'

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 962987a330d6..ad6be2263a62 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1708,7 +1708,7 @@ nvme_fc_handle_ls_rqst_work(struct work_struct *work)
  *
  * If this routine returns error, the LLDD should abort the exchange.
  *
- * @remoteport: pointer to the (registered) remote port that the LS
+ * @portptr:    pointer to the (registered) remote port that the LS
  *              was received from. The remoteport is associated with
  *              a specific localport.
  * @lsrsp:      pointer to a nvmefc_ls_rsp response structure to be
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
