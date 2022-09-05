Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF16EECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=xed9Tz0MYKpaaxJMC2iKEpf1EO
	EnuZvEBkksiMeRbNvojA17UJcdJ8aYAa8jitfglm81K7py7FZVonMCz6yj/qq6pbaMSHGjriyeneD
	Hypj0MiOumQfRFfkmeMjvACSoAqXlZNoiFAIwp1CS5SpDi2A4Iw8ze9YCJ/kVsLqxGgo831FCHLmb
	iq+MxoJZIgA3HAgJbOQSa+Q/U8WNfz3XxONJ7a1p6QWF/g1om8dMLDRdE8NlBEsvr/onn0453pnyG
	OvN1NI8ACA4BEX+GThyUYb4U+Taolv/SyrmqxzaQMUakxwLpKSJUv9q8UXOSF38jof5jLCXOU0Zs/
	J66yWsCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCrh-004FOn-Hz; Mon, 05 Sep 2022 14:14:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVA08-000vLc-9b
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 11:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=BJtsQjcSD8QSN65MVIwFi1dDds
	PUPnEBYcsEOr17Id0WoeD2H9zz0zLYTqyeU8ZltH8QcKJaLEEy3AQKnYVkR0T3Y0fKJx8RyneyU9z
	hZNXvfZEIeqwCyE43zwQ8T/ysPlHBop2y+1qGA6YdZkri7iVSvgu3cezps2li+25kedOI8OXVB7q8
	X4qZdKPhDULSfou2aNSnJnFGmemtYXRq7tmk1Xqkl5fkI/EfuqoNk3pESGsuz1Xe0+sQXiHNOBbMX
	DmzTp9UJK+Qv/F9DM2aNgQsGO5zZhSI2r92IBUcf/gdmbjgXLv4qoGGvJ8j62WTQnbUaJMQEXn18O
	DOHBUSXg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9s6-009YUZ-NB
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 11:02:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8A0168AFE; Mon,  5 Sep 2022 13:02:21 +0200 (CEST)
Date: Mon, 5 Sep 2022 13:02:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: avoid unnecessary flush bio
Message-ID: <20220905110221.GA21823@lst.de>
References: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_120230_924000_41305C68 
X-CRM114-Status: UNSURE (   7.84  )
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

Thanks,

applied to nvme-6.1.


