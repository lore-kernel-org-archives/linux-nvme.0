Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA8FC54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G9DKZysSjmDZhNMHfwJ9FjO80fbEfxu5Do2IKCx9iDs=; b=gt18nlRveF9zEN8VeiBj0+36la
	1Wr0h+zAuwhPAatxn10ZGeKUUC+CSmcGj/deoZbkJgkB0x2WqVRbdDunU0AwbnflZiBVXRCikUevj
	0c4khywgCur2bkBW188P0YJbAxnsrL6uM84kZ+eN0plgaX6jjK93VB+1Mm1wmn4zpNO4zmGOXdR6Z
	i3zDrnVMpaDP76tWrK3ez5heOk+5hR5lwdwrISIENYdXYPP2zM0CiOMGKnIDhpuVS4PtBztQnp5fU
	GZGp+AIfh/rMqdO4ICzOd6DMnTDt8TVsD3VsGfBh/TCz1C0HIHhbRM9DAfEAlfCFRKsT5mWicEFzf
	ig2Dg6YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxY2-00F8OP-ON; Thu, 12 Jan 2023 13:23:14 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxXv-00F8M6-Tg
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 13:23:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB4247D7;
	Thu, 12 Jan 2023 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673529786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9DKZysSjmDZhNMHfwJ9FjO80fbEfxu5Do2IKCx9iDs=;
	b=DcAsn5SyCcryk8njkYzsHniV5BTXOKyu+0ZS44zB+G7Bepr9wfNDXZBnQld0dbxIr26oGR
	zNANagl7eaJNpNdaOmHcy2J4n0SbrDWS7ATjb542aMrhwbxnRht81/Yd/4Eav/zuMqA52K
	sZAWo5vUPpO4JzCmTjXtgc4qBjX7x+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673529786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9DKZysSjmDZhNMHfwJ9FjO80fbEfxu5Do2IKCx9iDs=;
	b=qV7bCprSBOctRflSyISj6yrW7WOnesBL509jBDqQslhdFfb0PWPbSgRyAq0Yg1B2KPHW0X
	jxht2seoVEbdBSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E38713776;
	Thu, 12 Jan 2023 13:23:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ab2TGroJwGM7YwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Jan 2023 13:23:06 +0000
Message-ID: <df4da166-9fc3-11af-7481-2da452c04d35@suse.de>
Date: Thu, 12 Jan 2023 14:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] nvme: don't allow unprivileged passthrough on
 partitions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20230108165033.380842-1-hch@lst.de>
 <20230108165033.380842-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230108165033.380842-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_052308_154618_A2818AD4 
X-CRM114-Status: GOOD (  13.53  )
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

On 1/8/23 17:50, Christoph Hellwig wrote:
> Passthrough commands can always access the entire device, and thus
> submitting them on partitions is an privelege escalation.
> 
> In hindsight we should have never allowed any passthrough commands on
> partitions, but it's probably too late to change that decision now.
> 
> Fixes: e4fbcf32c860 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/ioctl.c | 47 ++++++++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 16 deletions(-)
> 
Doesn't a similar argument hold for ctrl vs ns-specific commands?

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


