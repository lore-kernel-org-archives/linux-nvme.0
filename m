Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899D2C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Jan 2022 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxPzaSMpnFyo8l6kVe4A+dozx2wuCnauIda1njE7MQg=; b=4lF5lLNANm7GQgVOA6BFo/6Tx8
	KDuJAgdohCgK6ZyvZOD4WpsGCGShwG07EjtHCxyqQX1Sb/lNiDb6qJWRlHEvOaUoiam6SHRUEoTQe
	xLGA6/nIM0nXR+YfjqoSGch0VEb1V60QTS023IJw9HdStE3G/dpLRdJdXZ9t2TvaHfsBWVa+DuTlQ
	jm3jqM30jJ4QRABBmvpg3VzpI4xBqvYKBHFHYSfnVcuYOCFMlRdsqJE8i+mzqqKLMOT8Awui9Vlx5
	UMWnRIIyr/oqko/cH/tPdFD6uh9ViV32XDnZzQ9HP1HTReaUtIkRgEnuxOj9d/u4+E7/YYv0Tb6yo
	VE5uMGUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDn8m-004moR-5z; Sat, 29 Jan 2022 12:47:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDn8j-004mo3-3I
 for linux-nvme@lists.infradead.org; Sat, 29 Jan 2022 12:47:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E3A21FD37;
 Sat, 29 Jan 2022 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643460455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxPzaSMpnFyo8l6kVe4A+dozx2wuCnauIda1njE7MQg=;
 b=J+QKMx/NaLAksjOKcBLlcMWsKVL4bcaez/PW5TsrahP2SESd/HACGmHK6SlyDP3EFLEFU7
 S/tdD4n3oTGwxBx5WESzSMg4hyxmiAeVDLkoRhxl5seBDEFpapch9YM7Mld8LZ1LBL1lSL
 5Up6qBNakYUYlnf5K00fzd8IHe/nYkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643460455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxPzaSMpnFyo8l6kVe4A+dozx2wuCnauIda1njE7MQg=;
 b=/KtiEk8f0b/qJRGmxUSrxcTfmZN3lz1JpUd+6OlFcgxcbfoHAMfvMp0l+jHsuKR0yq21c0
 Y5nYQdEXAEyx0QAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF2D713ACD;
 Sat, 29 Jan 2022 12:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OFJiLmY39WFvAQAAMHmgww
 (envelope-from <hare@suse.de>); Sat, 29 Jan 2022 12:47:34 +0000
Message-ID: <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
Date: Sat, 29 Jan 2022 13:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220129_044737_313625_F50E2166 
X-CRM114-Status: GOOD (  12.58  )
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

On 1/29/22 13:23, Belanger, Martin wrote:
>>
>> On 1/29/22 00:02, Belanger, Martin wrote:
>>>
[ .. ]
>>> It would be nice to have different events because if we use the "change"
>>> uevent for both "log pages have changed" and "connection has been
>>> restored", then the user-space app will have to send both an "explicit
>>> registration" and a "get log page" whenever it receives a "change" uevent.
>>> It won’t be able to tell what that "change" uevent is for.
>>>
>>
>> Au contraire.
>> Change events come with a full payload detailing out what the event is about.
>> In the case of a 'log page changed' uevent the event points to the controller
>> device, and payload is a string 'NVME_AEN=<aen number>'.
>> In the case of the 'path reinstated' uevent the event points to the block
>> device.
> 
> There is no *block device*. It's a connection to a Discover Controller.
> 
Ah. Correct. Guess we'll have to add an uevent here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

