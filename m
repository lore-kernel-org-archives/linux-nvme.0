Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C79C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:30:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D506620702
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S91AHNkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D506620702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=loTLd+8P+vzsccDUN3rDNm4aSP1xPUxtSfb+m0RQ4h8=; b=S91AHNkXy5R1z7VcJlyIp6+0C
	/Ut8OX3MlP0dJcmnSUiVBqDpbdAT7xarnPaRpybjdLRj5CtezAbkB9FrCu3SgE0k8i6JhdonwCj/D
	S1KyRyDopa70R+0K74HEVq2aHz1ch11mrtZF9td4uJxpDKFbuZhHJZZz5MeTny8W9X3leAEAgtERZ
	KO39TcCAVdfstO+CAiuEAxJxd0npJ0gNYzi9UWcrLXtJV2SPRR3ZDNj6H9pWvEy2QqSKSiKS9Qu57
	6qIpOv/iynffzFsUkBONO6nUvjIyosvFpEh2GL6FAKt0iT0RzNPnAjonA4C4Nr/dOdkCg+n3S7NrL
	76oQIDUHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k91VR-0008OS-0J; Fri, 21 Aug 2020 07:30:33 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k91VO-0008Nv-72
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 07:30:31 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 484C6D3BA6AE77980649;
 Fri, 21 Aug 2020 08:30:26 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 21 Aug
 2020 08:30:25 +0100
From: John Garry <john.garry@huawei.com>
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
 <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
 <20200820171214.GA15207@infradead.org>
Message-ID: <cd34f822-3f9d-80d1-f656-24f8cdeae42d@huawei.com>
Date: Fri, 21 Aug 2020 08:28:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200820171214.GA15207@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_033030_377397_1612F057 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, "Ahmed S. Darwish" <a.darwish@linutronix.de>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 20/08/2020 18:12, Christoph Hellwig wrote:
> On Thu, Aug 20, 2020 at 11:10:58AM -0600, Jens Axboe wrote:
>> To be fair, I've only heard this one complaint about it, so hopefully it's
>> not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
>> just fine:-)
> The cause for this is the weird NVMe of by ones, where 0 in a field
> means 1.

I thought that this was a common trick by spec writers to fit a number 
in range (0, 2^x] in x bits (as opposed to x+1).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
