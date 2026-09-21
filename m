Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1874EC982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLdNn/aCSUm+R4enumQyeADdg1qzapClKWCcDhTzsrw=; b=VQ6bcIG25fKg6Ox74QyotlwWYA
	kDLlv1dLdBWqix1Vttja5a4QGh944OWFqT2LtHL7XZ5gjPBYPkTfL8lCcaUXTVi3mSzQMojzAMhDu
	zyM59nvqajJcrOKPxlkv1KNv2MhmJ1Z2Zk7lQxIK2XPPIg2MfsXGwnRERdiFTYGADHq1oYMZGit6B
	/NGfTtAMwi5JrdUWVB8IpyU7LhXw4yuQjHWSOcCIiuiDqVL0z52oDcG6Ga/JH4UH/VB+5TiuAODv1
	BBZ4LarrEVD//P2r5SVDjjilkD0iE4uKgQS0exzuIb44xNRX1yuP28BhrZ9DsJIw0h9iTXTofo4es
	lUal64qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8dYz-000000029jj-3hKB;
	Mon, 21 Sep 2026 12:56:05 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8dYx-000000029ir-0UlC
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 12:56:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E26F71F7A6;
	Mon, 21 Sep 2026 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789995357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLdNn/aCSUm+R4enumQyeADdg1qzapClKWCcDhTzsrw=;
	b=y3zf7cVqKi6oxgocxdQnb0lTp/Bin1vyvOcnmVQ4blTEBHtBjA5+dI3dJFyENKHKmoeADo
	1/lnJ3M4R41j3OFb+e7JmeKHdtmNFMSH6gynR0ZLW2xHh5jBmzhDvLV3gBLKkmt3PpMVlB
	CtG8Uk6CS9JItaTBSXpORQrR1iRbOxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789995357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLdNn/aCSUm+R4enumQyeADdg1qzapClKWCcDhTzsrw=;
	b=npmZe3+RSF2KCVU6iKJXZDdsHGSys55FI4G8h6RhaJ3vbK0wp3Xv8krblwNzx9B0wIGfa3
	AVwfAQymbq5R6sDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q3oAWJpI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xeHT3ZUi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789995352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLdNn/aCSUm+R4enumQyeADdg1qzapClKWCcDhTzsrw=;
	b=q3oAWJpIHrJT205iQLIZ3OXycfdXwSwfa9/zappMv2t6IoTk5iY15zTe6UbJqVoWIBiAqz
	sv9jS+l9gQ1wM7ptW2afHTGAvzBX31+lQcK2qEDUlrBEc8muIw1aFqxnSSELmLh9RWwipK
	rmxZakmO8ARovKSGZxaoxzgGvkqeFI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789995352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLdNn/aCSUm+R4enumQyeADdg1qzapClKWCcDhTzsrw=;
	b=xeHT3ZUi6awv7g2yXxxJBJREHlUTnaGWOUgdcN2Uxb92f7Skig6J51nBJRjnK5kGbgCyO1
	UiUnsJPULysBJOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F27E11368D;
	Mon, 21 Sep 2026 12:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JY4xMVcpsWpYXQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 12:55:51 +0000
Message-ID: <6fc4c478-c564-469d-890e-b804013dcfb8@suse.de>
Date: Mon, 21 Sep 2026 14:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fc: do not warn on controller removal race
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mlombard@arkamax.eu, dwagner@suse.de, linux-nvme@lists.infradead.org
References: <20260908143434.105513-1-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260908143434.105513-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E26F71F7A6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_055603_306946_D424A34B 
X-CRM114-Status: GOOD (  18.42  )
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

On 9/8/26 4:34 PM, Maurizio Lombardi wrote:
> In nvme_fc_reconnect_or_delete(), the system attempts to remove
> the controller when reconnect limits are reached by calling
> nvme_delete_ctrl(). This call is currently wrapped in a WARN_ON().
> 
> If a user concurrently deletes the controller via sysfs, the
> controller's state may have already transitioned out of the
> CONNECTING state. When this happens, nvme_delete_ctrl() correctly
> rejects the operation and returns -EBUSY. Because of the WARN_ON()
> wrapper, this race condition triggers an unnecessary kernel warning
> stack trace.
> 
> Remove the WARN_ON() macro around nvme_delete_ctrl();
> this allows the system to safely ignore the -EBUSY return value
> if the controller is already being deleted.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 48454cb7a0fc..3a4030bcfab7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3338,7 +3338,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
>   					(ctrl->ctrl.opts->max_reconnects *
>   					 ctrl->ctrl.opts->reconnect_delay)));
> -		WARN_ON(nvme_delete_ctrl(&ctrl->ctrl));
> +		nvme_delete_ctrl(&ctrl->ctrl);
>   	}
>   }
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

