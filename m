Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FC6C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pXPYJ+fgOV1Zl5Qb/eENI/cPV1QeM/WC1l9xJtBkjrM=; b=nvfajaop2NAuBSMDkT1j9dG65O
	E0bKayEAXSmUkgtsAl0yGax+4XkNku7gdCrKXgqkfgTYYj5lLpQQ4e3DY7kJN632W/07ijgoVkGqU
	443r6GcGcQTVzox3mO4wbjkg2JtdFBJ34gjGEAoiTwzTaYJfTIc8NRTwVWa+sUEQwUvzDzGG2ETER
	KHCt+qPjaXwFxaVCc77bqa3Brge8FV/luWYH5Qh5cTjYoay87pkZ2DoYzNVOhWevnjHJD+4+u3dqO
	x9yGvsneP7bEC3Xr5hAjR03LKk4H65AOj5KnI9+lySk/KhxDX/+8L2jYdHxOKrvC6o+t4je17PdMV
	HnlOrfNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzTy-003wSV-Dw; Fri, 06 May 2022 15:03:02 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmIIJ-00BlqY-IU
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:56:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04B9F210EC;
 Wed,  4 May 2022 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651683366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPYJ+fgOV1Zl5Qb/eENI/cPV1QeM/WC1l9xJtBkjrM=;
 b=eG5CTnel4TjKB2USY2SAJ9eCwNU8e67BmdrokSpRYoTmgLAzzmsUHj1oj9PZ7Y21Kz3Jxl
 rNcQrR/iu03Ksv9UDz2DiOX+OExKEGybsXHUSvXQhuMNJUSykJBVAVQQAxBu7tmS7abwqO
 2BNB990G7wlwcuuGKAan3tNmNGDC/Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651683366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPYJ+fgOV1Zl5Qb/eENI/cPV1QeM/WC1l9xJtBkjrM=;
 b=CESc2MRtGMZZ4cBcssfZJruJS58Pp5zWKoK94jfLH5Ha6vbCUnmI1ZdLYnm5zvXU0kF351
 9woB0nHfywC6X0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B2C8131BD;
 Wed,  4 May 2022 16:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RAGMEyCwcmJAVQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 04 May 2022 16:56:00 +0000
Message-ID: <1286b88c-7068-d23a-1d0e-bb71efbb1258@suse.de>
Date: Wed, 4 May 2022 09:55:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
Content-Language: en-US
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
 <20220427160255.300418-4-p.raghav@samsung.com>
From: Hannes Reinecke <hare@suse.de>
To: undisclosed-recipients: ;
In-Reply-To: <20220427160255.300418-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_095607_791739_4122DD42 
X-CRM114-Status: GOOD (  11.55  )
X-Mailman-Approved-At: Fri, 06 May 2022 08:02:49 -0700
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

On 4/27/22 09:02, Pankaj Raghav wrote:
> Many places in the filesystem for zoned devices open code this function
> to find the zone number for a given sector with power of 2 assumption.
> This generic helper can be used to calculate zone number for a given
> sector in a block device
> 
> This helper internally uses blk_queue_zone_no to find the zone number.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/blkdev.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

