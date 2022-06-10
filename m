Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BFBC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+kVVA2EWP+811dl9X5zwTe3veeucrRh6iDyz5bKlHZc=; b=tuk/TaHVDIo7WWCLycc1wmCmdn
	p0zlznn3IuEeMOU51QQ+QCgOuGELFKsjzt64lDwKR2BdWtV66244Xo2exO4k58QQUXDScOPSZH2SC
	Ie2V2hE/V7hyC8RlSSzwvkewSIAn34i9/bR66iuJKJefnec5W5qVYPMldUYZfpaxea/+m5VuVxECf
	1RucV/Avi4EfkEYKKlJtpIoXTkzWfFR1gt4sDUnr6xkOHezYRGvSPmUo9Zp7tKmmEvgNAmDslB943
	4/IKAIOMoSIaHNkfXW3txx9rqCfumoAJ+S85lVx9rmK1djGHrvTTbhVWEIDDJD5vPIsJz2pimP45E
	bn+0gHmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzahP-0072vU-Op; Fri, 10 Jun 2022 09:12:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzahN-0072tA-20
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 09:12:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 249EF21C04;
	Fri, 10 Jun 2022 09:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654852371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kVVA2EWP+811dl9X5zwTe3veeucrRh6iDyz5bKlHZc=;
	b=Mi/WsdG0u1m6mZc2nOlIlTVbMjGoht5mFGo51Knlf4fdGgVaJsz2O91km5Zalzl5e61cG9
	QyMeXmgLBnPiQkvCvD+d7UBLAg2EUhnMT/ggFMZe3oL3lUf6yYGnwSJrQRzcmbmlO54Tg4
	9KUNcw458ufzqDgzkiHmajsNdeB4jRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654852371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kVVA2EWP+811dl9X5zwTe3veeucrRh6iDyz5bKlHZc=;
	b=O+rYPST2zgTxA5zKl8Wt7RtVufYGuwrDRm5oWARR+MFbJgN72bU/9BtBdJHdkCToeUAg9j
	dAOaQ888nL3d5lAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1596F139ED;
	Fri, 10 Jun 2022 09:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 556qAxMLo2KNWgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 10 Jun 2022 09:12:51 +0000
Message-ID: <af8d390c-abd7-d4da-6bd9-99354b2ab2c0@suse.de>
Date: Fri, 10 Jun 2022 11:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
 <7b9bdd9a-1411-ca0d-9f87-71e2c25dffbb@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7b9bdd9a-1411-ca0d-9f87-71e2c25dffbb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_021257_284426_36BD978A 
X-CRM114-Status: GOOD (  15.28  )
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

On 6/10/22 10:55, Chaitanya Kulkarni wrote:
> 
>>>
>>> blktests (master) # ./check nvme/039
>>> nvme/039 (Create authenticated connections)                  [failed]
>>>        runtime  1.400s  ...  1.707s
>>>        --- tests/nvme/039.out    2022-06-08 18:09:06.239931529 -0700
>>>        +++ /mnt/data/blktests/results/nodev/nvme/039.out.bad    2022-06-08
>>> 18:09:40.596663692 -0700
>>>        @@ -1,6 +1,7 @@
>>>         Running nvme/039
>>>        +tests/nvme/rc: line 269: printf: write error: Invalid argument
>>>         Test unauthenticated connection
>>>        -no controller found
>>>        +no controller found: failed to write to nvme-fabrics device
>>>         NQN:blktests-subsystem-1 disconnected 0 controller(s)
>>>         Test authenticated connection
>>>        ...
>>>        (Run 'diff -u tests/nvme/039.out >
>>> /mnt/data/blktests/results/nodev/nvme/039.out.bad' to see the entire
>> diff)
>>
>> Hmm. Not sure what has happened here, but all blktests worked on my
>> testbed. I'll be rechecking with the latest nvme-cli build.
>>
>> Which nvme-cli version did you use?
>>
> 
> ~ # nvme --version
> nvme version 2.0 (git 2.0-96-g0b286b1)
> libnvme version 1.0 (git 1.0-62-gaacaeea)
> ~ #
> 
> I'm I using wrong version ?
> 
> Can we please add check in the blktests to skip the test
> if we have wrong wrong nvme-cli version ? it will help
> others to not misdiagnosed the problem...
> 
Hmm. No, that version looks okay.

What's the kernel message log? Does it say something about 'dev_loss_tmo' ?

If so, can you try with 'export nvme_trtype=tcp' and then running the 
tests? Previous versions of nvme-cli had issues with nvme-loop, and were 
trying to set the 'dev_loss_tmo' parameter, which isn't valid for loop.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

