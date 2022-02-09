Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379C6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 06:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMV1y2jGFP95970/YB/hGNoW7JjSz01pv3Q5tRwBLmY=; b=bu/0izGrJLGcPeWq3izG86I1Bl
	2IeWiUptVPCfz5r1j+xMePfdWc+03s985UnSqWGL4+VnRNR4oUXgkMy0FcQ7dn7kue8O8fObTfZZt
	cZQRWUXTFs9ZZOD9H2WEgg1mKQQD6WXlGxm1NknkrrrKC96YETWLuRO4Ll/0HYly5Jz0AoGaYRmnj
	U3ofF5UFWTToEdAqA8W92XvWlVVUtlhSiHbXTGMaGGAahUaeFX0Rtwfk40YDqfFQ/QG030wJZO3Id
	zhulhf4qSaJMRm2PkXGPrAgQmhhMfmhWPAEiflFX72gfv7Dy+6YbVdYjsyQcf3CmkfY3n0PGMSAUn
	5j+CwBSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHgfq-00GNRm-Ho; Wed, 09 Feb 2022 06:41:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHgfn-00GNQr-N6
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 06:41:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15C162110A;
 Wed,  9 Feb 2022 06:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644388908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMV1y2jGFP95970/YB/hGNoW7JjSz01pv3Q5tRwBLmY=;
 b=PdLrgpu+XpVAVANQousglBnyF3r77BE0yBflmEi7++N0DSfD/2NV2v6pCvvk12Foi+EgZM
 vh+fNTVjWHQ16YnD9P+3czsNIYGmmwnFIN88joSc2cX6p88Yl7Pu3hStwdCV3i68iLJS+i
 af3wdCBtH4IG/2DwgKfNnvMAszdd0cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644388908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMV1y2jGFP95970/YB/hGNoW7JjSz01pv3Q5tRwBLmY=;
 b=0SyUtkQrSi9xM0/4lKFcjahj8JyDmmJzP/JzvCI2sS2i9NqNLnsD5q7HtGQBzOBQ4l3kZr
 X+/v3sjb4gv6J/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DE9E13487;
 Wed,  9 Feb 2022 06:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c7NTEitiA2I5dgAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 09 Feb 2022 06:41:47 +0000
Message-ID: <ca877685-646b-e076-1110-d5d94d852899@suse.de>
Date: Wed, 9 Feb 2022 07:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_224151_946954_F21170E1 
X-CRM114-Status: GOOD (  19.24  )
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

On 2/8/22 20:33, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the Discovery Controller Type attribute (dctype).
> The dctype is returned in the response to the Identify command. This
> patch exposes the dctype through the sysfs. Since the dctype depends on
> the Controller Type (cntrltype), another attribute of the Identify
> response, the patch also exposes the cntrltype as well. The dctype will
> only be displayed for discovery controllers.
> 
> A note about the naming of this attribute:
> Although TP8010 calls this attribute the Discovery Controller Type,
> note that the dctype is now part of the response to the Identify
> command for all controller types. I/O, Discovery, and Admin controllers
> all share the same Identify response PDU structure. Non-discovery
> controllers as well as pre-TP8010 discovery controllers will continue
> to set this field to 0 (which has always been the default for reserved
> bytes). Per TP8010, the value 0 now means "Discovery controller type is
> not reported" instead of "Reserved". One could argue that this
> definition is correct even for non-discovery controllers, and by
> extension, exposing it in the sysfs for non-discovery controllers is
> appropriate.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c | 39 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  3 +++
>   include/linux/nvme.h     | 10 +++++++++-
>   3 files changed, 51 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

