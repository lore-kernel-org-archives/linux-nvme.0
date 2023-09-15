Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC9DEE644D
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Sep 2023 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ox4t8vsBfHdHBvmrp8jZiGllqFgu3g66e8FODoz9bQg=; b=0zD6FcNG/n68Li8uPyPTFD4qhq
	PCerkiTHpFBgAU85jgHUBkWsIpB4Mq8gTc2pXkMfdSpI24Hy1/Ffds3D6phVQH8PcVIbDcA7AhISs
	W6HUSgyx+3nmktQMGJTAOMbUCw7JtOzM5JunDbLS46IpvjWn86Nfq/7fXasv8vuFSnMfVDPirHwcI
	zeEavQcFwhp9rOzD28vi3mv2544EEoNtwVEDc778K8awNGh06rfe8tgIiG5qOXdUs6KaKlM8NWBNM
	Ea9EjqN7pN04N0XOdrOEcHW0VvuGHQmIYyqhYmR8+d56oNcUFXmpnZKhdtEK62LohWurXEGEREPxS
	dNhNCnSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh5Iq-00AImM-0h;
	Fri, 15 Sep 2023 09:39:56 +0000
Received: from m12.mail.163.com ([220.181.12.214])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh5Im-00AIjd-1w
	for linux-nvme@lists.infradead.org;
	Fri, 15 Sep 2023 09:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=Ox4t8vsBfHdHBvmrp8jZiGllqFgu3g66e8FODoz9bQg=; b=fJI6WlWmj1AOf
	yUIIbKxoEaBQajm2Nrgs7xcc2sqHbxlzU8FsNIYsF/HsIba4+2xI8XKlUFF7uIcr
	t7swTLsfB4v4PBInxim9tmi+hoKt76Id9c85frM5jIGKYWMY7gWY9TAcWeSmdd9e
	uWaaHTzaTowEUIdPzCzsGPr+EH6gIY=
Received: from localhost.localdomain (unknown [139.227.195.81])
	by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wD3vKUsJgRlL82KCA--.12438S2;
	Fri, 15 Sep 2023 17:38:54 +0800 (CST)
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
Subject: 
Date: Fri, 15 Sep 2023 17:37:57 +0800
Message-Id: <20230915093758.31397-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
References: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3vKUsJgRlL82KCA--.12438S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15JF4xtrWfZw18GF18uFg_yoW8WFy3pF
	WFq3ZxArW8tF4rAw1UAws2q34vqw1rC3WrXayrJrZ2kr98KryxWr15AFy3Xrs5WFykKr12
	vwn2v398Xw48trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEzBTnUUUUU=
X-Originating-IP: [139.227.195.81]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBTrKV7WNENZmwAAsD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_023953_021923_63CEA543 
X-CRM114-Status: GOOD (  13.94  )
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
Reply-To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 9/13/2023 1:34 AM, Ping Gan wrote:
> > Since nvme target currently does not support to submit bio to a
> > polling
> > queue, the bio's completion relies on system interrupt. But when there
> > is high workload in system and the competition is very high, so it
> > makes
> > sense to add polling queue task to submit bio to disk's polling queue
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
I do two group tests. The IO size of first is 4K, and the other is 2M. 
Both includ randrw, randwrite and randrw.  Both have same prerequisites.
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
bandwidth of interrupt. But for iosize 2M the improvement is not obvious,
the randrw of polling queue is about 9% more than interrupt; randwrite 
and randread of polling queue is about 5% more than interrupt.


Thanks,
Ping



