Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C73DC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ywsg+ZsRlh4HXBsnE8tuYLyxV+DXe7AWruqzffbqEpM=; b=rKnlPZT590wB0XdIIkcTjYl1EC
	NhA/PtrS8BVEyXIfI0yDaH6pWyUDzsH0qCb7p8O7dscWLw/HgpaCyjoYlycRaOJQM14++t0Q5XlzY
	qIrRaMCYwAJSIpnd3QJLFXCuiWvvpEcA3J5uURwEGRm4dY7Jqo0MaKnKsdYxQQcjFgsg1s/JXbDOb
	LCXoH8AwMDOCG5LWyte+fW2Iaqe7rG0rW4+ZOxNQYz3tNhpH+jTfOgYjqCSvWeVC2JKUx5v9JtcLD
	8/PfimFQJTKLtlIzSBXord6SUHx4VUPnTuzBbI+6d7QXU1IozmCWZbLXvfWuGkgx1x10dKM7hHcpU
	HvlGKnsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouCnJ-00BYzw-4X; Sun, 13 Nov 2022 13:13:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouCnG-00BYy5-4i
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 13:13:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3B2D1F997;
	Sun, 13 Nov 2022 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668345179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywsg+ZsRlh4HXBsnE8tuYLyxV+DXe7AWruqzffbqEpM=;
	b=Us1VHdITDz/rPRXkoy0V4AU5/C8Hz3opqCMY3FVxv3HX+SI1WJL8X1O4S7ETdI6mdf7S00
	YmEbSN0nbu/G5dLmrRgCjRqv7MY5WALuwDfnbz7V81Bk81Y/Z+HUEDhFMER4dkTm2DjzsQ
	+Lk9jwd30gXv6k8D94Nzv2TUrNvVKnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668345179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywsg+ZsRlh4HXBsnE8tuYLyxV+DXe7AWruqzffbqEpM=;
	b=uY6buf3WYOU+tXMqlEyy7zl4qoZ086c1rLtTBMOiM+371ClSSdKcQ4xWiz+Kd8Y/5CGZpW
	ips2uVYBYKtl0yBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7324133A4;
	Sun, 13 Nov 2022 13:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id D5fsK1vtcGMgfwAAMHmgww
	(envelope-from <hare@suse.de>); Sun, 13 Nov 2022 13:12:59 +0000
Message-ID: <527b592f-78dd-d970-7d95-aa84f1bcdd3f@suse.de>
Date: Sun, 13 Nov 2022 14:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 14/20] nvme-auth: check chap ctrl_key once constructed
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-15-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221113112424.1049834-15-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_051302_347848_AB936151 
X-CRM114-Status: GOOD (  12.10  )
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

On 11/13/22 12:24, Sagi Grimberg wrote:
> ctrl ctrl_key member may be overwritten from a sysfs context driven
> by the user. Once a queue local copy was created, use that instead
> to minimize checks on a shared resource.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


