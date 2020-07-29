Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 01:59:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844F120672
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 01:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wWmY40dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844F120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rAVylpYlR5qf+Sv/Ur+C30jgg/vHnNBpLybxt4DvpGc=; b=wWmY40dQv7dTGzYBZxKjKTZm3
	rGl8vbRMCvqQDAWSFor21LbnkKqdMY3qd9SENYkH27ldRdDCwOM7ca4zCYhd6x6WauNgMT7qQfIae
	7E18PgBAmXlR5hJnVDv7skzSStXEtkNmGjQDykzs3LaVrSeVgenfaMofBBse7Y4REaA9NVE40e2o8
	ldBz5rgKRRJvo8KHKS/vD8FAm8AlSaPGffNesxtCNVrIsnmRgQKpppP0oKSuV/FsTJS+w4aYjKSD+
	cf0U+/lP1UK0TxkG5B6GISxn1nQwYyfpe2aJwnKim8jBpJ0lvEyJpePjbAFdViIEuwHejzb4uCRET
	WOn8Kpd8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0bMs-0003AC-5R; Wed, 29 Jul 2020 01:58:54 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0bMp-00039Z-El
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 01:58:52 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4B4A829EFBB5D0DED053;
 Wed, 29 Jul 2020 09:58:45 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 29 Jul 2020 09:58:43 +0800
Subject: Re: [PATCH] nvme-core: introduce the preferential local retry
 mechanism
To: Christoph Hellwig <hch@lst.de>
References: <20200727060644.22782-1-lengchao@huawei.com>
 <20200728112050.GB31546@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <b7f151ef-a30e-3ddf-ebce-5121ca12e9d9@huawei.com>
Date: Wed, 29 Jul 2020 09:58:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728112050.GB31546@lst.de>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_215851_783054_13615172 
X-CRM114-Status: UNSURE (   7.29  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/7/28 19:20, Christoph Hellwig wrote:
> If the callers asks for failfast, the caller will get failfast,
> period.If user issue cmd through ioctl, nvme core will set the cmd_flags:
REQ_FAILFAST_DRIVER, and then in some scenarios which need retry io
after a defined time, we will return io error, this is not what we
expected. So we need introduce the preferential local retry mechanism.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
