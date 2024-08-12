Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84197C3DA7F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PTgs5OfxsPG/J2sVpGh7T9if1nTLVXbNqyKvztBoArI=; b=jfMi601DobdkYVahoZonHlU1D4
	h7nDo/hKCNRbl+L4DLUB858HTVArJgTgdK0nhNM6lx4n8AnfwgM/gkGW3bhb3qATvsPEhFuFaDjok
	in5uGRF6wxiRmqs5oJRckAlLasCwfG/3gCp2erKAqyGBKN/+y/tUyRTmOPz0Ypl4ZMU7hDfbWoidx
	Viqt9UB9S4laL4KrJTLK+lwOMx+u9IwrPjOPxUTIb4jnVopyBKNCfiRekc4AG7qlDIUoSyDznVET3
	pKYOTcHrVyQTp5M5C/K2VNrMO+2Y/LviaHGE7HDhMBTy/fTIwNO3sKYb+0jhIqafL2UN6rmHgryUu
	IdlLOPBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdX5q-00000000lgO-0qN7;
	Mon, 12 Aug 2024 15:36:22 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdX5l-00000000ler-36yU
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 15:36:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D0682029A;
	Mon, 12 Aug 2024 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723476976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTgs5OfxsPG/J2sVpGh7T9if1nTLVXbNqyKvztBoArI=;
	b=2ZEyzpfTzoo7SIqFR3YzREOaLEFGraVA7OS2Zo9l6vX+IyCkybvqdapx7rZ7QcQGG3jlsl
	hWdj4ZshzjurNRJqQTvOoeCqVo7kJyIFGSrZReRzFC1nKfQItoB6C1mhqScP6YWBvo9+0p
	28xrJWviNHXnui9T8pn/wmur/a51duQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723476976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTgs5OfxsPG/J2sVpGh7T9if1nTLVXbNqyKvztBoArI=;
	b=zhxLQp/v8fo1l/DybqlSeOmp81ohIStj/Zf6hrgJKA4nrwFgbcKIsHA1s+xAbv2OwaBCqf
	tvcbvHTgtpC48UDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2ZEyzpfT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zhxLQp/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723476976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTgs5OfxsPG/J2sVpGh7T9if1nTLVXbNqyKvztBoArI=;
	b=2ZEyzpfTzoo7SIqFR3YzREOaLEFGraVA7OS2Zo9l6vX+IyCkybvqdapx7rZ7QcQGG3jlsl
	hWdj4ZshzjurNRJqQTvOoeCqVo7kJyIFGSrZReRzFC1nKfQItoB6C1mhqScP6YWBvo9+0p
	28xrJWviNHXnui9T8pn/wmur/a51duQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723476976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTgs5OfxsPG/J2sVpGh7T9if1nTLVXbNqyKvztBoArI=;
	b=zhxLQp/v8fo1l/DybqlSeOmp81ohIStj/Zf6hrgJKA4nrwFgbcKIsHA1s+xAbv2OwaBCqf
	tvcbvHTgtpC48UDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B068D137BA;
	Mon, 12 Aug 2024 15:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0qkcJ+8rumbYJwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Aug 2024 15:36:15 +0000
Message-ID: <6cbebf22-019d-4c33-9259-6f373c967be3@suse.de>
Date: Mon, 12 Aug 2024 17:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
To: Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Mark O'Donovan <shiftee@posteo.net>, Changhui Zhong <czhong@redhat.com>
References: <20240809135427.378953-1-ming.lei@redhat.com>
 <17cbd822-daae-4954-b184-974432ca2fe1@suse.de> <Zromvtmi3p4WjPgD@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zromvtmi3p4WjPgD@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D0682029A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_083617_950925_A40E81ED 
X-CRM114-Status: GOOD (  12.98  )
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

On 8/12/24 17:14, Keith Busch wrote:
> On Mon, Aug 12, 2024 at 01:56:01PM +0200, Hannes Reinecke wrote:
>> On 8/9/24 15:54, Ming Lei wrote:
>>> @@ -4612,7 +4612,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>>    {
>>>    	nvme_mpath_stop(ctrl);
>>>    	nvme_auth_stop(ctrl);
>>> -	nvme_stop_keep_alive(ctrl);
>>>    	nvme_stop_failfast_work(ctrl);
>>>    	flush_work(&ctrl->async_event_work);
>>>    	cancel_work_sync(&ctrl->fw_act_work);
>>
>> Huh? What happened here?
>> Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
>> has _exactly_ the same hunk.
>> Someone else must've changed it afterwards, so please update the 'fixes'
>> tag to refer to the correct commit.
> 
> Yes, someone did change it :)
> 
>    commit 3af755a46881c32fecaecfdeaf3a8f0a869deca5
>    Author: Hannes Reinecke <hare@suse.de>
>    Date:   Tue Nov 21 09:01:03 2023 +0100
> 
>        nvme: move nvme_stop_keep_alive() back to original position
> 
> So 4733b65d82bd moved it to the wrong place and Ming's patch is the
> correct one?

That's perfectly fine, it's just that the 'Fixes' tag doesn't tell the 
full story.
All I was asking it to update the 'Fixes' tag to the latest patch
(ie 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original 
position")) such that the poor people having to do backports can
rewind via the 'Fixes' tag and get all necessary patches.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


