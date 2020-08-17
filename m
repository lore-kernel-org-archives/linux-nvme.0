Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B929C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 03:55:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1EB206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 03:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="104v0Ca6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1EB206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WxXzx2w8kXXD+VcewIKTx/DFVcuPAuGm6TDliaDAEro=; b=104v0Ca6fFAjHh26bIjwCU/oB
	wpcUBJRpWPMH/xjxDfCkUAsGLyf4w3fV63kCeyS7NTU7CU1PdW0VGS5xplLjUFvwW+aZ/PUU0obkN
	zOz+tTqXxE7APkv31rALR7Il6job6nZ85iAlP5Bsw4C5LGKNTLgLyKhLM75mFZSq1GC9MNpUcsOzf
	QIBYSVRmoU96VJ6UMtTSyicCLQHz1iWsv+dSkFhMWqf6gQaCTDtll1gMnYwBZn2xqse6LShCQ38XA
	7lcbUThz0ghKki4KIaR+7QOH+dXNFx6jKh7HarQULVMckFsjSTT8VOOuWfs3YXa1UmOkW9gdVUomd
	e73Wx6nDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7WEj-0006cH-F3; Mon, 17 Aug 2020 03:55:05 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7WEf-0006bO-7v
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 03:55:03 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6D90AA1DD0BC70130C80;
 Mon, 17 Aug 2020 11:54:57 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 17 Aug 2020 11:54:53 +0800
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
 <02f6276a-bbb5-5185-6a4a-1ac7aa938399@grimberg.me>
 <20200815065526.GB15518@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <62ae1057-b8a2-2b0b-8702-607d72c7492b@huawei.com>
Date: Mon, 17 Aug 2020 11:54:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200815065526.GB15518@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200816_235502_467932_010E711A 
X-CRM114-Status: GOOD (  11.79  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/15 14:55, Christoph Hellwig wrote:
> On Fri, Aug 14, 2020 at 11:44:12AM -0700, Sagi Grimberg wrote:
>>
>>> If a command send through nvme-multupath failed on a dying queue, resend it
>>> on another path.
>>
>> So this is a race where we got a retry-able status from the controller
>> (not from the host teardwon sequence) and we just happen to see
>> a dying queue?
> 
> I think so, maybe Chao can explain the scenario in a little more detail.
> .
The scenario: IO already return with non path error(such as
NVME_SC_CMD_INTERRUPTED or NVME_SC_DATA_XFER_ERROR etc.), but is waiting
to be processed, at the same time, delete ctrl happens, delete ctrl may
set queue flag: QUEUE_FLAG_DYING when call nvme_remove_namespaces. Then
for example, if fabric is rdma, delete ctrl will call
nvme_rdma_delete_ctrl, nvme_rdma_delete_ctrl will drain qp first, thus
the IO, which return with non path error, can not be failover retry,
and also can not retry local, IO will interrupt.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
