Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F22EE57D0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivSqbdIaew11jIuy3b2FJ8sJqyjpyuQpjdb9X+4So/k=; b=S/bSZV9KX5Vnwhi//plxVsG8Ea
	5jidm/7+HPhZ9otlGJRqlsJ4huyQxOBsjzFh2ZomCTSYI0AXaQ5RFZVHMpmf4lRuQbyIZeid63SJA
	JKldPKc77qEuL1Bzu0tezkIejG85ATQB9c8Tr45A9xhWsO+XmFeqWAakuGO2uZdEqlTt9g8Me2Dis
	4KybVO7TH/jQKR+cLOaWaLPGTDMuP6q5tpR8rJS+pXoS2kzAl/ed/wLO5Mx7ZUwxaqlPTq4uOeTsj
	pJSd4b1+lZICFN74sh0B9vC/ktTNwGBrAXd66rDY/LCKPzhW5Mhy38ChQXpGLf/vXPq2YSDG6S64l
	6qOzIa+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUfg-00D7yZ-09;
	Fri, 08 Sep 2023 06:08:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUfc-00D7wj-1w
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:08:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 121FE1F45A;
	Fri,  8 Sep 2023 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694153323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivSqbdIaew11jIuy3b2FJ8sJqyjpyuQpjdb9X+4So/k=;
	b=Ww+PbR+NZChwI9hAoic8DpX3L4csUIVIEAvvkPKyzNqzwf/eRRHFhFYHXV5/jMOULswp4P
	J8gUjCB0V+qM+wi+jgVhu6RnYezEvVfsR/EVljabJmdtFuN472Ujma7vr4ZbKPJKypFhij
	wBBWzQlKeUktHrHgEy1eRN40jKsAGFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694153323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivSqbdIaew11jIuy3b2FJ8sJqyjpyuQpjdb9X+4So/k=;
	b=GZr0pwkKaX5mCM6Rvq/aswI7YZyZQd7svEZ13JJiPkTTDhDlDxuvj1gd5ZDh9JOvjyCIGD
	f2qrTt+7kMY7FIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CAA5131FD;
	Fri,  8 Sep 2023 06:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CCFRIWq6+mQYaQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:08:42 +0000
Message-ID: <bc365ee8-7fbf-4f1a-8ab9-901362bc257a@suse.de>
Date: Fri, 8 Sep 2023 08:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164340epcas5p11ebd2dd93bd1c8bdb0c4452bfe059dd3@epcas5p1.samsung.com>
 <20230906163844.18754-7-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-7-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_230844_784233_ED250553 
X-CRM114-Status: GOOD (  10.66  )
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
> For direct block device opened with O_DIRECT, use copy_file_range to
> issue device copy offload, and fallback to generic_copy_file_range incase
> device copy offload capability is absent or the device files are not open
> with O_DIRECT.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   block/fops.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
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


