Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29A5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F1UflJiT/C+aLCGaPFrCtnXw6syIU85V9VqllgoyNsQ=; b=H1932q35Rin12hVTvm9ZaMN86k
	tOT3NAxtEUwhkpFIGi+0rdL8vRt/rb527cKavtMbzQ390lPMSatOjaH188pD2MqWsUqfgr2iLzUuZ
	dtgUEhXLSSLMFdBpleP1vEIdlZwYxaOLtwjjCoNXp9gA+b/eA0Vy7yIxA6ks76hFdx92zbBq+aEv4
	/suVHf639PzhEDlb0hvG0+lUgb2kxZQpvLRNn77tzXdgTX0BJrhbNXoONkVKoCLQugAt5ra2Ap1cG
	CPl19TYqiv0tb7LP6b2XUYcA16PfolM3iC8aNBxe/Dtp4dHyuoxB7p6M8iljlrFqtpfazVXDcYbQn
	cJLQAIxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFIeP-00GIbd-02; Wed, 02 Feb 2022 16:38:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFIeM-00GIaX-15
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 16:38:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BD071F387;
 Wed,  2 Feb 2022 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643819908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1UflJiT/C+aLCGaPFrCtnXw6syIU85V9VqllgoyNsQ=;
 b=puI/AdpQ/jspQcK3mXAqRUwhDRtHt1MSPBzzy8N1Mifk+8scPd3zOn7xXDLF0P4jalWpeb
 3zwY+UlTQjuUbb+X5lykpgnY7ikIqin5+iKBeSeAhsHoiLtY6dwohtEa+d1kt2pdGnoc9k
 d+VpKvXPETRjviF2CwXpqYJ7fdzdStE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643819908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1UflJiT/C+aLCGaPFrCtnXw6syIU85V9VqllgoyNsQ=;
 b=4grxMtf5PsW9idScRI3PE3js7l6vQVXkZjy99aCei5I5HHh9Wy0iCDyXXx0hHR6VbI79sQ
 fHfUdD3zucB26NAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2A4913E99;
 Wed,  2 Feb 2022 16:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +AUgL4Oz+mHsNwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 16:38:27 +0000
Message-ID: <c2294974-38a5-1900-2af7-10d317493b63@suse.de>
Date: Wed, 2 Feb 2022 17:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-8-kbusch@kernel.org>
 <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
 <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_083830_239928_5EF3965C 
X-CRM114-Status: GOOD (  17.12  )
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

On 2/2/22 16:41, Keith Busch wrote:
> On Wed, Feb 02, 2022 at 02:28:53PM +0100, Hannes Reinecke wrote:
>> On 2/1/22 20:01, Keith Busch wrote:
[ .. ]
>>> @@ -3104,7 +3218,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>>>    	if (ret < 0)
>>>    		return ret;
>>> -	ret = nvme_configure_acre(ctrl);
>>> +	ret = nvme_configure_host_options(ctrl);
>>>    	if (ret < 0)
>>>    		return ret;
>>
>> This could be made into a separate patch, is it's not directly related to PI
>> support. >
> Well, the driver can't read the new PI formats without enabling host
> supported features for it. Enabling the feature tells the controller
> we're going to check for it, so I don't think we could reasonably split
> this part into a prep patch from the part that sets up the PI formats.

Actually I was thinking about a patch renaming 'nvme_configure_acre' 
into 'nvme_configure_host_options', as _this_ really is independent.
When mixed together with the PI stuff it's hard to track down from the 
commit message when it got changed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

