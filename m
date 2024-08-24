Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A8C5472C
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RcuK0SFUgIl6BKiirUgBL1yf46sHUgtAPR5CGAolM4=; b=vF7OYc8a2Y/LZEYJbUC0UpBAUt
	6DyvCfQRrl177jOgqSDJ0+DHbgb8JlkE50KCU5vW1cGEQtiiso8t9wP3IJZmyDjsIhU+VOMHPgQAC
	9lCVrFjrWjMVGepVHydMj2i2h8K2Q82dQM0jNSxF0mV3b+vtSktVUc0sFvanifBnxMRlTDr9irgam
	JJCPFkHf5ECpFwvs2nEC7qL+mAR2cnR1WN6CrRacUzuEShZu8zIJ+9eNbonUKxY9xcxzt5s4EEPtP
	agimt3sUrblFrIo4HQ6wwQqHr1EdJgAW/ZuWdOi/Q6rL8SEK/UrOWKi9JYaiNKOB3PCAkpi3Q0Vdh
	yn5jiZGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmFe-00000001rVk-0BEB;
	Sat, 24 Aug 2024 08:36:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmFa-00000001rV7-254V
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:35:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24352227A87; Sat, 24 Aug 2024 10:35:54 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:35:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20240824083553.GF8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8@epcas5p3.samsung.com> <20240823103811.2421-8-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-8-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_013558_762059_CF7DB69A 
X-CRM114-Status: GOOD (  10.62  )
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

This patch came in twice, once with a "block" and once with a
"block,nvme" prefix.  One should be fine, and I think just block is
the right one.

How do we communicate what flags can be combined to the upper layer
and userspace given the SCSI limitations here?

> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -11,6 +11,9 @@ enum bip_flags {
>  	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
>  	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
>  	BIP_COPY_USER		= 1 << 5, /* Kernel bounce buffer in use */
> +	BIP_CHECK_GUARD		= 1 << 6,
> +	BIP_CHECK_REFTAG	= 1 << 7,
> +	BIP_CHECK_APPTAG	= 1 << 8,

Maybe describe the flags here like the other ones?


