Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F4DC4167D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLhcztgY3BTkz5uriTBvQzIn5YMAhUVL4l50H8Z0dNU=; b=GnspAaxJUfWxKyAfVNhQ0prqUF
	dGxmGPI6dXXQLyHiOtrDIE3zh2pFT/IjYX6eVn9Nn43HYhuBSk2MUx4B+ChvnF/IrbSfH7650GwhZ
	5Wmtm/wvrbhoE+p2TI8aaRy+ES4fn1voQGq7Dlz9UVsdC5WG21RLCd6Dj0kkb1tymGsuyU5v8032w
	wTTuvykv0Psor7qufOh4Chd0kGEhMlxHRnJIhjvG/ewvmQ9VQKpCEkNC7qUIxuQEExZatJuykZm/L
	GXrKwtNYZUfPvMY+d/Nnd8L2KmaTM5na1fQNVlhH9ow3r/gRRJf4AmKIJHReOirYzyDfHwHWoye+E
	hqep3oLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOgs-00EeV4-0O;
	Wed, 13 Dec 2023 12:50:18 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOga-00EeAK-1W
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 12:50:01 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyR9rm8_1702471793;
Received: from 30.178.83.96(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyR9rm8_1702471793)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 20:49:54 +0800
Message-ID: <2999415d-f1db-4796-b558-95237daa2586@linux.alibaba.com>
Date: Wed, 13 Dec 2023 20:49:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvmet: fix wrong error handling approach in
 nvmet_install_queue
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-2-git-send-email-kanie@linux.alibaba.com>
 <20231213084319.GB6184@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20231213084319.GB6184@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_045000_691628_059CDF7B 
X-CRM114-Status: UNSURE (   7.24  )
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


在 2023/12/13 16:43, Christoph Hellwig 写道:
> On Wed, Dec 13, 2023 at 02:32:48PM +0800, Guixin Liu wrote:
>> In the nvmet_install_queue() function, do not set the ctrl pointer
>> to NULL if the sqsize check fails.
> Can you explain why it is wrong, and why not doing it is desirable?

If a queue which is already connected, then receive a connect cmd with 
sqsize=0, it will set the

req->sq->ctrl to NULL and break the queue.


