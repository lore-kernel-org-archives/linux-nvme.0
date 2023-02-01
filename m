Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2868C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6trNEhSnX6UksnvLUyepKfcqfzX8eLjMIjXHcFZJpI=; b=ZMe4mqcJf9NmC8gYHLLjh3YzRt
	pzWAEP4n+rAm4Xkx37ngxgR59LsRoSkynUA/Wa6LghcaBqih3M85nozHHJ+HheJ/H8eeky+mYFgXo
	3QBlOLhEyNixsJbM24W8RQwzajIzTbRYtQMFI3iZU5zv75ekQm4PaGm8SYYZYJK8z60eUvSwsBtMZ
	Tr9D/e4bqZVTjjSv0pSWEX00Cty1LPJAERoglLLZ2jaiNwkA5j6Y0aFqgdJRF6UYlZQNNzhPfD8p1
	Zosnl8DAD4tW8myPYlyH4B7Qx049D7wg1gynUBhKCK3b6/gNoazbyYjHxkN9KFi1tqs7ewqwMa9Yj
	KY4HCqVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNAQd-00BGZE-N8; Wed, 01 Feb 2023 10:33:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNAQa-00BGXU-DW
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 10:33:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 324A933BC2;
	Wed,  1 Feb 2023 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675247596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6trNEhSnX6UksnvLUyepKfcqfzX8eLjMIjXHcFZJpI=;
	b=lJyd2B05cB3H6kALxTa0MoAbJJHlZmVeMMj06jqY297yOkkC+1Sv+vdPz5vTumwVcdsI6J
	E1VXnLdl1xTDH/ZccvtmZv5wNffrZn9v2nsov84uW7VC55QW2Uexl0d9vDh9axpWVYVcJ+
	A6ly8cKgt/lv36dvOu/u+cEiP1SGXVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675247596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6trNEhSnX6UksnvLUyepKfcqfzX8eLjMIjXHcFZJpI=;
	b=CHx/2Daj8npkLseBMTGw20vruVhwDTVHYpJ130XW0C7xHxeNllh1BUzP/g2YOmqQzxZcG/
	qO1mazUqZe37hhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E64B13A10;
	Wed,  1 Feb 2023 10:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JxoeB+w/2mOfAwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 01 Feb 2023 10:33:16 +0000
Message-ID: <fb7f0f3b-bcfb-86a3-9461-e272a7aa0ca2@suse.de>
Date: Wed, 1 Feb 2023 11:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme-auth: use workqueue dedicated to authentication
 works
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Daniel Wagner <dwagner@suse.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_023320_628253_B35B68DA 
X-CRM114-Status: GOOD (  14.53  )
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

On 1/31/23 10:26, Shin'ichiro Kawasaki wrote:
> NVMe In-Band authentication uses two kinds of works: chap->auth_work and
> ctrl->dhchap_auth_work. The latter work flushes or cancels the former
> work. However, the both works are queued to the same workqueue nvme-wq.
> It results in the lockdep WARNING as follows:
> 
>   WARNING: possible recursive locking detected
>   6.2.0-rc4+ #1 Not tainted
>   --------------------------------------------
>   kworker/u16:7/69 is trying to acquire lock:
>   ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: start_flush_work+0x2c5/0x380
> 
>   but task is already holding lock:
>   ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410
> 
> To avoid the WARNING, introduce a new workqueue nvme-auth-wq dedicated
> to chap->auth_work.
> 
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Link: https://lore.kernel.org/linux-nvme/20230130110802.paafkiipmitwtnwr@carbon.lan/
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/auth.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


