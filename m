Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD2BC5478C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 06:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7f2wOr4WiYsb2yvk0XZ3KfOvOFjASpTy+VG+axdJKjo=; b=z0qPHlQ3mc1ZGMf5efBdHdnzyl
	mAFZUFcwtznFOwU2J9J0t35Eq0bv9zbtKEs1kXxLvNfOyql90VQ4Or5ml8tmPMWMlAXn13B9VRph/
	3/Bgt2Ga4+NDQqsgupwpkgIAGyIleYkUdIUj0F7wlxDyDQYo73klFXTqXLK2gw0cIsKTDeK/gJaAY
	VKrvMqJ6NHEMffYIIh0IaqUSonWkj9FftWPGo5wS8yi/pOuqUivLtWoNlgusvSkYcMIo0blKQq6Lc
	OpvnjKFX9OSFVH1WlRIO2gkwN96QGn1sBv8KaQoYk7h+alIYxy2DuqsLOPEAKWKGI8izu3BstrWA9
	UI1HqPLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd2qe-00000003j8B-1Ff5;
	Thu, 22 Feb 2024 06:46:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd2qW-00000003j7l-2T2a
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 06:46:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6E221F4D;
	Thu, 22 Feb 2024 06:46:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860B5133DC;
	Thu, 22 Feb 2024 06:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MZT5HrXt1mWNWAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 Feb 2024 06:46:13 +0000
Message-ID: <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
Date: Thu, 22 Feb 2024 07:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5C6E221F4D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_224616_799476_A99CA6CB 
X-CRM114-Status: GOOD (  18.92  )
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

On 2/21/24 17:37, Daniel Wagner wrote:
> On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
>> On 2/21/24 14:24, Daniel Wagner wrote:
>>> There is no point in retrying to connect if the authentication fails.
>>>
>>> Connection refused is also issued from the authentication path, thus
>>> also do not retry.
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>> ---
>>>    drivers/nvme/host/fc.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>> index a5b29e9ad342..b81046c9f171 100644
>>> --- a/drivers/nvme/host/fc.c
>>> +++ b/drivers/nvme/host/fc.c
>>> @@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>>>    			ctrl->cnum, status);
>>>    		if (status > 0 && (status & NVME_SC_DNR))
>>>    			recon = false;
>>> +		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
>>> +			recon = false;
>>>    	} else if (time_after_eq(jiffies, rport->dev_loss_end))
>>>    		recon = false;
>> Is this still required after the patchset to retry authentication errors?
> 
> Do you mean
> 
>    48dae46676d1 ("nvme: enable retries for authentication commands")
> 
> ?
Yes.

> 
> In this case yes, I've tested on top of this patch. This breaks the loop
> where the provided key is invalid or is missing. The loop would happy
> retry until reaching max of retries.

But that's to be expected, no? After all, that's _precisely_ what 
NVME_SC_DNR is for; if you shouldn't retry, that bit is set.
If it's not set, you should.
So why is NVME_SC_AUTH_REQUIRED an exception?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


