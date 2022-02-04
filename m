Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8441AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qr9MIMdKMGkl3+jFpIzHaakli0UMQW0DOSg3NO0bm0Y=; b=AwTKkq114MtFA5z6MVtkgMxH4U
	16SN+3DzAohQd5r1rLc0F31fwX3hpOnhcpbzokA/MgeifJUEoyMPNFQCrcQAeQGTu8uYv3y2KsmVZ
	t5CL5j1XKO4OAxJoiBg4YCJXsDlPPBhxiZwZhUtWm2WPriRzF1F1/3vMkkSuvz34lm90McZCg8QuJ
	va39YmhKflh5X7BUZBOMD2JO8mZGwFQRowKcwCnw0jSXVg50ohwtRr1HgSqyqWDy9U3Fy+tEv1J0p
	0Js8h9RFh8GDlZvgrwSWy63NdsmWoJeK/Skis6FOJNkfp2z5eyMk9uQmTmP4VJNbDPd1/QCDYojGQ
	4OWay1fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFt58-003fEn-Om; Fri, 04 Feb 2022 07:32:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFt55-003fDj-SJ
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:32:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FD131F382;
 Fri,  4 Feb 2022 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643959950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qr9MIMdKMGkl3+jFpIzHaakli0UMQW0DOSg3NO0bm0Y=;
 b=WmKPx8VrUL0vqI48unWF2D0Pu0uxVH634MMc8owFhG+v98hq7J9Kj8h/8kNr+NoHzpN3lu
 Gr9PvBMV6DoCH7e7mIwmmOduQmOBGFKYmZucfOjHDqODpTbuMxC8lT65PXuskSX9f0Zhtv
 fF8zYbiLCVmx8KVc4QjmMSsusvKilbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643959950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qr9MIMdKMGkl3+jFpIzHaakli0UMQW0DOSg3NO0bm0Y=;
 b=041BY0CLVtvxev5BHK3dUmGmdStoqOBjPyNZVxkT6lxxGKjCtReyg1zYZgBbn58TqIRl/7
 BRuScTtCmSlxw5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59C3113322;
 Fri,  4 Feb 2022 07:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7pslFY7W/GEWSAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 04 Feb 2022 07:32:30 +0000
Message-ID: <627420fb-606a-fef1-073b-27aac7155c8f@suse.de>
Date: Fri, 4 Feb 2022 08:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 gregkh@linuxfoundation.org, rafael@kernel.org, charles_rose@dell.com,
 stuart_hayes@dell.com, Martin Belanger <martin.belanger@dell.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_233232_087807_976D6A65 
X-CRM114-Status: GOOD (  13.40  )
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

On 2/3/22 22:17, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the Discovery Controller Type attribute (dctype).
> The dctype is returned in the response to the Identify command. This
> patch exposes the dctype through the sysfs. Since the dctype depends on
> the Controller Type (cntrltype), another attribute of the Identify
> response, the patch also exposes the cntrltype as well. The dctype will
> only be displayed for discovery controllers.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c | 45 ++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  3 +++
>   include/linux/nvme.h     | 10 ++++++++-
>   3 files changed, 57 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

