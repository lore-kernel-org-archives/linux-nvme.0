Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50863D3E2A0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AiGRvAxsF43PEdqJjOk0rHKow0q7uvulWVWnbWdLfTc=; b=iKIjQrAxHvUoTSTxUBxrIfqHTE
	ed6Jgmn/7pqgtbhf2MQyYfRrvh01uMU4yWDM2Pt5fAceTKd8BRkQ3dIirs3JJFzTO6vcDH8oQG0DC
	c2p+T9AcR3+SLRBWHrE6OAjOOS634cFmugjiUL42SjQrWf9mSssMbY814mrIPPeYmuOiF4uvfstbD
	DzywfjjTglBMKesSR7EaCD67hSrWIfzxGD5yyfLyMlTaLxIXrEQjk06oy2lVZrcXpHtlv3y+IGHT8
	nozqnmoarkSwefk2MCN9cl+oIx/hU8iVYzbZm1tAMtifN+JTUAmEq9icHMRDVmFR1qlnrkZuV7c6X
	6ovaQ1LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Udy-0000000BrCh-3eDe;
	Mon, 28 Oct 2024 18:39:10 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Udn-0000000Br9K-0whR
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:39:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 658E0A41C92;
	Mon, 28 Oct 2024 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFDEC4CEC3;
	Mon, 28 Oct 2024 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730140738;
	bh=yXvl5ucMYrCRugDnDUgPtXONHx76D+ygufgs+U8P30E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7JA3pW8g1hX5xPQMspeIhKV4yWSsMsg0b7U6TyGSNAuYS7nOhJZX+XjwSmAgbg8t
	 KfPEFiaSWvMKtDyhWgSObDlgGsupjIiHxfxRIzB2CHH1te2cgfYTZKB4bCJ5VWpJbA
	 jIygKCoa/Ggcpi0VyeQAfng4XZ5bggHOjHtaYGspnZlyt37k2krRH019x2gxp2dd28
	 jSQU0gXQyVQUY6lZ0P+JcU3f2y5JuWOF8Betv4q1ee8QdDQIQhpa22GpU9KdTfQpni
	 ZIcCOU1gdd6/yaOvhlct/ZVUksMJovqWEoaFxmXonb7bR3so0r1obwKwCQi5TxPX+8
	 LoWpWTUlvnQvw==
Date: Mon, 28 Oct 2024 12:38:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv9 1/7] block: use generic u16 for write hints
Message-ID: <Zx_aPg7Pjq-7lU-T@kbusch-mbp>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-2-kbusch@meta.com>
 <a86cfa72-426b-46f4-83b0-b60920286223@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86cfa72-426b-46f4-83b0-b60920286223@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_113859_345750_992EF546 
X-CRM114-Status: GOOD (  10.93  )
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

On Mon, Oct 28, 2024 at 11:19:33AM -0700, Bart Van Assche wrote:
> On 10/25/24 2:36 PM, Keith Busch wrote:
> > This is still backwards compatible with lifetime hints. It just doesn't
> > constrain the hints to that definition.
> 
> Since struct bio is modified, and since it is important not to increase
> the size of struct bio, some comments about whether or not the size of
> struct bio is affected would be welcome.

Sure. The type just shrinks a hole from 2 bytes to 1. Total size remains
the same.

