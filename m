Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FDCC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:17:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D76613B8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D76613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XuUHn1eoL+2a/FvDrhph4bEN4R3HoUx+cmM9zVTg9Y0=; b=J+9ktUc/jCCdAXOgxpM6MXLqP
	0gQVQE984WcH+BLQkOA5Dmvms3JQCBweLsFj3okhJo8dVlMo+kKqTebQ0GCd8V/rMZv7u/N8IOMlL
	4Y2PbR3XzfJ2Orj4srsmumo2qWESv1ziHDAITPUNbSWPOltk3bCRfpAtUqgoxO9/o8jB8E/fL35sT
	oPdXcd4YABJYAmTHqeN4nYP/d6LmeEchBW6ANdqAXSxRIbiVWwKh5AwjJjh4rhabUqwdY2LXXXMES
	Hvp2z3fOZK474xo6+7c/6kEEK0wQis6gbzYR/Qcnmddrx5DzeaV1/X3ogl69DDPBo6tMy4NloYJhi
	okHGJ7Gzg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYtz9-00CgyD-5F; Tue, 20 Apr 2021 17:16:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYtz5-00Cgy2-Q9
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 17:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CvKdHU7Mr8gQT95zHZreOI/kn5sJaSfeVa5RleyCcSM=; b=Kugt4/NN3LX+bviutza4rmJIPR
 1JXKg3qAJOTnJiF77oDAfzEyIzkSlQUiW1NUE0AscEhhBY0uBzC9BRlFrZFNeNhC9DJjnKuJZmqA+
 gU8so7zwNSwWQSaOOaQgx6eE1agnIWPbWQIxlStB4GyytEKqC8XbkGVz1rNiyQbjt3cJ5aBldLgpC
 wlbgJbX1toQmmrAE7G0MkVwxfEPM6feo3qoUAymXyaFygeL5Tcqu2n65fU8aSbcJlN4+MegEuT+tT
 oKTJjU3hQpd5fS5/BEkN0dIlFY9jyzBOdH5AiyH9w+DOfhDMeBzyZ+0hdvgMvvqvmLFROJ14FQDXk
 M0ZoBffw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYtz3-00CIzv-2J
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 17:16:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB1D613AF;
 Tue, 20 Apr 2021 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618938979;
 bh=5fn1i17qB5yDnbqftyGyHHPPkhw3DjoFLrIDE2B1uy8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hj1hByWZYv4A9d5tdim/rUACuQhQDV/FZxwvirvkg/AXx+4WSKAX2qU9MTy9iJeTJ
 1FtUw64gUt2vlWygLEVmE2KWNaJuJ/m+iJSzi4bnIyREp9lb/kcIp+7l+SIvWsmNfE
 WQNU+zltlc5h40uRkz5A4iw9rEqO+YrFTQwtTGuVhD4sBTTRCX/B/CaIIcIe4Zex0l
 gkv2PmJjwu8EYvQO0XjhDK/Tvgo0rnNhQ8O2rd9JjbgdPm6XxujbnnJEUp/FEd9zXs
 sTJuYdYp3R/hURfEF6OjHZIHjgRKbh6f1I2P2KxnH3trzBKxsdQa1rjdfv/IEEjMz5
 eICljcBk6kpWA==
Date: Wed, 21 Apr 2021 02:16:12 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
Message-ID: <20210420171612.GA18049@redsun51.ssa.fujisawa.hgst.com>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
 <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
 <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
 <20210420143906.GA19417@lst.de>
 <73f1a5df-7d40-41ce-e6c5-42fd9fd3a2f1@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73f1a5df-7d40-41ce-e6c5-42fd9fd3a2f1@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_101621_231482_4DA4F35D 
X-CRM114-Status: GOOD (  37.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 20, 2021 at 07:02:32PM +0200, Hannes Reinecke wrote:
> On 4/20/21 4:39 PM, Christoph Hellwig wrote:
> > On Tue, Apr 20, 2021 at 11:14:36PM +0900, Keith Busch wrote:
> > > On Tue, Apr 20, 2021 at 03:19:10PM +0200, Hannes Reinecke wrote:
> > > > On 4/20/21 10:05 AM, Christoph Hellwig wrote:
> > > > > On Fri, Apr 16, 2021 at 08:24:11AM +0200, Hannes Reinecke wrote:
> > > > > > With the proposed patch, the following messages appear:
> > > > > > 
> > > > > >    [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
> > > > > >    [  227.516807] md/raid1:md0: Operation continuing on 1 devices.
> > > > > 
> > > > > So how is this going to work for e.g. a case where the device
> > > > > disappear due to resets or fabrics connection problems?  This now
> > > > > directly teards down the device.
> > > > > 
> > > > Yes, that is correct; the nshead will be removed once the last path is
> > > > _removed_.
> > > 
> > > The end result is also how non-multipath nvme behaves, so I think that's
> > > what users have come to expect.
> > 
> > I'm not sure that is what users expect.  At least the SCSI multipath
> > setups I've worked do not expect it and ensure the queue_if_no_path
> > option is set.
> > 
> Yes, sure. And as I said, I'm happy to implement this option for NVMe, too.
> But that is _not_ what this patch is about.
> 
> NVMe since day one has _removed_ the namespace if the controller goes away
> (ie if you do a PCI hotplug). So customer rightly expects this behaviour to
> continue.
> 
> And this is what the patch does; _aligning_ the behaviour from multipathed
> to non-multipathed controllers when the last path is gone.
> 
> Non-multipathed (ie CMIC==0) controllers will remove the namespace once the
> last _reference_ to that namespace drops (ie the PCI hotplug case).
> Multipathed (ie CMIC!=0) controllers will remove the namespace once the last
> _opener_ goes away.
> The refcount is long gone by that time.
> 
> > > > But key point here is that once the system finds itself in that
> > > > situation it's impossible to recover, as the refcounts are messed.
> > > > Even a manual connect call with the same parameter will _not_ restore
> > > > operation, but rather result in a new namespace.
> > > 
> > > I haven't looked at this yet, but is it really not possible to restore
> > > the original namespace upon the reestablished connection?
> > 
> > It is possible, and in fact is what we do.
> > 
> It is _not_ once the namespace is mounted.
> Or MD has claimed the device.
> And the problem is that the refcount already _is_ zero, so we are already in
> teardown. We're just waiting for the reference to the gendisk to drop.
> Which is never will, as we would have to umount (or detach) the device for
> that, but I/O is still pending which cannot be flushed, so that'll fail.
> And if we try to connect the same namespace again, nvme_find_ns_head() will
> not return the existing ns_head as the refcount is zero.
> Causing a new ns_head to be created.
> 
> If you manage to get this working with the current code please show me from
> the testcase in the description what we should have done differently.

I see what you mean. I think we can detangle this, but it's not as
straight forward as I hoped.

As far as *this* patch goes, I think you and I are aligned on the
behavior, and I still think it's good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
