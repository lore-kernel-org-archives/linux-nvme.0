Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA05C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFJy+8mztCHWRYCBkovcycG/YErozQ9FVN04geA2ISg=; b=XPQpuhAzXec5wAnrwhwzUd0pHw
	o9t4NKho6SWPVR/eIeetYrHOWTHsP3U+QiUawJIkoUhtRTJSr//nkuUrnVxmuJ1eK8St1SSyMWbOX
	0P4QjSS1R0zBtbBJNntZ+OIhxqx1JMaGwbVGeV2hF2jkF3Jc487Gy6O8t8nHCXDEDi7yXrF773MHP
	yWhYvJn8sZCD4XAyJVqZDnBPti7OFizhXT/xDfFD4fTYfSrmMmxQBUHTYu6TfsxI3G629M4oFvlYr
	gkI+AHnIrQlNoiwZai0kieZExWHjFRRXCkKsl6dYdjVS+LSmvrT1PwYow0BqaUCdXQPy/HJH+opNe
	jpaluq6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouyta-00CqK5-7P; Tue, 15 Nov 2022 16:34:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouytV-00CqA1-Qo
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 16:34:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 60B4F618E5;
	Tue, 15 Nov 2022 16:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A300C433C1;
	Tue, 15 Nov 2022 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668530079;
	bh=H2+9OcpKvvJ28tEt5T3QFWz6W+NA/7Azi+wGoEh2GIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmc3VGU+XlODcxLY8BbOf0eEAfzjOwy2+q69pRQxodm13BlmMsIYRC6wbhdSs+YFI
	 1J37ttVhrdc2JLxdaOUqh6zpplIIHKLvWtl16P7JBzayKwuxh1koGxPjn5QWWPC1UD
	 zBfbeIbpGpUBAHGigLEQLh4TIChCluNzDprQUR2yag1ncEqmQ9Op5k6UGSON7X1Z/D
	 IHRYKPKCCRzCHJBlI3ITnR4puuJfH/I+VzH90ch2gMdAeQITWcKOD0Lf8pdEyiA+Tb
	 PgiDz8+qYySWtsxf2dM+pmTKHBJqg1vRtg/3CvoNvpveLwD+Ef+pobUvxpZFqxqshw
	 3H7nQW1eOOexQ==
Date: Tue, 15 Nov 2022 09:34:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
	Keith Busch <kbusch@fb.com>, hch@lst.de,
	linux-nvme@lists.infradead.org
Subject: Re: Resets during user commands leads to hung task and controller
 stuck in connecting
Message-ID: <Y3O/nNR46hF27C88@kbusch-mbp.dhcp.thefacebook.com>
References: <d4a25dc1-fd2b-8f25-9ec1-04b28dfac386@linux.dev>
 <1ffea25b-6f67-a1e6-5b96-22bf3b4d89ec@grimberg.me>
 <65816415-303d-5579-4878-d8cba766f797@linux.dev>
 <18e1c715-d31b-056e-bddd-189fd2948396@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18e1c715-d31b-056e-bddd-189fd2948396@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_083441_964037_3F16F8C0 
X-CRM114-Status: GOOD (  24.46  )
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

On Tue, Nov 15, 2022 at 09:46:45AM +0200, Sagi Grimberg wrote:
> 
> > > > I'm (again) seeing a hung task when doing resets and formats simultaneously.
> > > > Controller state is left in 'connecting'
> > > > 
> > > > Using nvme.git/nvme-6.2 as of 'nvme: implement the DEAC bit for the Write Zeroes command',
> > > > but I have also repro'd with Christoph's latest reset/probe-split set
> > > > 
> > > > 
> > > > ctrl="nvme0"
> > > > nsid=1
> > > > pci="/sys/block/${ctrl}n${nsid}/device/"
> > > > echo 30 > /proc/sys/kernel/hung_task_timeout_secs
> > > > while true; do
> > > >           nvme format -f /dev/${ctrl}n${nsid} &
> > > 
> > > How long to it take the format to complete?
> > Well it's pretty immediate but I'm under the impression that the
> > nvme_dev_disable path leads to CC_EN disabling, interrupting any formats
> > 
> > > 
> > > >           echo 1 > $pci/reset_controller &
> > > > done
> > > 
> > > What happens if you set io_timeout to 20 instead of 30? (given
> > > that you bound hung tasks at 30 seconds...
> > It occurs with the standard 120s task timeout too
> > Also there's no I/O occurring at the moment; just admin work
> > 
> > I added a blktests for this:
> > http://lists.infradead.org/pipermail/linux-nvme/2022-November/036475.html
> 
> Keith?
> 
> Is this related to bc8fb906b0ff ("nvme: handle effects after freeing the
> request") ?

Kind of. Jonathan previously reported an error with the same test, and
reported that the mentioned commit fixed it. This is yet another error
with the same test, but that commit doesn't appear to have been a factor
in this new observation.

This test could theoretically consume all admin tags with format
commands, and if the controller breaks on the format and stops
responding, then we don't have a tag available to tear down IO queues.
I'm not sure that's actually happening here, though. Is the sysfs reset
really the only stuck task reported in the kernel messages?

