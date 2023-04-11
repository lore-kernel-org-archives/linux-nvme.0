Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72955C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jPLIx1z2EU0oEU1Nj43y5nAv+u6B0Ix6LWD0GUUED80=; b=hoC73n3nPusJWX8gIvWpo4yE9E
	H/O9tXkDPj1RUs2DZZ+DWEkNvXX0kVSAbdiVWpCmloUL5dL2QpGOFX2ILmNP9RuYnIRtP83JLSicu
	+knYtG0bU9Khtauvk2v+XNRNnNyB5DAvy+BZ9btmbjHr5YFxTozipnatkJ1FQBXks300ssdKVTQyK
	QPXQpSv4SBes5rudNWchWJQX/LgNc2khhjtbcI/jS8x74UQ202PD1ADxrL3fYfm8z0dJMiH5PAyPt
	BA/9hZvA0SbhppYQULWmDbGBFMgemwcVFTT0/a2ZvX0JGm+OmSKOvAzFDE+oMF1Clk4tWnDQ4ZyNd
	OvzdISGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Bz-00Gfkx-0l;
	Tue, 11 Apr 2023 07:13:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Bv-00GfjQ-03
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:13:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95E7421A4C;
	Tue, 11 Apr 2023 07:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681197201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPLIx1z2EU0oEU1Nj43y5nAv+u6B0Ix6LWD0GUUED80=;
	b=m6MPLpb+tLS7w1BuYwIE0wagxfRujBq7gTSJQ4YRj1EFiE++futJeJ8/ItBRiabQL4tYae
	5lp5q+aD90IWWvicS4s8jFtuBuc/lUFdSZpSSgHnEGPw4xrY94HfpnBBKpf6QCSjLN9uk9
	LMtg9zdWaxZuh7+YH5xBKXuwR3ay2LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681197201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPLIx1z2EU0oEU1Nj43y5nAv+u6B0Ix6LWD0GUUED80=;
	b=OYlhBE5Ok5wOXTxYnCoAVHzR/k7zbapbkmCOzFrzszoOa4ZG8dGR6/cRUe18wp7qh0+A23
	/MOGLw0trNdTYiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B50713519;
	Tue, 11 Apr 2023 07:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vf3uDJEINWTpXAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:13:21 +0000
Message-ID: <39789d6a-389f-b2db-8274-1c692baa1117@suse.de>
Date: Tue, 11 Apr 2023 09:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 05/18] scsi: Add support for block PR read
 keys/reservation
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-6-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-6-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_001323_197474_9DE5F443 
X-CRM114-Status: GOOD (  12.65  )
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
> This adds support in sd.c for the block PR read keys and read reservation
> callouts, so upper layers like LIO can get the PR info that's been setup
> using the existing pr callouts and return it to initiators.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_common.c | 21 +++++++++
>   drivers/scsi/sd.c          | 91 ++++++++++++++++++++++++++++++++++++++
>   include/scsi/scsi_common.h |  1 +
>   include/scsi/scsi_proto.h  |  5 +++
>   4 files changed, 118 insertions(+)
> 
Unfortunately this ties our PR abstraction to the SCSI PR model.
Let's hope that other protocols like NVMe will map onto that, too.
But in the meantime:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


