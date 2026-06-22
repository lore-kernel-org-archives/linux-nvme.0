Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76ACDB46B
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aZ2dNw8c5Y2qiQoEC7JSiQcXhzHxmgAdrDVX4NthL8=; b=pyrPMSF8YAtyYo/8gnL3YjE0pA
	prZFpZ9ydYwcVgiQoqdVOpeLBtMYlFRC/SgwyJ11XoDzytRHf026dU1oOKkDpBfG7xphsOlqEQaBt
	KCDZh5Y/j/y8De5w/l6zdsD6Op48jx4EX6VihAtPvpSe1ablI45GzsFLTNxEUMhbH3jN6VrkMAq3Q
	xYPMtggtQ5gh6im46EOwLnBnkTEcDXn6TcmRuTa5svJ5MCFyh7aFTGUY2xOw7vmITMZUBJq5ODsjW
	PVbE8240T4lbOkyIo+2D5tkVKKvm4vLZMaT2Dp6MHAL5agZCA0CqqWhgRB3h1ynLUA5Pu/v+OKdDb
	3kD23PVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbael-00000004j31-24ga;
	Mon, 22 Jun 2026 09:09:27 +0000
Received: from out199-1.us.a.mail.aliyun.com ([47.90.199.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaei-00000004j1u-40qc
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 09:09:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782119360; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1aZ2dNw8c5Y2qiQoEC7JSiQcXhzHxmgAdrDVX4NthL8=;
	b=wtMW2ziqCsh7GyJZwBrzrkDMi+yxxoebIJ45yNEMy1jsj1LDSSp9sqY0+meb1Ytxh6jnYXxrBb6uCu3WeZnUOx5hiUeXZjxEMs9l7CBsQKYGqORLp7DDA6ZeGlz0/zcvula2VaHQjfXNoDbSTRY1YYXUoBGOxpKU48LWfUyfczY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5Ko4Po_1782119358;
Received: from 30.178.82.96(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Ko4Po_1782119358 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 17:09:19 +0800
Message-ID: <231abfaf-700c-4d62-b2ff-652da52d5109@linux.alibaba.com>
Date: Mon, 22 Jun 2026 17:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: expose path_state via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20260617121543.2291455-1-kanie@linux.alibaba.com>
 <38c7c98a-03cf-4c35-90d5-d7557eaa8a4d@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <38c7c98a-03cf-4c35-90d5-d7557eaa8a4d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_020925_402823_D391D4BE 
X-CRM114-Status: GOOD (  10.25  )
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

>
> Instead of only exposing disabled/enabled state, can we also expose the
> reason why the path was not usable?
>
> For instance, path_state attribute shall expose "enabled" when it's
> available for I/O (this is straightforward):
> - enabled
>
> But in case path is not usable/available then expose "disabled" along
> with the reason:
> - disabled (ctrl_down)
> - disabled (ana_pending)
> - disabled (ns_not_ready)
>
> Or any other combination depending on the ns->flags and ctrl->state.
>
> That way, the userspace would know the exact reason when path is
> not available/usable for I/O.
>
> Thanks,
> --Nilay
Good idea, I will add this in v2, thanks.

Best Regards,
Guixin Liu


