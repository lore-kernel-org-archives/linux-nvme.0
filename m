Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BEACD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/CxjR74qfj4NhT2Xdvad5ZnXWhPz60gyCd4fl+B/SA=; b=T/zJ4jV1RKSSKxHbL3uR3WjA0M
	nI+bUueTHApgaTuyedvSlMwiirmj/j7Nq4t8YUThpYxXJ0+F7k8e28eu28SAAN0TkNr8eZ6sFj2p2
	H/GizSOI7n7crmv9Cpjmh5GwbwR5F73jdl0E4DTynMLFtB9fViU+xE8uHdOL+HECtaEuPfZr/wpnj
	VHaMr7K+jrIhU2BokNRy12RUOJ4JpbVoW6sgBSjeaKstboFVZJXtwOByhVSyRMbsAqxeqAE/Wfhgj
	UISmAzoI2EgGVSPU22z+Lg4xJu8hUU6RVP5XXx2VT2aFhwkW9FoCsp7UdPsjomt6cLxGSAk9n2K8U
	+0COx6xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNOh-0000000D1pE-01d0;
	Mon, 11 May 2026 09:57:59 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNOb-0000000D1oY-3ei4
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:57:57 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e51e22dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 11:57:50 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 11:57:50 +0200
Message-Id: <DIFRBHA4ZPSU.WJQ6KF38WYCK@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>, <mlombard@arkamax.eu>,
 <mkhalfella@purestorage.com>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V4 7/9] nvme-core: align fabrics_q teardown with admin_q
 in nvme_free_ctrl
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-8-mlombard@redhat.com>
 <837128f8-bff3-41da-8960-f43ef79797eb@suse.de>
In-Reply-To: <837128f8-bff3-41da-8960-f43ef79797eb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_025754_245196_B9FF3392 
X-CRM114-Status: GOOD (  11.96  )
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

On Mon May 11, 2026 at 11:53 AM CEST, Hannes Reinecke wrote:
> On 5/8/26 15:33, Maurizio Lombardi wrote:
>> Currently, the final reference for the fabrics admin queue (fabrics_q)
>> is dropped inside nvme_remove_admin_tag_set(). However, the primary
>> admin queue (admin_q) defers dropping its final reference until
>> nvme_free_ctrl().
>>=20
>> Move the blk_put_queue() call for fabrics_q from nvme_remove_admin_tag_s=
et()
>> to nvme_free_ctrl(). This aligns the lifecycle management of both admin
>> queues, ensuring they are freed symmetrically when the controller is fin=
ally
>> torn down.
>>=20
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/host/core.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 5d3200a66f8e..73575d087a07 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4932,10 +4932,8 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *=
ctrl)
>>   	 */
>>   	nvme_stop_keep_alive(ctrl);
>>   	blk_mq_destroy_queue(ctrl->admin_q);
>> -	if (ctrl->ops->flags & NVME_F_FABRICS) {
>> +	if (ctrl->ops->flags & NVME_F_FABRICS)
>>   		blk_mq_destroy_queue(ctrl->fabrics_q);
>> -		blk_put_queue(ctrl->fabrics_q);
>> -	}
>>   	blk_mq_free_tag_set(ctrl->admin_tagset);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
>> @@ -5077,6 +5075,8 @@ static void nvme_free_ctrl(struct device *dev)
>>  =20
>>   	if (ctrl->admin_q)
>>   		blk_put_queue(ctrl->admin_q);
>> +	if (ctrl->fabrics_q)
>> +		blk_put_queue(ctrl->fabrics_q);
>>   	if (!subsys || ctrl->instance !=3D subsys->instance)
>>   		ida_free(&nvme_instance_ida, ctrl->instance);
>>   	nvme_free_cels(ctrl);
>
> One wonders why we check for 'flags' in the first hunk, but for the=20
> existence of 'fabrics_q' in the second hunk.
> But anyway.

That is true,

I have to send a V5 anyway to address other comments, so I will change it t=
o use
if(ctrl->fabrics_q).

Maurizio


