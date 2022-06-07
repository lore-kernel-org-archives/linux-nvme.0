Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE5EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 05:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Olr01p1SqTLVWk5m2pZtHAQkN82ArJ20o4hOVx4yths=; b=HhQG/ggj2X0Lk2n9SVFAfAGCNz
	1z3RCNnIpdhpyKoFymPqL5kJioCng4/pivWjqvxkYQglK+u5YPIViszuHfySHY37dXFnOmDfMPM9m
	Nz3JT3gcxi5jd5RHDriEtPC4veDnltt1wKaPJ6ThyPu+C4lRxpW2vogJMYf/83+TFWrWzTeXRI5EX
	eAeJMnH9IWgT9a307SxrY0qd4Hys9JfEIJF85U4PbbBaOMFQ3ptBcOG4OUl/wsRHuKabqOj0rRbKf
	MHoFyJgp194PE36kBMYOYV0zGnLD0qAP3WIL9sMueylRN5yBfPXFZRs5R0Z7V1RFATIR9sySOYA34
	F3ZRQAwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nySFh-004uN6-To; Tue, 07 Jun 2022 05:59:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nySFf-004uLo-R2
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 05:59:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C425368AFE; Tue,  7 Jun 2022 07:59:33 +0200 (CEST)
Date: Tue, 7 Jun 2022 07:59:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH 3/6] nvme-core: remove qid parameter
Message-ID: <20220607055933.GA8927@lst.de>
References: <20220607011647.24105-1-kch@nvidia.com> <20220607011647.24105-4-kch@nvidia.com> <20220607043940.GA7847@lst.de> <ed876e75-c6e7-ee2b-fd3f-e87daa4d5179@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed876e75-c6e7-ee2b-fd3f-e87daa4d5179@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_225940_065969_B98339B2 
X-CRM114-Status: GOOD (  16.55  )
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

On Tue, Jun 07, 2022 at 05:57:02AM +0000, Chaitanya Kulkarni wrote:
> On 6/6/22 21:39, Christoph Hellwig wrote:
> > On Mon, Jun 06, 2022 at 06:16:44PM -0700, Chaitanya Kulkarni wrote:
> >> We can easily derive the qid value from the nvme_command parameter of
> >> the function __nvme_submit_sync_cmd() when its caller is
> >> nvmf_connect_io_queue().
> > 
> > This is a pretty horrible layering violation.  The low-level submit
> > helpers should no known about the contents of the payload.
> 
> Okay, we can ignore this series then.

The first patches still look good to me, though.

