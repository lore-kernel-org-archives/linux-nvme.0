Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EF606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gS8AsSCZ;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OMVKAiP1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mkje3WKRACqEVFZ1c4Wen6c2CE20/dIWNeOIiG7XF0Q=; b=gS8AsSCZ/hGtQ/
	yT5o3kmYJg6L4fv6aiXOUnITCYS5e2ziGPM7APXKf++dSswDgcXa8+eIydyvLu2EBMRFEpQko9eCI
	cqoWxa/J5JC7WtcPVJc/FjjT7zJRriwEXxxzqfZr0BGQVYTbuZsboKXZLFXFbpJjbl4pBz4SCR9Cy
	ibfljeN0cL6Atuz//WTcaDslEOzbRRu2PzvOQY6P1ncwiqT7VtRgP0yGw1FwyU6iERO08o52u9HTd
	C2a2bbdQ3+2j5OZxjf57HkQZiCHX5guCvi6koCzJRZ4W0g0wa5XS/28TdDSb8HpF/wkvHHUElsEA6
	i5eOZi1rmU0EP/Oc0fmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKOP-00000003Xqa-493o;
	Tue, 03 Nov 2026 19:42:01 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKON-00000003XpX-1b49
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=mkje3WKRACqEVFZ1c4Wen6c2CE20/dIWNeOIiG7XF0Q=; t=1793734919; x=2109094919; 
	b=OMVKAiP1HPQ4jmKsoFtc8OBTp0bB1VGZkvxjBid4TX+Lc9nMG1vJTnSWQoBaMGT7PLXhbDKVfyt
	CKxGfItM7fsweRMii5WXugbZQCvppoOAhDmXUwtSa5ve5jma1VJjrwdvzHkH34HAA/j0xKVXhJzgZ
	kipXYwhcGZncfG3M0uHFci2lv0GyAoTHuKa+tZgyHb8+mbIPGGxeGKU1u1HUS8+XlQ55k98fc3/EW
	L1uD5jIZMo3ppVEEZWg33J5R6xnT08Jmp+hZFMpDwUvgAAUxa5GcaHVENeCvlj1Oy1NdzyH2jbckx
	HR1NiEegQLf62fKo5S17eLrefAa0DSp2qG8g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xOKOG-001XvR-DA; Tue, 03 Nov 2026 20:41:52 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xOKOF-0000000CdiP-0mDS;
	Tue, 03 Nov 2026 20:41:52 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1xOKOF-0000000EscM-07Ai;
	Tue, 03 Nov 2026 20:41:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 16:41:50 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: K <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
In-Reply-To: <CACd_6n03YaDPrJgD6EB=bHoN+sQ=aCH0XvPfpdkm_68WpPMqJw@mail.gmail.com>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <CACd_6n03YaDPrJgD6EB=bHoN+sQ=aCH0XvPfpdkm_68WpPMqJw@mail.gmail.com>
Message-ID: <8db6dc5f7735c3799d0b11824e28d706@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -3.0
X-Rspamd-Action: no action
X-Rspamd-Bar: --
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_114159_589405_E4D6A156 
X-CRM114-Status: GOOD (  29.22  )
X-Spam-Score: -2.1 (--)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 
 Content preview:  On 2026-11-03 16:21, K wrote: > Thanks, pls let me take a
   look, it looks like all AI generated. May I AI has not been used for analysis
    or the commit message; just the reproducer, as mentioned. Please check git
    log for previous contribution history. 
 
 Content analysis details:   (-2.1 points, 5.0 required)
 
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -0.1 DKIM_VALID_AU          Message has a valid DKIM or DK signature from author's
                             domain
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
 -0.1 DKIM_VALID_EF          Message has a valid DKIM or DK signature from
                             envelope-from domain
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily valid
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.0 DMARC_PASS             DMARC pass policy
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 16:21, K wrote:
> Thanks, pls let me take a look, it looks like all AI generated. May I

AI has not been used for analysis or the commit message; just the
reproducer, as mentioned.
Please check git log for previous contribution history.

If you're not comfortable with the commit message, I can certainly
change the authorship.
Please just let me know your preference (e.g., Originally-by,
Co-developed-by, name in the commit message, or none).

> know what kind of test you run or LLM run?

Sure. It's a synthetic reproducer that runs the completion handler
again.

Code: https://termbin.com/40tl

In a VM with 1 vCPU, (so nvme_handle_cqe() -> nvme_try_complete_req() ->
blk_mq_complete_request_remote() returns false),
echo mq-deadline >/sys/block/nvme0n1/queue/scheduler # (so
nvme_handle_cqe() -> blk_mq_add_to_batch() also returns false),
  # with both returning false, nvme_handle_cqe() ->
nvme_pci_complete_rq() is taken, reaching __blk_mq_free_request(), which
does rq->mq_hctx = NULL
echo 1 >/sys/module/nvme/parameters/repro_arm # prepare reproducer
dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1 iflag=direct # oops

cheers,

