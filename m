Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99460C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 03:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1BAbGX4MaRyjkntvz2pGzUXlU2g/9i8HVsKhs58iRk=; b=ZwvVbUKuQ0xBaPQNRX3cqHwL9z
	GGKioPov1lRSbq8OEtnlBGLelmvB2/Pc+iMrWssCGH5hQninID9ajlu5dV4/65ZgFB3mouAhUpnT6
	3DWc/lVpwNgZEYkDgKtguvRTYwmOIE5mswTJjItBs+9rI48ArjJ7Xdn1LY6RdTe26F/T24YZDFijK
	Y4z7Wvl8P8CFQr3LYvjceB1h59qUwWKjQoSLMUHS6OmRXHXAT0Lr+G7F+pAIvPg5TjbvhnUcCMsLV
	NN3HlloKfunOxPxcXF3nk+lI7V+Hv5XSupTnPACyWdfy1vRTluLT18W0yQFjyOV+evkAnukWqM0Fl
	BlqFQ8oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8BFt-006wK4-1I;
	Wed, 29 Nov 2023 03:28:53 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8BFr-006wJI-0C
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 03:28:52 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VxMeem7_1701228524;
Received: from 30.178.67.199(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VxMeem7_1701228524)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 11:28:46 +0800
Message-ID: <bd4340ab-566f-986a-afa9-8c6627ea632e@linux.alibaba.com>
Date: Wed, 29 Nov 2023 11:28:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kanie@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
 <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
From: yaoma <yaoma@linux.alibaba.com>
In-Reply-To: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_192851_291796_5E05F40C 
X-CRM114-Status: GOOD (  15.61  )
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



On 2023/11/28 18:13, Sagi Grimberg wrote:
> 
> 
> On 11/28/23 08:22, yaoma wrote:
>> Hi Keith Busch
>>
>> Thanks for your reply.
>>
>> The idea to avoid such a deadlock between nvme_reset and nvme_scan is 
>> to ensure that no namespace can be added to ctrl->namespaces after 
>> nvme_start_freeze has already been called. We can achieve this goal by 
>> assessing the ctrl->state after we have already acquired the 
>> ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
>> the list or not.
>> 1. After we determine that ctrl->state is LIVE, it may be immediately 
>> changed to another state. However, since we have already acquired the 
>> lock, other tasks cannot access ctrl->namespace, so we can still 
>> safely add the namespace to the list. After acquiring the lock, 
>> nvme_start_freeze will freeze all ns->q in the list, including any 
>> newly added namespaces.
>> 2. Before the completion of nvme_reset, ctrl->state will not be 
>> changed to LIVE, so we will not add any more namespaces to the list. 
>> All ns->q in the list is frozen, so nvme_wait_freeze can exit normally.
> 
> I agree with the analysis, there is a hole between start_freeze and
> freeze_wait that a scan may add a ns to the ctrl ns list.
> 
I think your proposal is nice, and I will test it.
> However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
> flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
> to what we did with quiesce). Then the scan can check it before adding
> the new namespace (under the namespaces_rwsem).

