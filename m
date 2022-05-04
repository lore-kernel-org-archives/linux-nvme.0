Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A2BC4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SoIBM/nGSHi+WngO6YgR90ctoJWllnH/TF3i7GxVO8=; b=14RaUheOD7oj+KXwBDfO10YYV4
	ArxLfHxt8qSUsSByYG9f5d8S1aL23LMHaoQ9wLi96c0A4TQlpkyW9D6aPgGYorWbF6W5fZGdSmdpu
	JqQR0U61EG1U7gmYyJTud0Skj6RfYEnJ/YgZp7l1PvR3bG/ePEoo0bpXCQNwI9TAvo6u3PiUGWCuo
	66mR9/szqueDoi5MIOS6twLO9jSYGMORFShaBqqKl/riF+Yvtf1y+z9cRwdSjc9risuzL3rhQsexT
	VIQp9mxw3+n8FoMndLwTMPp9awGhbzRCccyU2aI/quK4yamoKOdfj8sLyRLw8cTX0GpwqgLJLp3Rs
	IL0ZzGPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzUC-003wYd-PT; Fri, 06 May 2022 15:03:16 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmIRk-00BpN7-E6
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 17:05:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20602210E5;
 Wed,  4 May 2022 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651683951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SoIBM/nGSHi+WngO6YgR90ctoJWllnH/TF3i7GxVO8=;
 b=p5zbZTkWhtPC3vy3viiBUzgbyqi/1aOv58+1cxw6mwolzGFfy/tpzq2731Bc/BMlt7ZxrT
 1QKBkof3+l9oDOX/H6sBjXCZciMZUf+HD975co/WRx+iLleo17GGz+XE1dPBMBv07BSw6C
 3Nsl5NOp+fGDKp6pZrxcHtkLUOz2+8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651683951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SoIBM/nGSHi+WngO6YgR90ctoJWllnH/TF3i7GxVO8=;
 b=muWArSGJSIncH7RiBuU9uWp1WWtpL9L0sGY6fNwZwAwYLNrI06XVl/hunISR2toeTXkRHy
 SFIFZilv5c/39PAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB891131BD;
 Wed,  4 May 2022 17:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nh+DI2mycmIuWQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 04 May 2022 17:05:45 +0000
Message-ID: <e6f61c1d-ca8a-7570-a30d-c91f211d4593@suse.de>
Date: Wed, 4 May 2022 10:05:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/16] nvmet: use blk_queue_zone_no()
Content-Language: en-US
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035@eucas1p1.samsung.com>
 <20220427160255.300418-7-p.raghav@samsung.com>
From: Hannes Reinecke <hare@suse.de>
To: undisclosed-recipients: ;
In-Reply-To: <20220427160255.300418-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_100552_659229_C08651A7 
X-CRM114-Status: GOOD (  11.87  )
X-Mailman-Approved-At: Fri, 06 May 2022 08:02:49 -0700
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

On 4/27/22 09:02, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Instead of open coding the number of zones given a sector, use the helper
> blk_queue_zone_no(). This let's us make modifications to the math if
> needed in one place and adds now support for npo2 zone devices.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/nvme/target/zns.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer


