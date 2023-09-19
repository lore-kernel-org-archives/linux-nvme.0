Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E04BCD342E
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 03:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Y6wt5SzgLMJ3PPOdqn79HesSoUYnREHVbZj8xkzF7U=; b=iZ0yenXat0BQ0Zxj/cHgtXMawg
	C03wJ+88zvWx9bnb9MMn2bZGrNrmsYGakyUvtP3jPhSv1bP6Wn264LGHiflMXdFunyfdGUO0MMaZK
	qHVu7W6trvG7fU2p6IxcQuimbcnIdyequuqNcVDq5hYXSLV+4IpaQFe/mNg352eNr4oG+p/eWI9Gu
	dOOAJJAYwHsfqHRIYDzXQiq83fdaSVjLfHHxyRSnc0bz7j5UNgo11U4R0+gfzPnCuSR2UizOsfoMb
	N5eouKi0drnaH5bSvDM58pZGTqF375uAgsm80CQpjdkjwIG/+ylkFgsu2F1Ko8D9XFpwyEuL99mVK
	UDb5GUWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiROp-00Go1f-1o;
	Tue, 19 Sep 2023 03:27:43 +0000
Received: from m12.mail.163.com ([220.181.12.214])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiROm-00Go0u-39
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 03:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=4Y6wt5SzgLMJ3PPOdqn79HesSoUYnREHVbZj8xkzF7U=; b=nprfgFIvNTj1o
	VWkPe6q8BH3x4TNASdJVcYGb88WEi546PbzqFdujpfdVZ89mQTh+TbiLURzBvraR
	re0EjqkUX7/CjqiETRC4CXICfbYUm3+Xaihj5Wj9ms8GNb8qNKJet1FOe/urVnj1
	jXNUtndWlb5WKMtfO9JzGDIhn2za7E=
Received: from localhost.localdomain (unknown [183.192.130.204])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3Lij7FAllZePxCQ--.10947S2;
	Tue, 19 Sep 2023 11:26:52 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: chaitanyak@nvidia.com
Cc: ping_gan@dell.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	jacky_gam_2001@163.com
Subject: Re: [PATCH 0/4] nvmet: support polling queue task for bio
Date: Tue, 19 Sep 2023 11:25:38 +0800
Message-Id: <20230919032539.71629-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
References: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3Lij7FAllZePxCQ--.10947S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15JF4kAFykWF1rZw1xGrg_yoW8WFW3pa
	yFq3ZxArWktF4rA3WUAw4vq34vq3WrC3WrXayrJrZ2krZ8KFyxWr15AFy3Xrs5WFykKr12
	vwn2v398Xw48trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0oG9UUUUU=
X-Originating-IP: [183.192.130.204]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBohPuKVaEJhdPpQABs+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_202741_394077_762B9172 
X-CRM114-Status: GOOD (  15.25  )
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
Reply-To: chaitanyak@nvidia.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 9/13/2023 1:34 AM, Ping Gan wrote:
> > Since nvme target currently does not support to submit bio to a
> > polling
> > queue, the bio's completion relies on system interrupt. But when
> > there
> > is high workload in system and the competition is very high, so it
> > makes
> > sense to add polling queue task to submit bio to disk's polling
> > queue
> > and poll the completion queue of disk.
> > 
> >
>
> I did some work in the past for nvmet polling and saw good
> performance improvement.
>
> Can you please share performance numbers for this series ?
> 
> -ck

hi,
I have verified this patch on two testbeds one for host and the other
for target. I used tcp as transport protocol, spdk perf as initiator. 
I did two group tests. The IO size of first is 4K, and the other is 2M.
Both include randrw, randwrite and randrw. Both also have same prerequisites.
At the initiator side I used 1 qp, 32 queue depth,and 1 spdk perf
application, and for target side I bound tcp queue to 1 target core.
And I get below results.
iosize_4k        polling queue                        interrupt
randrw           NIC_rx:338M/s NIC_tx:335M/s      NIC_rx:260M/s
NIC_tx:258M/s
randwrite        NIC_rx:587M/s                    NIC_rx:431M/s
randread         NIC_tx:873M/s                    NIC_tx:654M/s

iosize_2M        polling queue                        interrupt
randrw           NIC_rx:738M/s NIC_tx:741M/s      NIC_rx:674M/s
NIC_tx:674M/s
randwrite        NIC_rx:1199M/s                   NIC_rx:1146M/s
randread         NIC_tx:2226M/s                   NIC_tx:2119M/s

For iosize 4k the NIC's bandwidth of poling queue is more than 30% than
bandwidth of interrupt. But for iosize 2M the improvement is not
obvious,
the randrw of polling queue is about 9% more than interrupt; randwrite
and randread of polling queue is about 5% more than interrupt.


Thanks,
Ping



