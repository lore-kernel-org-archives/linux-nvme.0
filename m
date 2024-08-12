Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53264C52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOdyr+wxN1cDjj6ceR17TGN4lCtZMdLyctV6JzMS36w=; b=A+BaPyPawUx41qKV4keiuOW0WM
	wU6dmCAhtYj7OAjFVKPDzvP3M4vYHSqQZ7TH9WsJ9iPz98VCJVoFIgjL1b6nPOZLf4NVMtqqllsh2
	3aGhvPVoCVobzoCM/J3O3r53902XO//Td5CEjpcK+a/AhtKwjFnAxi3ofLxH/ify9N/2Q8U16G3cU
	siLzcEJlz6JEo/vZpE/Lh6UWXQpHYPhbpgTP0/Gct0/R+ufrXGCn/EIayw976uR2jyeUHNTqh0DjJ
	pQN+DIIgRf3iZyCcs47gF3AFAMt6mTj/jaKAkP7LvhQMMClTpYHlRKzpSzW1nfLtfSaX5SlU+roRP
	IJ8C1quQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTej-00000000BOn-0O1l;
	Mon, 12 Aug 2024 11:56:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTee-00000000BN7-0AzT
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 11:56:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E13A122525;
	Mon, 12 Aug 2024 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723463762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOdyr+wxN1cDjj6ceR17TGN4lCtZMdLyctV6JzMS36w=;
	b=udYnqcLuaQaoV+HEoClgLJuE3R442xeiQ0zKZ0ZNjxV7Cy4A/FVZBXQgVKdg+i0XBzUvk3
	DOTEKjfU4/HvN1S0LOHJ/GL6oe4vg82m8ROUQZAuVK+2A1Gp97sA2KTaTHbnpvCpg8w75z
	9VH5whwGrqhhWAHXYb3+Oy4allaNPtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723463762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOdyr+wxN1cDjj6ceR17TGN4lCtZMdLyctV6JzMS36w=;
	b=p5juXZcHgbJUzoBo+/PHocnzOCdabgpwgt67xdjM2Qcs6z/0dBJ0m7hY1IlAJSXBX8hLBX
	SQ4M2kCMwrhzQyAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723463761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOdyr+wxN1cDjj6ceR17TGN4lCtZMdLyctV6JzMS36w=;
	b=fY6hvu2veXkTqE2Hh+0RhG8qC6QIpyvaVm9avIMMS0IRNppplwDAPkMFz3/NxzCXnNDWRw
	UjahQyX0iugzY8P5EwnZahzrHbqzOjrMk+3IpfhMpGZNjjbxfG3w50pvjLAihau1q/DSs9
	jNqWnMdIIWS68kAPhazyyHcDnMpm3HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723463761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOdyr+wxN1cDjj6ceR17TGN4lCtZMdLyctV6JzMS36w=;
	b=kGgzGi6z1gUgW/uW+9ZlyeCAlHtx+PpIb6INJKW45jMCsKvXoWr+0kUVPGcF+vABZ0aoaP
	CdM+HQQuOQCn1RBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9E6613A23;
	Mon, 12 Aug 2024 11:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t5LHLFH4uWYKXgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Aug 2024 11:56:01 +0000
Message-ID: <17cbd822-daae-4954-b184-974432ca2fe1@suse.de>
Date: Mon, 12 Aug 2024 13:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Mark O'Donovan <shiftee@posteo.net>, Changhui Zhong <czhong@redhat.com>
References: <20240809135427.378953-1-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240809135427.378953-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.10 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_045604_262218_DB73E771 
X-CRM114-Status: GOOD (  19.39  )
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

On 8/9/24 15:54, Ming Lei wrote:
> Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> moves starting keep-alive from nvme_start_ctrl() into
> nvme_init_ctrl_finish(), but don't move stopping keep-alive into
> nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
> after failing to start controller, finally use-after-free is triggered if
> nvme host driver is unloaded.
> 
> This patch fixes kernel panic when running nvme/004 in case that connection
> failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().
> 
> This way is reasonable because keep-alive is now started in
> nvme_init_ctrl_finish().
> 
> Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Mark O'Donovan <shiftee@posteo.net>
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 053d5b4909cd..562afa71ea85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4612,7 +4612,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_auth_stop(ctrl);
> -	nvme_stop_keep_alive(ctrl);
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);

Huh? What happened here?
Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
has _exactly_ the same hunk.
Someone else must've changed it afterwards, so please update the 'fixes'
tag to refer to the correct commit.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


