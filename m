Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CFEECAAD5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOgPUzVLKrUyL/90V6zm4bNGPKP7ni5MBXOB+2S9mgg=; b=ocDgL7yiZ04rj7DkDNqPLCWaJZ
	ygDO/pr3TA0sx33VQhqVWQhmAQYjk9oeaHrgBJjotvDaIxBeHiTgHmE5b06+qI4Mng/fG6LfPqjpO
	/sftgzV0tYR2bi6bDmEXeBs1F2aXX8hwsaVR9pOVkGjHP+tKjlTSJhDfhewn/FPDRyz4EORXYkQ1q
	YiM5Eux3zId6Pw4VDoCDowpKWvaG2SEa310jhK9iJIVLFtdkKLqu36F0jNKftcBG2CmYQGOQYAsZ/
	Ri2F06vh8I7zwFjl9GT5CM3wr94cw1ZC//k0InGK70zq24YGvSwHyowqQ7Wuy6IsiDC8Wiu9rUtlN
	+rhWnuHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWBne-000JCk-Ln; Thu, 08 Sep 2022 07:18:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWBnb-000J7W-LB
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 07:18:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E046A1F8D4;
	Thu,  8 Sep 2022 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662621483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOgPUzVLKrUyL/90V6zm4bNGPKP7ni5MBXOB+2S9mgg=;
	b=my0GEaXsez+Z4cR5SiFBCbSfaXz7V9VpG0NKGMaPJiIdZ4oWgI6h3BYMosDHLwJ3abrd3o
	5lSmZ2yVK3Sp1B7JUTG8hRuHZ7DNryPB/uv4YX1DnE9zojp5xtE1R66TAt7dw5jLbBFf8H
	viro9sGFYu6rd+/KJqPFknKUoU9fncQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662621483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOgPUzVLKrUyL/90V6zm4bNGPKP7ni5MBXOB+2S9mgg=;
	b=rmrBS3XUKHwwERu2kZ4HiIJ6CJVnQQU7BIq/04wkrdvlSquSb3Hcn2pi4Kz8kz7Q7qRVHJ
	fSMkEXFd33OO5FDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C37A13A6D;
	Thu,  8 Sep 2022 07:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nQdJBSuXGWMFDwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 08 Sep 2022 07:18:03 +0000
Message-ID: <d515dda3-be67-281a-31b4-138a51952c15@suse.de>
Date: Thu, 8 Sep 2022 09:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_001807_890765_F20BB60D 
X-CRM114-Status: GOOD (  19.56  )
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

On 9/7/22 14:27, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TCP transport relies on the routing table to determine which source
> address and interface to use when making a connection. Currently, there
> is no way to tell from userspace where a connection was made. This
> patch exposes the actual source address using a new field named
> "src_addr=" in the "address" attribute.
> 
> This is needed to diagnose and identify connectivity issues. With the
> source address we can infer the interface associated with each
> connection.
> 
> This was tested with nvme-cli 2.0 to verify it does not have any
> adverse effect. The new "src_addr=" field will simply be displayed in
> the output of the "list-subsys" or "list -v" commands as shown here.
> 
> $ nvme list-subsys
> nvme-subsys0 - NQN=nqn.2014-08.org.nvmexpress.discovery
> \
>   +- nvme0 tcp traddr=192.168.56.1,trsvcid=8009,src_addr=192.168.56.101 live
> 
> Changes to v3:
> Per Chaitanya review comments: Change the order of the variables
> declaration. And although len can never be 0, for completeness add a
> check (lev > 0) before decrementing its value.
> 
> Changes to v2:
> Taken Sagi's comments into account
> 
> Changes to original submission:
> Reword comments per Chaitanya's suggestion
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
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

