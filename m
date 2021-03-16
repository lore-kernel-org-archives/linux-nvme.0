Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1250C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:43:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A06B64DF2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A06B64DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=samba.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=umNARVfMDGgMMTwmBreCMZME1hyWp18Th5I6IBFGwmA=; b=C/dmBis90BJIJL+4nhcEfNfFy
	r4FnfqQsCCbS1YP4CVLmy0SEvuRwdtfEoJkqiMadEcRS/AGnlOIRW6duJNLB361z8mvlRciFhzqUn
	5Rfr+T/90fS7UOEBSIyTpsb7kTOdN/du6vso9YfkaY2gO5PwdAkgmrjLBxsZtPuA5giLvqkkLPFqe
	3BNAWFQOXcyy9ZNXWvHXRIAdIjMdpttz9ucXSJVbS/CByiXCYLQBsCoBXdKQ7mJE1bR4uVvwWJ4do
	tH7kR7E2PbN1TOgKwxsJTW0Rp7GhcHq/jCUGEf1qJzdKHiU627RL+et7ol8C5EWq/3euI2MZS2vs8
	EmXu9+7ug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMBqy-0016qs-L2; Tue, 16 Mar 2021 15:43:28 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMBqs-0016oT-Mc
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org; 
 s=42; h=Date:Message-ID:From:Cc:To;
 bh=jk2Nswj7x26s8HzoXxrcKWz9+ZAxPLO+IO4tkFcAoRY=; b=nGTU9iE34wRKSYSrP497UhqcQE
 m+ZNRnDEY/r7naGJH/zBdpQE25xQg1IKcfA10H3RI8e6r4iS6qtHOy1NjX4BeH3FIOvc3NPqgiSW6
 bcRK95d6eI1At3l//Ir0cl9gy/pGqFUu4pKrXsGgLdGBenmchE4I1UMtvgV/Q5x/QSXHCmG4VQB5A
 usTQZiskXoJJpDp/hktO86uQySBTAouVcxf5loCCOih4ARfmaZUGeKNI2oJzAOX5OsLTvhghnrGGR
 SEsKwKQmYg6lmfA9hCAmVZQ1+inw+z6cN3a00wXQzPod1k+o7q5bvtAA9TyrZ0h/5IX8oHUQTs1lO
 zDmZXkOtj6YcuAec6DExjUVju40eEYZbOUpCqilUOCPRuAAzvNlpuufXjZvGR0OwPMInSjz5YZj0v
 5k7TMwvHCStKIdlSpdIx6wYMlD19ehWDFQnfaFTRgcxzt8IJod41Ec7Ku4VnPiz107kTRR2tAt2s+
 +GgC1WwrKplhrCgtNMOXVVEH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
 by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim) id 1lMBqi-0000rV-ME; Tue, 16 Mar 2021 15:43:12 +0000
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, chaitanya.kulkarni@wdc.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, nj.shetty@samsung.com,
 selvakuma.s1@samsung.com
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140233epcas5p372405e7cb302c61dba5e1094fa796513@epcas5p3.samsung.com>
 <20210316140126.24900-2-joshi.k@samsung.com>
From: Stefan Metzmacher <metze@samba.org>
Subject: Re: [RFC PATCH v3 1/3] io_uring: add helper for uring_cmd completion
 in submitter-task
Message-ID: <7a986342-f745-a084-fcb7-1d20a64a7f87@samba.org>
Date: Tue, 16 Mar 2021 16:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316140126.24900-2-joshi.k@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_154322_822332_222F93A3 
X-CRM114-Status: GOOD (  11.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hi Kanchan,

> +static void uring_cmd_work(struct callback_head *cb)
> +{
> +	struct io_kiocb *req = container_of(cb, struct io_kiocb, task_work);
> +	struct io_uring_cmd *cmd = &req->uring_cmd;
> +
> +	req->driver_cb(cmd);
> +}
> +int uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> +			void (*driver_cb)(struct io_uring_cmd *))
> +{
> +	int ret;
> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> +
> +	req->driver_cb = driver_cb;
> +	req->task_work.func = uring_cmd_work;
> +	ret = io_req_task_work_add(req);
> +	if (unlikely(ret)) {
> +		req->result = -ECANCELED;
> +		percpu_ref_get(&req->ctx->refs);
> +		io_req_task_work_add_fallback(req, io_req_task_cancel);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(uring_cmd_complete_in_task);

I think this should be have an io_ prefix:
io_uring_cmd_complete_in_task()

I'll let Jens comment if this is needed at all...

metze

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
