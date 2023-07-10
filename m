Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A070DEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFiJJ5dbjIQyhn/1V3HmOxfq92ME+mqCcHpsxzYuehw=; b=Q8gvQ/elnuUkf5JFrJej2IkEYf
	wwbZO5SbQS8CAatVCeWclc4QLufog4W5gpLQZH2HU0SCGSwi/fimkuGNxmjo5H5wODJ1AXTKiGBnb
	Ac+Cp5YY0uHF6MGPjVmiyzFR1ULMrwAkvTUugZZaFFW3i1md9zbt+4BZfDSuZyVPYjN8sU4Nue6Ya
	GYbVeOlSEdGayPJzEjwQ3niTLaTTMrjlHtn/gfdHn4xVrXb+Dpay97wmiFDBmLC4Mqf6M7KYFKuWY
	KrB2b1BLKIAhWKzM2JbwbtKrZ6hACt9MzeuM3Cn+fOzvuPKARhdFpEdmlq8YGicosRyOohZo0fgdD
	6/Al2Jmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIu75-00CEci-0N;
	Mon, 10 Jul 2023 16:51:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIu71-00CEc3-2O;
	Mon, 10 Jul 2023 16:51:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AFF196101E;
	Mon, 10 Jul 2023 16:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463C9C433C8;
	Mon, 10 Jul 2023 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689007906;
	bh=5z3WsJxJGTtWjrX2KHLkkdeETGptB61J+3QAspj8jBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnFzUs11tjzs+9ReI3FmujHvobKv5/wZaFYYlv72apTaj5q+5nJjG3Xvck7oyN0Bb
	 3r44Ru3KtKzPCZgCsOL43nG19l61vH11QqTchheHpnKzoOF/dVEenhPlN7QrlfjL2c
	 FeX3O0mEnPMK13b8PlAUX6IiOnBOVP4/wLoDDuUj4ZMDIksPVrHBzd1QOTy9kmahwx
	 eobFZLlT4bSmSj1mrHmB1i/EikuL3cWQ95AmcH8Dqn1YdcXFE0GbnrJEJjvnJhy8yW
	 ZKEcOl6J/0mSWQsL0oTMC9iBItuU/lUz+vZp71BaggN8U1ScOprjLHgJij04ThusAj
	 TUT5ije+zaq+w==
Date: Mon, 10 Jul 2023 10:51:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKw3H2cJzRPZa29N@kbusch-mbp.dhcp.thefacebook.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_095147_827569_D837C7D3 
X-CRM114-Status: GOOD (  19.06  )
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

On Mon, Jul 10, 2023 at 05:14:15PM +0800, Ming Lei wrote:
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > > 
> > > Fix wrong queue mapping in case of kdump kernel.
> > > 
> > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> > 
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
> 
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
> 
> On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> simply keep one of CPU cores as online, and others as offline.
> 
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
> kdump kernel.
> 
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
> 
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.

Is the problem that the managed interrupt sets the effective irq
affinity to an offline CPU? You mentioned observed timeouts; are you
seeing the "completion polled" nvme message?

