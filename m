Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E0C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E9QiJ5pzLqAGiwgfydGuiZS96KPM3zkXpk0278kABOo=; b=xWJV25nkTGsXSfDxvayVWGIBq8
	ulWqFMLiAPGsNl6OndFrfwVr505wpoVzHyraOXqhSn4AXQpoDpxMN0akJQwq2CLeKVld7aZzMJLsZ
	K2H9oevmXTmeZG+vGJH/k+RKXAa1+RIAAYNe+0PHUr+jOIvMHuKDd2/2l8gq//O93WU7DFsbyXAOt
	b54/HeqrYtFFOMyRs5P7EofAWDXcEmuaZYlFO4J7sLGeFzvqnrKhYkt0kMMV6rYX86uzJwgCz6c2t
	Dp1WsbrQC1pUNT+qAcyZo3ldsoi6pQy8da7ApkRrnxDgslVH0GmR27cePTznU3KL8GU1ygCuDko5e
	yX+QUgPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouCli-00BYXe-AG; Sun, 13 Nov 2022 13:11:26 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouClf-00BYVi-Ga
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 13:11:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A08B1F993;
	Sun, 13 Nov 2022 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668345080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9QiJ5pzLqAGiwgfydGuiZS96KPM3zkXpk0278kABOo=;
	b=Dc984DFMUoL356sRc0VOHRo2Y/qYTQcpHyqTcIYYbJJt+tLPOaKp0iPMtWDEQ1+yoJxkcG
	Bq6KdpJx0j9v9g1Kne1I5ZzUkdarWt6O9K4sG9xU0SE8xIGeqgd+K0+HTv4979IemPqiVR
	urFJxLilbbs1axi6gd/BHcQVmFhGCoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668345080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9QiJ5pzLqAGiwgfydGuiZS96KPM3zkXpk0278kABOo=;
	b=I9qxTtq2x23V0Xf7W6rA2wa2tZP1Fzgv77tga+dohQVQF2S9PvwOSAf2Ak5VwIgo2s5dJb
	1HzR6ZMPB1bT3aDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA22133A4;
	Sun, 13 Nov 2022 13:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id geZSHffscGN6fgAAMHmgww
	(envelope-from <hare@suse.de>); Sun, 13 Nov 2022 13:11:19 +0000
Message-ID: <a5222f22-b011-b42f-0da0-8861ee9b1acc@suse.de>
Date: Sun, 13 Nov 2022 14:11:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 02/20] nvme-auth: rename authentication work elements
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221113112424.1049834-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_051123_747598_AC6C09DE 
X-CRM114-Status: GOOD (  11.35  )
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
> Use nvme_ctrl_auth_work and nvme_queue_auth_work for better
> readability.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
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


