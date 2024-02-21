Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0171EC48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=; b=rUm6x9jL4YpN8tA4pzmWvjFTpK
	TjnmKXII3BiWx7InkrZJUI/08d+E4YnwM5h8HvXpIAn7CcXonmF9+R/mWNgso7PzdVmFRW7IeBuAO
	ae6jsE9oa1kdTr1rzT94i1Ukav4KcI6fP+YNdNzyesIPxcT5lfD5b+n2shwYo545D4g4qGR7zyNnx
	2iGKU0DxqNqjMWO9UDHCwVX8p8vDOpKw0Owj+P5rWNuK22h7HJ6t/KVhky57wBZ9ZL4UHkHbEPDda
	htvpYDIj2/DRyA+nkq4c5NFDb7UpN5PC89P//ae2Adi0SVufMGUM2jj2r9yjfWxdwDVXHLuWOE66e
	1D4m+wzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcov8-00000001Znk-14w0;
	Wed, 21 Feb 2024 15:54:06 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcouq-00000001ZeC-3LSg
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 15:54:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E040C1FB65;
	Wed, 21 Feb 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=Y2SFviG8Kfqogu3HBU9UdX91Hd3BiFS+eLonXnuOSulcbMAjq0jCoQDu6TkyOITXDmozcI
	uhpERPSzq6zO9yL3XeFrAPGTZ7cCB53JvxelTwsYiITP9rdP716NH3EJh+eeueQDE/WoGy
	UUh9CgeTvS93HnJy+l7lM8wENZu4Mao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=/WAwWXy+xxY3E3+aEZQFyatvSlgvFm24Ha73i6SOPPgjmmB1BCOKNA5nSrcDgjnoVCcnBA
	Cq7ATt+Som0MztBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=YsZ/pQyV+LQI/nCt8zSi3cJs89SgUg5sV99TNkG/r/26Dtr8jW2oZVk/0bTilzUCWDbPr3
	IqOhxETSpcBHRu9t0NyYHSCURDYpT4thNbSpI5ReKBW0L645DOLLPPuMdC9AFzqqLX+7jx
	hIkf0RdATddprUNCqPgEQesieazwn2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=kHxMQ89NIxUtOZ6rUfWb3kmUfmO69/hfuliVLpahozSGe2rOATDaUoT+vnvaMmJygU48YW
	4dxII1LMua5PjUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D204213A69;
	Wed, 21 Feb 2024 15:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCgrMYgc1mWjFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Feb 2024 15:53:44 +0000
Message-ID: <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
Date: Wed, 21 Feb 2024 16:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240221132404.6311-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.51)[80.15%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_075349_364774_72E39027 
X-CRM114-Status: GOOD (  18.65  )
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

On 2/21/24 14:24, Daniel Wagner wrote:
> There is no point in retrying to connect if the authentication fails.
> 
> Connection refused is also issued from the authentication path, thus
> also do not retry.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a5b29e9ad342..b81046c9f171 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   			ctrl->cnum, status);
>   		if (status > 0 && (status & NVME_SC_DNR))
>   			recon = false;
> +		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
> +			recon = false;
>   	} else if (time_after_eq(jiffies, rport->dev_loss_end))
>   		recon = false;
>   
Is this still required after the patchset to retry authentication errors?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


