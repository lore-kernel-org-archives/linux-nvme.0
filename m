Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F46C55162
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 01:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+1j05Y62ATN4zY6HnepVA9qvSD3T6guz0dDY7TRvDo=; b=0QcgaMENiPZRpw5VA9NmhtdWl+
	GCuYRU5+41SFp29sRjDXsBcCXv15fKfeY7WOEOfmOsE6MXIXmcShGnohQhT6yx68oB9tMYY/Sj8J8
	R9U+yCUZjwZKz8tLdWOOjjsD7cgoVp2l7q7GdzpyzpYqFsjitE2Vwaaw+g8D3gW3vl0FwN3lotdQo
	cAteoKFIKkQ+fEu02LlJekbw1RzhQUU/vGWFRH8KVt9ApjTuydtKonxT84PWfjFrxVzk/PZkGB+rJ
	lmrGKqcir00C7wBVJrIISrT3Qawj8mrNUe5N5K8Ix1QwsVnszXnGMCvJ1HQ54SO2iZmC8LNJbJnhk
	zJSP4UVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpcVJ-0000000BbGZ-0OiJ;
	Fri, 31 Jul 2026 01:57:41 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpcVD-0000000BbGA-46Ww
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 01:57:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785463051; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=k+1j05Y62ATN4zY6HnepVA9qvSD3T6guz0dDY7TRvDo=;
	b=b/oyRwrtKO+h+MlFlI+2l+PaIjL3FV++QM7bTYrO7lisHeIg0As2HGM8/4DD2qkv1BXskehUBkEzWPgrBsTCRG5dg1a9XaV2kuk9XiAP3XkPZTclPtF9UQr1ITW0g2O6+gOGgZz6dogQkb+f+g3Vk+gKbRXqLMJnY61/A/hWHQc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X86XmpT_1785463048;
Received: from 30.178.83.106(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86XmpT_1785463048 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 09:57:29 +0800
Message-ID: <9187ff1b-9a40-486b-bab6-6ea6bf82268e@linux.alibaba.com>
Date: Fri, 31 Jul 2026 09:57:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Nilay Shroff <nilay@linux.ibm.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-2-kanie@linux.alibaba.com>
 <20260730113417.GA25454@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260730113417.GA25454@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_185736_750751_1AE31C2A 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
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



在 2026/7/30 19:34, Christoph Hellwig 写道:
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> On Thu, Jul 30, 2026 at 12:31:02PM +0800, Guixin Liu wrote:
>> When a host issues an Identify command with CNS 07h (Active Namespace ID
>> List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
>> called with match_css set. The command-set filter dereferences req->ns,
>> but this handler never calls nvmet_req_find_ns(), so req->ns is always
>> NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
>> namespace with an NSID greater than the requested value exists,
>> req->ns->csi dereferences a NULL pointer and oopses.
> Can you submit a testcase for that to blktests?
Sure, I will send a patch for that.

Best Regards,
Guixin Liu


