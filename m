Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E589D216A7
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3H17V252RU7ESp9DZzA2JUrHg4NOpS+1N4hob5Ke2go=; b=qsPvOrsxpfNebpV/Y8CYzZF2Hp
	Gz+wwlK0DmSCJ7yYO5JEZ5dZzx+HrKROrYawkZ3O+ovZKYROJons1iljZU3AuqKSd2DaW4h9xBtCs
	mJaKC95h/s8thBJVSwMQOlkJnpa8fPOKKSSDzl/opXoy8hT7ll6hO+6jJ7A+59KnM1BP+yk/WI2I3
	h9mwJTVUPTP5YQuZ/Ea0uH6ieHz6duoQe5uURnTMU8p5d413eTaxZ5x/gACkgmnAOpUDOjKvOEGmb
	S1F1/TIBrLK0UZwnKPwKVayuQA4qRMglP5FdotXE/EPEBJPlopfUW070iE1CGfdCfG/27cmUjUwHb
	2CwjhrJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0heA-00000008MWq-0DAD;
	Tue, 15 Oct 2024 13:31:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0hcG-00000008MAk-2fqN
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 13:29:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19400227AB7; Tue, 15 Oct 2024 15:29:29 +0200 (CEST)
Date: Tue, 15 Oct 2024 15:29:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kbusch@kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Message-ID: <20241015132928.GA3961@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com> <20241004101014.3716006-2-tero.kristo@linux.intel.com> <20241007061926.GA800@lst.de> <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com> <20241009080052.GA16711@lst.de> <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com> <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_062936_840797_311D4D29 
X-CRM114-Status: GOOD (  21.04  )
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

On Tue, Oct 15, 2024 at 12:25:37PM +0300, Tero Kristo wrote:
> I've been giving this some thought offline, but can't really think of
> how this could be done in the generic layers; the code needs to figure
> out the interrupt that gets fired by the activity, to prevent the CPU
> that is going to handle that interrupt to go into deep idle,
> potentially ruining the latency and throughput of the request. The
> knowledge of this interrupt mapping only resides in the driver level,
> in this case NVMe.
> 
> One thing that could be done is to prevent the whole feature to be used
> on setups where the number of cpus per irq is above some threshold;
> lets say 4 as an example.

As a disclaimer I don't really understand the PM QOS framework, just
the NVMe driver and block layer.

With that my gut feeling is that all this latency management should
be driven by the blk_mq_hctx structure, the block layer equivalent
to a queue.  And instead of having a per-cpu array of QOS requests
per device, there should one per cpu in the actual mask of the
hctx, so that you only have to iterate this local shared data
structure.

Preferably there would be one single active check per hctx and
not one per cpu, e.g. when the block layer submits commands
it has to do one single check instead of an iteration.  Similarly
the block layer code would time out the activity once per hctx,
and only then iterate the (usually few) CPUs per hctx.


