Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ECDCA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=; b=wVOpG8Cg1hDXEBXd4YnIyjxhPM
	k9iYfRasKbNDaoRHOtPj6322cS70W5/Lpae7/hOJq1F2pCQaxlV8bbgU/a6vvfdVP63wuMoLiyA4n
	8a+Kf3gCja9o7k43b36fooldsmGN8WEN2Tj3IlkajiCeyaDKe+FR3ZkqpeEHDpC0QdAeDp2/QxMLD
	7gw6nFhEOwndfD9XiKawuf+2ZdA+YuX5jUT68JIUrX3sKy+UksxYoNWnVMDEjCmUcK0sC06FAzvAi
	GGOU6/JikpFZZ/NVRHHDhs7vO/1/DmUG89NUgv3++ReL9r30/bu+1nBxk+o4eimtxFPU3481c4O7m
	VAiSkw7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utNH3-0000000GLuF-16uB;
	Tue, 02 Sep 2025 09:25:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utMoL-0000000GCrH-1n6Q
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 08:56:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD42A211D4;
	Tue,  2 Sep 2025 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=GHfTySCGELYBF+CHIKP5NdUjiZ/lAnF2KgjqEMC+TK8zOe1+kXzTP1EapIp1poS3nkVpMD
	4FMJ6yOs6NnlAZqeKIylcQhvBpIrV7cmckR4Jfs06MV9iVsl117QOXPHrj/Gj/D0s/SUUU
	sfEqdbp30rdklsN9+6//Mb+DEZVKNV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=fTiGe8zn5dg2Yn2VqKTS4/gLGRnNHbh7iIWRULt5tLp04NY3WqzhFPmazNi/eDVS1wOCsL
	qjkWKU9uW6oTkLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=GHfTySCGELYBF+CHIKP5NdUjiZ/lAnF2KgjqEMC+TK8zOe1+kXzTP1EapIp1poS3nkVpMD
	4FMJ6yOs6NnlAZqeKIylcQhvBpIrV7cmckR4Jfs06MV9iVsl117QOXPHrj/Gj/D0s/SUUU
	sfEqdbp30rdklsN9+6//Mb+DEZVKNV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=fTiGe8zn5dg2Yn2VqKTS4/gLGRnNHbh7iIWRULt5tLp04NY3WqzhFPmazNi/eDVS1wOCsL
	qjkWKU9uW6oTkLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8F7913888;
	Tue,  2 Sep 2025 08:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qiyuMC+xtmiZAQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 08:56:15 +0000
Message-ID: <054eb87c-c6c8-4c6a-8459-f238d73b9958@suse.de>
Date: Tue, 2 Sep 2025 10:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-fcloop: call done callback even when remote port is
 gone
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yi Zhang <yi.zhang@redhat.com>
References: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_015617_612183_FD716861 
X-CRM114-Status: GOOD (  15.15  )
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

On 9/1/25 17:51, Daniel Wagner wrote:
> When the target port is gone, it's not possible to access any of the
> request resources. The function should just silently drop the response.
> The comment is misleading in this regard.
> 
> Though it's still necessary to call the driver via the ->done callback
> so the driver is able to release all resources.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhnyGsj-MRV3jWDsPg@mail.gmail.com/
> Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

