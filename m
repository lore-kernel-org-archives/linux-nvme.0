Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EE0CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AtoYjWVEBbEBGedpPcc/1CpVKlgTfT+Xy2OLNe5u1fM=; b=fmDCJA0H73kB8t7n5MRAGB0/EL
	QZCBTh9THCC6hBBme6kLRfy0Us5vtFdj3ro/ee9eRRZrOmLNxityIUoLwfJmxrSdV/ghFpIcF8huR
	xesp6MtBqosxoRuoEWd05fxfTK+d8UsIwcivXRvdFvCskXhPpeaDG8fqFw0xYc1g4O07+HxvScC8P
	GSqj2QGyy7ch9taOg6xtINgx/dZ3vwI8bzkEu1TMYHXMqoZPGKntZiPDYDLmzcLgMN5kewfn8QmW2
	WfHpzNXsY/+Ph+bRXMau3cYOTr5ZBrwnJkoGg1v+rbmSU+t5R0ecH0tJfZPDhutQLyYDtl/pDf24U
	oQgpfaGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSU2-00000003yoc-1iBC;
	Thu, 04 Apr 2024 19:10:46 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSTy-00000003yoA-25Xh
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 19:10:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V9WRP67kkzlgTGW;
	Thu,  4 Apr 2024 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712257838; x=1714849839; bh=AtoYjWVEBbEBGedpPcc/1CpV
	KlgTfT+Xy2OLNe5u1fM=; b=DjR4MexMiWy6HGNtCcdZL+it0XjOJBacseACSp/a
	SCcDIduL9qVq1nQA4iEWLiB4JeYL46o98l3BqHQq2TgGIYzhBrHWPhme/JuKvn2x
	k4RBgfnNCwD+c2URRZpd1oIReo7ye5pdyVggAYuUnOT8Db/n6KbTDFQQeF/9lxy1
	+3CZb1ai2lNjhPxfCZlxb/dw+78sTMb3QXUGzBJKrphBIUeRlfvsX/RmiFzJTFTC
	E5WQaGPCkv4OmH7OnWPqmZunaIP6WlrAtwbm06Nar8AgQdqKxBs+PeOZfWaxWs9T
	5waa61P3EZI+DhYE1HRRaLMT49QDP8o8ZJ8JeTzZoc80OQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xU0Ys0OmGidF; Thu,  4 Apr 2024 19:10:38 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V9WRJ00PyzlgTHp;
	Thu,  4 Apr 2024 19:10:35 +0000 (UTC)
Message-ID: <da09a76f-de4d-405e-af0a-79df59e081a6@acm.org>
Date: Thu, 4 Apr 2024 12:10:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/28] block: Allow BIO-based drivers to use
 blk_revalidate_disk_zones()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-12-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403084247.856481-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_121042_590810_BFD9245B 
X-CRM114-Status: GOOD (  14.15  )
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

On 4/3/24 01:42, Damien Le Moal wrote:
> In preparation for allowing BIO based device drivers to use zone write
> plugging and its zone append emulation, allow these drivers to call
> blk_revalidate_disk_zones() so that all zone resources necessary to zone
> write plugging can be initialized.
> 
> To do so, remove the check in blk_revalidate_disk_zones() restricting
> the use of this function to mq request-based drivers to allow also
> BIO-based drivers to use it. This is safe to do as long as the
> BIO-based block device queue is already setup and usable, as it should,
> and can be safely frozen.
> 
> The helper function disk_need_zone_resources() is added to control the
> allocation and initialization of the zone write plug hash table and
> of the conventional zone bitmap only for mq devices and for BIO-based
> devices that require zone append emulation.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

