Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A29C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4DD208A1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4LTtVig";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP6balng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4DD208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VUv9YnVA2OaZ3qCE5XnjKeWJHPobrvYHkvcaZZIJZqU=; b=i4LTtVig4oI0JA
	uPn3ug59ggqoy+/b6F8V4Gd6xrvZlGBpbKpP+wMqSWnRJTIxjRjiDXqV/NmtBMKHU/xTbSltsR/Ra
	y/2aEUI/R9vwDiHeooZ54RmKjT5VxlkwxStK5/giD8/79WfOYhZxMC75OdiMPIpV1MRN3EsUj3tTQ
	zLvtGEDFh2IUad1+SnkoQSKMlwqff9C8SD4dfF9b/g9ClUtrPafe1xOHuOs0YW3bPTDHi0wNNHV9T
	4bu8SaDdIw99rdX+B5wtg/4qXp37O3AX32UW90/4EV0RJet2hCrz8oIsMi7Ss3UnulKzRLsNIzWqU
	o3CXepBKMe8Zk/Vcd9rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXUbF-0007sv-Sc; Wed, 20 Nov 2019 18:21:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXUbD-0007qy-3s
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 18:21:08 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BFA6208A1;
 Wed, 20 Nov 2019 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574274066;
 bh=OFPGCjAEPONyWkT4CQwvEaK8Rgflg8xOUPhkyIkt7sg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VP6balnglB6LrEnm+pEF+jkvIqmBlMrezQdO50geTVh6sHEKA76STwf8Hf00+PF++
 Sawuhm7bSpuFUVN3h8NaGOYlD3kwpCsOhxDMukW7u+E5jSRP00vQiEGArA5ZgshaPw
 y+kGjBlCE/mnglV8DVAETXTe7qLCWMMQ5z8fsF5U=
Date: Thu, 21 Nov 2019 03:21:00 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sushil <sushil32@gmail.com>
Subject: Re: NVM Sets supported on Linux?
Message-ID: <20191120182100.GA11886@redsun51.ssa.fujisawa.hgst.com>
References: <CAOoKxP99U8E=oAY23wA4_JVQNbPXVnkpcL6_-_zcwCnYDCoBaQ@mail.gmail.com>
 <20191120152935.GA9426@redsun51.ssa.fujisawa.hgst.com>
 <CAOoKxP8XWhuF7ROKsTHmUpsaUvwCJS0ZH7xOXJGUKQvqUOrU+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOoKxP8XWhuF7ROKsTHmUpsaUvwCJS0ZH7xOXJGUKQvqUOrU+Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_102107_178219_54AA97AB 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 20, 2019 at 11:33:11PM +0530, Sushil wrote:
> Basically, currently  I want to create NVM Sets on an NVMe disk and
> export these NVM sets as LVM volumes to VM instances using Openstack.
> Later on try things like Endurance, PLM etc. with these NVM sets.
> We don't have any physical NVMe controller with NVM sets though.
> So I was thinking whether I can use the 'nvmet' Linux target driver to
> create kind of logical/virtual  NVM sets
> and therefore whether target has/will have support for NVM sets. Its
> like how namespaces are created on-the-fly
> in Openstack during volume attachment using the volume path -
> /dev/vg1/lvol1 for ex. - and the Nova compute node
> then nvme connects to these newly created volume specific namespaces
> and attaches them to the VM instances.
> 
> So I am thinking instead of volume path, I create NVM sets and
> corresponding namespaces on-the-fly using the nvmet target
> driver and then the Nova compute node nvme connects to these NVM sets
> and attaches them to the VM instances.

Okay, so this is only making a case for linux target driver kernel
to implement nvm sets. Can we agree there is nothing special for the
host-side driver to do for enabling nvm sets?

As I mentioned earlier, it might make sense for the linux target to
report set identifiers for its namespaces if it can determine which
ones are isolated from others. Or maybe just add new configfs options,
I'm not really sure about the implementation details off the top of my
head.

In any case, I'm not aware of anyone actively developing support for
NVM Sets in Linux, so it may be an open topic if you want to take a
stab at it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