> 
> Regards,
> Chao
> 
> On Tue, Nov 3, 2026 at 2:17 PM Mauricio Faria de Oliveira
> <mfo@igalia.com> wrote:
>>
>> From: Chao Shi <coshi036@gmail.com>
>>
>> There are a few kernel crash reports from the Steam Deck where incorrect
>> completions received by the nvme driver have a command id/tag associated
>> with a freed request (rq->mq_hctx = NULL), dereferencing a NULL pointer.
>>
>>   nvme_handle_cqe()
>>   -> nvme_try_complete_req(req, ...)
>>      -> blk_mq_complete_request_remote(req)
>>         -> if ((rq->mq_hctx->nr_ctx == 1 &&   /* Oops! */
>>
>> Although the usual suspect is the nvme device firmware, one report shows
>> incorrect completions also received by the ath11k wireless driver at the
>> same time, which suggests the underlying issue might be something else.
>>
>>   [ 2585.223155] ath11k_pci 0000:03:00.0: tx completion for unknown msdu_id 0
>>   [ 2585.223163] ath11k_pci 0000:03:00.0: tx completion for unknown msdu_id 0
>>   ...
>>   [ 2585.228077] nvme nvme0: request 0xec genctr mismatch (got 0x2 expected 0xa)
>>   [ 2585.228079] nvme nvme0: invalid id 8428 completed on queue 3
>>   [ 2585.228205] nvme nvme0: request 0xe2 genctr mismatch (got 0xe expected 0x2)
>>   [ 2585.228208] nvme nvme0: invalid id 57570 completed on queue 3
>>   ...
>>   [ 2585.228726] BUG: kernel NULL pointer dereference, address: 00000000000000fe
>>   ...
>>   [ 2585.228752] RIP: 0010:blk_mq_complete_request_remote+0x1c/0x160
>>   ...
>>   [ 2585.228787] Call Trace:
>>   [ 2585.228790]  <IRQ>
>>   [ 2585.228828]  nvme_poll_cq+0x14b/0x300
>>   [ 2585.228838]  nvme_irq+0x41/0x80
>>   [ 2585.228845]  __handle_irq_event_percpu+0x4a/0x180
>>   [ 2585.228850]  handle_irq_event+0x38/0x90
>>   [ 2585.228853]  handle_edge_irq+0x8b/0x230
>>   [ 2585.228858]  __common_interrupt+0x3e/0x90
>>   [ 2585.228862]  common_interrupt+0x80/0xa0
>>   [ 2585.228866]  </IRQ>
>>   [ 2585.228868]  <TASK>
>>   ...
>>
>> However, even when the nvme device firmware is at fault and need an update,
>> it is interesting for the kernel not to crash, so that it is even possible
>> to run the firmware update where the issue happens frequently or early on,
>> and while waiting for the update to be made available by the device vendor.
>>
>> The fix is to check that a request is actually in-flight before completing
>> it. This has been previously reported and proposed by Chao Shi, found with
>> fuzzing, but without further feedback since July. I happened to learn of it
>> only after root-cause analysis and reaching a similar conclusion, checking
>> for prior work/feedback, thus keeping them as Author/Signed-off-by, adding
>> myself as Co-developed-by for the commit message and root cause analysis.
>>
>> In Chao Shi's patch, there's been feedback/question of whether this should
>> be done in blk-mq, as this is not specific to nvme. I'd say no, at first:
>> - Some blk-mq calls for completion have no return value (e.g., completion
>>   on other CPUs), which suggests maybe an API change and updates to many
>>   callers, all for an edge case.
>> - An alternative available currently might be blk_mq_ops.complete(), but
>>   that is handled in the driver anyway, with risk of hitting an error in
>>   blk-mq (like this) as the code changes, and seems semantically wrong,
>>   i.e., completing a request that should not have been completed.
>> - Keeping in mind a small fix for stable, for now, should this be merged.
>> - But happy to take suggestions if blk-mq is indeed the way to go.
>>
>> This has been tested with a synthetic reproducer produced by an LLM.
>>
>> Originally-by: Chao Shi <coshi036@gmail.com>
>> Signed-off-by: Chao Shi <coshi036@gmail.com>
>> Link: https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi036@gmail.com/
>> Link: https://lore.kernel.org/linux-nvme/20260715005105.1115958-1-coshi036@gmail.com/
>> Co-developed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
>> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
>> ---
>>  drivers/nvme/host/nvme.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd50155af115b4e1f6 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>>                         tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>>                 return NULL;
>>         }
>> +       if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
>> +               dev_err(nvme_req(rq)->ctrl->device,
>> +                       "completion for request %#x not in flight\n", tag);
>> +               return NULL;
>> +       }
>>         return rq;
>>  }
>>
>>
>> ---
>> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>> change-id: 20261102-nvme-double-cmpl-uaf-blk-mq-e3d28f74cdaf
>>
>> Best regards,
>> --
>> Mauricio Faria de Oliveira <mfo@igalia.com>
>>

-- 
Mauricio

