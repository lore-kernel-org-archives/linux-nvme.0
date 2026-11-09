Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86F606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BurhQNHT;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=WLENZ+09
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+XBSa+YGEqD13zOBtk291Un527MF5DVJf78DjKI+IVc=; b=BurhQNHTl808OT
	kjUSgRbAr+n45gI7m6L5PHvZ3h1Xk4a54cccaBm2Me1VUnLfw/kYsQc9Kh0PgIK5aA0P+AGqPV0F1
	hgjRyNhrqfZTlY0zcKVdqgr9zEzzUmQn+pE245Xz2V/nGu+QpNREvyeow9EfIkuM8eUFCy3pWzM8Y
	jbdZTuxQe3cOkO/8GiOUv5Q4JPnG3H0J5dLifZhmK/VENYZoH9+8dAECWKaZ6m88hJId/yiDWaMoG
	poMO3WkIZ/fbGgREwarply0VdbyVUc2l1y7yf6Rn5qGOLglI3tVRkk8quVFAnleNKOYXlcQ+hLh73
	yZUtd9/iEkxxRPbUz7Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQWJU-00000001gir-2u0x;
	Mon, 09 Nov 2026 20:50:00 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQWJP-00000001ggs-3vY1
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:49:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhjh5FQlz1XM5kD;
	Mon,  9 Nov 2026 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794257379; x=1796849380; bh=+XBSa+YGEqD13zOBtk291Un5
	27MF5DVJf78DjKI+IVc=; b=WLENZ+09mXAG6136e0lXt2JwmfE2aliftklXzG1K
	KhGskVuxetgZ4yjJz1/04VKiopEc3XmEbzDKEbNicw3FhPka/jWz+YbBy6axxmkm
	l+0PmN145aE5xuk/Gc/tb6ZdGij2TuOQCCynOVZM/4EMM0ExJCXyPYiBAEFqubUZ
	vfszHdDE3EbduZxMfptfJwJ9e/KU8z800E2VygAZbHXBAxFw67Iw2fXwtrwNWZti
	T7aKmhqouK5BUuRTji1hiSZUR5hGMtZq/ivEJl5BwKU5w4OJiZdXnySBi0hpxi2z
	eNJjDJIAuASUz/pbZZhvGgPex8JvxFPX4NkqSz/Xx8GEBA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 22iWdORwNULS; Mon,  9 Nov 2026 20:49:39 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhjZ6pjRz1XM4Tn;
	Mon,  9 Nov 2026 20:49:38 +0000 (UTC)
Message-ID: <060d5e0d-764e-40bd-8bb7-ead8d4ada5b0@acm.org>
Date: Mon, 9 Nov 2026 12:49:38 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/29] scsi: core: Clear cmd->flags for terminal
 queuing error
To: John Garry <john.garry@linux.dev>, james.bottomley@hansenpartnership.com,
 mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de,
 michael.christie@oracle.com
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-2-john.garry@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261108204733.557995-2-john.garry@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_124955_995063_A22D0022 
X-CRM114-Status: GOOD (  20.32  )
X-Spam-Score: -2.8 (--)
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

On 11/8/26 12:47 PM, John Garry wrote:
 > If a request can't be queued in scsi_queue_rq(), then we error out
 > with a blk_status_t code. Such a scenario may be the scsi_device has
 > its transport offline. For BLK_STS_RESOURCE or BLK_STS_AGAIN, the
 > request will be requeued in the block layer.

This is not correct for BLK_STS_AGAIN. Only BLK_STS_RESOURCE and
BLK_STS_DEV_RESOURCE cause the block layer to requeue a request. For
all other status codes, including BLK_STS_AGAIN,
blk_mq_dispatch_rq_list() and blk_mq_try_issue_directly() call
blk_mq_end_request().

 > For other errors, the block layer ends the request and so we won't
 > see it again (until recycled). Normally when a request completes
 > scmd->flags is cleared in scsi_end_request(). However for the error
 > scenario mentioned above, scsi_end_request() is not called and so
 > scmd->flags is not cleared. As such, when the request is recycled we
 > see the old value in scmd->flags.

Please describe the consequences of this bug in the patch description.
As far as I can tell there are at least two:
- SCMD_FAIL_IF_RECOVERING is part of SCMD_PRESERVED_FLAGS and
   scsi_execute_cmd() ORs new flags into scmd->flags. If a command
   submitted with SCMD_FAIL_IF_RECOVERING is failed with BLK_STS_OFFLINE
   because the host is in recovery, the flag leaks into the next request
   that is allocated with the same tag. That request will then be failed
   instead of requeued if it is submitted while the SCSI error handler
   is active.
- If SCMD_INITIALIZED leaks, scsi_init_command() skips
   scsi_initialize_rq() for the next filesystem request. Hence,
   jiffies_at_alloc and retries are not reinitialized and that request
   may be failed prematurely by scsi_cmd_runtime_exceeded().

 > Fix this issue by clearing scmd->flags in the error scenario mentioned
 > by calling scsi_cleanup_rq().

Please add Fixes: and Cc: stable tags. For the SCMD_FAIL_IF_RECOVERING
leak, I think this should be:

Fixes: 310bcaef6d7e ("scsi: core: Support failing requests while 
recovering")

 > @@ -1994,8 +1994,8 @@ static blk_status_t scsi_queue_rq(struct 
blk_mq_hw_ctx *hctx,
 >  		 * we hit an error, as we will never see this command
 >  		 * again.
 >  		 */
 > -		if (req->rq_flags & RQF_DONTPREP)
 > -			scsi_mq_uninit_cmd(cmd);
 > +		scsi_cleanup_rq(req);
 > +		scsi_run_queue_async(sdev);

Since the block layer also ends requests for which scsi_queue_rq()
returns BLK_STS_AGAIN, the BLK_STS_AGAIN case has the same issue.
Please convert that case too:

	case BLK_STS_AGAIN:
		cmd->result = DID_BUS_BUSY << 16;
		scsi_cleanup_rq(req);
		break;

Although no SCSI driver returns BLK_STS_AGAIN today, I think both
error paths should handle this in the same way.

Thanks,

Bart.

