Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB3606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OSAguMRH;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w17Zoc/a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DUySngk8+Kaf3BDWapeXrs/E4RHjMx9s58UzLzwwrd4=; b=OSAguMRHthXOn+
	pNOpEZxgi/Uno/icsGLLDINThL4mbQ4nav2sNYjrffPrZm1qbDsc1WVbThSgBZKlWfbj8g/G1tIv/
	9Je5YH8E3bKy4dNqweNmrjDLS+f2nPyPcf+qSn9XqIekRXGhxwzrQaV6IDUJfknNSBuKWElsADEoG
	Soez4+In9h7/7z6S9RNHSoc6bh7xguMOx+rFOu3STh7iOepi/8xAWomY9bpKcBNpc9x4zkeU3e9Uv
	aI54fCF9MAic4S3suvdG6MIeiB8nil1PlAnbjvY4uaccoxf+wa752i/78lfTV07A7wvb1ryiv6GOu
	vkDbrkkVxfwxaxC8ABYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5pe-00000008TwI-3ogD;
	Wed, 25 Nov 2026 05:46:14 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5pc-00000008TvQ-1fYL
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795585569; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DUySngk8+Kaf3BDWapeXrs/E4RHjMx9s58UzLzwwrd4=;
	b=w17Zoc/a6zmEJiDeXspRjfDKer47tSmV2pBxCV26cwwe1mUdoDnZWLhP1KY+nLOjfwliyFz8Dgd6coYvNXD1NPwKVTsiM40uF3S7O4PnPd240yFr0wJVcnq2vcDwVISG4u4zb4Il4ZkuGBNG+qQUZi8m5kTFxjKMHHIuQQTRcOc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQb.sa_1795585568;
Received: from 30.178.67.246(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQb.sa_1795585568 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 13:46:09 +0800
Message-ID: <471653ee-d4c5-4aba-9bf7-d64c17c810c7@linux.alibaba.com>
Date: Wed, 25 Nov 2026 13:46:07 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: define the SMART / Health Status async event
 subtypes
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
 <20261124120032.1824788-3-kanie@linux.alibaba.com>
 <20261125051817.GD20096@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20261125051817.GD20096@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_214612_625169_BA8C5CD2 
X-CRM114-Status: UNSURE (   8.67  )
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



在 2026/11/25 13:18, Christoph Hellwig 写道:
> On Tue, Nov 24, 2026 at 08:00:31PM +0800, Guixin Liu wrote:
>> Add the asynchronous event information values of the SMART / Health
>> Status event type (NVMe 2.x, Figure 154) alongside the notice
>> subtypes, and the events bit for the temperature warning.
> Pleaee split the command set addition in nvme.h from the changes to the
> host implementation.  The latter can go directly into the next patch.
OK, changed in v5.

Best Regards,
Guixin Liu


