Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F13D0BB4D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fG7cA869RxeLgnvQK1SGC33VB1PAIKymALFpviYpnE0=; b=uRBNx6JXHHRVQgu14ipaA4YiZM
	sSee16ybbfELQXMFVyLKuvz0onsvvZNYhTfEQW+X9zsdkMqe3eyfGAx5P+PzbkNag9xzgEukIq+Cl
	T7pKFTB56ZqUJTLTRLV3aWNS/VqV2amjIlQBH8fhFykkokL+5d8h2Q9ii8n5rIgbCHYXwzE3eFZwq
	XSeEL5JDsDY7kfit0ExCbUs5FnHrSTJIDo/KjN8V3+HW7GyC8j28wuqs5NtLB0D8yJWTbCcP6lQ8l
	kYJzGQ0ybTBOjSYaOb+LYSCE5w14QXepeSnpJmmCURONV42o+4MU7KXTQzUQ4pRY4trG//elDrfCw
	SWUUlUow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mmd-0000000GR4h-0cuc;
	Thu, 24 Oct 2024 01:37:03 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mhu-0000000GQVd-3RrQ
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729733526; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fG7cA869RxeLgnvQK1SGC33VB1PAIKymALFpviYpnE0=;
	b=IZ/Byw+bJB+9VeMNUQs+J4MdbvnH5HP+hsWUm+gQmaymXc3Qr/98Acjq0WYiz+RMMleBTeNY6J0uKhBBGe6v1UqffSjJjFD0ffmKx0aiqPOFSlgObBo/BVlqK63JFd+FSYLaaPPwEdG+fiJx0Q8TPi0mkm0KfvwSzQcJ5lGYP5Y=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHnD8u2_1729733521 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 09:32:03 +0800
Message-ID: <d34fc631-dc8a-4c15-a48c-d0e5336d8ffe@linux.alibaba.com>
Date: Thu, 24 Oct 2024 09:32:00 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
 <20241022142039.GB17410@lst.de>
 <75748d86-5ed2-4310-b02c-500984e6feda@linux.alibaba.com>
 <20241023122453.GA29256@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241023122453.GA29256@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_183211_463627_3B3B6CDF 
X-CRM114-Status: UNSURE (   7.12  )
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


在 2024/10/23 20:24, Christoph Hellwig 写道:
> On Wed, Oct 23, 2024 at 03:35:03PM +0800, Guixin Liu wrote:
>>> Guixin, can you test the code with lockdep enabled and see if there
>>> is other fallout as well?  Thanks!
>> You mean use semaphore to replace mutex pr_lock? If this works, I
>>
>> can send a v18.
> That should work.  Although semaphores are kinda frowned upon, so
> better write up a comment why they are needed as well.

OK, the v18 will be soon.

Best Regards,

Guixin Liu


