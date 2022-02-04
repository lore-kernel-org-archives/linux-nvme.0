Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95892C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdOXLCWTpkUcFRfA4UjyyGzvhhFnyuOW9aKopbavdpA=; b=EnmPAlNAMbOUijZ0+Wd/k2Rn5Q
	0D+RY0iocd7Z2zJNcSfGmDAYl2TNs2pO/373x566g98hmgwXfY5AzyfiDooJxe9opZvmajN4tcB6t
	4Xy8b6/UNxDvGUXPg/eugTjUFP4hEWbKS9PrEhX3FycKREaAt9pni0EfEwC90q6vk+nCdLvem9RNz
	zmRvukE4cRaiAJsNoRXhTOlPKAPS2ugZHN8sRoA8BNaCZ+8RmE/L1y+0PGDyuuXPRTzHcsgVG4jOT
	TCyxn9/jMLZnzpk7u9ijj2NZnBYCpoW1nuNl5ZdPwz3RBcqk2tOmL8IHLxn2NGYgyyxv05nc556mh
	OEXzh8UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFt3y-003f75-Ay; Fri, 04 Feb 2022 07:31:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFt3w-003f6h-2x
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:31:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91A111F44E;
 Fri,  4 Feb 2022 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643959877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdOXLCWTpkUcFRfA4UjyyGzvhhFnyuOW9aKopbavdpA=;
 b=jlFKNryzFfYlHKv9wY47XXeP/BVMOOxcKOCqzv8rV+3ZQwEzutWdL2tJl0e2yCfn6wpFQA
 cdvJEcQr1KYZT4BeznYwoMfEXzLSoNADWjJCitLNHFYfl8dYb7lURhZbpGKtSbzV/3UiJk
 UwI0DRaiBWrbx0uwyDklvJIqxVUWvCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643959877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdOXLCWTpkUcFRfA4UjyyGzvhhFnyuOW9aKopbavdpA=;
 b=dyl9jw/yzP7uYzpCo8J/JQiYIDQmTIfIbHCh3zLsas47iqQ5y3SKXjt6JSLsXMFnGebdVI
 UXDAkMePNBoMhpAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 500FF13322;
 Fri,  4 Feb 2022 07:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M5kqEkXW/GG5RwAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 04 Feb 2022 07:31:17 +0000
Message-ID: <e9c8f491-5577-98c4-4266-08657fabfa91@suse.de>
Date: Fri, 4 Feb 2022 08:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 2/3] nvme: Add device_update_groups()
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 gregkh@linuxfoundation.org, rafael@kernel.org, charles_rose@dell.com,
 stuart_hayes@dell.com, Martin Belanger <martin.belanger@dell.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_233120_302876_E930491D 
X-CRM114-Status: GOOD (  10.90  )
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
> This is used to update the sysfs groups after device objects are fully
> initialized.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/base/core.c    | 28 ++++++++++++++++++++++++++++
>   include/linux/device.h |  1 +
>   2 files changed, 29 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

