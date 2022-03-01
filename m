Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AFBC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=amRql2OSifwDnMAJL8/238tLYYm1geBZTyNb+J/J5JA=; b=N8mqureOPdMRivF3+4Ruqemtes
	PChlvzhOztPcBoigqUNAjN93JopU3ROqHF1LvELOAbiHCHT3ycItpLes+3dJAZais+Cc4LFqmFnfW
	A0GxO4P7OprtYkRTTvV131UIz0/BLDJA+07zyNqu70esSIRm+ZoFmDTCnHG7bG1bX9G5Ad5Rc3w+f
	wsfL9i3EOi0GiV9Rlk4+LPV4pZw/Qaw3j0qLcDVc/98DSsryqYHLyIFhhrcNlmcmmV0Z2aRmyTu/H
	/a1+8i2XoV8uI4tMpMusEZhkl77Hyp5WWz+0N31/WOHqpkor/K2dcpVb/drGJYvp/o2nqerCGwvlv
	MLaDg76A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOtDM-00Emtk-LJ; Tue, 01 Mar 2022 03:30:16 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOtDJ-00EmtQ-RK
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 03:30:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E55E219A6;
 Tue,  1 Mar 2022 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646105405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=amRql2OSifwDnMAJL8/238tLYYm1geBZTyNb+J/J5JA=;
 b=GkO1RUbcIRDbBCTKpoHK/XgB7T7pycbqRlZiHjWMyYPtQz799SdXOGArNfPTKDenlvaNhe
 tp9AZqw7DYsgL9qhnkeDPnVx11SCEjUk77K1volH2Jf5FVwH1+37p9awpQcEb6uioG8Oby
 d9KUd9rbWXvJ5ZlaShDoKUu8d7v1A+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646105405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=amRql2OSifwDnMAJL8/238tLYYm1geBZTyNb+J/J5JA=;
 b=b/8i+0AkMC/6pODT8F8eIhKH9YDMyi22Q5LdsklgO2aNjgkeJ6fH0yV1kbm0v7Z/chzSQ/
 Q9XAh8o+OFVO8BAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71B9513AF5;
 Tue,  1 Mar 2022 03:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cBklDTyTHWJ3aQAAMHmgww
 (envelope-from <ematsumiya@suse.de>); Tue, 01 Mar 2022 03:30:04 +0000
Date: Tue, 1 Mar 2022 00:30:01 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Message-ID: <20220301033001.tozk6cakdznww6wi@cyberdelia>
References: <20220227234258.24619-1-ematsumiya@suse.de>
 <20220228092215.GA8549@lst.de>
 <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_193014_079789_AEF1642A 
X-CRM114-Status: GOOD (  12.13  )
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

On 02/28, Jens Axboe wrote:
>On 2/28/22 2:22 AM, Christoph Hellwig wrote:
>> I don't think we should add code to the absolutel fast path for
>> blinkenlights.
>
>Agree. It'd be a lot better to put the cost on the led trigger
>side, and not need anything in the fast path for block devices.
>Monitor disk stats, or something like that.

There's been at least 4 attempts to do so, as far as I'm aware (one of
them being mine). All got rejected due to the complexity it introduced,
that's how I ended up with this one-liner.

Performance-wise, I'm understand the problems, but according to ftrace,
ledtrig_disk_activity() adds an average of 0.2us overhead, whether an
LED is assigned or not. Is that really unacceptable?

If so, would introducing a CONFIG_NVME_LED (default =n) and wrap that
call around it make it better? Then at least there's a chance to inform
users that desires this feature about performance costs.


Cheers,

Enzo

