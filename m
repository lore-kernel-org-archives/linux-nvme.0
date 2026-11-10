Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202A606A32A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rdx6nAcM;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZJZFPXly
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RVeBa7JDltEzcUamn6iaAoD8oldQHkRaOK0iiNzaP3M=; b=rdx6nAcMZBwk0/
	ScbOTchj6Hku8ohK0nGcsg3PIcLn63yw9LZaY1ongNEq4E/3Fc50/J4VsI4eXrzYB5uqEDXgNZYej
	UbL62VdtztX9DL1+Gp8BTVpBlhr8sHIyUZQ4zJ7Pd/xar+OjGmMixDyf10g1T7DcKPZ5YOw5Le7HT
	0i0Q9qOTuo2QLfi/VGvRbOFQwZg2qXymINagFsEgkYicXnSQDpgPY2hL7EtWese00BrEUO57FdgmH
	3NQt+z8GM3ZTz8XqZPIcUTaX2iCHqSsNwrDzb+d88v1LnTxJfDzGCZzBh4mZb4vFuclDSKFN8EdtK
	Bwj6OI5eNs9DL1Z5M7xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQbig-00000002BAa-3ObX;
	Tue, 10 Nov 2026 02:36:22 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQbid-00000002B9a-3XfN
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 02:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794278177; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RVeBa7JDltEzcUamn6iaAoD8oldQHkRaOK0iiNzaP3M=;
	b=ZJZFPXlySVCR6SKZbouYCI3hQ7SnvB/bNOKU++NFzcSfgQKfwSA1y8jd3iI+fOxNwH6JwElfEwk1cBQfZr3GhiKDTojd0YXzmUk2lDUhLQia2CL7V1oQ09n053SL/hNL43ZIMWTpap1rhQbSq8pBcle51BjZDJxnDTjkKfu5leI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XETW.OI_1794278176;
Received: from 30.178.84.209(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XETW.OI_1794278176 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 10:36:17 +0800
Message-ID: <f6d5f032-0d4c-413b-a708-307b7e3e96e3@linux.alibaba.com>
Date: Tue, 10 Nov 2026 10:36:15 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] nvme: reject a reconnect_delay of 0 through sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
 <20261109022646.290792-2-kanie@linux.alibaba.com>
 <avII73yoEjhR0v3l@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <avII73yoEjhR0v3l@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_183620_056895_676C9FC6 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/10 01:54, Keith Busch 写道:
> On Mon, Nov 09, 2026 at 10:26:42AM +0800, Guixin Liu wrote:
>> nvme_ctrl_reconnect_delay_store() accepts any value the option parser
>> also accepts, except that it misses the lower bound: writing 0 is
>> rejected by nvmf_parse_options() but not by the sysfs attribute.
>> nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
>> DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
>> crashes the kernel with a division by zero.
>>
>> Reject 0 like the option parser does.
> There was another patch sent earlier with an identical fix posted here:
>
>   https://lore.kernel.org/linux-nvme/20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn/
>
> I ended up applying the one that published first, but removed the
> unnecessary code comments.
OK, and could you please apply the number 4 patch too? I will drop the two
patches which you applied in v3, thanks.

Best Regards,
Guixin Liu


