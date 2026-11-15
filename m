Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC815606A31A
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ooBVOZrb;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MQtY6NIt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9+CWduOD2mKLrUtPjD/H/4JSv1e7FTjJ8If9tjLANUo=; b=ooBVOZrbeBAyX/
	/rDmM542lAR4tmZRB8vCSPAAAGJPeuoxr5nPXOKmnTwPX5MJOfYgk2X0dFu35nMLsGsYbdlx4uM5v
	8n2ac27Qsqmx3iy9Nz2djTuwjicUJuAkZ5v6O1scIoRzN1eFQ7P3pUp78yn95ZIw8NkMygMDNmUAu
	bGZ2FQTbhX9idsBhlot5v6uCxJmRO8+7v92xFTQXbLC+DpJNutvFvGQVhkOyDyIAz+JwC7iRSl0Z0
	+CepNhz/TCDH/YLI5w7Qb5IySkYkyc7m63iBSfqv34Ecp/4bIFDJcAEPX/GsmNZJsNmKKl+dWHz3y
	qVM8Gsz58Gof4Z0Wa47w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSf6e-00000000LJ8-4BNa;
	Sun, 15 Nov 2026 18:37:37 +0000
Received: from out-19.mta0.migadu.com ([2001:41d0:1004:224b::13] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSf6b-00000000LID-1Q21
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 18:37:35 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=JOx3d+X1zVfHWepWY8CK1e2hQWjyfmWSp9MXd/S2URA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794767850; v=1; x=1795372650;
 b=MQtY6NItBSPHeo5XNdLlKlS12p92qKMsy4V0enD0O77WNlcb7TDZf845urA7TjXonFBJq4Ji
 zAm7/p++WuudAXJcLRxqdhmOfwW23QU8vARBC/g4hdn26LyT1gB3sPC/nuLaFo2rYet5uS4lFpX
 dhMsZbSSGUrzPp83vGJOrFjw=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 8bdf4a6ce8e839ca;
	Sun, 15 Nov 2026 18:37:30 +0000
X-Mizu-Trace-ID: 8bdf4a6ce8e839ca
X-Migadu-Flow: FLOW_OUT
Message-ID: <84b50119-cb4a-4bda-9ab8-7b590216858e@linux.dev>
Date: Sun, 15 Nov 2026 18:37:28 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/29] scsi: core: Clear cmd->flags for terminal
 queuing error
To: Bart Van Assche <bvanassche@acm.org>,
 james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de,
 michael.christie@oracle.com
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-2-john.garry@linux.dev>
 <060d5e0d-764e-40bd-8bb7-ead8d4ada5b0@acm.org>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <060d5e0d-764e-40bd-8bb7-ead8d4ada5b0@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_103734_200812_31538A5D 
X-CRM114-Status: GOOD (  31.29  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 20:49, Bart Van Assche wrote:
> On 11/8/26 12:47 PM, John Garry wrote:
>  > If a request can't be queued in scsi_queue_rq(), then we error out
>  > with a blk_status_t code. Such a scenario may be the scsi_device has
>  > its transport offline. For BLK_STS_RESOURCE or BLK_STS_AGAIN, the
>  > request will be requeued in the block layer.
> 
> This is not correct for BLK_STS_AGAIN. Only BLK_STS_RESOURCE and
> BLK_STS_DEV_RESOURCE cause the block layer to requeue a request. For
> all other status codes, including BLK_STS_AGAIN,
> blk_mq_dispatch_rq_list() and blk_mq_try_issue_directly() call
> blk_mq_end_request().

ok, right

> 
>  > For other errors, the block layer ends the request and so we won't
>  > see it again (until recycled). Normally when a request completes
>  > scmd->flags is cleared in scsi_end_request(). However for the error
>  > scenario mentioned above, scsi_end_request() is not called and so
>  > scmd->flags is not cleared. As such, when the request is recycled we
>  > see the old value in scmd->flags.
> 
> Please describe the consequences of this bug in the patch description.
> As far as I can tell there are at least two:
> - SCMD_FAIL_IF_RECOVERING is part of SCMD_PRESERVED_FLAGS and
>    scsi_execute_cmd() ORs new flags into scmd->flags. If a command
>    submitted with SCMD_FAIL_IF_RECOVERING is failed with BLK_STS_OFFLINE
>    because the host is in recovery, the flag leaks into the next request
>    that is allocated with the same tag. That request will then be failed
>    instead of requeued if it is submitted while the SCSI error handler
>    is active.
> - If SCMD_INITIALIZED leaks, scsi_init_command() skips
>    scsi_initialize_rq() for the next filesystem request. Hence,
>    jiffies_at_alloc and retries are not reinitialized and that request
>    may be failed prematurely by scsi_cmd_runtime_exceeded().
 > >  > Fix this issue by clearing scmd->flags in the error scenario 
mentioned
>  > by calling scsi_cleanup_rq().
> 
> Please add Fixes: and Cc: stable tags. For the SCMD_FAIL_IF_RECOVERING
> leak, I think this should be:
> 
> Fixes: 310bcaef6d7e ("scsi: core: Support failing requests while 
> recovering")

I am more inclined to go back to some commit pre-LTS v5.15, which is the 
oldest LTS maintained today. Even if you check 64104f703212f, I'd say 
that the issue existed then.

> 
>  > @@ -1994,8 +1994,8 @@ static blk_status_t scsi_queue_rq(struct 
> blk_mq_hw_ctx *hctx,
>  >           * we hit an error, as we will never see this command
>  >           * again.
>  >           */
>  > -        if (req->rq_flags & RQF_DONTPREP)
>  > -            scsi_mq_uninit_cmd(cmd);
>  > +        scsi_cleanup_rq(req);
>  > +        scsi_run_queue_async(sdev);
> 
> Since the block layer also ends requests for which scsi_queue_rq()
> returns BLK_STS_AGAIN, the BLK_STS_AGAIN case has the same issue.
> Please convert that case too:
> 
>      case BLK_STS_AGAIN:
>          cmd->result = DID_BUS_BUSY << 16;
>          scsi_cleanup_rq(req);
>          break;
> 

ok, fine. BTW, does anyone ever check cmd->result in this case, or are 
we just exercising good practice to set the result to failed?

> Although no SCSI driver returns BLK_STS_AGAIN today, I think both
> error paths should handle this in the same way.
> 
Hi Martin, I would really rather not post yet another version of this 
series. How about send the extra change which Bart requested separately?

Thanks,
John

