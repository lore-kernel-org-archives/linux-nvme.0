Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9EAC77B74
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9g5WDTB6cpiz+yloumL16ZX0fxpSpbRDao1PSldQAeA=; b=fr44gtjvOoAyXnUrS+cGGU01Cq
	yvtnE4xh69LaFWeqCW+bF8Zp4/9suJU+C35l6M137H9houQYy5wu7RCIin6S4+y/w5HnwCk0OHv4s
	CYky51lJk+wQyHMJZjWIsGa73xJg+xwHEPb4XbnU765GxYrisOC4AcqL3jf3AGqnLDsqwdtA1Y/ul
	fTTEo/HXkoODZbw6W+yp3OvZy+Ksw/3oiM4Cvwzj1lK5cqxssZ+1OOmnu7rrS5At+T+9RpKJukePi
	CuSv87vDzEQkyoSAkfz+upHmY+8tBh3yU50cwdUPqzeBTJVQI9/ZzfuJJ27gCHw6yOovmF0zvH5Df
	jok6ahEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Fv-00GhTP-1d;
	Tue, 11 Apr 2023 07:17:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Fs-00GhSB-2V
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:17:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8248D21A54;
	Tue, 11 Apr 2023 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681197447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g5WDTB6cpiz+yloumL16ZX0fxpSpbRDao1PSldQAeA=;
	b=A3aObFtZm9hnz896Z1mfuymTR+0An8XcogfulEgJGIP3yB5JnhBtQ0R4+GpsqJkO+vLdMT
	SQQ5viQqVojFfXcUdFXsF+pZTXtnLX6qiMJNItT3S8oZr154CrnCnzMdvMMK5d7Suvb+zx
	1rYtNdOxEbV6dnFxULgyxAUDAQHX208=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681197447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g5WDTB6cpiz+yloumL16ZX0fxpSpbRDao1PSldQAeA=;
	b=PrTuNKCqAdeXRpQfmNEih2jrbL8uzBHPpKmK0DiqV8gbgaLW7dw6qGZ9T3xwf2D65ZuGzm
	cIU0+d1nANLsSZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2449213638;
	Tue, 11 Apr 2023 07:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OtWfB4cJNWQiXwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:17:27 +0000
Message-ID: <5b8c3a6e-6a97-6917-e172-468ba220e03f@suse.de>
Date: Tue, 11 Apr 2023 09:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 09/18] nvme: Move pr code to it's own file
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-10-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-10-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_001728_956288_06E73161 
X-CRM114-Status: GOOD (  11.46  )
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

On 4/7/23 22:05, Mike Christie wrote:
> This patch moves the pr code to it's own file because I'm going to be
> adding more functions and core.c is getting bigger.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/Makefile |   2 +-
>   drivers/nvme/host/core.c   | 148 ----------------------------------
>   drivers/nvme/host/nvme.h   |   2 +
>   drivers/nvme/host/pr.c     | 158 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 161 insertions(+), 149 deletions(-)
>   create mode 100644 drivers/nvme/host/pr.c
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


