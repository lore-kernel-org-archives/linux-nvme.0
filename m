Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A99CF8868
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2VC8qI0q43BjF9ZEaHIPqDkde6qxIB0LzkBDmmyVc2c=; b=RRJmlwh7T7GAtx8FveKVMyeoPg
	zrkK/BJWb5ol816i+RQ8puQPlY1qp09koe4tt0V/5NeCXF3y3eXl+luzXe9gEZjj4SFDapRP+0MQ1
	Uc6oXMwkaax8mTWAz1hiCI7HrcZHoUafb7iX6Tqz14RvWC/xUJkkMrH/HvTQZshSznoWq0UJZdz5z
	AvBGH7+zsNvlGcrdW9kVrewxJYQbkUV4Q2zwGcxc+U4bbixNziWMQtDt/rj+IijbkqJRKmHyWkZr7
	5t8+oqReS3k+Z6VxSa27w6hE+ZRnGLZcgwEXyiSpKU+gBPmbqI8ikCpN8EeHNDr6kx3tQye08V63v
	v7BgCseg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swtZi-0000000EaiZ-351g;
	Sat, 05 Oct 2024 01:27:14 +0000
Received: from out-185.mta0.migadu.com ([91.218.175.185])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swtZf-0000000EahR-3rRw
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 01:27:13 +0000
Message-ID: <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728091628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VC8qI0q43BjF9ZEaHIPqDkde6qxIB0LzkBDmmyVc2c=;
	b=caXVk7holI5r3PJjd9jKsM7ObMBgv6mEhFphPcPLVJQYorAQFMHyw7eehDowCjNuIumOe+
	rHF3uTT9M3sNDnPOD2OYe6r9zVinJ3bJmZ5Ln78QAba/dy88vevt0JVKDYmDhsWr05UwrL
	VH/7reVf3BHTne6xZSDpvbCSq9Yc5ns=
Date: Sat, 5 Oct 2024 09:26:56 +0800
MIME-Version: 1.0
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_182712_191892_23498B6E 
X-CRM114-Status: GOOD (  11.42  )
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


在 2024/10/5 0:31, Bart Van Assche 写道:
> On 10/4/24 5:40 AM, Zhu Yanjun wrote:
>> So I add a jiffies (u64) value into the name.
>
> I don't think that embedding the value of the jiffies counter in the 
> kmem cache names is sufficient to make cache names unique. That sounds 
> like a fragile approach to me.

Sorry. I can not get you. Why jiffies counter is not sufficient to make 
cache names unique? And why is it a fragile approach?

Can you share your advice with us?

I read your latest commit. In your commit, the ida is used to make cache 
names unique. It is a good approach if it can fix this problem.

The approach of jiffies seems clumsy. But it seems to be able to fix 
this problem, too. I can not see any risks about this jiffies appraoch.

Zhu Yanjun

>
> Bart.

-- 
Best Regards,
Yanjun.Zhu


