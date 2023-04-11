Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91347C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQxRTzrMKqSON3EvIhCwW2gyksjvr/oR+pPMFwHDT1E=; b=QKw2FUxjIAtTIsgNPhPCoKEqd0
	2ANDi5Jtyl1u7u4Eq+9EgvYrP7yq1FdMtEYAwYATsFgB5PCGtqJ+JXtWK/A3S/DyIutTT5z4hFQID
	wfLewHmWo/LfF3T2EUF5g1NlbTZ2+Ud3EHQNeWEmNsYVJis/TQ752fp8Rzwgoc0UszU+KK8GG6t53
	bJnBf2T1NHgxzr1L/rzwG1YMRSBlgELYxCi6l2h/vtDYjqgemaxNVDalPpX6wHDFM7SDa5UtAW16u
	RvxsjKh8QZFsUC6oR8jyWH/NFXmh+vw4R4NgDwi/gruDkhdea30BkksJt717aVPK7wtFhNGfgmOTo
	AROhNV4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Se-00Gj5Q-1j;
	Tue, 11 Apr 2023 07:30:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Sb-00Gj4m-2W
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:30:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B5A421A4F;
	Tue, 11 Apr 2023 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681198236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQxRTzrMKqSON3EvIhCwW2gyksjvr/oR+pPMFwHDT1E=;
	b=JwJ/WkxwVuKtT5Q+kimpbGaODJKKKAv4OFi0LZOHnrwR9jcTBtFMDLo66znOHDKy2PxTBc
	UFGUbGP8t/08YPEJL9fDKJOMRRFJbzeMXERrfv7fAlQ3S2vVZIQ5pULXs5s1uABQbfDVdc
	zJxH8ALFjEUeMuUjabu3Z8hrmkU/+nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681198236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQxRTzrMKqSON3EvIhCwW2gyksjvr/oR+pPMFwHDT1E=;
	b=+NiSZ4j2wSSNQFmzbgUvS6L4hSy+wz7KIBXop/FHmMhMqCnyq277tXGJfjo7pnuxod53+x
	DpsbBScHRQxgRtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A55C13638;
	Tue, 11 Apr 2023 07:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ETXYAJwMNWQUZgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:30:36 +0000
Message-ID: <2803b786-2573-699b-9f71-46854d0958b5@suse.de>
Date: Tue, 11 Apr 2023 09:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 14/18] scsi: target: Rename sbc_ops to exec_cmd_ops
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-15-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-15-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_003037_963783_33C5DD34 
X-CRM114-Status: GOOD (  11.79  )
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
> The next patches allow us to call the block layer's pr_ops from the
> backends. This will require allowing the backends to hook into the cmd
> processing for SPC commands, so this renames sbc_ops to a more generic
> exec_cmd_ops.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/target/target_core_file.c    |  4 ++--
>   drivers/target/target_core_iblock.c  |  4 ++--
>   drivers/target/target_core_rd.c      |  4 ++--
>   drivers/target/target_core_sbc.c     | 13 +++++++------
>   drivers/target/target_core_spc.c     |  4 ++--
>   include/target/target_core_backend.h |  4 ++--
>   6 files changed, 17 insertions(+), 16 deletions(-)
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


