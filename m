Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887F0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4kOlQN+dyBIib+I+w20DK4Z8Cth/v178u0BxJZjt/1k=; b=nnYPHpVa/bP8+93P5WrbMqOV5s
	NMv+mjag2EY0XOcRQATQW54BW5DyGYlEZ33FwKQrRrx192vyIvvx9Dadni3vo5uv/+l9R1iCfYngL
	g+KE95e1EzJhqa/s3Wkqic99bwQvrZNrmZ0LVE8/y6MnX1aOypvVE1A3v4c8zFBd7sSr7AFl+IU8w
	DjMqYCkdidpRNDaWpTwALMp9bGdI7L1JG1uFzu649vCUlsO6i5d9DiW9NdUyfyI8bWuj8klxGshRW
	epgx8DWbTM8B8fCKQuzFtD8AB686x/e/sID99fswTteUOL7pcXDtxn3uf9ewgJrsDtp6KGWLmw6U0
	YXsFGT1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp0L-00FcMY-7Q; Wed, 09 Nov 2022 17:36:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp0I-00FcIb-IY
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 17:36:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9D6622C40;
	Wed,  9 Nov 2022 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668015401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kOlQN+dyBIib+I+w20DK4Z8Cth/v178u0BxJZjt/1k=;
	b=XOQoW+9ocZL9xARl0nlMcjaOvELyp266/piTS34HZ4ZQu2EYcvu/BhgTCRUENqJUuvd8Nd
	7OdrgIIdvDKoTn8HAJS7KppcC24NKD4kcLYSv6n6nncXT2cT9iSdwXDYPuZR2ppWzy26IY
	LHICrG3X16XMCo4xL05s/AWZZYFU064=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668015401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kOlQN+dyBIib+I+w20DK4Z8Cth/v178u0BxJZjt/1k=;
	b=AyIvSWAZxNgs/4f8s2kYkfTfwmR/9ZoGlkeq5mqqCePSf3QK4Xe0c9tj+TL50+xaVINxcR
	AtDDtwqGm9vNGOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B187139F1;
	Wed,  9 Nov 2022 17:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id K6BJDynla2N8FwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 17:36:41 +0000
Message-ID: <b89d0a81-4375-9763-1791-9cb4e3be49da@suse.de>
Date: Wed, 9 Nov 2022 18:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/16] nvme-auth: remove redundant buffer deallocations
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-5-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-5-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_093646_811990_5CADF101 
X-CRM114-Status: GOOD (  11.82  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> host_response, host_key, ctrl_key and sess_key are
> freed in nvme_auth_reset_dhchap which is called from
> nvme_auth_free_dhchap.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 4 ----
>   1 file changed, 4 deletions(-)
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


