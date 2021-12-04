Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26741C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Dec 2021 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMnoxpj71x9JHRoSc3fgTerD1+UNPIurvEtthRFPiJ0=; b=EptiAABNzYgES5h8ts3i5XfNcy
	lWNjU0eFYg2P1GhKe0JT3nAIr/83mxD7xAc3XgQhLMv0fTciuupMmIGqB0P0XH+faMcDQ+MUX6h5I
	sOdy24knK5IeSOT1ixwC3KNoeVFtCBatb18lYw2IGrq7odh9eG/C0UpNf8z8g4JfoyrTgSWZFYTIt
	4jK4I41B75QMXKn0GetkwSoY1FtSbIHJEmJqNydKGH969v01WhWC6Y7DpVYsn5Elu1pAg1VpDP2jx
	S4TDefk710+hZpisXIsDhVNLBQUlZ/vx7DybIYOJyNNbclR2OdETeguMLZ+L0hRfAC/AG+YisEfGA
	r79jv3wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtSY0-000Dew-91; Sat, 04 Dec 2021 10:45:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtSXx-000De7-Ix
 for linux-nvme@lists.infradead.org; Sat, 04 Dec 2021 10:45:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDB8E218A8;
 Sat,  4 Dec 2021 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638614735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMnoxpj71x9JHRoSc3fgTerD1+UNPIurvEtthRFPiJ0=;
 b=fPwLQaANb34jGVNx3sDnN1OIQYjfsAO0kQGP3vz+tSxLv32Ox9uH1J5oG10gbLfawmoJm5
 r830HQCi2YqXO20O7mIiaYgYw5gIn3hK+FxsanweI1DnLB9dgEUTPJ13AyWs392a8GsopR
 6Kv9KJrnvdHBu/1OcbJTlwyQFdjaC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638614735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMnoxpj71x9JHRoSc3fgTerD1+UNPIurvEtthRFPiJ0=;
 b=Wt98VwuwI2rNl+/bQJ/sdrTdWXMWskFKujZd1mjakYWc3fQInkqz6vK+qRaREyAwtbUFVs
 2l+7zW65LIWm62CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD81D13BF8;
 Sat,  4 Dec 2021 10:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0LdkNc9Gq2FHawAAMHmgww
 (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:45:35 +0000
Subject: Re: [PATCH 3/4] nvme: separate command prep and issue
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-4-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8facb330-ba89-614c-79e0-a12b1b4e13cc@suse.de>
Date: Sat, 4 Dec 2021 11:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211204_024537_806463_67BE6140 
X-CRM114-Status: GOOD (  12.83  )
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

On 12/3/21 10:45 PM, Jens Axboe wrote:
> Add a nvme_prep_rq() helper to setup a command, and nvme_queue_rq() is
> adapted to use this helper.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 57 ++++++++++++++++++++++++-----------------
>   1 file changed, 33 insertions(+), 24 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

