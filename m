Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A2AC7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Ai4/nJD9quPvfRJgPnsjThcNw9HC1HgmSHIrqS7uKM=; b=Skxqdo6U/b//L+8NeG4FALHeHf
	4Jq3WF+Tns9FlsDWreWqFrbra0MU6QeDnlFQTv/Pe0ytneNACTEf4QJT89Fte78ClGXaTFjpZ7Ndd
	fHwSopWLu5w644CJKy6mCD3zRsD7A+uagRkEJSny2LWg/LDYioIMLf8Z52PBC1MKDdk0acf/m1Avg
	wvvxfLryNqC2V9/OZIyxjT+bj5XdFazvblbxXGNrOawJLo4UFjNsbaFzGS+U9ogq8FGKGPjphhT0V
	P+Dy2w3X9rm6XRUvRo6XbpKwukcoEJeG3ctraQzhg3aEk5U89b2IuG31KYiXHy6yRv9Sf2nl5v+oZ
	D4W0Zi0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm89n-00GfIK-31;
	Tue, 11 Apr 2023 07:11:11 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm89j-00GfGK-1H
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:11:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D86A81FDFF;
	Tue, 11 Apr 2023 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681197065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ai4/nJD9quPvfRJgPnsjThcNw9HC1HgmSHIrqS7uKM=;
	b=f4ihOsXS6Y8Sm9aRJHehIPmW9I1PWJxfYZmTJyVLqcp8mlw6Fhqyys6HVQLUeqQNIV+rLA
	pVUkRbvKaKSP+Dh5UF/OpVOfRadOVxBqy59KnvYCme0Xoo3FbuzaZfZWIaxgDPLQaF0wyQ
	LHmbBAZbP2x1BD0z0pTiSUdFcISxalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681197065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ai4/nJD9quPvfRJgPnsjThcNw9HC1HgmSHIrqS7uKM=;
	b=AJNiy9t92MG2dEqRtLAR6fBp8wsg5fKDMh9S0EHo8PwKpXPIZpZaZ7XOW5pD7DXGtfCI7B
	Yj7d5vONjsjZs1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B99B13519;
	Tue, 11 Apr 2023 07:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 03L2IAgINWQMXAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:11:04 +0000
Message-ID: <512a6380-6bc4-b49f-37d7-32fb7e7aa478@suse.de>
Date: Tue, 11 Apr 2023 09:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 04/18] scsi: Move sd_pr_type to scsi_common
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-5-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_001107_583487_221E6397 
X-CRM114-Status: GOOD (  13.69  )
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
> LIO is going to want to do the same block to/from SCSI pr types as sd.c
> so this moves the sd_pr_type helper to scsi_common and renames it. The
> next patch will then also add a helper to go from the SCSI value to the
> block one for use with PERSISTENT_RESERVE_IN commands.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/scsi/scsi_common.c | 22 ++++++++++++++++++++++
>   drivers/scsi/sd.c          | 33 ++++++++-------------------------
>   include/scsi/scsi_common.h | 12 ++++++++++++
>   3 files changed, 42 insertions(+), 25 deletions(-)
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


