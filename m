Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B5C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVzSqInnNM56yA+McnwsAoPWmU626VSt8/3oE4z+vaE=; b=tqwLWyyW0o6koyLaY97pBLsjVD
	1kAylUaj6Hv/jTUGjDCKHvmUosnWrHoEXBuczSaBfB+oLaASP0Eqq0N4Gxg2Ds/PQJi6r9jPnFVkb
	5OGMt1ijmU+Rt9TTNfCUsPg6vfBTiWX6l49Vqpb95OgYOehaAOIEScjx9DhqCgP+jL8b9jKlPikEH
	y5Ker8cpaqIdNaGX5VYkOsX01mFeyfUY+Rs8vY46J+DMS2WYiXpr/fKR3oncm9Ucv6fIXgBWrKXBr
	6iQ6QyqKlWz76hSBm75eIbrJ0tpaFBmUvp5XOrmO0mrYooHN0ZxPduLJl7fTjVbyLx1jerUXNZ2HO
	1EhV1yIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q64tq-00Eb5Z-2O;
	Mon, 05 Jun 2023 07:45:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q64tn-00Eb4h-2K
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:45:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F09621F8B3;
	Mon,  5 Jun 2023 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685951105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVzSqInnNM56yA+McnwsAoPWmU626VSt8/3oE4z+vaE=;
	b=ZuOBTtrDX8amx3XYW4x3dra3gIHb3iD/Ddqcy7oq770m3jvjcmueI+4RSSeO5G20o7icRF
	nquVAa7ni0JipT+SofknBB3u7iGJPNb8fSp+6ogkCczPpAVDjzGfkrBUtCwz4wseA9wr7N
	jCnVn2gBM6V9Wln7UEX0AD/B2ZTrEto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685951105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVzSqInnNM56yA+McnwsAoPWmU626VSt8/3oE4z+vaE=;
	b=lVpCv2nJu+gssvgVAYJ+MVAP2ovcP3lU027SDOH5XukJ9noUjrVqI+OIVKh8qVfBu6IjpR
	WIUYS51ZoN8HDwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2330139C7;
	Mon,  5 Jun 2023 07:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VTlPMoGSfWTOcwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 05 Jun 2023 07:45:05 +0000
Message-ID: <99a8f5f0-84d3-1795-e635-62a91670e923@suse.de>
Date: Mon, 5 Jun 2023 09:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/4] nvmet_auth: use common helper for buffer alloc
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
References: <20230605064434.45233-1-kch@nvidia.com>
 <20230605064434.45233-3-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230605064434.45233-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_004507_905010_0C8A5425 
X-CRM114-Status: GOOD (  13.73  )
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

On 6/5/23 08:44, Chaitanya Kulkarni wrote:
> Add a common helper to factor out buffer allocation in
> nvmet_execute_auth_send() and nvmet_execute_auth_receive().
> 
> Only functional change in this patch is transfer buffer allocation is
> moved before nvmet_check_transfer_len() and it is freed if when
> nvmet_check_transfer_len() fails. But similar allocation and free is
> used in error unwind path in nvme code and it is not in fast path, so
> it shuold be fine.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 43 ++++++++++++--------------
>   1 file changed, 19 insertions(+), 24 deletions(-)
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


