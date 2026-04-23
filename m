Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BCAF589D4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HptwGGr9opBUecJMdQt8J/p/O09XCzqffhv0tU/XMwQ=; b=x0MW9PMus26qhhx72z62udmJ/i
	gQezoYwOPVeLwDvWnht7o8FtzuYh5R4KDnFuheCaFPUPi4uuRdkEahSd2nnCiUzyh0eTvNDKHQXTV
	LXrNV9DBa1L6P8MxOfStmsxVYNizAHkgR8i/jp3aGubz/xPxbUUVGk+5PvUd5b6CR8aFAjMEIcCjo
	lQRagxWyOw3uk3KLa/ThmsBVLmdXS75YN+erQOBV0HjOGDdD7qk3cYT1Vbwgo+MNKy1mxJLplNVN+
	NF1yOfUqGIWw/XkiCdAFFfJmHjZAC1nuUGsZ1Kpa+ZTQVCEjwl4YZ6Io8fu+D6gZWr0OnH6WGc9Ya
	AL3crYbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFuNB-0000000Blfd-2O3l;
	Thu, 23 Apr 2026 13:45:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFuN5-0000000Blf0-3OjZ
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 13:45:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B9BD6A86C;
	Thu, 23 Apr 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF4CD593A3;
	Thu, 23 Apr 2026 13:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R9XuOX0i6mkTQAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 Apr 2026 13:45:33 +0000
Message-ID: <7fda4cf3-942c-42bb-b8f8-3276d4f793d3@suse.de>
Date: Thu, 23 Apr 2026 15:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin timeout
 per nvme controller
To: Daniel Wagner <dwagner@suse.de>, Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org,
 mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, mkhalfella@purestorage.com,
 chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
 <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
 <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
 <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2B9BD6A86C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_064535_992312_D09BBD86 
X-CRM114-Status: GOOD (  13.28  )
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

On 4/23/26 14:46, Daniel Wagner wrote:
> On Wed, Apr 22, 2026 at 01:08:44PM +0200, Maurizio Lombardi wrote:
>> On Wed Apr 22, 2026 at 12:10 PM CEST, Daniel Wagner wrote:
>>> On Fri, Apr 10, 2026 at 09:39:18AM +0200, Maurizio Lombardi wrote:
>>>> +	/*
>>>> +	 * Wait until the controller reaches the LIVE state
>>>> +	 * to be sure that admin_q and fabrics_q are
>>>> +	 * properly initialized.
>>>> +	 */
>>>> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
>>>> +		return -EBUSY;
>>>
>>> I assume the idea is to use an udev rule to set the value. Though I
>>> think this is racy:
>>>
>>> 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
>>> 	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
>>
>>
>> Not really, the idea was about to prevent the user from setting the
>> timeouts too early during the controller's initialization.
> 
> Yes, but then how do you know when is too early? Do you read/poll the
> state of the controller?
> 
Well, a timeout less than KATO is questionable, as we cannot detect any
timeouts reliably until then. So having a KATO of 20 seconds with a
command timeout of 10 seconds will be pointless.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

