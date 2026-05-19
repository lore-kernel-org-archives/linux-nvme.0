Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FD6CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nqwz+Pl/w6xB4LPZG5z+Z0WhVCEqeR0ogVlOPmUBjiY=; b=dBEhysXBFtCe7rjG9r0IfVbDpZ
	UnwjOVOl7rJEz/hBCAWz/kPj8rv3ETNQzJSTRL9H+ChJVgklcytwbWfM8zKRmQZL2fyvNXboxYTw2
	EtklSIqHJ8BZpc/zAU+brpBCOgEsWJCJfQ2kif42Fcqu0PfFur2+SzwVdQsCDWyVgHzPZxPnvoj/D
	Fv7nYoo8IXGsY+WcSzTRZ8PP1WfS+48okS1xfXSH9Cu524Gi6VBd8y+hMx00WmS1aTQpS4/pVVjTx
	Kd7R3QTMVvikmfZme+xoRMiuB2uBIT8rPmI7Hly+OgIXKfn4xYrL+yKqKR+hN0UeqBZFD2SfZO3LI
	7yXmZ3BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGpR-00000000w99-3FcK;
	Tue, 19 May 2026 09:33:33 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGpO-00000000w7p-1Q8W
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 09:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=gQbupuwzcGebkF
	Xljwfw+i6pPmMxgY/ls3RRUC3YeIU=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=lTtakCU3KQMHtH+OAiDcgGnY4HNXv9n5tLnbH
	Wu/FRa/i1KYa1GdHHZIJe84l3pyeYtlM1EYZoA9UIQ3it3sIQ7gzQsAgAqUGvb9XZdvvdo
	Qlv8LeVO2kHJbGC+I4zPGY49vgHQFauuSz448OuZ4l03L9GP6khpP7kQiDkraMONJfG43X
	5TLFP67OU958B3euDYd2F+aQq/zClV+LWrqCyKvaSsRDIDtq/+rI98Mik8JRbh61OYDIMw
	5/8aeCzDFQAQX3Egb0l/EcO82rCHE3Y9KEXlVHsv0Mbyw6WochyTNHGCQXaIoAEUPeozlm
	stlGEuXVFWuayp7yd4e1VI10w==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e50b0428 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 11:33:28 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 11:33:28 +0200
Message-Id: <DIMJT6826UO7.5S1W29JK9I7D@arkamax.eu>
Cc: <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>, <mlombard@arkamax.eu>,
 <mkhalfella@purestorage.com>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V5 7/7] nvme-core: warn on allocating admin tag set with
 existing queue
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-8-mlombard@redhat.com>
 <9776f677-df3d-4258-90af-ea464f8cfca8@suse.de>
In-Reply-To: <9776f677-df3d-4258-90af-ea464f8cfca8@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_023330_708608_A03EBD09 
X-CRM114-Status: GOOD (  16.31  )
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

On Tue May 19, 2026 at 10:52 AM CEST, Hannes Reinecke wrote:
> On 5/14/26 10:32, Maurizio Lombardi wrote:
>> Currently, nvme_alloc_admin_tag_set() silently drops and releases
>> the existing admin_q if it called on a controller that already
>> had one (e.g., during a controller reset).
>>=20
>> However, transport drivers should not be reallocating the admin tag
>> set and queue during a reset. Dropping the old queue and allocating
>> a new one destroys user-configured timeouts and may race against
>> nvme_admin_timeout_store()
>>=20
>> Since all transport drivers are now expected to preserve the admin queue
>> across resets, calling nvme_alloc_admin_tag_set() when ctrl->admin_q
>> is already populated is a bug.
>>=20
>> Remove the silent cleanup and replace it with a WARN_ON_ONCE() to
>> explicitly catch any transport drivers that violate this lifecycle rule
>>=20
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/host/core.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e6bb1f5e9657..f23a957c6e8f 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4893,12 +4893,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ct=
rl, struct blk_mq_tag_set *set,
>>   	if (ret)
>>   		return ret;
>>  =20
>> -	/*
>> -	 * If a previous admin queue exists (e.g., from before a reset),
>> -	 * put it now before allocating a new one to avoid orphaning it.
>> -	 */
>> -	if (ctrl->admin_q)
>> -		blk_put_queue(ctrl->admin_q);
>> +	WARN_ON_ONCE(ctrl->admin_q);
>>  =20
>>   	ctrl->admin_q =3D blk_mq_alloc_queue(set, NULL, NULL);
>>   	if (IS_ERR(ctrl->admin_q)) {
>
> Why don't you return an error here?
> The WARN_ON() now introduces a memory leak (at best); I'd rather
> not do that here as we can easily recover here.

Ok if I just do the following?

if (WARN_ON_ONCE(ctrl->admin_q))
	blk_put_queue(ctrl->admin_q);


Maurizio

