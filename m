Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1ADC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:50:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8749923977
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8749923977
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MKbz23RDkeIZOr/f+V7Dqsa+AQ/eaL0y9wwOGPDtQsI=; b=qcn1YiJc36hPCnPzg1ATUKIRg
	h0AY1MjqCghuEmKpHr+4rTCZAJPsKGGA9CkQVnLZb1Rlt2ZDWEuar2/wc8ffq3Ju1PvHL+symLPYY
	3yxssvhaFK330tJInruTgtdS/bQqVE+cmxoZPL3B6Tjyo2cqA4SW5vmofRdYD/TKy+sRYrA4fOCfV
	Pbn64i0hJMbgCCHlunViala05BPsOLaECjxLrphvgT3jnrDF0JTCJHpNGRj93SWUsR68EJCFWtxx8
	3cFeYv29FM1Zd75qZjJSBwwp6Nruxl08+nB/8J0FEwUOf9ZikAc1/tshvZ54N8Yjy5YhqtyuZ7nyy
	m2bFs+/oA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzwSc-0007sD-8x; Thu, 14 Jan 2021 06:50:22 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzwSZ-0007q5-Ct
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 06:50:20 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DGZdg4rrqzW0ds;
 Thu, 14 Jan 2021 14:48:23 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:50:04 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:50:02 +0800
Subject: Re: [PATCH v2 0/6] avoid repeated request completion and IO error
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <879d04a5-c52e-4d21-5003-d369ab5cdaee@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <3a8426ea-1488-b7c7-630e-162e61270190@huawei.com>
Date: Thu, 14 Jan 2021 14:50:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <879d04a5-c52e-4d21-5003-d369ab5cdaee@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_015019_769959_05982E9E 
X-CRM114-Status: GOOD (  11.49  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/14 8:15, Sagi Grimberg wrote:
>> First avoid repeated request completion for nvmf_fail_nonready_command.
>> Second avoid IO error and repeated request completion for queue_rq.
> 
> Maybe this is me chiming in v2, but what is this fixing? what
> is the bug you are seeing?The bug is crash and io error in two scenarios.
First inject request time out, crash happens due to request double
completion, the probability is very low. The reason: we will do error
recovery for request time out. When error recovery, new request will
be completed by nvmf_fail_nonready_command in queue_rq, the state of
the request will be changed to MQ_RQ_IN_FLIGHT, the request is freed
asynchronously in nvme_submit_user_cmd, nvme_submit_user_cmd may
run after cancel request(the state of the request is MQ_RQ_IN_FLIGHT)
in error recovery. The request will be double completion.

Second use two HBAs for nvme native multipath, and then inject one HBA
fault, io error happens and a low probability crash happens. The reason
of io error is the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq
call blk_mq_end_request to complete the request. We expect the request
fail over to normal HBA, but the request is directly completed with
BLK_STS_IOERR. The reason of crash is similar to the first scenario.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
