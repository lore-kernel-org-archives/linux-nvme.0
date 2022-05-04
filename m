Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01287C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIH8khGfsWQr/G8XxJBCff3FHm1s2U5cIJcIUqX8z74=; b=G53UdaalxFZU2uvG3U8O28LJ7n
	9ENfkHkgFwZdO2zHDlwYkmuzSEn/VXpb1vtM3cQw0yfLduEmSF6fX4UegxNPjX59vZ+a6zdKo9rAY
	4k5qQJtrgK9SP0ljdjNnvExDDeUmy0yoawyZpHZeyuOnhAmQFtR+1tmerzvBiysoBVBYfnq2qtgAV
	7HOCmxmIxKAVTWItbqRpWwsH8f4SCnfLNKa6mtBiDMVtWPYS2gohyy5ENhviINv+l0MdPBAjkbXVI
	gIlq7mSNv33sRpT7zB9fBYIXq7xnZB2eESyzR66DewJch0isHvZnw2YE0b1NwEwNT4uF/YCAtIc+/
	9e7mmoow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzTu-003wRM-8t; Fri, 06 May 2022 15:02:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmIHZ-00Blaq-O5
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:55:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56CEC1F38D;
 Wed,  4 May 2022 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651683320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIH8khGfsWQr/G8XxJBCff3FHm1s2U5cIJcIUqX8z74=;
 b=fxvMs/oy3r+8L1n1MFQIapG73Ibm3O6/tat7+NP9WW1TW8r09Du8uoO6rocjdXzlpyGvwk
 C5hEla1QoB9EEgtab/YDHaB2tVq7238KrlBol0zAj2Qjbef06pxxIesMIcT6fEQSxkR9D/
 BoZBGUCuzL5vXw3JnF4pK4+YU3x97Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651683320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIH8khGfsWQr/G8XxJBCff3FHm1s2U5cIJcIUqX8z74=;
 b=ZP5QPuSU+43VPlOkMbFvUEvnny6lgfp5xqVC+flR2XZPgdo+xyxM/1E7KQx4QYaM3MKY3Z
 0aJBeF5beNC5vnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED96A131BD;
 Wed,  4 May 2022 16:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dlZdLvKvcmLmVAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 04 May 2022 16:55:14 +0000
Message-ID: <f25bdfcb-d01a-2bd0-6d7b-7d58205a2df6@suse.de>
Date: Wed, 4 May 2022 09:55:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 02/16] block: add blk_queue_zone_aligned and
 bdev_zone_aligned helper
Content-Language: en-US
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160258eucas1p19548a7094f67b4c9f340add776f60082@eucas1p1.samsung.com>
 <20220427160255.300418-3-p.raghav@samsung.com>
From: Hannes Reinecke <hare@suse.de>
To: undisclosed-recipients: ;
In-Reply-To: <20220427160255.300418-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_095521_980227_6A578938 
X-CRM114-Status: GOOD (  13.40  )
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
> Checking if a given sector is aligned to a zone is a very common
> operation that is performed for zoned devices. Add
> blk_queue_zone_aligned helper to check for this instead of opencoding it
> everywhere.
> 
> The helper is made to be generic so that it can also check for alignment
> for non non-power-of-2 zone size devices.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is done for devices with
> power-of-2 zone size
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/blkdev.h | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

