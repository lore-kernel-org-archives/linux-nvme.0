Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A79C3DA64
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 02:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZ9r6niTYNrCxK8B6XBW+XzVZwCXO5bwC8vmdFJG53g=; b=BnR26RXoJlYpFE1enC+C+0vN/t
	WfCWDW2alu8OZwo8i9dtNALeH9ugBZws1Roym0eXXSle3tZNA/4KTCwFFs86bPOgB/wo7mU76CiKy
	u/dmf64xP0McN3bqflFTw5iQsiEejhYOK8P2HU1daVe65WcUzaSpgUQA2elKHuQqKS6wFpUVzG+g/
	xJdcwOKVZx3f2a0ijFFZDLQfQHrUAYfTHyjnJusy7zA+Bmed0UwtNEo9krUZiQE6d/a2jP4EirMaP
	ynrAoaDA4fS42hPcRP0GOa4c7yqzbzDrpP46lnoqI1d1aePmEvla3aETYz+t+F6+NuIROaGKJo7lQ
	or0PT2uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXAno-00000002hhK-3PUi;
	Fri, 26 Jul 2024 02:35:28 +0000
Received: from m15.mail.163.com ([45.254.50.220])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXAnl-00000002hgT-0yQd
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 02:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eZ9r6
	niTYNrCxK8B6XBW+XzVZwCXO5bwC8vmdFJG53g=; b=T41v94BMIzIpbf9lSZSce
	dTmrafWcn5nFy4+56SptlcRE+b6OD4Ai8iGHXSFSo3ss//aVkX5I1/MRs7OVftgH
	rfHpTiboGMm29wcANcbO3ou7zR2hwXuPR9DjCWI3spvmOOd8urU33wg1BwRN2BJS
	O8XTpPmioYtfAvNQthlz7A=
Received: from localhost.localdomain (unknown [139.226.176.233])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD338RWC6NmhrIhAQ--.16234S2;
	Fri, 26 Jul 2024 10:35:03 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
Date: Fri, 26 Jul 2024 10:34:06 +0800
Message-Id: <20240726023407.70799-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
References: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD338RWC6NmhrIhAQ--.16234S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4rJF18try8WF15GF18AFb_yoWkCrg_u3
	9Fgws7Ga1xuF4Dta1xKFyrZF1xtFW5JrW5Aa18KF4xKry5ZF13GF4vkr9a9as7Gayktrn8
	uw13Zw1vk3sFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR8u45UUUUU==
X-Originating-IP: [139.226.176.233]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBMmKWXAmcpbkgACsp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_193525_731748_57BB1F53 
X-CRM114-Status: GOOD (  12.29  )
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

> On 19/07/2024 12:19, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use bounded workqueue to handle IO, but when there is other high
>> workload on the system(eg: kubernetes), the competition between the
>> bounded kworker and other workload is very radical. To decrease the
>> resource race of OS among them, this patchset will switch to
>> unbounded
>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>> get some performance improvement. And this patchset bases on previous
>> discussion from below session.
>>
>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>
> Hold your horses.
>
> This cannot be just switched without a thorough testing and actual 
> justification/proof of
> a benefit beyond just a narrow use-case brought initially by Ping Gan.
>
> If the ask is to universally use an unbound workqueue, please provide 
> detailed
> benchmarking convincing us that this makes sense.

So you think we should not do a radical change for the narrow usecase
but
keep the parameter to enable it in previous version patch, right?

Thanks,
Ping



