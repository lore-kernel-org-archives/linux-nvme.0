Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF48C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED279221FD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9SeIF3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED279221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SgVXsRM8nyq8ICljSRkYNbIhlxVgL9zei0pShmBmFlY=; b=m9SeIF3lSbaAQ5UhLQMnDym0Z
	1bK7pQxNejgSOtkPHtnXg+1nNrYTzrl/g14+HGKzmLuIBoDJtluOPASHvkj1hR5zLqXa5zkqxntYN
	endIMrhlRGCWyhdIuXIfEQJTEys9q1SxiKY8cPW7KgKf7tltIvUZHyH3HLaai9lsep6PdcdzGtNz1
	NFSGqw3Fs1zPJ7OqJW92IsxaiP1cVPEKEELK9zvs4PPJrf5Y4SnbRdVGNwTCW62OOfbgnfQrHSpW/
	0jr3yPJIKdaMwdtjcZ4i7Nx3yf/tgEE5knRfAowVcf4igI7BXIWRe8uBOnUYDOasC5HQVBgP8k8Cs
	8RsJRkPfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keiHd-00006T-OS; Mon, 16 Nov 2020 17:27:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keiHa-0008WF-MS
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 17:27:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0934F68C4E; Mon, 16 Nov 2020 18:27:13 +0100 (CET)
Date: Mon, 16 Nov 2020 18:27:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/3] nvme-loop: use blk_mq_hctx_set_fq_lock_class to
 set loop's lock class
Message-ID: <20201116172712.GK22007@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_122714_890153_3B88B4B0 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Qian Cai <cai@redhat.com>, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 linux-block@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
