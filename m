Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE61BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:00:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615B722473
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615B722473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EOIZvLSwIT7V2hVT5ph4CjdB6024FRmCA4ddDS5jjU8=; b=Ph7ywCo7whp6RWMvi78Lj2QdH
	L5izAxQY6g6bs7a/4DsOKv2XY1uSK8elj010+d/zjPVDhPu9+QsHIE4M5zNzBDXzTEs42UahSZAzS
	Iph5x/r/zdHkTIwW+N54YLz0yqfjg54XCxhEwI/VKk05CjHo6Ff2QWRVGO+6srgrPUKKje/JQgleC
	zZcki9lTl3RAU05oVgkwOe+xPwn8ilZ5SgQsRetFBO9IVO3ZKa1EG1E16XTh2CsoUSEJDh8k57IA1
	7SwRIOY7H70UEU9bKbqlJIvoXh7LzVhxexoxkhCCIaxdJh6EXrE8ZlfPlTLlZjilsTaqC+SDmRWpW
	vd7/ddm2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2VpE-0001h4-3A; Thu, 21 Jan 2021 09:00:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VpB-0001gU-Om
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:00:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D723C67373; Thu, 21 Jan 2021 10:00:12 +0100 (CET)
Date: Thu, 21 Jan 2021 10:00:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion
 for nvmf_fail_nonready_command
Message-ID: <20210121090012.GA27342@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
 <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_040017_914715_29DB6F27 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: axboe@kernel.dk, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 21, 2021 at 09:58:37AM +0100, Hannes Reinecke wrote:
> On 1/21/21 8:03 AM, Chao Leng wrote:
>> When reconnect, the request may be completed with NVME_SC_HOST_PATH_ERROR
>> in nvmf_fail_nonready_command. The state of request will be changed to
>> MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
>> asynchronously such as in nvme_submit_user_cmd, in extreme scenario
>> the request may be completed again in tear down process.
>> nvmf_fail_nonready_command do not need calling blk_mq_start_request
>> before complete the request. nvmf_fail_nonready_command should set
>> the state of request to MQ_RQ_COMPLETE before complete the request.
>>
>
> So what you are saying is that there is a race condition between
> blk_mq_start_request()
> and
> nvme_complete_request()

Between those to a teardwon that cancels all requests can come in.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
