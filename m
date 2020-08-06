Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A5C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:25:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5DC22DBF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jngFL69V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5DC22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sDJlgzckW8VtaXUbWtol8W9IcANRkj2PbCpC+6uCO/w=; b=jngFL69ViX0boOm7YIULZbxvM
	xNhcG2U9bf+WsO7OkQE/BJ95+rxL9qWR4txnq2SEKCRHG9f+uRkYz84pSGcgW3TafukHLeosa2CoG
	8P+VLZMqrCqvweTvWY1mhpWJPc5N+sxnwWxZ5c4inB94Xd4O6nToeovQvI/4n/4HH40F9oiI0urLM
	ZNe0W45iUuGEFDNAChQhNbJC+XSn+yiC/ZYABNu00s1MlkOsrGCIbxyVO6m0i1/CEx9rFe4ZGmTvK
	Co86cw1b6tWXHcyOU8FDQwGO76uialr4uqU6YhdVQSp2LlwreV470GFLhtXPQrl91Lkg32lOqg6AO
	sAWjtzqrw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3Ypm-0003tA-Ai; Thu, 06 Aug 2020 05:52:58 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Ypj-0003sP-1R
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 05:52:56 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AABA32DCB7F5970CBF5D;
 Thu,  6 Aug 2020 13:52:44 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 6 Aug 2020 13:52:43 +0800
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
To: Keith Busch <kbusch@kernel.org>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
Date: Thu, 6 Aug 2020 13:52:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_015255_350535_5DEFBE09 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: linux-nvme@lists.infradead.org, John.Meneghini@netapp.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/5 23:29, Keith Busch wrote:
> On Wed, Aug 05, 2020 at 02:40:48PM +0800, Chao Leng wrote:
>> John, Wat do you think about if delete translate NVME_SC_CMD_INTERRUPTED
>> to BLK_STS_TARGET? Thank you.
> 
> Perhaps BLK_STS_TARGET should only failfast for REQ_FAILFAST_DEV rather
> than REQ_FAILFAST_PATH.
> 
Now we transate NVME_SC_LBA_RANGE, NVME_SC_CMD_INTERRUPTED, NVME_SC_NS_NOT_READY
to BLK_STS_TARGET. NVME_SC_LBA_RANGE should failfast, because retry can not success.
NVME_SC_NS_NOT_READY may retry success, but the probality is very low.
NVME_SC_CMD_INTERRUPTED need retry, according to protocol define, retry will success.

So it is recommended that add the local preferential retry mechanism, like this:
---
  drivers/nvme/host/core.c | 2 +-
  drivers/nvme/host/nvme.h | 8 ++++++++
  2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a1ad5e5212c..3d39528051ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -242,7 +242,7 @@ static blk_status_t nvme_error_status(u16 status)

  static inline bool nvme_req_needs_retry(struct request *req)
  {
-	if (blk_noretry_request(req))
+	if (!nvme_req_local_retry(req) && blk_noretry_request(req))
  		return false;
  	if (nvme_req(req)->status & NVME_SC_DNR)
  		return false;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226d3299..17064455f2db 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -710,4 +710,12 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl);
  static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
  #endif

+static inline bool nvme_req_local_retry(struct request *req)
+{
+	if (nvme_req(req)->status == NVME_SC_CMD_INTERRUPTED)
+		return true;
+	return false;
+}
+
+
  #endif /* _NVME_H */
-- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
