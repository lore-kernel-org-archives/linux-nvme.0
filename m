Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE96C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3AVnyzkPb6vlzYX+cg5I6rkefjHvfq/DFbRgwN6pxQ4=; b=OOOclcb55WJro30D7BgJN9hQsi
	+dS9FA4tSvb8Yk+TapWi4IdRxd9dVKExf2gAWicgwtxnLtFmnFrK9yWSvkcnnaVfF1o7cABQrrXQ/
	+/+otytcY8PW20otD1QY66Ar3kl7XZIG1stN0yzEujxWpyK3PHkjGZuzl8kLvQqHqg/zS4wiC5c3j
	IWJ7S5/JW80APkdl7kQHtvCf7TNdLxsQxUAMS54cBEhIeJOXtwM9QRgyV9vqt5zloXSsBcgCrZlhn
	+bLht3biYc7VXUKhdyYOlqcFUz4umqf1M7q2vzRW7PzJHPpJFeeYo1E6b+y/kU9/lWDtl3MLDpr5E
	pK9XfGtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNgB-006SKn-OR; Tue, 25 Oct 2022 17:25:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNg6-006SIt-KH
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:25:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 112DF1F38C;
	Tue, 25 Oct 2022 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666718725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AVnyzkPb6vlzYX+cg5I6rkefjHvfq/DFbRgwN6pxQ4=;
	b=S6Nx60ha6fa20WufQBRKySlGvS7BFfUGY9Lhpz1Y4ln9EI2Iu92TQTZ8lfqikbWzdJJTCE
	Cm/ZxF1gh6v8RGGjpEcz5CCniSBMnzUrMx/tupr8XzRQhk6SXUd40u3+T6vib7NZhX7X5/
	OXdxLEVq3o6xQrAs7o7LdfVL0ir/8pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666718725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AVnyzkPb6vlzYX+cg5I6rkefjHvfq/DFbRgwN6pxQ4=;
	b=/MKB6CLO1EwOXD6bv/FZnXqnaSyxxkN1MBa1qySFE3nvidHMlsLZMxiyUrzZQcCfiMMhOz
	fBEzaq/r2Q9D67BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E539F13A64;
	Tue, 25 Oct 2022 17:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TGdYNwQcWGMKOAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 17:25:24 +0000
Message-ID: <41cc8acd-bb71-51f2-7f73-c6c80a897d47@suse.de>
Date: Tue, 25 Oct 2022 19:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/6] nvme-auth: don't override ctrl keys before validation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-7-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221025134330.1028352-7-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_102526_861634_6CA30510 
X-CRM114-Status: GOOD (  11.06  )
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

On 10/25/22 15:43, Sagi Grimberg wrote:
> Replace ctrl ctrl_key/host_key only after nvme_auth_generate_key is successful.
> Also, this fixes a bug where the keys are leaked.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


