Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE642CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3F1UUlCXoimO/BIhNLnHjRQEzJ3XkWDmqgCng0m4dEE=; b=q6U2pSq+MJPAC6rpNpauLOGhT2
	xhABq7mGEGaVXmgmAqnqyV3ffs68zWTCvQL15ul5NMi2DcQP+hLlhc7DHkcoxDFpxuuH8YYNXt5cU
	gFIJZAHN2rVkFD0DgI/rfoZDgW0CEyaygpxVEdQ1aQCLGhiXTAxBH6eaUdq9aAMi1f39IbVb5NX2I
	6pnrXEn5tm/1UQKDbCBlaYQ7psz/+J3RY32iM/wL7A97qWqqDKU6rv/hN/YK7b3j9G3yMvowvKQ6i
	/Glp/BQy+6WhfvIQSt1e43CU1GPOTFzze6cuMwlbZpoj6MzUBzSijpgWGLJYWiVENx1wEY9dTUGwX
	tJWDFHYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3xM-00000007ypX-33h9;
	Thu, 21 May 2026 14:01:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3xJ-00000007yof-217r
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:00:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 12D14444E2;
	Thu, 21 May 2026 14:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893221F00A3D;
	Thu, 21 May 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372057;
	bh=3F1UUlCXoimO/BIhNLnHjRQEzJ3XkWDmqgCng0m4dEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KOKRbuMeGFrN1K48E3VaW2XFILxbViyFADC2bfEteq841CkhcdjDp4dbv78LmQier
	 YzjgsHd776esFZJU5QRV3SnuySh3Ew5WWy2ML0zIQ/LEATrS+HckNTvHlpcMro5zww
	 apxLjdSAqzj2Idk8kDh7YOYQP8eMVvM54ppJbP5R1f4b00IT4zKy0ZWmF06BheF5TS
	 XK06A2u1o4qpGlIQYPEu+mt0y6DfBdHZYAnhWj5mO+i4NxH7TeH+DKqUHCPKv2bEbI
	 gnMHWv2AqMJ5Syv1ILjMxTStwh7Ugm9+VKhflF7nS/MedNN9nIqW+B6CiVtWJ9Zg6g
	 FNrQM+Hg+EAlg==
Date: Thu, 21 May 2026 08:00:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: dwagner@suse.de, mkhalfella@purestorage.com, hare@kernel.org,
	hch@lst.de, mlombard@arkamax.eu, linux-nvme@lists.infradead.org,
	error27@gmail.com
Subject: Re: [PATCH] nvme-core: fix unsigned comparison warning in
 nvme_wait_freeze_timeout
Message-ID: <ag8QFrW3UpMId4vX@kbusch-mbp>
References: <20260521122941.418049-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521122941.418049-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_070057_539033_A1347055 
X-CRM114-Status: GOOD (  11.91  )
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

On Thu, May 21, 2026 at 02:29:40PM +0200, Maurizio Lombardi wrote:
> The timeout variable in nvme_wait_freeze_timeout() is an unsigned type.
> Checking if it is <= 0 triggers a compiler warning because an unsigned
> variable can never be negative.
> 
> Fix this warning by changing the condition to !timeout.
> 
> blk_mq_freeze_queue_wait_timeout() is a wrapper for
> wait_event_timeout() and the latter returns 0 or a positive value.

It looks like it returns a signed value, but the conditions for which it
may be < 0 currently don't apply since we're using the uninterruptable
state. So looks fine, but I might feel more comfortable if we just used
a signed type to match the API's return type.

