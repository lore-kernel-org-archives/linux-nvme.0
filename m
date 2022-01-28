Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E70FC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23gdDwBuh3nxrnrwJKdxoVCEjVb7iOtLt/UOWosg4AM=; b=IwsBHqhw/nyUwfQT26LzVpcGX9
	/UZYM3cnH+FOj2Xc4++JA0OiSqjHIjc+PBXJTSbU6ch9HBLv0pR83jXB96rJkR6/8M3F4KrC+ueIU
	eF9Fl7LhnC6/WZfFZtfO0IsmTjspm7hWqbz12kc7gmBZE9eTZ31PKy7bw7YuaobPrTAWPtEJs0wiB
	Fxb9KVKhAtGMoPlzPTYSm39sdTEGFGtsIrdPDurin8FRzlRnj3JCQxKI0DnGSkzoYZyjTOu4oKFdx
	+IvaefxmnbYmmHhK5FNyzGlpPQRXIZSD2b1UNgH1GXOb+Egf8i6KD09uv2+0mQ91jStH2Hc0Vjg1R
	QgPbC3hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDUIC-0032YZ-Pu; Fri, 28 Jan 2022 16:40:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDUI9-0032W4-9e
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 16:40:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF70D210FE
 for <linux-nvme@lists.infradead.org>; Fri, 28 Jan 2022 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643388000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23gdDwBuh3nxrnrwJKdxoVCEjVb7iOtLt/UOWosg4AM=;
 b=DZorNth9o6c5mRQmtPjDzH/BIOii7B7IUgxXWpy67q4MvcUzsnR5vfan+6p1zUVIG4KUgR
 Wu2RfrKt2iXfdL3B3HpF0iae8Rj177CTuqmnuHJltJAEskIpH1G9wPXWTYmWGSK2sYL3RD
 lL1Q5uKJgfl0g9oLsMlI9BWraBtmkx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643388000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23gdDwBuh3nxrnrwJKdxoVCEjVb7iOtLt/UOWosg4AM=;
 b=8x5dRYegaLpb8a3fzTbiXhYcQ3QE4NCh4gOKq0ef1W7p5MQgWKHss4ehcU8ZOLvIXCO7UB
 L0SrGFFr7Gtkj2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBE4E13A3E
 for <linux-nvme@lists.infradead.org>; Fri, 28 Jan 2022 16:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CVULNGAc9GGhcAAAMHmgww
 (envelope-from <hare@suse.de>)
 for <linux-nvme@lists.infradead.org>; Fri, 28 Jan 2022 16:40:00 +0000
Message-ID: <528c2c20-1343-b0e9-1a24-1469e275006c@suse.de>
Date: Fri, 28 Jan 2022 17:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V4 1/1] nvme: Add verbose error logging
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20220124185144.53810-1-alan.adamson@oracle.com>
 <20220124185144.53810-2-alan.adamson@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220124185144.53810-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_084005_539349_68E70849 
X-CRM114-Status: GOOD (  12.64  )
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

On 1/24/22 19:51, Alan Adamson wrote:
> Improves logging of NVMe errors.  If NVME_VERBOSE_ERRORS is configured,
> a verbose description of the error is logged, otherwise only status codes/bits
> is logged.
> 
> Verbose logging examples:
> [  183.333734] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
> 
> [  227.767945] nvme0: Activate Firmware(0x10), Invalid Field in Command (sct 0x0 / sc 0x2) DNR
> 
> Non-verbose logging examples:
> [   41.280509] nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (sct 0x2 / sc 0x81) DNR
> 
> [   77.249153] nvme0: Admin Cmd(0x10), I/O Error (sct 0x0 / sc 0x2) DNR
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
>   drivers/nvme/host/Kconfig  |   8 ++
>   drivers/nvme/host/Makefile |   2 +-
>   drivers/nvme/host/core.c   |   3 +
>   drivers/nvme/host/errors.c | 230 +++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h   |   2 +
>   include/linux/nvme.h       |   1 +
>   6 files changed, 245 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/nvme/host/errors.c
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

