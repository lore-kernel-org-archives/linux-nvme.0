Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE5C9830D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vw5qY40x4C5dklJ73ibDmRnrR0RKgmbPRP29+0wyXUg=; b=hYW+mPMA/Kue/MephYhNZx7yVW
	64eO/OzCvnvN8+yL3SecnWjyU/m4zOXOQ/yinAvz/xxYYUUhvvCwKcQpgBE8zcacixXhny3vReCg7
	BB3KGWBZRM88o6EartbrQTIUaB1lccVysgOrbdh6jHUj/TPVCvahTBByFpkc9uXX624CkuOuVcd9E
	KnQUzDJhWpaueju+w06qWEsNaKrE5qAUANhtWit4irEEicBup5lnVY1oa9U0iGcLceKv2o16AAbXk
	nK9NRPzO08K9gu1EwlC5NV1NSx9uuT6h72RlVfI2+eQsjEWIsgC73W9RouGSH9NVMdyIBwNdIJSC4
	taewRuAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9UpL-00000009c27-2IYQ;
	Wed, 23 Sep 2026 21:48:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9UpL-00000009c21-0ByV
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 21:48:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7890743B49;
	Wed, 23 Sep 2026 21:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0937F1F000FF;
	Wed, 23 Sep 2026 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200110;
	bh=vw5qY40x4C5dklJ73ibDmRnrR0RKgmbPRP29+0wyXUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h6QBh8V05EqLJ+IYPefzsG2aoVf20/NeCh93Ws9r49BOCWzkn14nEUc9cAcyIo+lh
	 lvIMgxuk+dkuKDQ3rN1eMjpY9Kna0PPlKpk/uvUjWzQICRxCiVB9TisW+MfOyeXJH0
	 swGOl12LFGg709dPQgXRkV8lCxBEo9KqLUIyWiJwTBnZfskAAwkOCaaTvwTC9scJna
	 6VvDGwSBOwdNyrQHzR71sugKEqYyDK5dFbYEKYKPDmLtXq8L+0sSwOKA0iSK230s53
	 9/NBx8K1n9h37RahvbnBvnL5eZ3VyjjPyS30hAeOGLGbxj6R+JOttU7cAvgks5cIQt
	 2T26f8YL5xKcw==
Date: Wed, 23 Sep 2026 15:48:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com, sjpark@crusoe.ai, saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Message-ID: <arRJLL4ki-sVQnHf@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923004959.88440-1-kiyer@crusoe.ai>
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

On Tue, Sep 22, 2026 at 05:49:59PM -0700, Krishna Iyer wrote:
> When no usable path exists, I/O on a multipath namespace is queued
> until a path returns. With ctrl_loss_tmo=-1 that can be forever:
> during a long fabric outage any process waiting on the I/O is stuck in
> D state. We hit this on virtualization hosts, where a SIGKILLed VM
> process cannot exit while draining I/O to an unreachable NVMe/TCP
> target.
> 
> Nothing can fail this I/O without tearing something down: controller
> deletion takes every namespace on the controller with it.

I agree with Hannes that we shouldn't need a new flag for this. The
current behavior is just broken in a few ways.

We just need to restrict queue_if_no_path to only if there really are no
paths so that we actually respect the failfast_tmo.

And the ANA inaccessible and persistent-loss handling you introduced
here should just be the default without requiring a flag. But I think
you need to add a requeue_list kick in nvme_update_ns_ana_state() too in
case the ANA transition leaves the namespace inaccessible.

