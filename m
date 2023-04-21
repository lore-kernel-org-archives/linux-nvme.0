Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7F2C77B78
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8BDdQ0I4Yf6GR72ElgTwNi4vLCj+zPKb+0wtccSr70=; b=kczKO42EQwNlWtWQfkeqCqe/RN
	nCuvq5JL5gPVPJ97mq3fJtSrt58kwkkZ1LK6htafKEEhAFo35h/GZFwN4H84XUqqo+Tov4+7Wn9i2
	U5lUR83l23gPaMT/e2AbwK6q+OgOiuoKBY6q31vZZhwvaGDDHqeCREXaHoZR4XXll3PXSHSIEY2Cg
	fOFyidEsu2GNigQYyMpBRk2lKK7JDRZX43LwPEt9NknTytOgwll8HAwhVEALL3RRlzPidekzThuys
	QK0OmKFiyeGztUjaOtQTgtehqu8RnuHYagBuToJjEZaGdx9DvhIJVTrB4EZdWeoeQPY+pc7aFpeVf
	zN4SdQbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkPc-009qyL-0N;
	Fri, 21 Apr 2023 06:38:28 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkPZ-009qwy-1o
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:38:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDEA1FDDD;
	Fri, 21 Apr 2023 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682059104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8BDdQ0I4Yf6GR72ElgTwNi4vLCj+zPKb+0wtccSr70=;
	b=2IJWSTV0HYmEiy8yX5KgCyidCbBe6Q1H7MGTjn/6fQiz+bY43kRwdjO9h8TQZl4ElgBOnY
	dT7zzkSjaGjfGNcVBkaZFPB1/R+JvuhHTpzRq2ylmHvVrn/kRqQfbn7f6j3rQjsDdK+mtF
	2G31KrO0ayuUd6M8NQFt4yxiexKFAm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682059104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8BDdQ0I4Yf6GR72ElgTwNi4vLCj+zPKb+0wtccSr70=;
	b=9tNQrfdAZoXIoemhgRElZ8S1V0ybKQpXIw7Qe76IkTbiO2qWGOcf4Fw7wB5q1je73F8UHt
	242daXgCIRwU1cDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D52DD13456;
	Fri, 21 Apr 2023 06:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ap2oMl8vQmQPdQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:38:23 +0000
Message-ID: <327808f1-74f1-d26f-abb6-f5839cd36b03@suse.de>
Date: Fri, 21 Apr 2023 08:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery generation
 counter code to rc
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-9-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-9-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_233825_742742_B22B16B7 
X-CRM114-Status: GOOD (  10.11  )
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

On 4/21/23 08:05, Daniel Wagner wrote:
> Move the discovery generation counter code to rc so that we can reuse
> it in 002.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/002     |    4 +-
>   tests/nvme/002.out | 3004 --------------------------------------------
>   tests/nvme/030     |   22 +-
>   tests/nvme/rc      |   13 +
>   4 files changed, 20 insertions(+), 3023 deletions(-)
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


