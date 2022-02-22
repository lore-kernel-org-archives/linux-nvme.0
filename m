Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C174C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XpavuZdke+JIoZyh3o8ixlmbkC5qOTT27ltNo73OKuY=; b=y8UUm19/tWSFNjz/cIlULJYXOK
	Z3moU5GcCR1YvHRi/fw3hVHiaB8JMDVEgCETc3OH2rfT2o9jjvGtKVJmHTcO2t3z/1nEd/3d7SFI0
	hX90fraOmjl8uepdLPE+4MaTUFORYxzlN15jxF5okEwSbEwnN3AzT6R621qsVnCaJgYFOAdIyKF8g
	8yxg8No+LLWJdL1ctdrTyQHDEVrJUyzS+t2wkPeS8rdh9n08Z2NunNkgdJWvu3HNoP3zSLKqDYqZB
	54FESvBX/DUngKOAnCCqGtX8l4mlZAr3PeGaBqUT+3P+l2r35h/7s1bo0RoiaTXTZEKvkSjixctao
	Vw6SbELQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMbTH-00BTau-MQ; Tue, 22 Feb 2022 20:09:15 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbTE-00BTZL-UY
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 20:09:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 96FE5B81C67;
 Tue, 22 Feb 2022 20:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B59C340E8;
 Tue, 22 Feb 2022 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645560550;
 bh=1RpeK2ezkeXvyqdfTt2Tyf6eIBlrvYVjmKs7rO0ojdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kX1+BSiIzoCC7MPwCqygUVYJjYjCGP8r0uNbfIvHrEUClkW1piWFY0f6WZWt/CKnC
 JMhyXgFkSIr4Wqa/2F+eN6U1ZhpPp8qhzTr4/djfi8ayJprxTYDMxvyXHbj37008Sp
 CCiY+w24npvSlnH9uitpVrv76+EUJbJgG130TtVndHZCfTHUOQSMesvAH2Ipw5qw1z
 wq3MxQKizauoTcEZtY0Q9ZhCOAkjDy/Wfd4XhtkRQH7yVPT6D/Qc0UnlFcsYpokyFW
 ESFioc5kDB+DFV9dR1MblY51KCMUdRQ+vUUPzTu0Wi5TViO/O6bZ/mpLm1PlS5bkuq
 yXu4fBMHR5igQ==
Date: Tue, 22 Feb 2022 12:09:07 -0800
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <20220222200907.GA1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
 <YhU+kuMhueXVQvxe@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhU+kuMhueXVQvxe@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_120913_141887_8FCB14CC 
X-CRM114-Status: GOOD (  15.06  )
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

On Tue, Feb 22, 2022 at 11:50:42AM -0800, Eric Biggers wrote:
> On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> > +config CRYPTO_CRC64_ROCKSOFT
> > +	tristate "Rocksoft Model CRC64 algorithm"
> > +	depends on CRC64
> > +	select CRYPTO_HASH
> > +	help
> > +	  Rocksoft Model CRC64 computation is being cast as a crypto
> > +	  transform. This allows for faster crc64 transforms to be used
> > +	  if they are available.
> 
> The first sentence of this help text doesn't make sense.

Much of the this patch is a copy from the equivalent T10DIF option,
which says the same as above. I meant to revist these help texts because
they don't make sense to me either. I'll be sure to do that for the next
version.

