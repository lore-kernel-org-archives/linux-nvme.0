Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FE5C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cTkbArGcpFmU06KIIEvA3hO7zAFZZFkTDvPJIefhxnY=; b=ehThw990fRG1LwlFNHh5AS42Ku
	gBq+N7oPMN6W00wnEATo5bW6BNiSGjzCo66ewHnX7y1RhR2acvbj/dW67gSp5sCWTP7UcpJ89PYfq
	74Y8CfTTp9xsp14WlrrBwNuuPHD5jrusZ5LL9jFVSUDs1XHrYw8tC2I6hP6BKGlB45f/Y+cXvOWsh
	ge34flNW9hILbVfKuURwsKTgx7DkPUzdyQ1rN6LkZkUY8kTsCoL7qyNlxWbvhbxhxvgCpqFlG93zn
	hArGwy9edkLBobfwh1lKQ40Sca9N9EybWW/IWkE9JC5d5uW69yD3ms2momlaG0kzXU/EHpBIo8pc5
	G/HGkGhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3JPL-001GS1-Tk; Mon, 20 Jun 2022 15:33:43 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3JPJ-001GRc-A4
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 15:33:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C3838B80F63;
	Mon, 20 Jun 2022 15:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D37C341C0;
	Mon, 20 Jun 2022 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655739218;
	bh=hbhAp8mbe8aejEUwyoBwRDrBV0pbR7SwNVAA2pp29Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAJOdMY8Tvr2Y8jufS0EnH/4qhM0uDu/VmV0B3f0x+6t1I7VcRpnjkeuIP+TTilBC
	 nZcFTGq+2PBjjp5t6Ve6wnZOh+u3ZL3rD35iNqh2o1KeWoy3n4G00h8QW/71TM1HlG
	 tC9Q4hNTuzjvxKlhVTxf+dRxO/SK7hHr7lq8fe71vyb+W3k9R5Ayc67Mswv0DYiQZR
	 1wjld5FHcILMP/RFKBhhJBHpjnrWFK+f7+5T05Ln99qlM4oaaOWgs2OpXO0mboq1Sn
	 YXfHvtLkdYoDY5GE97QDs0w1CnC/BNj5FDcB7PSk8VXYdvvHtH68XlIxM3z2pDOnZ3
	 BoqkqIZb+nUvQ==
Date: Mon, 20 Jun 2022 09:33:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, joshi.k@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v2] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Message-ID: <YrCTTzUnBAy0F6zE@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644@eucas1p1.samsung.com>
 <20220620120842.829292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620120842.829292-1-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_083341_528341_CB919F9C 
X-CRM114-Status: GOOD (  16.23  )
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

On Mon, Jun 20, 2022 at 02:08:42PM +0200, Joel Granados wrote:
> Adjust the values of NVME_CAP_CRMS_CRIMS and NVME_CAP_CRMS_CRWMS masks as
> they are different from the ones in TP4084 - Time-to-ready.
> 
> Fixes: 354201c53e61 ("nvme: add support for TP4084 - Time-to-Ready Enhancements").
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  include/linux/nvme.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 29ec3e3481ff..bbe8b03e7452 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -233,8 +233,8 @@ enum {
>  };
>  
>  enum {
> -	NVME_CAP_CRMS_CRIMS	= 1ULL << 59,
> -	NVME_CAP_CRMS_CRWMS	= 1ULL << 60,
> +	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
> +	NVME_CAP_CRMS_CRWMS	= 1ULL << 59,
>  };

Oops, thanks for the catch. Could you just rearrange them so they appear in
ascending order?

