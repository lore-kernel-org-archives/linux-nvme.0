Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F5CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MR9RjZfLa7s2uHd5pmVsJeJQRZrShTdWCwy2auI20rw=; b=hgkqe4Mm/q3HAyf9La3Z5iNSsc
	+Fj3lR2Uojv6QjccKi71QVQO2W4YbMP6hoyWvxIFObmapYGGxD/hAi1ObvCCf2Pn4TuyM4CuHaQ/l
	yWJTb4c8GdXzx6jGlWJG8TA6WEeuyS0h2Y8qK1aiC6zsg0Xezd7FFnMn6kimTPTnJc9ew1LTESypC
	QMfuu/QiIUZH2qnCIpAZD///eV4liOs5HjUGdcmkcSi+HVj6kWA4uiPNTSdqckcEC2nC/XIHQvfmZ
	uShu2MAJYxhEZHrQUFoy6vCCH4lex6aR4f6H3hhs2A+xlh2xlfDQDWR5RDlRFcJBDfAiNUG35EzFJ
	wYKnQLPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOp3-0000000DK0F-1gEn;
	Mon, 11 May 2026 11:29:17 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOoz-0000000DJzG-1N2j
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:29:14 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 272f8a96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 13:29:10 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 13:29:10 +0200
Message-Id: <DIFT9EP0Y3DI.29VPGB322MQ8F@arkamax.eu>
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin
 timeout per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Christoph Hellwig" <hch@lst.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-3-mlombard@redhat.com>
 <20260511080721.GB29677@lst.de>
In-Reply-To: <20260511080721.GB29677@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_042913_769749_2B4090EB 
X-CRM114-Status: GOOD (  14.42  )
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

On Mon May 11, 2026 at 10:07 AM CEST, Christoph Hellwig wrote:
> On Fri, May 08, 2026 at 03:33:28PM +0200, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values
>> on a per controller basis with nvme admin queues.
>> Add an admin_timeout attribute to nvme so that different
>> nvme controllers which may have different timeout
>> requirements can have custom admin timeouts set.
>
> Please use up all 73 characters for commit messages.
>
>> =20
>> +static ssize_t nvme_admin_timeout_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>
> The indent for prototype continuations should use two, not three tabs.
>
>> +	 * Wait until the controller reaches the LIVE state
>> +	 * to be sure that admin_q and fabrics_q are
>> +	 * properly initialized.
>
> Please use up all 80 characters for comments.

Ok.

>
>> +	 */
>> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
>> +		return -EBUSY;
>> +
>> +	err =3D kstrtou32(buf, 10, &timeout);
>> +	if (err || !timeout)
>> +		return -EINVAL;
>> +
>> +	ctrl->admin_timeout =3D msecs_to_jiffies(timeout);
>> +
>> +	blk_queue_rq_timeout(ctrl->admin_q, ctrl->admin_timeout);
>> +	if (ctrl->fabrics_q)
>> +		blk_queue_rq_timeout(ctrl->fabrics_q, ctrl->admin_timeout);
>
> Do we really want to apply the the admin timeout for the fabrics queue?
> If so can you document here why we do that?

Both admin_q and fabrics_q are initialized to share the same
NVME_ADMIN_TIMEOUT value, therefore keeping them in sync maintains the
consistency.

If we didn't apply the timeout to fabrics_q, it would end up
operating under a different timeout than the standard admin_q, is there
any reason why we would want that?

Maurizio



