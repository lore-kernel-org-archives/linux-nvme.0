Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C1C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWbngByKG5GF5TJ6h3W2K3hH5fuZhemsVYDEu2vsqW8=; b=KsZsgVyf7S1HijTlhgeCPebVyr
	wit0H+AxCeEoXKEVqKWvMtpJam7e9rwQoOFHSpk0M8D3WWbiJpfrbxmSPsxhPPKE0SuiEfesMIACG
	T1QWDVGCC1uawhFxBQOilRo2VxVbtiqyVWzghBRveranH+F8UYrjaM79F8juas3Qi38uribrtjsno
	Y+CsQop+a9J0fALvHMd9Tu2N9e7Evo1I7ZF47BRtH0z1x8sFfQEXnfmOXILcugnSmwiuIikYqz19V
	m9KmsvVtECrX4XYytuz21t6mTr7mrIpPgV1l93sDMSda+2HMNH7T5cWFrj3Qbq9t/m7tL/NJ8U2WH
	wR3su2rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHOOx-004UtV-LJ; Fri, 29 Jul 2022 11:43:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHOOv-004UrQ-1q
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 11:43:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 474FF2039F;
	Fri, 29 Jul 2022 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1659095005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWbngByKG5GF5TJ6h3W2K3hH5fuZhemsVYDEu2vsqW8=;
	b=eOdOOAV0AoqiyO8pmWJKs7iQJo2xFmY/Q6lhdCYtYwT3Nhi+lhsEnjK8fpU6njiwKPnThf
	6qHNzUdK0mAdkNS1qWQDJdJTb8VvRXIgS7R4XRvrx5GP8954sWkbFK+ssn1fz3MEdRoVfU
	uwWrkNMcDLFCfaRuW/eBCBA91fdBw14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1659095005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWbngByKG5GF5TJ6h3W2K3hH5fuZhemsVYDEu2vsqW8=;
	b=5bnQgIkeFUZBsAKBZgxojV7K67FMh1jGI51Lrbdi7DLHTYyJSqKKuos/Gy8eTMv/WUUYXX
	3Rm8t16R2v2b6WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DFE713A1B;
	Fri, 29 Jul 2022 11:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wLfzBt3H42IkHwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 29 Jul 2022 11:43:25 +0000
Message-ID: <1ea9ec22-7984-b933-e808-53ca5defd7d7@suse.de>
Date: Fri, 29 Jul 2022 13:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Karel Zak <kzak@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de> <20220425135409.zov6h63i76e2ljj6@ws.net.home>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220425135409.zov6h63i76e2ljj6@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_044329_283225_EACFDF2F 
X-CRM114-Status: GOOD (  17.68  )
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

On 4/25/22 15:54, Karel Zak wrote:
> On Tue, Apr 05, 2022 at 07:48:36AM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 05, 2022 at 07:46:40AM +0200, Hannes Reinecke wrote:
>>> On 4/5/22 07:42, Christoph Hellwig wrote:
>>>> On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
>>>>> It is really annoying to always have to loop through the entire
>>>>> /sys/block directory just to find the namespace path links for
>>>>> a single namespace in libnvme/nvme-cli.
>>>>> So provide links to the namespace paths for efficient lookup.
>>>>
>>>> I think having some form of links would be useful.  Quite a while ago
>>>> Thadeu looked into adding some form of relationship for lsblk and
>>>> friends.  Maybe it would be good to sync up and make sure whatever
>>>> links we are adding would be useful for all users?
>>>>
>>> Care to elaborate?
>>> Using the block device name is the most straightforward way here; we don't
>>> have a good enumeration to leverage as the paths are essentially just a
>>> linked list.
>>>
>>> We sure can have a subdirectory 'paths', and stick the links in there.
>>> If that helps with lsblk ...
>>
>> I personally don't care.  But I've added Thadeu and the util-linux list
>> to get everyone on board.
>   
> lsblk internally can accept arbitrary relations between devices
> (and libsmartcols can display it). If you introduce something new or
> extend the current holders/slaves, it will probably be accessible for
> lsblk to use it.
> 
Christoph, ping?

Shall I resend the patch or can you pick it up directly?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

