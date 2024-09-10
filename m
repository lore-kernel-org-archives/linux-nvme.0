Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F57ECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkuEBFe/phfP3mVSPZsFfI6kppYkvVEqtNgrnLVbgs8=; b=21cB4lQQYXpTpFawLawznkMtmC
	5RglFB2rZrxe+iLk80Qc2bZkDI04TZhtUbiKehurJy95gc7RTT0z8Stj8GUy/YEgZfEbFgCU3v6L4
	RTjiuvJA8IYW8oHzxh3Mh3ncA/EhYL1Gi9V5LiSjFYUN2JvCywnGU/xGFJKwbVQqX64ZXq/ybGWV9
	o61XHH99bjUTv5ue3cvJQcO6Yb955mGqL0sS7Z80sTmKZfXuchQH6ck5PKp2YhsjJSCD4GKMdIp+7
	ZNHyiwbCivuSY2CBqLuLV64zkOjBb1Po8/L6o6g10gscKSKFhOao1JVC9S/grqcT1jDWa3ujz5ZD2
	PSgQ7d+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so0Fg-00000005bN7-2dlG;
	Tue, 10 Sep 2024 12:45:48 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so0F5-00000005bFW-1RYl
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 12:45:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A32ED1FCE8;
	Tue, 10 Sep 2024 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725972309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuEBFe/phfP3mVSPZsFfI6kppYkvVEqtNgrnLVbgs8=;
	b=sPJzZbw81iOzcP39i3+J4ZmkLk1vjzPgwIdMgCTFAlie7gg/1KwgvUFPw7P+B8GR/LPWGs
	7c504KI5nAcapd3Zdj3vAvdyA9uvXr5+oEhw/nQLfcCi1FpkyTcVrZa6a9ILY+oHm47HAc
	yBzgKWbyQf/GPXI5NEH/czZpJ0kELzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725972309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuEBFe/phfP3mVSPZsFfI6kppYkvVEqtNgrnLVbgs8=;
	b=s14is5yU2Wc/2Czl/313ng+l3tfSIZPhLRBY95jy1eGWpASjLnvE/I93A2W5r2LcYpj8cu
	f+qRjJ5yE58I6nBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725972309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuEBFe/phfP3mVSPZsFfI6kppYkvVEqtNgrnLVbgs8=;
	b=sPJzZbw81iOzcP39i3+J4ZmkLk1vjzPgwIdMgCTFAlie7gg/1KwgvUFPw7P+B8GR/LPWGs
	7c504KI5nAcapd3Zdj3vAvdyA9uvXr5+oEhw/nQLfcCi1FpkyTcVrZa6a9ILY+oHm47HAc
	yBzgKWbyQf/GPXI5NEH/czZpJ0kELzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725972309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuEBFe/phfP3mVSPZsFfI6kppYkvVEqtNgrnLVbgs8=;
	b=s14is5yU2Wc/2Czl/313ng+l3tfSIZPhLRBY95jy1eGWpASjLnvE/I93A2W5r2LcYpj8cu
	f+qRjJ5yE58I6nBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81AD1132CB;
	Tue, 10 Sep 2024 12:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SjCHHlU/4GZQDwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Sep 2024 12:45:09 +0000
Message-ID: <14b31e97-d67c-4dd2-949f-0666fb30eb54@suse.de>
Date: Tue, 10 Sep 2024 14:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Force ns info updates on validation if NID is bogus
To: Yihan Xin <xyh1996@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240910095006.41027-1-xyh1996@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240910095006.41027-1-xyh1996@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_054511_563971_3F8DB023 
X-CRM114-Status: GOOD (  25.19  )
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

On 9/10/24 11:50, Yihan Xin wrote:
> When validating a namespace, nvme_update_ns_info()
> would be skipped if nsid changed. However, this
> happens everytime the in-use controller is
> reattached if NID is bogus, causing nsid not being
> restored to the previous one, eg /dev/nvme0n2 ->
> /dev/nvme0n1.
> 
> Don't skip ns info updates on this circumstance.
> 
> Signed-off-by: Yihan Xin <xyh1996@gmail.com>
> ---
>   drivers/nvme/host/core.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1236e3aa00ed..c0875fb93b8d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3979,11 +3979,24 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
>   
>   	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
> -		dev_err(ns->ctrl->device,
> -			"identifiers changed for nsid %d\n", ns->head->ns_id);
> -		goto out;
> +		/*
> +		 * Don't skip ns info updates if the NID is bogus as it
> +		 * changes everytime the in-use controller is reattached
> +		 * to the bus and thus the namespace is recognized as
> +		 * another one.
> +		 */
> +		if (ns->ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
> +			dev_info(ns->ctrl->device,
> +				 "Ignoring nsid change for bogus ns\n");
> +		} else {
> +			dev_err(ns->ctrl->device,
> +				"identifiers changed for nsid %d\n",
> +				ns->head->ns_id);
> +			goto out;
> +		}
>   	}
>   
> +
>   	ret = nvme_update_ns_info(ns, info);
>   out:
>   	/*

Nope. A namespace is identified by both, the NSID and the namespace 
identifiers (GUID, UUID, you name it).
In our implementation we identify the namespace by NSID, and then
validate that the identifers match.
If you have a device which changes NSIDs you would need to swizzle
that logic around, ie identify the namespace by GUID/UUID, and then
check if the NSID matches.

But you'll run into issues here, as the NSID is stored in head->ns_id,
so if you attach a namespace with a different NSID you'll end up 
addressing the wrong namespace when sending commands.

So this 'fix' is actually wrong ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


