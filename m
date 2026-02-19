Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F060BE9A03B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QpvUoO8SvwaFYWuI/CPEkZHlXgWnpcpRdU5D+5Dylhw=; b=GJWLoL2Jt2jRzwtwUDyJ2iRKCK
	3G0XyNXq6Zre6WaBVhY3jYvxIe9bz2rsCxL7VVvhbjr9QeA9pCz8HsUr0dhQgjN+uUInBk67eqvts
	loJJ3xgVdbISShRmrvX3Ci/UIkk20kU3vK85SESzqn4atLwDD8SGdrEDlcT/6cehdH7aV5cC0kvjz
	DGKoD5O5SqCJzDMAUjNLh6W9VkyY5x0EG66K5pgGAC7LW4Np2YPjCOlvZp+H6T2st4HlWVBvqILDO
	UU9iQRd2fqxLz6QTpWxIqbQ4LGm02714gZ82mgRnevZr59yt8mApQ4ji9bjc2nvmK6QO3roGnJEJq
	SerfFXdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt6iB-0000000BcWw-0MuI;
	Thu, 19 Feb 2026 16:17:07 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt6i8-0000000BcW5-0hya
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 16:17:06 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 89f02d34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 17:16:57 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Feb 2026 17:16:57 +0100
Message-Id: <DGJ2NM6TSHVX.3PDKR8JRZU2CF@arkamax.eu>
Subject: Re: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin
 timeout per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@bsdbackstore.eu>
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-3-mlombard@redhat.com>
 <20260218180024.GM2392949-mkhalfella@purestorage.com>
In-Reply-To: <20260218180024.GM2392949-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_081704_552744_71DFBAE9 
X-CRM114-Status: UNSURE (   7.03  )
X-CRM114-Notice: Please train this message.
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

On Wed Feb 18, 2026 at 7:00 PM CET, Mohamed Khalfella wrote:
>> +static ssize_t nvme_admin_timeout_store(struct device *dev,
>> +			struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
>> +	u32 timeout;
>> +	int err;
>> +
>> +	err =3D kstrtou32(buf, 10, &timeout);
>> +	if (err || !timeout)
>> +		return -EINVAL;
>> +
>> +	blk_queue_rq_timeout(ctrl->admin_q, msecs_to_jiffies(timeout));
>> +
>> +	return count;
>> +}
>> +
>> +static struct device_attribute dev_attr_admin_timeout =3D  \
>> +	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
>> +	nvme_admin_timeout_show, nvme_admin_timeout_store);
>> +
>
> Do we want similar attribute to ctrl->fabrics_q?

Makes sense, I think.

We don't need other attributes, it should be sufficient to modify
nvme_admin_timeout_store() to do the following:

static ssize_t nvme_admin_timeout_store(struct device *dev,
                        struct device_attribute *attr,
                        const char *buf, size_t count)
{
        struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
        u32 timeout;
        int err;

        err =3D kstrtou32(buf, 10, &timeout);
        if (err || !timeout)
                return -EINVAL;

        blk_queue_rq_timeout(ctrl->admin_q, msecs_to_jiffies(timeout));
	if (ctrl->ops->flags & NVME_F_FABRICS)
		 blk_queue_rq_timeout(ctrl->fabrics_q, msecs_to_jiffies(timeout));

        return count;
}

Maurizio


