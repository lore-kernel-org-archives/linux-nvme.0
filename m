Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2977C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 15:33:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B4611BF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 15:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B4611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tJjs3U1TRnW/6w3RRrYI4fULQOL5OpL8yJJpY6tyNf8=; b=Zy4je9aBToapwWu5jppLDvDpT
	kJ2hEi50/TlSITXuxAOHnLK8zoXHanwDnrtUI7NQczwwYOibP5MXyW7tT4Kzs+xbXCaAqQbvJyHHc
	L69++0Mc5g6bJZBKErf4vVUKDRlHo+5B4ePL37e7+r8CJiwBM74Bc3HFNYnj4SVswcuvO5qjQoj6O
	N5hmgRUcOSsnJPCiB6Ko3aH03txkWerzzNZbhVYKduNwHFtU54vaH6sbC+orNSpMzhNgaabRhEpmv
	3nw3ycX0LvRCjKfOeJZfRCInYBml32DEoBpjePZnzrjmOlYQXgT9luKlMtVy0Qe/qWGv9IjLzLE+0
	Kyuyu1Faw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXQT9-002dap-9r; Fri, 16 Apr 2021 15:33:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQT6-002dZp-5n
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 15:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Vqoh0bpBWbXkcp8vTRZHwAUESy3cKGws450KVMTeFV0=; b=p/UUPI4e8R1KLV57mN8DAbrBLl
 gWHZPqg4CtSQGXpYDm5tmYvKYAZ05Y2hSqFoyeiE5WISvTOyfw3z/Vj5/p4Y6alw8QAJFuXDenRt1
 46Q0GY3DdvKt924po5ImYkmXF/JjDKKWN1Macb0d5QLYbT6EZf+dnmC68uSQuJctD0+gnm8geDxic
 yTlINbkrgNeYnuFYHsNFxLOGOViFrxhAOqyvh66dGrpYx2cPAMh/SJLpYy1BUa/++T+JUUW4trhTz
 t6XXqHkNlOcWwmXT58x6RjM3fGxnE97o3yxghlk9e/R8BpfTpPouHEW2/p8AAit8ST+U/mQeGIqlL
 za3xvUIA==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQT0-009VXE-J0
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 15:33:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618587189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vqoh0bpBWbXkcp8vTRZHwAUESy3cKGws450KVMTeFV0=;
 b=IX2L5JETdXeGtNsoZdmisPz5TJa+/DWwz56GKJDE06OvEIOgaXc6yxJ6Dm5CAjkdQTTalW
 yHXAdkqhgA0VwiTLLEuV0Sh/Urr3FuS8VIKgJJ9P7yA2dwOsh9x6DkwTVV15C+ZgwYsCLn
 s6eZcDRrsUyS1SXkB1vUJUL8AQtPids=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-uf6B3rjCOcOC8At4J4euBA-1; Fri, 16 Apr 2021 11:33:05 -0400
X-MC-Unique: uf6B3rjCOcOC8At4J4euBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6DF107ACC7;
 Fri, 16 Apr 2021 15:33:04 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B9D25D749;
 Fri, 16 Apr 2021 15:33:00 +0000 (UTC)
Date: Fri, 16 Apr 2021 11:32:59 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 2/4] nvme: allow local retry for requests with
 REQ_FAILFAST_TRANSPORT set
Message-ID: <20210416153259.GA20150@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-3-snitzer@redhat.com>
 <da184561-2c97-5807-5c5b-9cc6593693c6@suse.de>
 <20210416145340.GB16047@redhat.com>
 <3c5d6257-5f49-877e-91c2-c6d7687b002b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c5d6257-5f49-877e-91c2-c6d7687b002b@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_083310_727344_BBCE5D5B 
X-CRM114-Status: GOOD (  32.98  )
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

On Fri, Apr 16 2021 at 11:20am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 4/16/21 4:53 PM, Mike Snitzer wrote:
> > On Fri, Apr 16 2021 at 10:01am -0400,
> > Hannes Reinecke <hare@suse.de> wrote:
> > 
> >> On 4/16/21 1:15 AM, Mike Snitzer wrote:
> >>> From: Chao Leng <lengchao@huawei.com>
> >>>
> >>> REQ_FAILFAST_TRANSPORT was designed for SCSI, because the SCSI protocol
> >>> does not define the local retry mechanism. SCSI implements a fuzzy
> >>> local retry mechanism, so REQ_FAILFAST_TRANSPORT is needed to allow
> >>> higher-level multipathing software to perform failover/retry.
> >>>
> >>> NVMe is different with SCSI about this. It defines a local retry
> >>> mechanism and path error codes, so NVMe should retry local for non
> >>> path error. If path related error, whether to retry and how to retry
> >>> is still determined by higher-level multipathing's failover.
> >>>
> >>> Unlike SCSI, NVMe shouldn't prevent retry if REQ_FAILFAST_TRANSPORT
> >>> because NVMe's local retry is needed -- as is NVMe specific logic to
> >>> categorize whether an error is path related.
> >>>
> >>> In this way, the mechanism of NVMe multipath or other multipath are
> >>> now equivalent. The mechanism is: non path related error will be
> >>> retried locally, path related error is handled by multipath.
> >>>
> >>> Signed-off-by: Chao Leng <lengchao@huawei.com>
> >>> [snitzer: edited header for grammar and clarity, also added code comment]
> >>> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> >>> ---
> >>>  drivers/nvme/host/core.c | 9 ++++++++-
> >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index 540d6fd8ffef..4134cf3c7e48 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -306,7 +306,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> >>>  	if (likely(nvme_req(req)->status == 0))
> >>>  		return COMPLETE;
> >>>  
> >>> -	if (blk_noretry_request(req) ||
> >>> +	/*
> >>> +	 * REQ_FAILFAST_TRANSPORT is set by upper layer software that
> >>> +	 * handles multipathing. Unlike SCSI, NVMe's error handling was
> >>> +	 * specifically designed to handle local retry for non-path errors.
> >>> +	 * As such, allow NVMe's local retry mechanism to be used for
> >>> +	 * requests marked with REQ_FAILFAST_TRANSPORT.
> >>> +	 */
> >>> +	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
> >>>  	    (nvme_req(req)->status & NVME_SC_DNR) ||
> >>>  	    nvme_req(req)->retries >= nvme_max_retries)
> >>>  		return COMPLETE;
> >>>
> >> Huh?
> >>
> >> #define blk_noretry_request(rq) \
> >>         ((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
> >>                              REQ_FAILFAST_DRIVER))
> >>
> >> making the only _actual_ change in your patch _not_ evaluating the
> >> REQ_FAILFAST_DRIVER, which incidentally is only used by the NVMe core.
> > 
> > No, not sure how you got there. I'd have thought the 5 references to
> > "REQ_FAILFAST_TRANSPORT" would've been sufficient ;)
> > 
> 
> Ah. Misread stuff. You're excluding the REQ_FAILFAST_TRANSPORT here.
> But then it's _actually_ similar to the next patch (which I've also
> commented).
> 
> Wouldn't it be better to fold them into one patch and discuss things
> together; especially as my comment to the next one might actually
> achieve the same thing?

2 discrete things. This patch enables local retry.
Patch 3 allows proper failover via upper layer multipathing.

And as I replied, your suggestion about using DNR doesn't achieve the
same thing (said as much in reply to the patch 3 thread).

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
