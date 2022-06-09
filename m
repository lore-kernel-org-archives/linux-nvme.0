Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F22EC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 06:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yctXHqfBJMI05kHLlsKx6jie9y+DLfkkqYfIWdnL+uM=; b=F+h7YD0ds5LlT4/Amc/SK2HhZJ
	tqabavrjpJhvXRMYOQGKl5DK6NLHV+LeeL5a3lOsOg43Sx5bzYkVLGUJMAGRNdKNvoCYoZqQMFNeJ
	Kk+6xbyLNYDAoWF7ii5YqSITzIupDJnjShkPRoD3VBfz4M/nklBOi1rzV6esk8dvHu+no3X4n5+u1
	zEA9CWLKzPgdXmjfuwbGFmMeGzwVJ3PTyIIndsVruiBWkrIZ91dedvICImhkSajn2hfXGxkrjJdAk
	KC4xDpCWf2NZ1lPLBI+eqtYN6pT1YszyYLz9kB+K7pczk465XNjbZH9RaHkMS4EfJEFK2OSNQGMy+
	YRgntGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzBL7-00GzzF-7E; Thu, 09 Jun 2022 06:08:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzBL4-00GzwQ-GK
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 06:08:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1073C1F927;
	Thu,  9 Jun 2022 06:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654754888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yctXHqfBJMI05kHLlsKx6jie9y+DLfkkqYfIWdnL+uM=;
	b=fFGIvIL2TWRW/uM/DGFy7J1wGwr5S+VUVbQ3hLgLsypaQuO0t7KoPp3eB79IB+6lRRWska
	377GnUUorfrUNGY+YN5WAReVIh2oLZrC5wxrpZrAUINlDJS18ZLNTv5/r+HiJR3s+U1Vy9
	9wgxQBGmHMEjh/nyAsK/PWOUylAp2lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654754888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yctXHqfBJMI05kHLlsKx6jie9y+DLfkkqYfIWdnL+uM=;
	b=udn868z2Zr98ns0+A41DDzSSGnHJhX4jYbAXUPNbKWWFavYMkACsQ5grILDhVjdA6RlhPO
	iGanLZCqL/bS/DCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDCFA13A8C;
	Thu,  9 Jun 2022 06:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bDUCNUeOoWJQFgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 09 Jun 2022 06:08:07 +0000
Message-ID: <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
Date: Thu, 9 Jun 2022 08:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_230814_737078_FA21DC92 
X-CRM114-Status: GOOD (  17.51  )
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

On 6/9/22 03:13, Chaitanya Kulkarni wrote:
> On 6/8/22 07:45, Hannes Reinecke wrote:
>> Hi all,
>>
>> recent updates to the NVMe spec have added definitions for in-band
>> authentication, and seeing that it provides some real benefit
>> especially for NVMe-TCP here's an attempt to implement it.
>>
>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>> to provide us with a FFDHE implementation; I've updated the patchset
>> to use the ephemeral key generation provided there.
>>
>> Note that this is just for in-band authentication. Secure
>> concatenation (ie starting TLS with the negotiated parameters)
>> requires a TLS handshake, which the in-kernel TLS implementation
>> does not provide. This is being worked on with a different patchset
>> which is still WIP.
>>
>> The nvme-cli support has already been merged; please use the latest
>> nvme-cli git repository to build the most recent version.
>>
>> A copy of this patchset can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>> branch auth.v14
>>
>> The patchset is being cut against v5.18.
>>
>> As usual, comments and reviews are welcome.
>>
> 
> 
> blktests (master) # ./check nvme/039
> nvme/039 (Create authenticated connections)                  [failed]
>       runtime  1.400s  ...  1.707s
>       --- tests/nvme/039.out	2022-06-08 18:09:06.239931529 -0700
>       +++ /mnt/data/blktests/results/nodev/nvme/039.out.bad	2022-06-08
> 18:09:40.596663692 -0700
>       @@ -1,6 +1,7 @@
>        Running nvme/039
>       +tests/nvme/rc: line 269: printf: write error: Invalid argument
>        Test unauthenticated connection
>       -no controller found
>       +no controller found: failed to write to nvme-fabrics device
>        NQN:blktests-subsystem-1 disconnected 0 controller(s)
>        Test authenticated connection
>       ...
>       (Run 'diff -u tests/nvme/039.out > /mnt/data/blktests/results/nodev/nvme/039.out.bad' to see the entire 
diff)

Hmm. Not sure what has happened here, but all blktests worked on my 
testbed. I'll be rechecking with the latest nvme-cli build.

Which nvme-cli version did you use?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

