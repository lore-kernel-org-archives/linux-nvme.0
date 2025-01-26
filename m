Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A099C0218D
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2025 20:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lK6D0EqpSAxMIcRwJlC63H6iKC5dwxdw05gI3Fn7Sj4=; b=DKgbxk9Y1ezoIFceW2w2u/EGLH
	pwErive8uaMB7FBvmSYPAhTHeAKbw5sNfjCHxZPlY3mtKdh6sOagS2drGKMZ09WzElFS0e7vfDl0J
	XDZ/lA95s2WE1RILRTP2ut0FL+gI455WWwgUneAZeV4BrkfkvBswJ8JtfrYwTQRzb+fRIl66K5Xnp
	rKvA+oHQyz/PtIaUiQOxdF04qteqfsggUTZpm7WOLSbN0MDKcu1/yzjwSztQemNh9vE4kMbonTDAV
	9DEr0NeeDgWjstGWE1M+I9X42zx9eHoTQrf/8dDS7GceHxeKi/s2x5uk0HF+cbsJO1LOplz8Orx4G
	xwJcRPSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tc92J-00000000tvu-1r7t;
	Sun, 26 Jan 2025 20:15:15 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tc92G-00000000tvU-2Xvg
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jan 2025 20:15:13 +0000
DKIM-Signature: a=rsa-sha256; b=jwaDGOTzGd514su76rvpBIttxt3CtiIu1sJq7M85x4pTYrV0DAqp0pUbFw5oggsBLto87ETFYAtXkdqs7R2N+g4OSjxtlFdHyqX/gzihaDGtib4UsfKEBWt/kJPnSaJrVJNTjcnvNVi/4/x0OdT3UOR0/UqOg49BiSed/O0PoaqQ1oPV4/GzL8/Sdc9w1sgnyjsATsYuoxMjofzhx9BLeIqeYFdtk461pcVj02dpZ5Fc/oQ9RezHl+1UdD/VIGP6i5bUOmX1yCh+r8hixRjp5hsXKceCJgipq8FRTg55yv+nGNxeuf913b4S9mRojsm/lwUYdhXH4JVQpuqnkf/jJA==; s=purelymail3; d=saulv.es; v=1; bh=lK6D0EqpSAxMIcRwJlC63H6iKC5dwxdw05gI3Fn7Sj4=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=hagwh1uK+Hokh9oseoeGJRPpk/5uGEJpH773YKaBfk0ENHLjvR2gIXH7pyNDhnuCV28JG/z7N1Tb4jI1mMuNksK6CsFjgG8FUETzWTZg/GPyTS02RQ4F56qPEQqToTSgBBBLt6KgSg39iv17kREaTthYMKvQRDNA87mm3P4BN7BYV2UH2gZxHN6P5BJSKhMrRVtW3mwnLXi0lrRmK8L+qogaQpOUHgVLVlYBOI89GTMmf72DTZOFkXHHcU/P1pCFYfgElKMmq5cctrzlDV7w8UYOmKhQKGGclfteS/3+9CYay1SYwdYxHVmPufa+RGUr13bAqvRmPGiyBpSUVyMjYw==; s=purelymail3; d=purelymail.com; v=1; bh=lK6D0EqpSAxMIcRwJlC63H6iKC5dwxdw05gI3Fn7Sj4=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -829291433;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 26 Jan 2025 20:14:50 +0000 (UTC)
Date: Sun, 26 Jan 2025 21:14:48 +0100
From: =?utf-8?B?U2HDumw=?= Valdelvira <saul@saulv.es>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid the deepest sleep state on Wester
 Digital SSD
Message-ID: <n4373utrn6qzdm4vrxyvmsiaeocq2hclcwyg4qz3wrxekrxs6v@fwv2gs6jgtw7>
References: <20250117164653.1751-1-saul@saulv.es>
 <Z5PAbgT0d4RIvtSv@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5PAbgT0d4RIvtSv@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_121512_820383_62D34258 
X-CRM114-Status: GOOD (  11.50  )
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

> We would definitely prefer the firmware solution. Quirking devices in
> the driver would force everyone to subscribe to the less aggressive
> power savings even if they're not affected.

That makes sense.

> How do they offer their firmware update? I think it's common for vendors
> to provide some kind of bootable USB image that does the update if they
> don't provide a standalone firmware binary or other tooling.

I don't really know. I'll search for that kind of thing. And even if I
can't find it, I can still avoid the problem with a kernel parameter. So
it's no big deal.

Thank you so much for your time!

