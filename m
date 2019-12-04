Return-Path: <SRS0=IJIS=Z2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1622C43603
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 08:29:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E8D20637
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 08:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H9jrh1dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E8D20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SB5ePXyVe+R7Do2w9cpXaJfg4kyRavDHRUEnTMNkGQU=; b=H9jrh1dyIU9Phd
	I1LNlU8P2ub6Tkb+epa0eOkmcNcLghDLEV9mDQ+luDckfbJ58XqYW+m3Q1fpvEUsny1XLIyjNBZUx
	o0rX9ooxHpBU+GoxzyUlStwViLP/6DJxry0Kd2AzUDBLY8LTfFV3NurdVe6At8WhoAlYgLJbkOVI4
	BdgJ5KL3wlscRxrRrnkgd9j1M+FqtBrwctd9NUi9nWsVynQXFSOg7oC2Qu1X570TTZ034UX7TrRa4
	vrcYIoE4cOEx2JGWgzHgtmMkPTSNemBSagTfh1B/U0RsTTIb5YAEEIop1Z+jNjv3Rxh1uK6339+CC
	2LI1bU6BFRDZpm3bs23A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icQ1n-0007af-9j; Wed, 04 Dec 2019 08:28:55 +0000
Received: from ip-12-0-68-226-us.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icQ1j-0007aI-6S
 for linux-nvme@lists.infradead.org; Wed, 04 Dec 2019 08:28:53 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Dec 2019 00:28:49 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::8056:cf5f:fb1f:e123]) by
 SJSMAIL01.us.kioxia.com ([fe80::8056:cf5f:fb1f:e123%3]) with mapi id
 15.01.1779.004; Wed, 4 Dec 2019 00:28:49 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: James Smart <james.smart@broadcom.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Index: AdWoHEM2hZCp1trGT5CqiIXVszcBJgBiTd2AAAZbKjAAHmVugAAOa+zg
Date: Wed, 4 Dec 2019 08:28:49 +0000
Message-ID: <ac9b5d7192fb49ac9bdf19dd35be0ab2@kioxia.com>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
 <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
 <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
 <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
In-Reply-To: <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191204_002851_236684_F55113C0 
X-CRM114-Status: UNSURE (   9.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/03/2019 06:19 PM, James Smart wrote:
> On 12/3/2019 2:04 AM, Victor Gladkov wrote:
> > On 12/03/2019 00:47 AM, James Smart wrote:
> >> O
> >> The controller-loss-timeout should not affect IO timeout policy, these are
> two different policies.

> 
> Ok - which says what does make sense to add is the portion:
> 
>    !(ctrl->state == NVME_CTRL_CONNECTING && ((ktime_get_ns() - rq->start_time_ns) > jiffies_to_nsecs(rq->timeout)))
> 
> 
> But I don't think we need the failfast flag.
> 
> -- james

OK. I think, it's good enough.

This is updated patch:

---
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818..b58abc1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,8 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
        if (ctrl->state != NVME_CTRL_DELETING &&
            ctrl->state != NVME_CTRL_DEAD &&
+           !(ctrl->state == NVME_CTRL_CONNECTING &&
+            ((ktime_get_ns() - rq->start_time_ns) > jiffies_to_nsecs(rq->timeout))) &&
            !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
                return BLK_STS_RESOURCE;

---

Regards,
Victor
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
