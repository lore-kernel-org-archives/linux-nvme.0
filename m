Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E706C04E69
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0q945IgIffc812XZDpwmAjUWxOnZGENLVOUTBX7sU3w=; b=GvZaNygrRfOOzM8m9cFYFCYom2
	G1fgfMFO8ByGT+qnpTkCkAIxGT6ObppW5rMgFywrnaSgnyDdctbcNDExEK0kIXUGYtc7j7p5tAC+n
	PMdN7aMk7QP1uplVPuYjR8gbZajjMo5DpV6xrtGNU2MM9DaR+fsuMcTlho3W26VyzlXAYKxNPdrbq
	ncNChAAyi16J3gnNDXh8nZYUgz3qPKs8ChGjLBl/iR+aq9nIR5KDJvv+eilQIksOLJGKwerq7pe8l
	KgHsYhDhsObjp2JwmBp+vGOBpB22NYYUflGXu8iPjGgNfN0rae7+ihQ6PRsJvs4r4WrKzlVEvJOci
	uIivofSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOvLT-00CSKO-0z;
	Thu, 27 Jul 2023 07:23:35 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOvLQ-00CSJp-03
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 07:23:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94B8C21B76;
	Thu, 27 Jul 2023 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690442610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q945IgIffc812XZDpwmAjUWxOnZGENLVOUTBX7sU3w=;
	b=THMvwnmF4HI9CbS8NCGUVaQaFZP1blRNVv3e9k06FbJt138amRstquWhxRPEXFlHpP/7Np
	NoMgTpz8PjSxyacQxJ7VerDHDUjGqJ85q4DuqL1y7OITYXxJ+EUrXgoLHjO2JUUicQz15a
	tkYggyoPp743J4DfVp41gDH0RguYzS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690442610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q945IgIffc812XZDpwmAjUWxOnZGENLVOUTBX7sU3w=;
	b=2vSU7ZCloQFGvXSpyXvjlt5teP1YCxdc/nbPgesNLZwP5d3Mqu06CcaJXMcV3jRAsvj8ab
	Oh/+z8h3gKnyTXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A1D138E5;
	Thu, 27 Jul 2023 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JMH6H3IbwmQRMQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 27 Jul 2023 07:23:30 +0000
Date: Thu, 27 Jul 2023 09:23:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guangwu Zhang <guazhang@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <gvplwccjkke5rn2fu2gvncbtgctcuc64xb3bv5vgwhp2qloabg@22ivmfqiyub4>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <ZMHIrcv+GyqB4FfM@ovpn-8-16.pek2.redhat.com>
 <CAGS2=YpVe=4mPnUNVd4mvcsaL66wUv0TPhSAf_MB9jAbbSOJKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS2=YpVe=4mPnUNVd4mvcsaL66wUv0TPhSAf_MB9jAbbSOJKA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_002332_206999_316B1FD1 
X-CRM114-Status: GOOD (  13.72  )
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

On Thu, Jul 27, 2023 at 09:37:05AM +0800, Guangwu Zhang wrote:
> Can not reproduce the bug with our test environment.

Thanks for the quick test. It looks like it depends on the SDD invovled, the
ones from MAXIO:

# nvme id-ctrl -H /dev/nvme0
NVME Identify Controller:
vid       : 0x1e4b
ssvid     : 0x1e4b

Both reports have this SDD in common. Other SDDs in the same systems did not
cause the stack smash.

> > >  b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data")
> >
> > This commit only fixes DMA UNMAP direction for integrity data, but is
> > there integrity data involved for 'nvme sanitize-log /dev/nvme0'?

Don't think so. As I said I just saw this fix and I was wondering if the changes
which came in v5.2 in this area uncoverd a bug. As Christoph suggested, I need
to figure out if device behaves correctly for example with playing with the
IOMMU.

