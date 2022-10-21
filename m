Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F8C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+e55qnoYClQvZEcxGwSqNGwE4xgxw7vbay5ghEmriXM=; b=dJ3K07yCSXkuED7h6D9m1TjHkC
	xffN6NN7vYKkeVXWi7fI3eQKvDt9L8c6FHec0/ctqK3Q5Z/00tsZyeC4Aq20/97UowSaKPmj1i/UV
	d6jSIXxktFcpql6WweGjYx7yyXV3GB8Qg5OoD8F/x8muw2KTMLodfup6e4cfMNFVLMWhkQKZNwm6m
	xcxzsHvnWuBLsWNo9DdknVtsJSoX6/Jp2TYqoNCrKXhX/xPY/QGqBq8O81zslGEr7j/nvI9d8IUVY
	YDZwWjZ0oYF0jYdh6zeH/EQLmox6ufnXyfHnmTysHSKX/UgxNV3X3lgIcrkdipFFQdPnPoGIL49Lg
	pckyqVtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ollsK-005nAv-3H; Fri, 21 Oct 2022 06:51:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ollsG-005n8p-Oq
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 06:51:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8924221890;
	Fri, 21 Oct 2022 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666335079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+e55qnoYClQvZEcxGwSqNGwE4xgxw7vbay5ghEmriXM=;
	b=fDCcRYr5GxhDckYqff43MGiaj9D7bKPIACx+Wkzo3m6GOW4n0/4IlVrLGCFUyO4mcFkV14
	L+AACZKafOS6otFGvp2qv6baDlQByKs61DdrcdRkCBDUJVmBFseakEx+IceECs0aQmhh7c
	mxQjVajNGyRwbf38xgz44gzU/DJ1nVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666335079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+e55qnoYClQvZEcxGwSqNGwE4xgxw7vbay5ghEmriXM=;
	b=5t/L7Utg4S1rRlNWB+QPOc4Pho+ILT0PhIOU4dv9cvRzUlAgwjsB9NcUVrgmbcbzo6vieS
	3XpSgR0asir8luBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 568431331A;
	Fri, 21 Oct 2022 06:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dkZoFGdBUmMxHwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:51:19 +0000
Message-ID: <66fcb7c7-47bd-b1f8-0bae-f961f4c0015c@suse.de>
Date: Fri, 21 Oct 2022 08:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_235120_984421_AF7D665F 
X-CRM114-Status: GOOD (  16.71  )
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

On 10/20/22 12:56, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an
> interface to quiesce all the queues on a given tagset. This interface is
> useful because it can speedup the quiesce by doing it in parallel.
> 
> Because some queues should not need to be quiesced(e.g. nvme connect_q)
> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
> tagset quiesce interface to skip the queue.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: simplify for the per-tag_set srcu_struct]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c         | 25 +++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   include/linux/blkdev.h |  3 +++
>   3 files changed, 30 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


