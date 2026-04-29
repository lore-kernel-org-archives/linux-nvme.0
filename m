Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7452FF8867
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b37k7qC+HDanuGcpovHBoi0j8q12edBKYp4TZpzTx+M=; b=yznXnJ6vibg/0MgTFMuUAy51go
	1L5N+hIZKrlyCMM/YHcEXeG2hFpw5kixNlUkymU36as+CLMPIt6BLn44cc5qE/ognWcM9fBM8Rc0X
	pRbjnZPw9MRQ7vGOOTCyAM30WwAddCgWWw1CqQ7jazxJlIGGMdmGuZgVEaxSmdWPd1BxfQW0INC8W
	6+fB765iijPZgc3BCOAQzbLhsKPeKXgbsqgEamrv5baECMrj0WGk5YlXcAVCfMe4vju66yc4LQ9SV
	q+dViyaZaVlIbBVMsBL3NFE/8E07HnGTI2JdMuQeaMAxiWcsDZRisADlpkVdiKsloPeG7MvEk+KJE
	sf1HFeUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI3gp-00000003YQ5-2S1D;
	Wed, 29 Apr 2026 12:06:51 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI3gn-00000003YPS-1WoC
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 12:06:50 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 36cfa8ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Apr 2026 14:06:43 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 14:06:43 +0200
Message-Id: <DI5MJM5FJT8C.3MD9WL5GJ4OJF@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout
 per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-5-mlombard@redhat.com>
 <20260428172310.GE2686-mkhalfella@purestorage.com>
In-Reply-To: <20260428172310.GE2686-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_050649_761734_C64B82EB 
X-CRM114-Status: GOOD (  12.10  )
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

On Tue Apr 28, 2026 at 7:23 PM CEST, Mohamed Khalfella wrote:
> On Fri 2026-04-10 09:39:20 +0200, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values on a
>> per controller basis with nvme I/O queues.
>> Add an io_timeout attribute to nvme so that different nvme controllers
>> which may have different timeout requirements can have custom
>> I/O timeouts set.
>>=20
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 000c29bd1f1f..1e6a0eecb30e 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -664,6 +664,52 @@ static ssize_t nvme_admin_timeout_store(struct devi=
ce *dev,
>>  static DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR,
>>  	nvme_admin_timeout_show, nvme_admin_timeout_store);
>> =20
>> +static ssize_t nvme_io_timeout_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(ctrl->io_timeout));
>> +}
>> +
>> +static ssize_t nvme_io_timeout_store(struct device *dev,
>> +			struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
>> +	struct nvme_ns *ns;
>> +	u32 timeout;
>> +	int err;
>> +
>> +	/*
>> +	 * Wait until the controller reaches the LIVE state
>> +	 * to be sure that connect_q is properly initialized.
>> +	 */
>> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
>> +		return -EBUSY;
>> +
>> +	err =3D kstrtou32(buf, 10, &timeout);
>> +	if (err || !timeout)
>> +		return -EINVAL;
>> +
>> +	/* Take the namespaces_lock to avoid racing against nvme_alloc_ns() */
>> +	mutex_lock(&ctrl->namespaces_lock);
>> +
>> +	ctrl->io_timeout =3D msecs_to_jiffies(timeout);
>> +	list_for_each_entry(ns, &ctrl->namespaces, list)
>> +		blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>> +
>> +	if (ctrl->connect_q)
>> +		blk_queue_rq_timeout(ctrl->connect_q, ctrl->io_timeout);
>> +
>> +	mutex_unlock(&ctrl->namespaces_lock);
>
> ctrl->namespaces_lock is not needed to set timeout for ctrl->connect_q.
> Maybe move mutex_unlock() up just after iterating on namespaces?

Yes, it can be unlocked just after scanning the namespaces' list.

Thanks,
Maurizio


