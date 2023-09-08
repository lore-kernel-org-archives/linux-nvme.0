Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901C0EE57CA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhh86L1a0Ac0pSFA8hXQbQNg11VEwhvnOW57DV+REVA=; b=KKY4FOYSawrj0FmpLzxjNB2mI3
	GkmyrcRDp6rSSWmAvJnX9kd4Lp9mIKnype+im7q5y6zMDNDmdzdo+6J8aEHr++YUV3uN/S5xaQQtr
	gAbmJfHGFePW28U0xLYLDV6pbTM/bO9mAPjrVf7Q8PDYZQ0Xxo4p4anz/a90ctC1BTzZBvh8Rghmx
	/yNgNgqBIT+D/sWa6CQlT4g5uz47PCbVCR5msbAOeOGbQ3MnR4GshBo3izZ+eTsBT74YfEL25apez
	bhWavJ0stgAxmRrehyUhplEzKr5zu0mqIr/FIqvykpJ7Y+dMptVtc8Vh5s5Ln9HaLn+kMze2NTmAY
	f5qdglwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUdi-00D7hc-1b;
	Fri, 08 Sep 2023 06:06:46 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUde-00D7h5-2j
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:06:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5880218E0;
	Fri,  8 Sep 2023 06:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694153199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhh86L1a0Ac0pSFA8hXQbQNg11VEwhvnOW57DV+REVA=;
	b=zMuWdrBIaSNFqIIXPXdPjTuDPASA1tateMYYR1Nx7YqYbc97yCMa0dRaqzTgW4gf4+fyiI
	1xG//iibMhqxYkfvVoNBP60YY2cXGaq3Bh6K0pomIYJ2RqFRJGqFUDDkC+moYai7iZR8Bj
	0RrA+Qq+lsqz+u5Uulo9hfVf+JRd9sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694153199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhh86L1a0Ac0pSFA8hXQbQNg11VEwhvnOW57DV+REVA=;
	b=laUyeSPKn5jrNLRDjpA0OVdQd1LpZvPMMJ7MMPQ0q8DTusjAmhVkJSeuJbmHQwp41fKTM/
	c73bp/F1wuNo1LCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25CF2131FD;
	Fri,  8 Sep 2023 06:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id o2HgB++5+mQYaQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:06:39 +0000
Message-ID: <e6fc7e65-ad31-4ca2-8b1b-4d97ba32926e@suse.de>
Date: Fri, 8 Sep 2023 08:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 04/12] block: add emulation for copy
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7@epcas5p4.samsung.com>
 <20230906163844.18754-5-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-5-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_230643_050892_4910D16B 
X-CRM114-Status: GOOD (  13.43  )
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

On 9/6/23 18:38, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is
> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination.
> Also emulation can be used, if copy offload fails or partially completes.
> At present in kernel user of emulation is NVMe fabrics.
> 
Leave out the last sentence; I really would like to see it enabled for 
SCSI, too (we do have copy offload commands for SCSI ...).

And it raises all the questions which have bogged us down right from the 
start: where is the point in calling copy offload if copy offload is not 
implemented or slower than copying it by hand?
And how can the caller differentiate whether copy offload bring a 
benefit to him?

IOW: wouldn't it be better to return -EOPNOTSUPP if copy offload is not 
available?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


