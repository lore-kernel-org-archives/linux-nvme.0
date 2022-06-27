Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36001C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y67YHtWt/6l2GO/req2Lxy+gR+5c7uoNLew8o4pQx4Y=; b=hWyVNFOT2lBykFa4W7SPHhLKG/
	A2pKHf5bKyG1nXVMq5Rlh91/RJip83nCYx3cO1uxWFtaoRiUOBx/7FntBAXtuBHGJNeU3ucuEwvzU
	pmAqJ+GJAwiql2XASB5p6FAY7zeCrcAjuwqVTA3CwbiXpsu444MjmK0X7JSgRLXuhjKs+LTmpDr/1
	OPj7fJXUIDXr1dr9plBR+IUskEiWELWrE/0x2uV/kZoG/cvCPbzJUmQff+jmoyKANhIPKHBZxt6Ze
	QFO8SLW9i/idEeAY+tIV5e+nC0Dqp/JxAYFIr9l+o+HzeD66pGtrhl+NQzHXhrkRriYvUSvrht+cl
	Y+5VgxFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qnS-001gvA-Tj; Mon, 27 Jun 2022 15:37:06 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qnP-001gu5-Ih
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 15:37:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id EAA40B817D3;
	Mon, 27 Jun 2022 15:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DFCC3411D;
	Mon, 27 Jun 2022 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656344220;
	bh=CuWQqDJRWxJQ6RoyWnytqv86/5mnNlfI8V08ozRBjFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTyii0/1g8OM0TNyfu2I1K6ecK0kjKlapjUP1nhlKneu1qzZn+cM4GzTZsKO08b32
	 fOldkFG8sR3Ggx0khePLHV63JLu+VXzpLZn3/mTD8Cm1pSaNzLoKO60o/7Xrkk6p92
	 9ejBxUWiEoUoWj3ImtuJMh4UmBU0i3n+fFqOIKzaBovRZj1r74so+mqbH/C7OV9BNL
	 TUVCP76VntSyT9KLb+Nna9QYxXCW85vDcOFey31DbB9TsyYdzgkJBlkOnD6k/qXTT5
	 LsCcyxad+npePYbFp6JHYUBqEKF8i95hI6ywxRoiJ3zURfRE9IS2ur7tH15Uennbdz
	 seaO7RMKDoSSw==
Date: Mon, 27 Jun 2022 09:36:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
 <YrS2HLsYOe7vnbPG@kbusch-mbp>
 <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_083703_796522_067D0553 
X-CRM114-Status: GOOD (  18.60  )
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

On Mon, Jun 27, 2022 at 11:21:20AM -0400, Eric Farman wrote:
> 
> Apologies, it took me an extra day to get back to this, but it is
> indeed this pass through that's causing our boot failures. I note that
> the old code (in iomap_dio_bio_iter), did:
> 
>         if ((pos | length | align) & ((1 << blkbits) - 1))
>                 return -EINVAL;
> 
> With blkbits equal to 12, the resulting mask was 0x0fff against an
> align value (from iov_iter_alignment) of x200 kicks us out.
> 
> The new code (in iov_iter_aligned_iovec), meanwhile, compares this:
> 
>                 if ((unsigned long)(i->iov[k].iov_base + skip) &
> addr_mask)
>                         return false;
> 
> iov_base (and the output of the old iov_iter_aligned_iovec() routine)
> is x200, but since addr_mask is x1ff this check provides a different
> response than it used to.
> 
> To check this, I changed the comparator to len_mask (almost certainly
> not the right answer since addr_mask is then unused, but it was good
> for a quick test), and our PV guests are able to boot again with -next
> running in the host.

This raises more questions for me. It sounds like your process used to get an
EINVAL error, and it wants to continue getting an EINVAL error instead of
letting the direct-io request proceed. Is that correct? If so, could you
provide more details on what issue occurs with dispatching this request?

If you really need to restrict address' alignment to the storage's logical
block size, I think your storage driver needs to set the dma_alignment queue
limit to that value.

