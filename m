Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58675C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=; b=ANW4necfP6GcCXsCN9l1a8phuo
	dqfNhtihP/Dn3fUNBjxmDnmODFu1ROwggkIo7Av4BrTcFY8wmyjh4XGrb4CYhZnM9fc3o1A0jxXjB
	EqH91H15KpjTky5BmPBrkRj/aZwJh1gj41k4z33GX/9/4tihjFEcWx6n2Y72HT47qRfbWGf4mxRsN
	NsjfHYW9vrgWWWstDqScBTwmjS7T6kCwWS1hVr2+kL45+I0cGBHUVfr+6RUvEaBqZnc7cAwgOwjP5
	NOFCKZhuixf5YPp5AIUnCKbBc/W0A3dU5fFPOVdcp+gniVGuaBCRSp7Y1mfTkG9zDYLHp5SNOamYx
	jl5I6hjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYip-00DvXe-0C;
	Tue, 19 Dec 2023 11:57:15 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYik-00DvVd-3A
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:57:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88129220FA;
	Tue, 19 Dec 2023 11:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=LiZCWRsPrnaxDNyBpHc9sUYct6c2z2u3/Ci2k3lr3D7fiIpOxyUki8DV5Xhm/dyPvCd4vK
	QuHj23xU+E4NFUDZ11/Pi7ewEmVgwdwA4c9aI2YVG2vhiIBU0rLWsaq5Y/b+d2sXb/5Snp
	PLsRsn3ptvJV3KpuuHGhRHJzbqbRqi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=GahS37pgNIEWzubnsPql3p2P2rW8+ZCk7L4DiOCqH3jNIKphDUG4l/lApDrn2m/VmSGcum
	MQrxRklNOqZ2P5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=SHWlNkvlI9aEqu+vJc/nhbr3tyJSatGXP7Xtw4wDs7876dowEonbhgeekLjH7wLrwd7sgJ
	zNOOxLPHiYPEsSiY9A7BUedJGwm6rzvJwqx+qwkQl2LoEu8sf3JcjByWTVOkz5ST1N4Y5y
	VCr9FH/ZrhcBFM7hZ3toN9PqQ9gBJkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=vAE5dI/yDSdz2SI2v3UEBG2hccpI+Bt0HrOQ0n5/eT4pY90LQhUxThsy3td9DlgX7rto8O
	LLdLK6GACEVakqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 145751375D;
	Tue, 19 Dec 2023 11:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHOMAhOFgWV1OgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:57:07 +0000
Message-ID: <863fd40b-c702-4450-a136-d47567080bd7@suse.de>
Date: Tue, 19 Dec 2023 12:57:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] nvme: refactor ns info helpers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218165954.29652-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.03)[87.49%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_035711_180716_BB959E1C 
X-CRM114-Status: GOOD (  11.68  )
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

On 12/18/23 17:59, Daniel Wagner wrote:
> Pass in the nvme_ns_head pointer directly. This reduces the necessity on
> the caller side have the nvme_ns data structure present. Thus we can
> refactor the caller side in the next step as well.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/core.c | 36 +++++++++++++++++++++---------------
>   drivers/nvme/host/nvme.h | 12 ++++++------
>   drivers/nvme/host/rdma.c |  2 +-
>   drivers/nvme/host/zns.c  | 12 ++++++------
>   4 files changed, 34 insertions(+), 28 deletions(-)
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


