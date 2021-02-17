Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FCBC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E7964EB1
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E7964EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2n37br7tc9dZSWWX65av9ygmhqi3HKUKUEeftlpvids=; b=EE81uUvKp3RUkU+2YWlFIiubb
	iujeqxZFcFFP7TKqFkOtL+vgJd97ydPi599nrHFuyCvZ2XH89Zm/dGbFV709L6YvaEqVlvW57SCaH
	NswbLXgQQ7IKvCkqf9yrt4jItvR6JjF27VsoGGbJ9qpQ0+/8uisqDX1RCnpW+bg2yy8peV71vhxr9
	ySxGX1vkN+L5q+rIWDz8m8O3luyUxvYou3z9hsJ2G0oe6ihmejKaz4RdarFoA7M6GUcm6YrtTWcIc
	5OJtb6PU1KZYiMXTuWj5mkI4ehwmANqSv/0HV05oVhnXpXgOddRICcStKAGtkbIyyMyAz1Hq6c0ji
	SuFwLBnBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCARy-000836-RT; Wed, 17 Feb 2021 00:12:14 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARu-00080Z-1H
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520730; x=1645056730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eU0YQN61KSWKfm17WTbeDsD3XX5KEfY6swXeOQHzX5I=;
 b=AP9yxXkIINNsqfLKh/M6OjJzElqxZP6L+shWUA2lSDV/mSLM4BZqotTl
 IJdK3EzKx2hWf3kZERA+8VTISfDYmIDzULpxYX1KaxAHnx2vKm6vH5PFK
 9tB1jQkJTPhhaCPpKl9sV2p5LyTto76a31YkuIOPXa11xnDut+neT5HkG
 fFH6SJu8+/vJv71LMwXsF03m9Pd626/tJKW6a2KrTtK2ne9NRlOeNuktD
 UsDMbY5g1LcyEWvx1EJeDqUis0njDTFgrmK6fVc8sRObB9B6t3BN6mvPI
 +wuDfANNK3Qc/fzyRnNsLITEwsx/QLLNir5mDIKlKGyvYAFDy08UpycwU w==;
IronPort-SDR: Lc9S3W0erpV2oTyx+c2s44QZGeB1RktWiwpEO0z2BkISHileqDtPbr8RFZKOC4ypWX801QoAC3
 71v6fL6UpEYLIDFyuuhqBG9ls1PJ1QW6c6G0NTcO/5kfXavWZMtfA/1dhD4GVvkb0HbeimKVMl
 p9DYYQD8pvdcT8r6mqZWygntgfhR3u+bdH7W2RZqbK6JE6DaaULtqxk6o78bi8c7EHCqIti1zB
 cBG+NH5BeCc/BnW+kyyy3e1vba2CzJ9EBMpJph+WBjhspcEMrua2w0M0/v5dEylwR+oo3fVia5
 O1w=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="270629675"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:12:09 +0800
IronPort-SDR: 3kStJcTnr2XXLMknK+EH+g7BZEVnyL4kZwzjBXAf6FZmLE4thdY3vS/00S4Y+ROPUHH7MFcuqy
 Thdoq5JP3To+JIDY8nqJptmJ9rfXgvinAPR6jgTEyEU0Hrweq0Wbg3oZxc7v6yTG6b4Tdmr7GQ
 157agnlS7LRmip3TdzgqqLYN4endyG9wnQ7RmdRMUtluaztcEEdY5S0n4BAXjclS3kQMcf1BOq
 5806TZot4K1d2bC3ywH+rkCWgLXYK9t/uMBWkYoRgnmYYUU/pnzhDrHzHReEyqhVi0Yq2lkQyT
 oNt0e8h7jcoYaQVvq1TV3PNO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:53:53 -0800
IronPort-SDR: xW6crGsOORmePTFKUV8YZFnpzkK73mWddcM5Yp96yPYC0/H3JZSkiH9j9qSpRkMGPDiVU8/5JW
 3eyKBpFJdS4RF7t3tXoiwbnhQWOd35nA6Y0BscrvZd0qwX+dqMptsKoQUr8J1kJYMlBo0uSwlp
 czZqEnPIO+9NYfxQGBAoqgm40puVjuXesjWBmC5soMuifP6mm6VSBrWOj7xHHziAl/tKS9/82O
 6Z5pjDa4+cjA7apjKjLXiybBCVXKt9Sc/pglXjg1pSFPJcQI9QvmeLLMA4YKbdP0dpptatG4bx
 yug=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:12:09 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 13/14] nvme-fc: fix the function documentation comment
Date: Tue, 16 Feb 2021 16:10:31 -0800
Message-Id: <20210217001032.25741-14-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191210_314814_775D997A 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme_fc_rcv_ls_req() function has first argument as pointer to
remoteport named portprt, but in the documentation comment that is name
is used as remoteport. Fix that to get rid if the compilation warning.

drivers/nvme//host/fc.c:1724: warning: Function parameter or member 'portptr' not described in 'nvme_fc_rcv_ls_req'
drivers/nvme//host/fc.c:1724: warning: Excess function parameter 'remoteport' description in 'nvme_fc_rcv_ls_req'
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e981..d894d3eebadf 100644
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
