Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBABFCF34AD
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTm9+Fd9U/H4haC16sHTR1bTESO2Tnj8MtorXX9dHs8=; b=qJh5DoeilHO4ri1J/YKx6R2KVx
	pmn0vdjoxbXF909jYllBRL4du1J2uhNpJAMyvwnXLRcojclPgJ2N2dNsVppj93EkNgA0gEVkJSKJx
	Uqgw2IQNd++jeppSYH9q3lbjwlD1jfrBeVniVf5UIXWWsgGqs/gZ1uiHXXsv47buTQ1QPMYPxyfM2
	NqsK454rZQUnGDUoIU3xoKQdFI3KFbw23oHR7JLBGVAt7zkv+I26t5IxlvpgYu7RzCjRuop1HGAT5
	0+WqzeDMWq+2fqYEEukmqHkJnFY/iavrwDFqD9YTA6Y5Omklv7vTvQ05N4oMSsNuqknRpXUHvPxnV
	SkWbCIhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swSsL-0000000AKa1-1Vbx;
	Thu, 03 Oct 2024 20:56:41 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swSsI-0000000AKZY-03zn
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 20:56:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XKP9d3r9lzlgVnY;
	Thu,  3 Oct 2024 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727988995; x=1730580996; bh=FTm9+Fd9U/H4haC16sHTR1bT
	ESO2Tnj8MtorXX9dHs8=; b=xk/+/6N6QppPaTwrc2/ZXsj7P0XkCx6/abEpvUij
	7rnzdtFkmXCvnGQ4WT4/ROVVqQIWjE1GhpClMCwptIEXn9w3ODdu2lepfN1d555H
	yXw15gb0ui1kT/tG1PKxhSX09JjcUVSPhdD0JVgteokPrfxlxKnJtAxSdnjVWXP2
	xJNDOpzJOoxivlrpxMLynthyTW/4UykYwKxUyTxnvelDN2Oqtwh/cFGCGxGEi1GG
	VLg50OPsv6B1vbWzD0Sdz6VDL1iTfbimrklp8ua2U2UDeIKdhXGUGHBmPgudS9Dk
	3sQevp889vWwxaYwUCvuG+kD/tb5ChPjxaP81gsLcc2foQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xiJGC-xD0fY5; Thu,  3 Oct 2024 20:56:35 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XKP9Y5388zlgVnN;
	Thu,  3 Oct 2024 20:56:33 +0000 (UTC)
Message-ID: <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
Date: Thu, 3 Oct 2024 13:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_135638_105911_2F8BE20A 
X-CRM114-Status: GOOD (  13.19  )
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

On 10/3/24 1:02 AM, Shinichiro Kawasaki wrote:
> #3: srp/001,002,011,012,013,014,016
> 
>     The seven test cases in srp test group failed due to the WARN
>     "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The failures are
>     recreated in stable manner. They need further debug effort.

Does the patch below help?

Thanks,

Bart.


Subject: [PATCH] RDMA/srpt: Make kmem cache names unique

Make sure that the "srpt-rsp-buf" cache names are unique. An example of
a unique name generated by this patch:

srpt-rsp-buf-fe80:0000:0000:0000:5054:00ff:fe5e:4708-enp1s0_siw-1

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c 
b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9632afbd727b..c4feb39b3106 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2164,6 +2164,7 @@ static int srpt_cm_req_recv(struct srpt_device 
*const sdev,
  	u32 it_iu_len;
  	int i, tag_num, tag_size, ret;
  	struct srpt_tpg *stpg;
+	char *cache_name;

  	WARN_ON_ONCE(irqs_disabled());

@@ -2245,8 +2246,13 @@ static int srpt_cm_req_recv(struct srpt_device 
*const sdev,
  	INIT_LIST_HEAD(&ch->cmd_wait_list);
  	ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;

-	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
+	cache_name = kasprintf(GFP_KERNEL, "srpt-rsp-buf-%s-%s-%d", src_addr,
+			       dev_name(&sport->sdev->device->dev), port_num);
+	if (!cache_name)
+		goto free_ch;
+	ch->rsp_buf_cache = kmem_cache_create(cache_name, ch->max_rsp_size,
  					      512, 0, NULL);
+	kfree(cache_name);
  	if (!ch->rsp_buf_cache)
  		goto free_ch;



