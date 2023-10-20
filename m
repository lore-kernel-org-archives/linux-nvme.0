Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AEEC0032E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IvQp+Lj1RtWKJxIhCpbwDxWiQL84jFnfP/NyDPB5MfE=; b=jSJIbrHNuU9NNeFqhiPuPvd7tq
	I3KJ/j3OZBJpNcAzEPBfRynJzibFU5W7n3bQmnXqagpBPfX9UiYWwAO1x5MIPa4a2yBKAcoqJT/SZ
	7bAWodxvse12GAUd4nzHTtPZo4OyENUjgQ18bG6IGSRd95Jr+trr2XynnsX5f1bLz6udn2E7tP2qh
	kNvfALqjFCnrmUAx9a3sfphWYVvxYV5QAn+j/PuXlI4139qf9E21rEl/M63EaI8/wvH6M5Y3bIVYk
	5gk6WB6o4h4PXtbikzuH7yIDPbLJ2j2KT4uZF9wEHeCKunIyppIrH9gXCv92Wpzchz0w/xujMAav2
	xfQZHD3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtplx-002OtN-26;
	Fri, 20 Oct 2023 13:42:41 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpls-002Opt-2l
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:42:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A77461F8A3;
	Fri, 20 Oct 2023 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697809351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvQp+Lj1RtWKJxIhCpbwDxWiQL84jFnfP/NyDPB5MfE=;
	b=vsmhi6iZ6I4cjQ8cU8PYVhxiK6kXjqY0kiz0O4xh8g9Cc852ZI2uGaaYUgSjmQ69w/UEvg
	paCQF5k7Si+G8rfL8K1N6O13qlAZ491dqcbBYEBuMxkVdHHvRkpzB3j83TVSnGS7vx4dLa
	bssl8/e7exHiLzCImEwPnxkqyjIcxdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697809351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvQp+Lj1RtWKJxIhCpbwDxWiQL84jFnfP/NyDPB5MfE=;
	b=y0DfmcOLPYaXhUH2RmsCYDg6s0pphzMaPcwOWREYutmSXl3NysbVblSLiPGgAXAD9lv2Mp
	luJSCG4xw42mpVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29A1113584;
	Fri, 20 Oct 2023 13:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HjAaB8eDMmUqLQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 20 Oct 2023 13:42:31 +0000
Message-ID: <b3fd6ccd-c00a-4de0-ad5e-383f6e4c0e54@suse.de>
Date: Fri, 20 Oct 2023 15:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: common: make keyring and auth separate modules
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20231020130644.485649-1-arnd@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231020130644.485649-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.78)[99.06%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_064237_056950_8723F619 
X-CRM114-Status: GOOD (  13.09  )
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

On 10/20/23 15:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When only the keyring module is included but auth is not, modpost
> complains about the lack of a module license tag:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o
> 
> Address this by making both modules buildable standalone,
> removing the now unnecessary CONFIG_NVME_COMMON symbol
> in the process.
> 
> Fixes: 9d77eb5277849 ("nvme-keyring: register '.nvme' keyring")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/nvme/Makefile         | 2 +-
>   drivers/nvme/common/Kconfig   | 4 ++--
>   drivers/nvme/common/Makefile  | 7 ++++---
>   drivers/nvme/common/keyring.c | 2 ++
>   drivers/nvme/host/Kconfig     | 2 --
>   drivers/nvme/target/Kconfig   | 2 --
>   include/linux/nvme-keyring.h  | 2 +-
>   7 files changed, 10 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



