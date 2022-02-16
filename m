Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FEEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 06:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GGMtEIGANtAaJZgWgs4fHi8bEqaZzSeIEHxY3YZQSM=; b=nM8meks0TMFmP8oalQJS05MECh
	IWFPjCIGq3hqV0m14avQsOiTVMLju9fmcWHRkXGGFpeB5zq+rxJmAjF9T83EUgg5cctdx7mVxPFWc
	bhTiPkA+k3XT65RvJBW3vW0vn0Rv4X/N8yoM63/3+Fj/Vry1+HdGZlw3NF4XdEykz+rERBHH3/jhQ
	Rl+NMjw+PQppSQwo7UIacVvGoZY2z4bqIid8RO5HsFdFIGVYyy8jaKIChPzrtewEiwSpALwhVACSw
	CWkdnz7M7R65nnjER5WLyfjfsHFMa2PRbbnc/vzxPD8Dnn6hV8jrCt3HhaJ5HqINjKwvP1lpFTjos
	1lC6MMaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKDyM-005i5H-25; Wed, 16 Feb 2022 06:39:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKDyJ-005i4p-3Q
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 06:39:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0651F37D;
 Wed, 16 Feb 2022 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644993565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GGMtEIGANtAaJZgWgs4fHi8bEqaZzSeIEHxY3YZQSM=;
 b=m54ylZrQ963wIR6zi/BQOguiJ0LS7VKESk6EZVzEEtdNitM7NhSeOR6d8YfWns9fyd+rKO
 JQf8TMGuCoyo6S5CNhgOtJi4Pr7kJ2boPw9pJnDQjgv+PrGMTZgLqzMGym7//FPLFmH3hz
 GMdFeegXjZsFRhDkJm5JwTpI0ta8AIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644993565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GGMtEIGANtAaJZgWgs4fHi8bEqaZzSeIEHxY3YZQSM=;
 b=i5cHX04eaVceesCbkAEE3R3DVeOG/2Qc1y6CzyyOpK21iDbNYaNV813kGh1GjuqRkR6YDM
 AcIAcFu6O9glNJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0673213A1A;
 Wed, 16 Feb 2022 06:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hQkqAB2cDGLUIwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 06:39:24 +0000
Message-ID: <da0e1493-bdfb-f510-7cf9-ffbf4baf6159@suse.de>
Date: Wed, 16 Feb 2022 07:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Markus_Bl=c3=b6chl?= <markus.bloechl@ipetronik.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Roese <sr@denx.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215191731.GB25076@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220215191731.GB25076@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_223927_316439_F6A3DC81 
X-CRM114-Status: GOOD (  13.29  )
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

On 2/15/22 20:17, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
>> After the surprise removal of a mounted NVMe disk the pciehp task
>> reliably hangs forever with a trace similar to this one:
> 
> Do you have a specific reproducer? At least with doing a
> 
> echo 1 > /sys/.../remove
> 
> while running fsx on a file system I can't actually reproduce it.

You should be able to reproduce it doing a PCI hotplug from qemu.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

