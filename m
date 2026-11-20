Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E1606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n5tFAAgQ;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bmaT2pZn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xRFhMlcn0xlxKDAyzDGD6BZdkslSLafjjRmcFObGPdM=; b=n5tFAAgQUeJn8Y
	xJFttrRg2dKT889cxa0UpGz3Z+5h8EdcD/FGUom3RpKExSY8ZB8Wre/N8X8vxE4fU7JiV5zme/Xpo
	2J5OyFgv/M/0q6kiY9qIw8djFbg2V75/LJv+4gZq7226BjmgskCQEIikCZy2YYmHcn/uTWgtALC64
	/51d4VmbGEErF6g31T6Pui3Ebv6hgE2oZGMJGgsxj21YS5E5ap1gH9Em/avDkz+8UjXESDwsZohCc
	PosWf7l5YjfkCFvfaCuCt1UDCIpKVOLmabjWr2zX1QF9ZBpCqn5SBEVqLYbTNRwBiegnJ1tgPV9nt
	JisuOcTDSsUKZQizCHSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUK37-0000000ELJS-06h9;
	Fri, 20 Nov 2026 08:32:49 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUK2z-0000000ELIp-3cWS
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 08:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795163558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xRFhMlcn0xlxKDAyzDGD6BZdkslSLafjjRmcFObGPdM=;
	b=bmaT2pZnHMhH7+6zae8c4d+gvIZSmmXxdbx6UGJN6U9D/MiO6B3YCkNiQgR63zoiuoD7vxKkJZGf4lndTimFh9TeNPsRBFG6kzZOaYEl97c27NpU0ChuvUwgviultUBNswRiedwTG/24AsxtANZXphJETuUuHDT1Y0B6Lr1IytI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XF5jp19_1795163557;
Received: from 30.178.67.37(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF5jp19_1795163557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 16:32:37 +0800
Message-ID: <f7a83440-6fdc-4b8d-aa63-3677ce4e21f7@linux.alibaba.com>
Date: Fri, 20 Nov 2026 16:32:35 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: don't abort the preempting host itself
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261120080642.1179691-1-kanie@linux.alibaba.com>
 <sashiko-outbox-224708@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-224708@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_003243_407908_0FB190AD 
X-CRM114-Status: GOOD (  13.94  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/20 16:18, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvmet: nvmet_pr_unreg_all_host_by_prkey() skips abort on
>   false pc_ref premise
> --
>
> commit 07f50eedfd5f5e5d148cd9fefe65d629fc37077e
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvmet: don't abort the preempting host itself
>
> This commit skips calling nvmet_pr_set_ctrl_to_abort() for the issuing
> host in nvmet_pr_unreg_all_host_by_prkey() when handling a Reservation
> Acquire command with the Preempt and Abort action.
>
>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>> index 8c818f24815bd..ed530d7362f5b 100644
>> --- a/drivers/nvme/target/pr.c
>> +++ b/drivers/nvme/target/pr.c
>> @@ -502,7 +502,14 @@ static u16 nvmet_pr_unreg_all_host_by_prkey(struct nvmet_req *req, u64 prkey,
>>  		if (reg->rkey == prkey) {
>>  			status = NVME_SC_SUCCESS;
>>  			uuid_copy(&hostid, &reg->hostid);
>> -			if (abort)
>> +			/*
>> +			 * Aborting is best effort (NVMe Base Specification
>> +			 * section 8.1.25.7): skip the issuing host, as the
>> +			 * abort flow would otherwise wait for the preempt
>> +			 * command itself, which holds a reference on its
>> +			 * controller's per-controller ref until it completes.
>> +			 */
>> +			if (abort && !uuid_equal(&hostid, send_hostid))
>>  				nvmet_pr_set_ctrl_to_abort(req, &hostid);
>>  			nvmet_pr_unregister_one(pr, reg);
>>  			if (!uuid_equal(&hostid, send_hostid))
> [Severity: Medium]
> Does a Reservation Acquire command actually hold a reference on pc_ref?
>
> In nvmet_parse_io_cmd(), nvmet_parse_pr_cmd() returns 0 for reservation
> opcodes and returns early before reaching nvmet_pr_get_ns_pc_ref():
>
> drivers/nvme/target/core.c:nvmet_parse_io_cmd() {
> 	...
> 	if (req->ns->pr.enable) {
> 		ret = nvmet_parse_pr_cmd(req);
> 		if (!ret)
> 			return ret;
> 	}
> 	...
> 	if (req->ns->pr.enable) {
> 		ret = nvmet_pr_check_cmd_access(req);
> 		if (ret)
> 			return ret;
>
> 		ret = nvmet_pr_get_ns_pc_ref(req);
> 	}
> 	...
> }
>
> Because that is the only caller of nvmet_pr_get_ns_pc_ref(), the preempt
> command itself never holds a reference on pc_ref->ref and cannot cause the
> self-deadlock described here.  Skipping nvmet_pr_set_ctrl_to_abort() for
> send_hostid instead stops nvmet from waiting for in-flight I/O commands on
> the newly unregistered issuing host's controllers to drain before
> completing the Preempt and Abort command.
Sashiko is right, Please ignore this patch.
>


