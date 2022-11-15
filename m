Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3700C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZInHOHfKb/y2FDOyR28+fCMOHIbA0euekzQOIIoFAk=; b=4VyEPuEUrkhmR4UBkIUBQ3s6Ja
	hUTIeL5Y2u/+f0Ab+5iyoxPWHoz1oF75+nOcrlQP+U70Py3ObeBP/RDUTQy/75/8CHjwCuXE+DyfN
	UWkgJ5moG3mTIJ4B4DBadVqfehCrFeXgr754jZD1PYbj7oFOGAs4SkPY9HLcahKvU78lD9evYhHMW
	ZU+XJgVxK5uuutjdbmLvIM6/6b6Za0gzd1FG33vCJHn0iUsXcNrcioGqEhPlylsC1s3JDeHfSbvr9
	7DJewjrrPL0m5RT8E7YbrqsE4AA5hK8hcNZQzCvXmbiOcCjjYucf7SHi+TFK39ku8U4SpmS7+qA1F
	80vPiMcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outAX-009uzu-Et; Tue, 15 Nov 2022 10:27:53 +0000
Received: from [2001:4bb8:191:2606:160:4e5a:8508:c11d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ousnA-009gxa-8r; Tue, 15 Nov 2022 10:03:44 +0000
Date: Tue, 15 Nov 2022 11:03:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 15/20] nvme: move nvme_dhchap_queue_context
 declaration to nvme.h header
Message-ID: <Y3Nj/psuDSXdONNO@infradead.org>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-16-sagi@grimberg.me>
 <0226ef28-ec4c-689e-03ed-d2d8a85c1c98@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0226ef28-ec4c-689e-03ed-d2d8a85c1c98@nvidia.com>
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

On Tue, Nov 15, 2022 at 04:20:37AM +0000, Chaitanya Kulkarni wrote:
> On 11/13/22 03:24, Sagi Grimberg wrote:
> > We are going to have an array reference from nvme ctrl, and we want
> > to avoid a casting on reference.
> > 
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> honestly I didn't get the commit description at first glance
> maybe that just me ...

And there's also no need to move it, we can just use a forward declaration.
I'll fix it up when applying the series.

