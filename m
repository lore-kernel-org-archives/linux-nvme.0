Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA8C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HrBrg5QvUAIEV+jz3DGdQVqQeKMcVuJL634mtXFHdsI=; b=bepTOVtp/zDKhR+cJc1Kck3bO/
	y3mjg6zE3mfUS+bayNYpexJSL3phoZxeObg1GVjt2tEEFI3L61V6+nHKE5+VSWDKrzWjxu+Ml7ea+
	KdrFhGYKLQmk4kWQP0hnle41AzIMJ2eM/sbizoJkvlEwzX5YHqKpL7WXbQmVvRfXEJundVVr/4mdG
	Cf0VTInkUOA13LkeWmap5ZiloPtSV7HXeyGGmTjA4OOTf2ysDYIoEL4x4oYQJyovumkbDIqhii+kg
	eEzv6ooyfJBdnnWPLTqEYTNa3DAheG3pSXSIImarSqEj6m+8lpB3xKuN6JIhkkChYbQ5f096ngcyc
	fQTlAAfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyqZ-00FRuE-MV; Thu, 12 Jan 2023 14:46:27 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyqT-00FRsC-BU
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 14:46:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A5D63FEBB;
	Thu, 12 Jan 2023 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673534777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrBrg5QvUAIEV+jz3DGdQVqQeKMcVuJL634mtXFHdsI=;
	b=rvj8/WFL8TbAB2ZWnYy2bPxp2tVG8pK6sI6j6WkIQ3UIdb+de+5QB/PO+3tldpBtdLYhVC
	mV+pOw6U3OR0KWe1atjFENO0aOUJin6qs/IXbkuqRyFwZqFqslp1DYPhS/6akESIzqZrJZ
	gsSwliW057MSrOwOR9pKwNH7j5l7PPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673534777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrBrg5QvUAIEV+jz3DGdQVqQeKMcVuJL634mtXFHdsI=;
	b=ksPyq5Qj7locvziy9JH6dr1AxpNnr4pHprnB3EftuUgp4QpX8QuSTv3VOqEjgavELrrL6f
	UTaC7oQ+mh8kFcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAFEB13776;
	Thu, 12 Jan 2023 14:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ++8qNTgdwGNiEAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Jan 2023 14:46:16 +0000
Message-ID: <bfec42d1-a1bf-3b3a-10dd-8d3db0a6e6a0@suse.de>
Date: Thu, 12 Jan 2023 15:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 3/9] block: add emulation for copy
Content-Language: en-US
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230112115908.23662-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_064623_503457_A0BB673E 
X-CRM114-Status: GOOD (  17.90  )
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

On 1/12/23 12:58, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is
> added. Copy-emulation is implemented by reading from source ranges
> into memory and writing to the corresponding destination asynchronously.
> For zoned device we maintain a linked list of read submission and try to
> submit corresponding write in same order.
> Also emulation is used, if copy offload fails or partially completes.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   block/blk-lib.c        | 241 ++++++++++++++++++++++++++++++++++++++++-
>   block/blk-map.c        |   4 +-
>   include/linux/blkdev.h |   3 +
>   3 files changed, 245 insertions(+), 3 deletions(-)
> 
I'm not sure if I agree with this one.

You just submitted a patch for device-mapper to implement copy offload, 
which (to all intents and purposes) _is_ an emulation.

So why do we need to implement it in the block layer as an emulation?
Or, if we have to, why do we need the device-mapper emulation?
This emulation will be doing the same thing, no?

Cheers,

Hannes


