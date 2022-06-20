Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09309C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E12767Hc332KCm4R2bY/Y0KwukzPF8hS6kvY9dFw8dU=; b=PXWfF2NVZGtgmjPMABtu/xaQn9
	1P0nR1K7upyuHdLCKHM57EISx3FNb04EcVyfFNAT6mWRDKkw6sz2gTlZEbZHSnDziPRN680U0NjEH
	kyQfRGxZYu4GsQAwUYLGxz3K8D7j8JF7HGDbr9At1hCccnWqNnA0anFXwM8ZV8Wd8thZbqQUDN0+T
	B94cc8pEnhMfc02go5itYFz3V5OA1/OmtXuYwrPuQ7ROhsMCzJrlXKUatdUBpaU2wajmtE/9ML/S5
	wXq3aSFlDkQF2/tiPZdUKlFvDB7nqCcTcam0DOtLrMN7gmTLeSLUJWvN/LWRztvspfeSB/UyjoJHF
	ei9s+1JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BF5-00GVhC-07; Mon, 20 Jun 2022 06:50:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BF1-00GVd5-ML
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 06:50:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C41821B1F;
	Mon, 20 Jun 2022 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655707827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E12767Hc332KCm4R2bY/Y0KwukzPF8hS6kvY9dFw8dU=;
	b=dmNodsMVabo0hXcpm8qRnVbDuU1NwAfrsi9oRjewHumyNhiBsBwQDDsb8w/KIVUnkXX061
	uDNx4W1sTlkhwUR6tCRFTa7QTD1TbuKJ0Lki1hx1DjGjiho3rjMTM3sgyfYBr9qlle8BCd
	VVZeGU+0qQlsDueWK9sEOOmBb8x7Eik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655707827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E12767Hc332KCm4R2bY/Y0KwukzPF8hS6kvY9dFw8dU=;
	b=wUJO92wH3tMrT4/05gR6v2LcyVqIT6kHlHJ+j+g9qcvJgin0rD0gGCZMNAiTmYOhKAeiMJ
	BNKhS7XJlvRrSJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5D9F134CA;
	Mon, 20 Jun 2022 06:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id b/tRN7IYsGIYdQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:50:26 +0000
Message-ID: <4cab2256-a1e9-502b-91f0-8b34d9be03f2@suse.de>
Date: Mon, 20 Jun 2022 08:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220608144518.67607-1-hare@suse.de>
 <20220608144518.67607-7-hare@suse.de> <20220613181222.GA16146@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220613181222.GA16146@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_235031_926163_D4D0E3E3 
X-CRM114-Status: GOOD (  17.94  )
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

On 6/13/22 20:12, Christoph Hellwig wrote:
> On Wed, Jun 08, 2022 at 04:45:13PM +0200, Hannes Reinecke wrote:
>> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
>> This patch adds two new fabric options 'dhchap_secret' to specify the
>> pre-shared key (in ASCII respresentation according to NVMe 2.0 section
>> 8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
>> the pre-shared controller key for bi-directional authentication of both
>> the host and the controller.
>> Re-authentication can be triggered by writing the PSK into the new
>> controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.
> 
> The Kconfig doesn't apply due to the new nvme-apple driver.
> 
> Also when I fix it up manually Kconfig and sparse are both not
> happy:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_DH_RFC7919_GROUPS
>    Depends on [n]: CRYPTO [=y] && CRYPTO_DH [=n]
>    Selected by [y]:
>    - NVME_AUTH [=y] && NVME_CORE [=y]
> 
> i.e. when you select something you also need to select its dependencies
> 
> sparse also isn't exactly happy with the series:
> 
> rivers/nvme/host/core.c:3667:1: warning: symbol 'dev_attr_dhchap_secret' was not declared. Should it be static?
> drivers/nvme/host/core.c:3717:1: warning: symbol 'dev_attr_dhchap_ctrl_secret' was not declared. Should it be static?
> 
> drivers/nvme/target/fabrics-cmd-auth.c:33:30: warning: invalid assignment: |=
> drivers/nvme/target/fabrics-cmd-auth.c:33:30:    left side has type restricted __le32
> drivers/nvme/target/fabrics-cmd-auth.c:33:30:    right side has type int
> drivers/nvme/target/fabrics-cmd-auth.c:118:22: warning: cast to restricted __le32
> drivers/nvme/target/fabrics-cmd-auth.c:118:22: warning: cast from restricted __le16
> drivers/nvme/target/fabrics-cmd-auth.c:389:30: warning: incorrect type in assignment (different base types)
> drivers/nvme/target/fabrics-cmd-auth.c:389:30:    expected restricted __le16 [usertype] dhvlen
> drivers/nvme/target/fabrics-cmd-auth.c:389:30:    got restricted __le32 [usertype]

Right. Will be fixing it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

