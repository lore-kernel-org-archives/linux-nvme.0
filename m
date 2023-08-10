Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A31C001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlxsstlqxekptQd2+EpPADskOZjnrugKy/xavQoCUtE=; b=FNEsNu7zrO4QTLGdgEBwl6QjXw
	nMW1jshKZCmh9QHLzvrEWyOkjJAv0OzG/giTSpFpDvNTOhI5wuMfVTqGiSYIGPi3CE5+x2kADQELM
	qZvYPqqpHSf/Y44zSBj/kzG5ym/wAFsQTbFwiG/0mUcjil13r+2zxObl596if+3Vt0qRdsvrF8bOf
	1DdOZdOIVN5GJbJnXZpZPvsty7uCW+HaLMo82DpYMEN/WQRB4VKj1qT9KtwGyG7If0EyxKPJj63fD
	TjdmUUWQVpJl2eUTetT1Mjpsbww7EMKPbcJintQBdSfRFdJVsLTgpzvrzwC1d0yqcog4XEJNwDcZi
	r/SMcGVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5lj-007k36-2F;
	Thu, 10 Aug 2023 13:32:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5lf-007k1w-0D
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:32:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D68D5211BD;
	Thu, 10 Aug 2023 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlxsstlqxekptQd2+EpPADskOZjnrugKy/xavQoCUtE=;
	b=1AW5m9rcIQqVVRfw2S0ajB/nnXmG2d8yQW5nk4MNS+6KUiuaa7GhuCQ7GbAXJ3LVhnpcWo
	nKXvviUsFQ/DPp6dFMX5oPGDi14jlchxG0hbLlsYh2L0s3rLqwvEK/l/zSk9rUjCZR5qAY
	69y9Fu+J+5oa4dPiLEO9UfNjkIUw/mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlxsstlqxekptQd2+EpPADskOZjnrugKy/xavQoCUtE=;
	b=6XE1u98JDVZA32Udxd+m0vgwxL4l0ohHPg4PWFAXnGwY7J5PTjBDkS14lPm8s33W/Tof35
	bwylSTTp4vc86lDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A73B6138E2;
	Thu, 10 Aug 2023 13:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0DlbJ83m1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:31:57 +0000
Message-ID: <1ee4f878-c383-49c2-9472-376be0ba1f5c@suse.de>
Date: Thu, 10 Aug 2023 15:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 5/6] nvme-rdma: re-resolve traddr upon reconnect in
 case it is a dns name
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-6-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-6-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063159_247667_A0519858 
X-CRM114-Status: GOOD (  12.23  )
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

On 7/24/23 11:20, Sagi Grimberg wrote:
> In case traddr is a dns name, it may describe a different address
> during the controller lifetime. The classic example would be
> a discovery-service dns name that may be load-balanced via dns over
> multiple addresses.
> 
> So try to re-resolve the controller address. There is no dns query
> in case the traddr provided is an ip address.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



