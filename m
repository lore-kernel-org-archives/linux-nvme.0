Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E6C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 20:15:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8939B23A56
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 20:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8939B23A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TaZVa7Rmhnw9FxyXZoRyXsZGxNBpZtYpkNJB/24gwpk=; b=rFqdqpBrUYeT9Y5arZe4TOPuJ
	9/SbM2M92VEPbRT4O6jFhEiDx8+CzJie45FX6jxSGFR+dBYsNuU4m6XSia5x8G+5XAdXHmVrSCMFV
	qpDhGgBJQarqYpIIwz9yLi/xnSuqznwW6jHGSIxIGLHrxbbV8iDi6KO+ICCOjVQSGSs4rfCWTl9B0
	sq3NNUUvrtiakjI/WnKsWjnVPwXzjMn4OseMjmDEhFlVHPz4VNBHQASjJB43c1/Virnvuqk+uf47S
	JXpet4h/9WoiVJShwY1Ea0KHwVz7spNHkbhhxYtI7TzBUf12MbWmNnZ3oe0JprFvy9ElIsN91XAcm
	Rx9Cqvppg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2gMG-0003WE-Kf; Thu, 21 Jan 2021 20:15:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2gMC-0003Uz-Uy
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 20:15:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 954C023A56;
 Thu, 21 Jan 2021 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611260102;
 bh=H2bx1y8E84tQpRbz82Rir4kd42qiUhICqG0o8wldeD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZdHDZ+swgZ7E1pTyXranaa43eWM632S0sQlaVY2GvJFtcDgQPtltxEK0G9o7OipOi
 o8t2wLmt1vcdBLMbCkIqj6/NeUOS+tlTApHsr+7bNaNr3qGrCsWqSVUx7T5689O3Y3
 5/kYMJZVzL9lZiewZ6EOfvGiMPwngwUqp4Khar2wImXk4mVyRXl7fkUXYbCWTZIBw2
 D4RKi+GeLDnzF08IT7sGm2DFcWaqsvnb+YExk6lRGe8invW/Hxgu8u8d+nE5Fq1urD
 9PwgJ5crZ8rvEEZITqluG7kyfJQaCZO/QwO7+o/MfKmsUFNk7K3D1/R/MvCh26ZnCE
 2zUBDGuo3n65A==
Date: Thu, 21 Jan 2021 12:14:59 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
Message-ID: <20210121201459.GA1727271@dhcp-10-100-145-180.wdc.com>
References: <20210121095021.22807-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121095021.22807-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_151505_100282_91BE491B 
X-CRM114-Status: GOOD (  11.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 21, 2021 at 10:50:21AM +0100, Hannes Reinecke wrote:
> If the call to nvme_set_queue_count() fails with a status we should
> not ignore it but rather pass it on to the caller.
> It's then up to the transport to decide whether to ignore it
> (like PCI does) or to reset the connection (as would be appropriate
> for fabrics).

Instead of checking the error, wouldn't checking the number of created
queues be sufficient? What handling difference do you expect to occur
between getting a success with 0 queues, vs getting an error?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
