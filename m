Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2BB606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zzy49DZv;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kbKsKo1Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OOmiW/Hnr9WAnYqD21yaLkL0N0qGuHFwoAzF0KZH5TM=; b=zzy49DZvIAzgwa
	HyO0j2rmFH1gleQJm5nrQsCB7dn5t1tsQd4VWz6EddFDyyu2dGutB3GQoWpxZywe6ZOYqtpPdN6by
	/iUekmxa/xHcC3yfuhpMjKhOMJ1ABqTa8XGaGVBmTuGxgpES+H5RoVGmhlwxYjO7a/px4uMRfnNN9
	4sjDqtfkCJt3ElhNdq8fkwAVg8q2H1ZYTz9rUlT4cLgJQUPq+twXLBB9A1yKP8WFvuJhzSg8Q8/ik
	dIpzkZcYJFqXVfbpsSZYZqVMgI/vkPAZrdgMCa/5Fz5Qzu/i62mOZ//Hnjm1sXBcjChLUlefOnrKU
	7loL0fBuZkAWwH+MQ8QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5pJ-00000008TtY-3La2;
	Wed, 25 Nov 2026 05:45:53 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5pH-00000008TtD-0eTp
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795585548; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OOmiW/Hnr9WAnYqD21yaLkL0N0qGuHFwoAzF0KZH5TM=;
	b=kbKsKo1Yco+CT2Xnk1wbmjqzHVeZzwvXXbaPqYBMLO4N++9JVbYf+wLMhRhUmywo5jFKsv4lEv41z9XZFEiJvxSZxv87olDPwuKMbVWVfIzYOL+SxnBxHBvcPGg9E5DZ5R16+011mGBfeiiHuR/fSNCg+bOIb3xAwK8KgK1TIFA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQWe.G_1795585546;
Received: from 30.178.67.246(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQWe.G_1795585546 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 13:45:48 +0800
Message-ID: <d703f338-e482-4009-aa3f-c8cc7860e9f9@linux.alibaba.com>
Date: Wed, 25 Nov 2026 13:45:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] nvme: define an event bit enum for
 nvme_ctrl::events
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
 <20261124120032.1824788-2-kanie@linux.alibaba.com>
 <20261125051721.GC20096@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20261125051721.GC20096@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_214551_522283_3FBCE801 
X-CRM114-Status: UNSURE (   6.79  )
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



在 2026/11/25 13:17, Christoph Hellwig 写道:
> On Tue, Nov 24, 2026 at 08:00:30PM +0800, Guixin Liu wrote:
>> +/* Event bits in nvme_ctrl::events.  The numbering is independent of the
>> + * AER type and subtype values in include/linux/nvme.h.
>> + */
> Please use the normal kernel comment style.
>
> Otherwise looks good.
Sorry, changed in v5.

Best Regards,
Guixin Liu


