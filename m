Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCC6C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mgm5UyMxbdRWtEM0SaQ0v0sCDYs9AsyA2ZGCDARH4IE=; b=sp5l7McUQ9AcUel7mNzBVT3VqI
	hv3i5EoxpR6OZmfl8exX4pkFlHq7J/HwTtr+IawO1AZSIuDSbpyW120lsgThYrwT037WDG9Co4tW8
	BW8y3wndoOwR8we6P4FrS2Cgze5IsrTLInUk1lCEjY+B+NOS9dWcLGNdd4jocZq2JNGbW6HXZE/Bt
	5zLt2UmOGT9Q+bXVDbvyCV2bpdveUmp8mo4BwiUPbVLbXSDp4xXLHNvYd9KWcu7qtD+zsqtwpC5o0
	9vu3fVcP3BwJDPwFsT11V6fOICG16nLlUZkRaPwfO5fKc21N+ILF+vssr2ZZhopp+Za4dLeggmJSz
	5KKrHNng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUWa-00D5w1-01;
	Tue, 19 Dec 2023 07:28:20 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUWV-00D5si-0G
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 07:28:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6030A222EE;
	Tue, 19 Dec 2023 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgm5UyMxbdRWtEM0SaQ0v0sCDYs9AsyA2ZGCDARH4IE=;
	b=yXdQPBKAhxEAsBcRbpt2UgI75NLkKgq7kNkHLVsKF+LLHyEpRS0ibbn2XugQJQPym1wiT7
	R+HrQ6TadpQSuq5vc4P2/CyyE7kww9bCwC+2IkKgIJR2dPY6xryv6zLgUwe87u5s4t3qE3
	5s7qXuMrmUHFXTWgbZTTORW8fpIn+8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgm5UyMxbdRWtEM0SaQ0v0sCDYs9AsyA2ZGCDARH4IE=;
	b=moG/AdGPrPIWlov2tI/LS9ns7KEuxubuRmXXowXUBKUOJF6GGlZvHEgZY3DfjUG96ALhws
	NxkeRfOBYzFc74CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgm5UyMxbdRWtEM0SaQ0v0sCDYs9AsyA2ZGCDARH4IE=;
	b=yXdQPBKAhxEAsBcRbpt2UgI75NLkKgq7kNkHLVsKF+LLHyEpRS0ibbn2XugQJQPym1wiT7
	R+HrQ6TadpQSuq5vc4P2/CyyE7kww9bCwC+2IkKgIJR2dPY6xryv6zLgUwe87u5s4t3qE3
	5s7qXuMrmUHFXTWgbZTTORW8fpIn+8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgm5UyMxbdRWtEM0SaQ0v0sCDYs9AsyA2ZGCDARH4IE=;
	b=moG/AdGPrPIWlov2tI/LS9ns7KEuxubuRmXXowXUBKUOJF6GGlZvHEgZY3DfjUG96ALhws
	NxkeRfOBYzFc74CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9438813AA6;
	Tue, 19 Dec 2023 07:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGCpHwxGgWVmcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:28:12 +0000
Message-ID: <90f10adf-d4ec-4cc6-aecf-e20290ca6746@suse.de>
Date: Tue, 19 Dec 2023 08:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] nvme-fc: Do not wait in vain when unloading
 module
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-7-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.69)[98.63%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.982];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_232815_266856_40146E8B 
X-CRM114-Status: GOOD (  12.52  )
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

On 12/18/23 16:30, Daniel Wagner wrote:
> The module unload code will wait for a controller to be delete even when
> there is no controller and we wait for completion forever to happen.
> Thus only wait for the completion when there is a controller which
> needs to be removed.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


