Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C710D74968
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cYYcGSRG5stZ9R+yFZubQibCK2xfPLSAUzf/LazeVog=; b=A0Ybr9INpk4vM9yB3NPRxf3kEf
	SyCjtz/1+8aBY/x/FDGTztFAwKB8JasJ1h54j27GoAqEKrV+ov4epzNspCwr5l+Hig6XzIgZEzn4f
	b8gx2eTxsgdJjXQRJ5q4jl/tDSvgVe4ZeI7Qx0Mz98lrx5rfUPb/RQoJ3B8TM9tdZpiyrnbcmFQL4
	sGoxfZmySik0MrC5fZVLfAUtWDShQuSXYA2EjC3oJvlunou+nfHIJOlWmcyeBTLHD+vTmjwyRSgPJ
	W22kuTxR/m7upxvy3PRFTYxC4Sr+JcvqXVrc+ycpyE6Xxlx03xFU7/mcctwegLbI9Jz4M6z6zJJDT
	vCEkMoZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t60yK-0000000GksT-3cy8;
	Wed, 30 Oct 2024 05:10:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t60yI-0000000Gkrr-36vy
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 05:10:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32B60227A8E; Wed, 30 Oct 2024 06:10:16 +0100 (CET)
Date: Wed, 30 Oct 2024 06:10:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 09/10] scsi: add support for user-meta interface
Message-ID: <20241030051016.GD32598@lst.de>
References: <20241029162402.21400-1-anuj20.g@samsung.com> <CGME20241029163233epcas5p497b3c81dcdf3c691a6f9c461bf0da7ac@epcas5p4.samsung.com> <20241029162402.21400-10-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-10-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_221018_945868_25038935 
X-CRM114-Status: GOOD (  12.07  )
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

On Tue, Oct 29, 2024 at 09:54:01PM +0530, Anuj Gupta wrote:
> Add support for sending user-meta buffer. Set tags to be checked
> using flags specified by user/block-layer.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> -		if (bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false)
> +		if (bio_integrity_flagged(bio, BIP_CHECK_GUARD))
>  			scmd->prot_flags |= SCSI_PROT_GUARD_CHECK;
>  	}
>  
>  	if (dif != T10_PI_TYPE3_PROTECTION) {	/* DIX/DIF Type 0, 1, 2 */
>  		scmd->prot_flags |= SCSI_PROT_REF_INCREMENT;
>  
> -		if (bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false)
> +		if (bio_integrity_flagged(bio, BIP_CHECK_REFTAG))

BIP_CTRL_NOCHECK is unused now, and should probably go away.


