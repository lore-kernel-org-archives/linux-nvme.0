Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB20C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 03:13:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF71206C3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 03:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qdjMpGC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF71206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kM0JI6t1buL4E6JcPlufApF2oepCdQmaFNmi+xnAvaI=; b=qdjMpGC1ZV6cIMoaCuNmKdmBP
	OUmIdaqKO0Az89/MmRsS3jjS0X9z3augpaPv6mK9QuWXZwCY+ILlQCQoyFtsCowjUnckdEeNhe5wH
	/dT2Jkh/H4bzjYGeIb1l4vtKQ7NAnzHD8rj5Fc8wirkSMUuAvF/M2zQC9PCwDyR5qTOKnB/x81UpA
	fRHdCNrX7wD1XWbKg3S6fD5Mix20xJfjYBj0HvylXfmwDAXlj0/g5Mc2DdCdFxZ+oCkrhOsTKoDJQ
	vu4jM2qVOuU7MbPOF9sAEfiQ88Jf2uMM0i2p4LkaGLtM0SgL+7DKidB+AQMxZJdpZVqnSEM17amPl
	91+iCHqmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5KjF-0004dY-QO; Tue, 11 Aug 2020 03:13:33 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5KjA-0004cG-KP
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 03:13:29 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7E13A863C7704E13A4B4;
 Tue, 11 Aug 2020 11:13:20 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 11 Aug 2020 11:13:14 +0800
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To: Ming Lei <ming.lei@redhat.com>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
 <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
 <20200810031547.GB2202641@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6dc6bb01-5bfd-bf13-f53a-1bc75a6b3991@huawei.com>
Date: Tue, 11 Aug 2020 11:13:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810031547.GB2202641@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_231328_972371_1AFCB1EE 
X-CRM114-Status: UNSURE (   7.10  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/10 11:15, Ming Lei wrote:
>> About using per_cpu to replace SRCU, I suggest separate discussion.
>> Can you show the patch? This will make it easier to discuss.
> https://lore.kernel.org/linux-block/20200728134938.1505467-1-ming.lei@redhat.com/
Directly replace SRCU with percpu_ref, is not safe.
This may make quiesce queue wait extra time, in extreme scenario,
maybe wait for ever.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
