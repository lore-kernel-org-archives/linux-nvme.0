Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5569AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 07:01:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1480F61AED
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 07:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1480F61AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4EBImjIlFfb56mswFvxG2IqeUqy42kOVMr8oRktw6dI=; b=V2miilusOlY5AOuJKZcU66cf4O
	+7401OQ3A4Wi9SevCLZgrKZTxgySDh9xKWkksovJEVUxSW/XYc5TQSLkmVrzBgQZfEICEuMFBD5QU
	aqYd+GD0/lmSwSpPVWxAM+ru0BwLe1vGKXoo7+hhjEWVBeUQL+73Oi0Ev7jc/PbVKFSZQSOfY05n4
	7lczOvWa35mt+B0zP2PhMuI9GSFsY7L6c8zxT7d/i+7KvUmJRZxgYDfdbNpRrgIWm7IBPNe769ZrN
	2P5hiWoZUK3IHKmkdrYhA+qULmHivPIBNH+FyEmA6zWHEd8xLsiiWzmKUnBo151EoUezvHYOfBZmG
	ZX33qWKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmsSn-000XVA-9J; Tue, 16 Nov 2021 07:01:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmsMo-000VUC-2X
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 06:54:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF1B1FCA1;
 Tue, 16 Nov 2021 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637045692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EBImjIlFfb56mswFvxG2IqeUqy42kOVMr8oRktw6dI=;
 b=0gCbMd15ntankEgHA2SqJiUaIqeGIQ1pnhTeMtcxM0og1cm6Ka4xp/HvYMUMbqiya1HynC
 Fkg/dkRCzYt8Z7f0lING9wyDd1l3Rvk55pON0LSFVmVqm22DG2NvaYciz9TY+FSki6fOJH
 Dv3c5cGJT2TVVkNtVc6aRtSDU3Fo+54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637045692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EBImjIlFfb56mswFvxG2IqeUqy42kOVMr8oRktw6dI=;
 b=Wx+kFnRCa5ynW1I6pS4XvaTT2nF/VDaJ3qtV8+ErXIi9Lp8ovKTafGkM6RQg3Y7jvX1a1U
 4QlrZm316Q6gk5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D447913B65;
 Tue, 16 Nov 2021 06:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id InI3LbtVk2FUSwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 16 Nov 2021 06:54:51 +0000
Subject: Re: [PATCH] nvme: honour O_NONBLOCK during resetting
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211111105953.63072-1-hare@suse.de>
 <9c8da771-c5f9-923c-4c03-5d5ac8392ef8@nvidia.com>
 <YZMU+DUJpsD7uMHY@C02CK6ZVMD6M>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f8f99648-fe6d-7b9f-6cb7-4c7444754a51@suse.de>
Date: Tue, 16 Nov 2021 07:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YZMU+DUJpsD7uMHY@C02CK6ZVMD6M>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_225454_315845_B03197B4 
X-CRM114-Status: GOOD (  19.88  )
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

On 11/16/21 3:18 AM, Keith Busch wrote:
> On Tue, Nov 16, 2021 at 01:40:04AM +0000, Chaitanya Kulkarni wrote:
>> On 11/11/2021 2:59 AM, Hannes Reinecke wrote:
>>> When opening a controller device node we should honour the O_NONBLOCK
>>> flag to allow the device to be openend even if it's in state 'resetting'
>>> or 'connecting'. This allows user-space applications to use a call to 'open'
>>> to figure out if the controller is present, even if it's currently
>>> undergoing a reset.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>
>> Will resetting and connecting ever result is deleting the controller due
>> to error cases present in that path ?
>>
>> If yes then application will have handle for something that might
>> go away in the future, should allow such a semantic ?
> 
> Resets can happen at any time, so they already have to handle it even if the
> controller was live when they opened it. Perhaps the open should succeed for
> any non-terminal state.
> 
Indeed. And we should add a state check for the ioctl itself, returning 
an error when the device is not running.

I'll be sending an updated patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

