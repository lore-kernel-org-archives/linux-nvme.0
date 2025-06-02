Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABD0C5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x64QjRBCRpirY2fNZf36VUt7jRDj1P8V0N4SrNE88ZU=; b=T127NhZwwuueCmvOjKDJELgn0h
	ADVReB0vIoIJqQ4ljUbMeQUSx5aRM963ZJSy6LfXr02yEvG18G1/YTMLXval9B9C5kl9gkUULjM99
	kAYygYE0dQOeSZKvzBsAkyrXTrMiY7L43WI6pYiBOM3L8kSNdQ4DazumUS683gRAf4SZVeGxOKUD9
	fAOi9kfo/GhDQRHRTP32NKixDgR9izdoAZvk5Al5mUTeFbKiytTi6TsOs4S3+9kA7PfyhaILyzdhd
	FcsDi+E/JdchdBkyOPGSri89I5uZ1Ni1HFfGs9HSRm4seEwnuTqnzEqbgKrTy1AzUZRSHQWSzwKOv
	Pxy/y4/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLyqo-00000006qy2-1EJT;
	Mon, 02 Jun 2025 06:40:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLyoh-00000006qiE-1UYG
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 06:38:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D5522121B;
	Mon,  2 Jun 2025 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748846316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x64QjRBCRpirY2fNZf36VUt7jRDj1P8V0N4SrNE88ZU=;
	b=CHxR8tEiC3M+bbLMGG3OaOwx4gb+Wt1vnHQwrzN9B39+OqVU5MOAt0JzFI1KGSVgRmZvKe
	bEKVjKqS0AOV1LCWRNIgSwDxOPJbYXGfhgYqaZvnN9LRgigVm9eNmtTFGRu9ERqOCn7NnY
	onOcCg/mPsuXY67EmtLRqTrHoKSKrgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748846316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x64QjRBCRpirY2fNZf36VUt7jRDj1P8V0N4SrNE88ZU=;
	b=M0Vy/tb0RR46mHbn3yem+n/QmJPYHL3eESeVSeQfrtzTnaDM+/ZkKN+1+XiBwlzZk3pW5N
	KcJGysCd9PVq9UDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748846316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x64QjRBCRpirY2fNZf36VUt7jRDj1P8V0N4SrNE88ZU=;
	b=CHxR8tEiC3M+bbLMGG3OaOwx4gb+Wt1vnHQwrzN9B39+OqVU5MOAt0JzFI1KGSVgRmZvKe
	bEKVjKqS0AOV1LCWRNIgSwDxOPJbYXGfhgYqaZvnN9LRgigVm9eNmtTFGRu9ERqOCn7NnY
	onOcCg/mPsuXY67EmtLRqTrHoKSKrgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748846316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x64QjRBCRpirY2fNZf36VUt7jRDj1P8V0N4SrNE88ZU=;
	b=M0Vy/tb0RR46mHbn3yem+n/QmJPYHL3eESeVSeQfrtzTnaDM+/ZkKN+1+XiBwlzZk3pW5N
	KcJGysCd9PVq9UDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18BB2136C7;
	Mon,  2 Jun 2025 06:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I+b7A+xGPWi9SgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Jun 2025 06:38:36 +0000
Message-ID: <6c201ca2-e288-4f82-a3d8-9a3158948cce@suse.de>
Date: Mon, 2 Jun 2025 08:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
 <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
 <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
 <f540dd31-75f6-4e1c-9bee-304530984610@suse.de>
 <czrjrtn2q5srlg664xryrzhjifkuz57jip2qx4b7aagky57xpz@fertvxdzaknc>
 <coaws33pv7tw6j7uzd7xzamkpymhczc36nz65dfowrhj4maqb4@55zbe6nqd6bs>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <coaws33pv7tw6j7uzd7xzamkpymhczc36nz65dfowrhj4maqb4@55zbe6nqd6bs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_233839_544160_994BCBEE 
X-CRM114-Status: GOOD (  19.03  )
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

On 6/2/25 04:14, Shinichiro Kawasaki wrote:
> On May 21, 2025 / 20:51, Shin'ichiro Kawasaki wrote:
> [...]
>> With this fix trial patch, the KASAN sauf is still observed. I guess it has
>> another cause and requires more debug work.
> 
> I chased down the KASAN suaf, and now I think I understand the cause. When it
> happens, nvme_tcp_create_ctrl() fails to create the nvme- tcp control in the
> call chain below:
> 
> nvme_tcp_create_ctrl()
>   nvme_tcp_alloc_ctrl() new=true             ... Alloc nvme_tcp_ctrl and admin_tag_set
>   nvme_tcp_setup_ctrl() new=true
>    nvme_tcp_configure_admin_queue() new=true ... Succeed
>     nvme_alloc_admin_tag_set()               ... Alloc the tag set for admin_tag_set
>    nvme_stop_keep_alive()
>    nvme_tcp_teardown_admin_queue() remove=false
>    nvme_tcp_configure_admin_queue() new=false
>     nvme_tcp_alloc_admin_queue()             ... Fail, but do not call nvme_remove_admin_tag_set()
>   nvme_uninit_ctrl()
>   nvme_put_ctrl()                            ... Free up the nvme_tcp_ctrl and admin_tag_set
> 
> In this call chain, the first call of nvme_tcp_configure_admin_queue()
> succeeds with new=true argument. The second call fails with new=false
> argument. This second call does not call nvme_remove_admin_tag_set(),
> due to the new=false argument. Then the admin tag set is not removed.
> nvme_tcp_create_ctrl() assumes that nvme_tcp_setup_ctrl() would call
> nvme_remove_admin_tag_set(), and frees up struct nvme_tcp_ctrl which has
> admin_tag_set field. Later on, the timeout handler accesses the
> admin_tag_set field and causes the BUG KASAN slab-use-after-free.
> 
> I created a trial patch below. When the second
> nvme_tcp_configure_admin_queue() call fails, it jumps to "destroy_admin"
> go-to label to call nvme_tcp_teardown_admin_queue() which calls
> nvme_remove_admin_tag_set(). With this fix, the KASAN suaf looks disappearing.
> I will create a formal patch for review. I will post it as a series, which will
> have two patches: one for this KASAN suaf, the other for the WARN.
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d89c89570d11..74a388550995 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2392,7 +2392,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		nvme_tcp_teardown_admin_queue(ctrl, false);
>   		ret = nvme_tcp_configure_admin_queue(ctrl, false);
>   		if (ret)
> -			return ret;
> +			goto destroy_admin;
>   	}
>   
>   	if (ctrl->icdoff) {

Thanks for debugging, that patch looks correct. Please send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

