Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB67C3DA49
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5/EeHzpNabXc5RVd46C/7TAlz4/G8RSGiM4PhgH1hs=; b=tpDnFIf0dg5Mnzf0d6IcBFsc7h
	I/Bgo1vs9wc6f1UnZKUMSUNVazH/eBbmEA1gW+KKKy7cpzBpZRnimUh4F/n3hWSP+w7+inVdBQDOl
	rg5Cq+CVwjUIixhjilYyG0qQy3C/sBJKZ5cwkYCsIGLeFpkzF6lR1Mlqczx4qXSZBitHxVp/9zCxZ
	W9XYxUJC8TyIGhlLrxjC+Fu2JX99k4aHNE5VTSfYmwSd4czZoCyIhIZPd9hXpDiTKi4sYUWJ0a7KS
	dsM9oOQQXazvnrcgYfKDVVD5Q6Xh405tdbqhJywe0voaqgaa4t4fpQAGEJdH8KgRw/+a+N4WtCWQ+
	mjzE2kzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTswH-0000000CDCs-18Si;
	Wed, 17 Jul 2024 00:54:37 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTswE-0000000CDBJ-25Hk
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 00:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t5/Ee
	HzpNabXc5RVd46C/7TAlz4/G8RSGiM4PhgH1hs=; b=TEq9CJB5fJj2t7fvUc32R
	HEhIeVy08Ot9HIC4g1MWp2IFRlAN+MutULMrOON5qyEylJMT2RuyDSvzBpyWvfEz
	yklcpK3/Gp1gN3ry1XI6lYRt6uTlUCKgaWv1BhtJ1UEwH1ytdtIy45z0Vzy3b6U3
	tljzXsmcuqkGfLG2lE/Yn8=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3X502FpdmwwpwBw--.43354S2;
	Wed, 17 Jul 2024 08:54:15 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP 
Date: Wed, 17 Jul 2024 08:53:17 +0800
Message-Id: <20240717005318.109027-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <af243508-e5f3-4835-8d8e-c1bb741e22f3@suse.de>
References: <af243508-e5f3-4835-8d8e-c1bb741e22f3@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X502FpdmwwpwBw--.43354S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw1ruw4UZF48GrWxZF18Zrb_yoW8Jr15pF
	yfJF1vyan7Kr1Fy3ZFkw42qF4Utw4rAFWqgF97trWrJr1Y9ry2y34xtF1rWFykGr4fWr1j
	yayDX3yDua1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6uWJUUUUU=
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBgfKWXAmTHxfwAAsl
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_175435_013297_F56DB0B1 
X-CRM114-Status: GOOD (  12.39  )
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

> On 7/4/24 10:10, Ping Gan wrote:
>>> On 02/07/2024 13:02, Ping Gan wrote:
>
>>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>>> improvement.
>>>
>>> I think you will see similar performance with unbound workqueue and
>>> rps.
>> 
>> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting
>> unbound
>> workqueue, and in same prerequisites of above to run test, and
>> compared
>> the result of unbound workqueue and polling mode task. And I got a
>> good
>> performance for unbound workqueue. For unbound workqueue TCP we got
>> 3850M/node, it's almost equal to polling task. And also tested
>> nvmet-rdma we get 5100M/node for unbound workqueue RDMA versus 5600M
>> for
>> polling task, seems the diff is very small. Anyway, your advice is
>> good.
>> Do you think we should submit the unbound workqueue patches for
>> nvmet-tcp
>> and nvmet-rdma to upstream nvmet?
>
> Please do. I have been using pretty much the same patch during
> development of my nvme-tcp scalability patchset, and using WQ_UNBOUND
> definitely improves the situation here.

Thanks for your confirm! Okay, will do that.

Regards,
Ping



