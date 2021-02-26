Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C9C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:22:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1A264F3B
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1A264F3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T1CJJiV3URNt7p+fQlHy2qfILJIeJonXutW+h6U8T+g=; b=NioaKf5BqkgF5wbEBCcF4+E1o
	sHLPUcW0jLA1Sud9OZrkEh+6QM8o9XEM9VfuhDA4ecWxnu1HEWhMTqjuSZDvjIGiMsdK69qilAy8U
	l0l1JasSVQTK8Dif5+ZuP/4lVDqI7f3NezukyZ5LYELSzv3t5DbLgW4sblYFhEm2IowJuHa0BBuOq
	acRvpUrhh7Cwt/3HlnYuy6FH+OiIaxaD+hXEWJRsTIdimI+b0sct84eJI4aONG12p5IT2QkkFIkXO
	5Xg037SPdR5P1+mHVPHYBr6ZMawAHeMJh8PzfZrpKPTmlrwlyPZg+O4AoA/jY0EwB8P+ZyeBJl+fS
	Xlr2Ef1SQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFZK4-0003u4-7N; Fri, 26 Feb 2021 09:22:08 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFZK1-0003tF-4Z
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 09:22:06 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dn3z83JJQz5KDT;
 Fri, 26 Feb 2021 17:20:20 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 17:21:57 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 17:21:57 +0800
Subject: Re: [PATCHv4 0/4] Fixup return value for nvme_submit_sync_cmd()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210226071728.106923-1-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <1e5e84d1-4c28-47a8-cb6d-98e3764209d2@huawei.com>
Date: Fri, 26 Feb 2021 17:21:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-1-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_042205_451224_9B3AAEB9 
X-CRM114-Status: GOOD (  18.60  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/26 15:17, Hannes Reinecke wrote:
> Hi all,
> 
> here are some small patches for fixing up the return value of
> nvme_submit_sync_cmd().
> As Keith correctly noted, nvme_submit_sync_cmd() should be returning
> an error if the command could not be performed; however, currently
> only pci does that.
> So we need to fix up nvme_cancel_request() to return an -EINTR
> on any pending sync commands during reset.
> And modify nvme-fc to return the same nvme status after timing out
> or cancelling requests.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v3:
> - Dropped patch to change the status code for aborted commands
> - Dropped patch to set -ETIMEDOUT on timed out commands
->timeout() also need to consider, maybe can add the flag:NVME_REQ_CANCELLED
like nvme_cancel_request.
> - Include reviews from Chao Leng
> 
> Changes to v2:
> - Include reviews from Sagi
> - Simplify error logic from nvme_validate_ns()
> 
> Changes to v1:
> - Include reviews from Daniel
> - Include changes for nvme-fc to return the same status as the
>    other transports
> 
> Hannes Reinecke (4):
>    nvme: simplify error logic in nvme_validate_ns()
>    nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
>    nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
>    nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been
>      aborted
> 
>   drivers/nvme/host/core.c | 9 +++++----
>   drivers/nvme/host/fc.c   | 3 ++-
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
