Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEE2C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsa+fdfwdlDM2GetrLrqpou94nUfON/csukFq2m/izo=; b=E3A9zSNG/dUH77IzdjOlfoK6gP
	IHpAWqYOn+wGGCPQVWogTiA1m/MY86M4V7N+3adUJzWzNNiNsZOBp6hujzcd8tOTccLj3eVXiPgK8
	y8GVrHvqYZtoRz9lnEF7gM1tWrO9aayk2hlhaLYrPE7aX2UMu58Q+1D04Jkp8ltqcy2CMiS+oqVWy
	5vBivmRgrFwAbgL6sHSFvvJNiKFQcHrFQ3NsgulZeFkpYSzwccJDenI9P6+AIE0jTIlcKX0Oj3J/q
	Yd10qyLZPaRPey4mAexV0r9QaJx2A2SXdZ1lPxmxvryiRpBSGuAy6VB17e7Uh2zFPZVNT0a5IZHPU
	dMBpCz7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFysg-00FSMe-Io; Thu, 12 Jan 2023 14:48:38 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFysd-00FSLR-08
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 14:48:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD0B03F0CB;
	Thu, 12 Jan 2023 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673534912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsa+fdfwdlDM2GetrLrqpou94nUfON/csukFq2m/izo=;
	b=kSH/6kvbmwFCrzEEWGGvL2I7yKz/0cDBLQGnVISP472mTr6ExKDickiXG6C6K+KZtX5iuG
	tOz/EgxbD9EltuY8CoTfas6xed9+rz+XZSvZD5nZq5QFCAPmfEStsRo2imWcxLR4WSq3Bj
	UUU+eukN0ulxKY0Yv+szQQi4rm476TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673534912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsa+fdfwdlDM2GetrLrqpou94nUfON/csukFq2m/izo=;
	b=2KNJsOzqPWJTzkRPymaNqNliovVGM6bjPs1WxlGHd0wVD9lIsbdd9Y3kxcnBOE7z9QB0Ne
	s3obyhpx6c60AwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 836B913776;
	Thu, 12 Jan 2023 14:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /6ZkH8AdwGOIEQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Jan 2023 14:48:32 +0000
Message-ID: <20d7fde4-dd17-de97-53e8-aa808a325efd@suse.de>
Date: Thu, 12 Jan 2023 15:48:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 3/9] block: add emulation for copy
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230112115908.23662-1-nj.shetty@samsung.com>
 <CGME20230112120054epcas5p3ec5887c4e1de59f7529dafca1cd6aa65@epcas5p3.samsung.com>
 <20230112115908.23662-4-nj.shetty@samsung.com>
 <bfec42d1-a1bf-3b3a-10dd-8d3db0a6e6a0@suse.de>
In-Reply-To: <bfec42d1-a1bf-3b3a-10dd-8d3db0a6e6a0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_064835_211048_A8F378C1 
X-CRM114-Status: GOOD (  19.72  )
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

On 1/12/23 15:46, Hannes Reinecke wrote:
> On 1/12/23 12:58, Nitesh Shetty wrote:
>> For the devices which does not support copy, copy emulation is
>> added. Copy-emulation is implemented by reading from source ranges
>> into memory and writing to the corresponding destination asynchronously.
>> For zoned device we maintain a linked list of read submission and try to
>> submit corresponding write in same order.
>> Also emulation is used, if copy offload fails or partially completes.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   block/blk-lib.c        | 241 ++++++++++++++++++++++++++++++++++++++++-
>>   block/blk-map.c        |   4 +-
>>   include/linux/blkdev.h |   3 +
>>   3 files changed, 245 insertions(+), 3 deletions(-)
>>
> I'm not sure if I agree with this one.
> 
> You just submitted a patch for device-mapper to implement copy offload, 
> which (to all intents and purposes) _is_ an emulation.
> 
> So why do we need to implement it in the block layer as an emulation?
> Or, if we have to, why do we need the device-mapper emulation?
> This emulation will be doing the same thing, no?
> 
Sheesh. One should read the entire patchset.

Disregard the above comment.

Cheers,

Hannes


