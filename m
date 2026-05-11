Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD12CD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6MEzt0pPxE3au4JbtUYlQGwvIRmRJDID+UYaux3Jno=; b=N8uJQvGeHgPjPiLl2ZR11Ygxip
	rEDzSncfo5AckaSQZ1KKsMwJcbAqpqrHwBQwgno7r5SG7VKB5TuByPdOqAP4s+l9DUIpJLc4nW/gJ
	MmB+97QrukQpB5SBXXTDAXgEvtoI/vXWbo4cZdGC0BArOEbmqvo4L3YjSr453njGMQaZSJTf/oDp/
	1k+A40ZmUPU3RhUFKHrwQZCrn6jqDOOsFhJ3Vmoq7TNlTlHjE3C9eyoSn9AH2i9CJvctjzG1hxIw0
	WOGCHOguVJsKXU/dP58Z+kwAbSfJ4bmzfW+t7UtcLNo2OpkE6zl+oQ1t7aou44Rr22jl8eTxZEPAl
	CtuQbwQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNDd-0000000CzPV-1XB3;
	Mon, 11 May 2026 09:46:33 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNDa-0000000CzOw-3jfd
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:46:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51D0768563;
	Mon, 11 May 2026 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778492788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6MEzt0pPxE3au4JbtUYlQGwvIRmRJDID+UYaux3Jno=;
	b=sOxI+MjzkbBqF/bRF2i0vkIfKZ34Dm/X7SamIN8PedKvVjjCwUNCtecsWpXz/pLhMgb0lR
	Eq4RlgCI9dGliZJsZsxNjRgEW/iO/SxbHE8OKcadmKBT1GFwkmZa3re3V825f8z19m8PDo
	d97Xf9foozrCKHBOFzgZ5G260A0Ixr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778492788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6MEzt0pPxE3au4JbtUYlQGwvIRmRJDID+UYaux3Jno=;
	b=JduTcyvGPj8phJTZ0yC3pWXJZ0SiQwQH68zBTXKbUwXvPBDDRPtSQLqGgKXlz229oJRduk
	XeCBihP2/avOA0Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778492788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6MEzt0pPxE3au4JbtUYlQGwvIRmRJDID+UYaux3Jno=;
	b=sOxI+MjzkbBqF/bRF2i0vkIfKZ34Dm/X7SamIN8PedKvVjjCwUNCtecsWpXz/pLhMgb0lR
	Eq4RlgCI9dGliZJsZsxNjRgEW/iO/SxbHE8OKcadmKBT1GFwkmZa3re3V825f8z19m8PDo
	d97Xf9foozrCKHBOFzgZ5G260A0Ixr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778492788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6MEzt0pPxE3au4JbtUYlQGwvIRmRJDID+UYaux3Jno=;
	b=JduTcyvGPj8phJTZ0yC3pWXJZ0SiQwQH68zBTXKbUwXvPBDDRPtSQLqGgKXlz229oJRduk
	XeCBihP2/avOA0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5034593A3;
	Mon, 11 May 2026 09:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8MpyLHOlAWpkQAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 May 2026 09:46:27 +0000
Message-ID: <81e347ac-20f6-4b51-b6b3-dc25d0b11285@suse.de>
Date: Mon, 11 May 2026 11:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin timeout
 per nvme controller
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-3-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260508133335.98612-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_024631_089027_01EC4501 
X-CRM114-Status: GOOD (  13.04  )
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

On 5/8/26 15:33, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values
> on a per controller basis with nvme admin queues.
> Add an admin_timeout attribute to nvme so that different
> nvme controllers which may have different timeout
> requirements can have custom admin timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c  |  1 +
>   drivers/nvme/host/nvme.h  |  1 +
>   drivers/nvme/host/sysfs.c | 42 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 89948d0acf18..b1bfcd0a0e5b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5140,6 +5140,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>   	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>   	ctrl->ka_last_check_time = jiffies;
> +	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;

Why do you remove the default timeout?
Shouldn't admin requests run with the admin timeout per default?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

