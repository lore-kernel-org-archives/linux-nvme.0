Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338B606A33D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eNl2jBti;
	dkim=temperror header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P8dkLOts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OeXuhuGa1Oh38vtgGn+F+zPBex4mTRGe2TpzjOfha98=; b=eNl2jBtip9v+ti
	jJWCBFEfLC4Nn7BkkL1zfxa0pXOm7BKlGbIXr8poAtSTEiCdNAwzix30nW3OU0vnCyfNxZrZBSyZe
	vi0Gg8FkKHIoharz/59IePdFW4tXOTdDlfYC5Z9d07GbKkSYIMirpbdmfPKI/dmpR1a7ykIzTZ0Ul
	vC+OAUgipk7ZpA0QZ79aSe41KxTe7Of/ADRq2v/AhK9TJGKDd9F1/ic54/91Dq34/1qMhhraEFxOI
	+0LIt8sAq2HG42pEeXvZo837Pxo6XJU2w7b0tc4VeO3fha1BC4CWDk9ZbceKxG1+ep97W04UMT75N
	cC+nLJX28LWIpAqnQ9Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPGGL-0000000Bhhp-09Xi;
	Fri, 06 Nov 2026 09:29:33 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPGGH-0000000Bhgt-3XHg
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 09:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793957367; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OeXuhuGa1Oh38vtgGn+F+zPBex4mTRGe2TpzjOfha98=;
	b=P8dkLOts8wS7430Ihv4QNNZMZH/Nl6zdP2M0HIoGqf8vOcf9uXB9YBmi2lHWgMVxRHM6izZVU3yhZOjzKaTBXJ1c4Q2ngQxEzbFqSKzEuTRyJx5oLFxS2+Bxe5iuw8JhB0QOAo6oDjUuOXmmFb0Irx9EFvGTOLZ8JJ20fwDqc0k=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEBIpA3_1793957366;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEBIpA3_1793957366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 17:29:27 +0800
Message-ID: <e9497a43-423a-4908-8cce-8b8d2a30a53d@linux.alibaba.com>
Date: Fri, 6 Nov 2026 17:29:25 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nvmet: fix controller reference leak in
 nvmet_install_queue() error paths
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-6-kanie@linux.alibaba.com>
 <74470d7c-5763-4963-ae0d-90e87eb208f3@suse.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <74470d7c-5763-4963-ae0d-90e87eb208f3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_012930_036649_3CB3464F 
X-CRM114-Status: GOOD (  14.28  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/6 15:31, Hannes Reinecke 写道:
> On 11/6/26 2:58 AM, Guixin Liu wrote:
>> nvmet_install_queue() takes a controller reference for req->cq->ctrl
>> and installs the controller in both req->sq->ctrl and req->cq->ctrl,
>> but neither error path undoes its work: the busy return after the
>> failed cq->ctrl cmpxchg leaves sq->ctrl set and the reference taken,
>> and the err path for a failed transport ->install_queue() clears
>> sq->ctrl but leaves cq->ctrl set with the reference still held.
>>
>> The queue is then permanently wedged: a connect retry finds the stale
>> cq->ctrl, takes another reference and fails again, and the leaked
>> references keep the controller alive forever. Clearing cq->ctrl also
>> matters because the caller drops its own reference, which can be the
>> last one on the admin connect path, leaving cq->ctrl dangling.
>>
>> Roll back the sq->ctrl assignment and drop the reference on both
>> error paths, and also clear ctrl->cqs[qid] on the err path to mirror
>> what nvmet_cq_destroy() would do.
>>
>> Fixes: bb78836b3a7ca ("nvmet: fabrics: add CQ init and destroy")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/target/fabrics-cmd.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
>> index fc626c2fd2c9..773dad857a35 100644
>> --- a/drivers/nvme/target/fabrics-cmd.c
>> +++ b/drivers/nvme/target/fabrics-cmd.c
>> @@ -216,6 +216,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>>       if (old) {
>>           pr_warn("queue already connected!\n");
>>           req->error_loc = offsetof(struct nvmf_connect_command, opcode);
>> +        req->sq->ctrl = NULL;
>> +        nvmet_ctrl_put(ctrl);
>>           return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
>>       }
>>   @@ -234,6 +236,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>>               pr_err("failed to install queue %d cntlid %d ret %x\n",
>>                   qid, ctrl->cntlid, ret);
>>               ctrl->sqs[qid] = NULL;
>> +            ctrl->cqs[qid] = NULL;
>>               goto err;
>>           }
>>       }
>> @@ -242,6 +245,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>>     err:
>>       req->sq->ctrl = NULL;
>> +    req->cq->ctrl = NULL;
>> +    nvmet_ctrl_put(ctrl);
>>       return ret;
>>   }
>>   
>
> That looks wrong.
> We already do a call to 'nvmet_ctrl_put()' in 'nvmet_execute_admin_connect()', right after nvmet_install_queue()
> failed.
>
> Cheers,
>
> Hannes
Right, I miss that, sorry, remove this in v2.

Best Regards,
Guixin Liu


