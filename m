Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A8CD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 05:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=17ewGM0r+PGAeUVaI9rb6QCG4BGkiFUn31YatY1FXOQ=; b=UbBXguM2poR7ZZYUzQIv3p0Kyj
	9u1pOF+ps0F56ZuGc5+KXpLR0EOu7zRcxZF4nFrUlxTA4rOGf78pFloh9cyyNFTANNQLXpSj2DvLs
	nwvHBkJnPeW4iYUYvzIyYtwwn3/yovziRjmy97FlCQpDevB+BbVA0HWJ1vb6ccP6nxdsef9pazZf3
	uMEo+CujGIW6wr69JbVoeTzPo7OhJ0+DTvP15zp0WMS14niQldfOZ6b3O9vthzaqh7G0+GVyAtJpU
	1HptCr3gvmdC9mKXU0luggwulfMbQMzTWsgdJMdJs8b9Trmgw5u5Tr3a10v23ZFD6h3MgK9TAE/0k
	IP7udU+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNlUz-00000007SZx-1IMy;
	Fri, 15 May 2026 05:54:13 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNlUw-00000007SYR-1jtA
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 05:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=3eO8ya7um1wnAv
	SVUXfUuxr6bgiNoWaOBHUIW0un3HI=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=IwfiQqvw6bdY0JFV7a+1XAPpqvS2d+NusvrEoreY
	iPckSrrKZLf+e9WEltY1lhlaKqnbW34l9pveJL9llCUUNZJ7N1LgqCbDYAjE54jgnJFENa
	YxnBV56qpz67RSxQiuPsEmac10W8dnNLwbhucjflkzHQM6XnEpmka9YsCSENBrMBnx5yMy
	T4v/mnvZRJb3xqfGqA24QCXPf801o+1NJimZDNr7GTOxoJAMd3llqq9EImzdLdE70dLkCS
	I27MgAcuvay0uU4afU66cl2wVEoUWQ6ppvkq7Bkh7fAgguf4gMvOCaYCBbhxCde/gBEgPC
	I3lI48+xUMGRUrqEXSzXGQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 68f19c64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 May 2026 07:54:03 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 May 2026 07:54:03 +0200
Message-Id: <DIJ0N00IF49P.2C9YI5U1FE9FG@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V5 3/7] nvme: add sysfs attribute to change admin
 timeout per nvme controller
X-Mailer: aerc 0.21.0
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-4-mlombard@redhat.com>
 <20260514165929.GJ10532-mkhalfella@purestorage.com>
In-Reply-To: <20260514165929.GJ10532-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_225411_088503_AB6EBFDE 
X-CRM114-Status: GOOD (  15.78  )
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

On Thu May 14, 2026 at 6:59 PM CEST, Mohamed Khalfella wrote:
> On Thu 2026-05-14 10:32:51 +0200, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values on a
>> per-controller basis with nvme admin queues.
>> Add an admin_timeout attribute to nvme so that different nvme controller=
s
>> which may have different timeout requirements can have custom admin
>> timeouts set.
>>=20
>> The admin timeout is also applied to the fabrics queue (fabrics_q).
>> The fabrics queue is utilized for fabric-specific administrative and
>> control operations, such as Connect and Property Get/Set commands.
>>=20
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Thanks for the review.

>
>> ---
>>  drivers/nvme/host/core.c  |  1 +
>>  drivers/nvme/host/nvme.h  |  1 +
>>  drivers/nvme/host/pci.c   |  2 +-
>>  drivers/nvme/host/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 44 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 84f295e3bf08..fe6dcd19cecb 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -5144,6 +5144,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct =
device *dev,
>>  	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>>  	ctrl->ka_cmd.common.opcode =3D nvme_admin_keep_alive;
>>  	ctrl->ka_last_check_time =3D jiffies;
>> +	ctrl->admin_timeout =3D NVME_ADMIN_TIMEOUT;
>> =20
>>  	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>>  			PAGE_SIZE);
>
> nvme_alloc_admin_tag_set() uses NVME_ADMIN_TIMEOUT. Do we want to
> replace that with ctrl->admin_timeout?
>

That shouldn't be necessary. nvme_alloc_admin_tag_set() is only called
once during initial controller setup. Since the user cannot modify the
admin_timeout sysfs attribute until the controller reaches the LIVE state,
ctrl->admin_timeout will still just be the default NVME_ADMIN_TIMEOUT
at this stage.

Maurizio

