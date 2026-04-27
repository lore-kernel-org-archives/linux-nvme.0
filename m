Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101E7FF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+I2KfQ7fanMGtq6YW5yAWEs+JJ7rZx4NTS69b4+Gazs=; b=mJrrnONIaGRRUnRwlKhtIljG1W
	n+8JHJJIsqHvlU4JDigUtW69MGXv7s1fz2//xlP4+op4o3bNaDOjuwed4bq/hrLsgsmxgT7BbmsF+
	r8GmVqRXmx5Wx32f7kfIVeHzQR6nAxSvhEsEN6YBypLjVxaN9VQu/mIXrn0fhvYaeDxO5oaAiV5jP
	Z8W9dZr54uWZqa5ybd7MtR4/b9YbStuZrewCTOJ9pt/+Uv74nL/xEWTOB1T1MZnC+yabVc3UHPZIu
	1UfarbW4DIFcMzWZW5zFkaNcdBOFYYjIgJyq66qvFfV9/swXwWz4HHEOZCz5u1/Gy1WQwFoRYCNDl
	Ij4RWDaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIZP-0000000Gbry-2fGz;
	Mon, 27 Apr 2026 09:48:03 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIZM-0000000GbrZ-3XWd
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:48:02 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 43504ba7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Apr 2026 11:47:58 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 11:47:58 +0200
Message-Id: <DI3UCAOM00SL.2JC75N91NPHWN@arkamax.eu>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during
 reset
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-8-mlombard@redhat.com>
 <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
In-Reply-To: <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_024801_216265_391F6EF9 
X-CRM114-Status: GOOD (  13.04  )
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

On Mon Apr 27, 2026 at 11:46 AM CEST, Daniel Wagner wrote:
> On Fri, Apr 10, 2026 at 09:39:23AM +0200, Maurizio Lombardi wrote:
>> @@ -375,12 +376,15 @@ static int nvme_loop_configure_admin_queue(struct =
nvme_loop_ctrl *ctrl)
>>  	}
>>  	ctrl->ctrl.queue_count =3D 1;
>> =20
>> -	error =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
>> -			&nvme_loop_admin_mq_ops,
>> -			sizeof(struct nvme_loop_iod) +
>> -			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
>> -	if (error)
>> -		goto out_free_sq;
>> +	if (new) {
>> +		error =3D nvme_alloc_admin_tag_set(&ctrl->ctrl,
>> +				&ctrl->admin_tag_set,
>> +				&nvme_loop_admin_mq_ops,
>> +				sizeof(struct nvme_loop_iod) +
>> +				NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
>> +		if (error)
>> +			goto out_free_sq;
>> +	}
>> =20
>>  	/* reset stopped state for the fresh admin queue */
>>  	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
>> @@ -415,7 +419,7 @@ static int nvme_loop_configure_admin_queue(struct nv=
me_loop_ctrl *ctrl)
>>  	return error;
>>  }
>
> Personally, I am just not a big fan of conditional creation/removal of
> resources controlled via a bool. If it's the cleanest solution fine with
> me, but I wonder if here it wouldn't be cleaner to allocated the tagset
> outside of nvme_loop_configure_admin_queue and obviously the same idea
> for destroy.
>
> Have you tried this approach, does it look too ugly?

I have not tried, but I will look for an alternative approach before
submitting the next version and I will update you.

Thanks,

Maurizio


