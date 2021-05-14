Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89193C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:29:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B4D61457
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B4D61457
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rky0i7/JmOy2sZtV/D9LCsL2bgB2ma132VFuQGG4xhg=; b=Gv7N8Y8OQH6ZQ2Ah5zPZOl7nV
	0855mzQFht23ODBxi7abRWWWR1LmW6/P3oMxG8mQQxilJXjLOhfVgNN3DEoqzTgST13HsuUQj62gt
	7f+w39kFaGBEDZ0CNfM/UZ7UqXZ96w6VSQknNSZ2V9WggkOhdyuGXQu62uOXo1paXiG9n8hfWwZgk
	66+9d4RrVrhSmyi3HS7cf8JQ2aS7wEWPqglvbj4qneYHPW/U8I292vSrMD6coGFxIR2UhaTvWnDYQ
	Skrem+pYl3uYp8QufLgCvm7E2M5LrEfgudczR36NRUSBH4MRXYF7ao2VlhLPQuTqXL11xlDXkgQn8
	7p2HF30Vw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhag9-008UiD-KO; Fri, 14 May 2021 16:28:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhag6-008Uhs-Kw
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5miRo78MViADReE4Tfz8K8hZWTyX7NvnqkYt19zMD+Y=; b=Kri83hp8cGxH7GrKHhi/d9ymo4
 CxB7OAtXsG/Ug62nzz0cqoctVpc8IYnrESWL4VzhZKWGm1nQ31x7i9bEjxaaMGA0tLjrOmmHfhmQM
 SMnh4aoD5240smZCjqhbNdcqKwSA+3SvHY70rMzNZtYgE1U+kCKG70bRtn54kYFJm0IMY73iGl4N7
 3+DpMIEKykosVASl6C3VAkXKTl2+IWwxy4kIrSWRDBPpbCOSLTYo231Eiamg2cUSHkhwKxlrDpD+I
 DVEogro/Gp/Z7LJml0bgnHOfl6lMibBzArwjCeAeTe3eFokpWq9NlRjek4oL2nixHMVIFwkCaU8S1
 KxvXDKUg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhag4-00C7IU-0p
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:28:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BD8A96736F; Fri, 14 May 2021 18:28:33 +0200 (CEST)
Date: Fri, 14 May 2021 18:28:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Ming Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210514162833.GA11873@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
 <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
 <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
 <20210514162612.GA2706199@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210514162612.GA2706199@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_092840_229508_79D9926F 
X-CRM114-Status: GOOD (  20.07  )
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

On Fri, May 14, 2021 at 09:26:12AM -0700, Keith Busch wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7febdb57f690..d40a9331daf7 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -419,6 +419,11 @@ static void nvme_requeue_work(struct work_struct *work)
>  		 * path.
>  		 */
>  		bio_set_dev(bio, head->disk->part0);
> +
> +		if (bio->bi_opf & REQ_POLLED) {
> +			bio->bi_opf &= ~REQ_POLLED;
> +			bio->bi_cookie = BLK_QC_T_NONE;
> +		}
>  		submit_bio_noacct(bio);
>  	}
>  }
> --
> 
> This should fix the hang since requeued bio's will use an interrupt
> driven queue, but it doesn't fix the warning. The recent commit
> "nvme-multipath: reset bdev to ns head when failover" looks like it
> makes preventing the polling thread from using the non-MQ head disk
> not possible.

Yes.  Althought I'd rather move the code together with the bio stealing
in nvme_failover_req (and possibly move it into a block layer helper
as it is too subtle to be open coded in drivers).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
