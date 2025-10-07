Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE60CCA470
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 06:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kDgZfIHBnrX/QfSAAO9t6FUUAcuDSRPxnKzeI2BCUOo=; b=T7n/HpSGGIFWKDEjAbnFIoK5cd
	slA4yVY8VQoHTmM8MBZmW1EglzY36PcgNSdyj/8SbwmyJxWNjnRIbIGqisNcykdQh1Akop2XhQvCx
	Wj347MqEhDOXEIgIlUQ7+PRZouSk5Tozb85Q2ZdsmZ9qKPHpt+CajMbvqOE1JJqZelpp5l0fXF00w
	o9gujtPbe5oDrSJhyRc5RfFw84CWw61OuJtq3KpjtbgWoNkO5atwUl6LgR5pYpztw61oWTNDoQkn7
	SGd/NWIMQZ7dQzlIfSSDE+tYiUnQ/6a0TaUQdEajdhwi+A1ODQvqki2BrWCjQGq1mdWtiZJCxj6NN
	oO5gv/6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61T3-00000001NyJ-11t6;
	Tue, 07 Oct 2025 06:46:37 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61T0-00000001Nxf-37YC
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 06:46:36 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 8b2b63a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Oct 2025 08:46:32 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 08:46:32 +0200
Message-Id: <DDBVZC2RLIZB.96BBZ55VO06P@bsdbackstore.eu>
Cc: <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet-tcp: remove a redundant line in
 nvmet_tcp_release_queue_work
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Tomas Henzl"
 <thenzl@redhat.com>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
X-Mailer: aerc
References: <20251006175910.62721-1-thenzl@redhat.com>
 <DDBVK80QRT7V.2R17ZR0TPDAHO@bsdbackstore.eu>
In-Reply-To: <DDBVK80QRT7V.2R17ZR0TPDAHO@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_234635_133376_E54A0351 
X-CRM114-Status: GOOD (  11.78  )
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

On Tue Oct 7, 2025 at 8:26 AM CEST, Maurizio Lombardi wrote:
> On Mon Oct 6, 2025 at 7:59 PM CEST, Tomas Henzl wrote:
>> cancel_work_sync(&queue->io_work) is called twice, remove the
>> second instance.
>>
>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
>> ---
>>  drivers/nvme/target/tcp.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 470bf37e5a63..a1d0f6b18b2c 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1577,7 +1577,6 @@ static void nvmet_tcp_release_queue_work(struct wo=
rk_struct *w)
>>  	nvmet_tcp_uninit_data_in_cmds(queue);
>>  	nvmet_sq_destroy(&queue->nvme_sq);
>>  	nvmet_cq_put(&queue->nvme_cq);
>> -	cancel_work_sync(&queue->io_work);
>>  	nvmet_tcp_free_cmd_data_in_buffers(queue);
>>  	/* ->sock will be released by fput() */
>>  	fput(queue->sock->file);
>
> I am not sure it's safe to remove it because io_work can potentially
> re-enqueue itself.
>

Small correction, the problem isn't io_work re-enqueing itself
(the first cancel_work_sync() prevents that); I think the real problem
is that nvmet_sq_destroy() could end up calling
nvmet_tcp_queue_response() which enqueues io_work again.

Maurizio


