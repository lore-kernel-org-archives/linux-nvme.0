Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B34C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 22:38:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAE5613EC
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 22:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE5613EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5tODVTRCEKvWzPsWhyO+gBv8MFrzz2+1ymh/x9x+oSk=; b=dwJ8coGAidvZzE
	gdR+kXZ0HW4vFVcgpciRl8MnxiejioSSJ0YeYrNXGntJdgyt7syn8EyeZHdfL3VvK4WcgSs6nmIwD
	N463a33qOUo+HERWlAJobiEzyCQuolS1PzzwUB9BDKT64C48gHejbjlQObY0bk49NYPFbTKNTvq6/
	5JhfBZxwAnJbtnIAGyGiFazE92FNhsm/DRfqZRjxkKKiVz4B+UtEp+B41oIWFzXb2CF6Dup9GOxA1
	HCL+WuTyAoQySIxxGSt+HiEZe9b+XrvNAqIzRfSePKSq9dM9CmgNyIXylTH6z7zRZiIMndzQqXUvb
	E1rZFWuCFabEjtjbA5lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llJCX-002A5Y-OC; Mon, 24 May 2021 22:37:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll4xP-000k2Z-20
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 07:25:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 08B3867373; Mon, 24 May 2021 09:24:57 +0200 (CEST)
Date: Mon, 24 May 2021 09:24:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 06/26] brd: convert to blk_alloc_disk/blk_cleanup_disk
Message-ID: <20210524072456.GD23890@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-7-hch@lst.de>
 <83fc5cdc-53ed-0bd3-fbe8-93d0afd20771@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83fc5cdc-53ed-0bd3-fbe8-93d0afd20771@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_002459_269139_065C9129 
X-CRM114-Status: GOOD (  14.41  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, May 23, 2021 at 09:58:48AM +0200, Hannes Reinecke wrote:
>> +	/*
>> +	 * This is so fdisk will align partitions on 4k, because of
>> +	 * direct_access API needing 4k alignment, returning a PFN
>> +	 * (This is only a problem on very small devices <= 4M,
>> +	 *  otherwise fdisk will align on 1M. Regardless this call
>> +	 *  is harmless)
>> +	 */
>> +	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
>>   
>
> Maybe converting the comment to refer to 'PAGE_SIZE' instead of 4k while 
> you're at it ...

I really do not want to touch these kinds of unrelated things here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
