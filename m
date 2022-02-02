Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B95CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bP/Cb29IH3aYrBioPBqWo3Wm+2fW+zC2bc9XLXLbfCY=; b=QeZWOA2kAvf1o0rd71/p5xqMB8
	va4wpVZc9FhcC9/1e/nSloy5svUMETbt4nNK7w3NXAXqTvkB/0SQQx1Ha0fxQU/DN4TACk7ce2Qku
	0Z9PK+dCcpTH6sL9k1n5iQLZsj7WT5POtyKJ3PVgH0gaeOSBjMVuTcssGWT5GHUbJygXqTBUA1l+Q
	H0q2edwD0xLLEuZIVip96l5QWxvzr7fG1c12toyrQEggPLkDRgJo7PXhz6bTnZsujsF76CPIYn0RN
	3YWyLWXx6HhGlQhsjSGNy1s8pfx5n7szS0FPoBzNTMBdzWgNPJEwf63L2anTfieZekVHN4fxH8BnF
	jzKXnO6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFB82-00EcLR-7v; Wed, 02 Feb 2022 08:36:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFB7y-00EcJA-9W
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 08:36:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41C7921126;
 Wed,  2 Feb 2022 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643790990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bP/Cb29IH3aYrBioPBqWo3Wm+2fW+zC2bc9XLXLbfCY=;
 b=xPHTkSGAwUstazl4gRo0ONFgHzfdBkywt4OEalRiFBmwJlcZi+S0NnUZlv9SR3J4yBSzNi
 MpfEY+WbLw4TNAyam9sjCf9RpZcySdQU4T2rqf4p71Rt93bKkCX+L+myA2/0givGjjTzJt
 VycQ1PXwOjTrmySOpvNU3TELmwrq44E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643790990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bP/Cb29IH3aYrBioPBqWo3Wm+2fW+zC2bc9XLXLbfCY=;
 b=mQe3+ATRUhIavRA5nuQyjOVgpYhNoXVcXU4IsqB/mco2/e73nP8ODSYseePs5iZT3lz4cH
 Buam5KDTjHukhsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 172FB13DE1;
 Wed,  2 Feb 2022 08:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yAXlBI5C+mG5KQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 08:36:30 +0000
Message-ID: <4e79411d-3009-a376-6ecb-bb10100f9cee@suse.de>
Date: Wed, 2 Feb 2022 09:36:29 +0100
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
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
 <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
 <SJ0PR19MB4544E634C5B347F231783B20F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <9c5e4cff-2a5e-c1d2-34ed-ac7918c3991b@grimberg.me>
 <SJ0PR19MB4544AC1F430E3B025FE8D0C5F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR19MB4544AC1F430E3B025FE8D0C5F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_003634_561364_75B5B8B4 
X-CRM114-Status: GOOD (  15.96  )
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

On 1/31/22 17:16, Belanger, Martin wrote:
> 
>>> Hi Sagi. Thanks for the code snippet. I just had a question about your
>> comment.
>>>
>>> You say that you don’t see any point to send an event on the
>>> disconnect because it is async.  I don’t quite understand that part.
>>> For example, I've observed that when connectivity is lost the kernel
>>> will try to connect every
>>> 10 sec. And it will keep trying to connect 60 times (i.e. 10 min)
>>> before giving up. Wouldn't sending an "offline" event when
>>> connectivity is lost give user space apps a heads up that the nvme device
>> may not respond.
>>
>> Why does userspace need it?
>>
>> When the host will disconnect it will send event asynchronously, so
>> userspace cannot reliably do anything before the host disconnects.
>> Other than that I don't understand what would userspace do with "offline -
>> I/O is going to fail"...
> 
> I was just asking for completeness. Some apps may use it.
> 
We had a similar discussion during udev development; originally we had 
KOBJ_ONLINE and KOBJ_OFFLINE uevents
Turned out that the KOBJ_OFFLINE events were quite pointless (as Sagi 
indicated), and hence we settled on a single KOBJ_CHANGE event which 
typically is sent when a device/system gets back online.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

