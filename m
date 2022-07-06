Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96422C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kiUjfUaxXUHtTpdwighgqJkP8dPW871+3s1BnMx2Ltw=; b=PWEa6eb++J8ys0BtVJnIQmHsMS
	FQH9dlbKCnhHzslMCf3leqJPdsXNmtah4Zvlo6uOSCnhOSoBPrDBpbu+xcSa/yqXBis5hJLxC17ry
	DDhiTZ22ASI4Po9oxEfWJmdf0tnRhUvyuW5TUaXh8QrPwXJ1lMdDl0oa18BE4GJ3RR/WWzuIOX2E5
	ArQkqa2qLZDEfOwovgySsFaDm/f5AHPMeLmcl9kXu7EfGoiq6nkKv2uflREA7/Jjd8999opSw+W/r
	zFadCPZHwAo1llXl0s/BZR8vS4zTg9RpJEcEewIDKd0EBUujLDE9MNZTdkpozPaPr3wFQtUMtw2/+
	sn/bULDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o95XV-00AU47-3Q; Wed, 06 Jul 2022 13:58:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o95XS-00ATzL-N0
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 13:58:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B0FE2262B;
	Wed,  6 Jul 2022 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657115873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiUjfUaxXUHtTpdwighgqJkP8dPW871+3s1BnMx2Ltw=;
	b=yvPvbIuuxtdk2ZX8Q8tSoKYC5cW9dKB+5Zw1LzSQH7197bMhDdli0CWLiflL03yBVSxu31
	3GMcXYJKFvhvNqtUy2cQiQ4XZHsfkN6pzZ7I3g+QRQgLeWpktmJqk3iii4LCOU5lITaQ9i
	sL2Y/gJxVd14DsEMqswdcEn7ilbN6V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657115873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiUjfUaxXUHtTpdwighgqJkP8dPW871+3s1BnMx2Ltw=;
	b=DrSRj0EvDTIpUIt/FJqzoaO8ehUFDCc6m4Kks/eb8UIsdpsS4gF3k4Myi2JAHEtoQp9hzo
	OUxLU3k8ElQq8jAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F0F213A7D;
	Wed,  6 Jul 2022 13:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RZFGFuGUxWKNOAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 06 Jul 2022 13:57:53 +0000
Message-ID: <18d78bd6-2150-f771-9a6e-2b972d2e1192@suse.de>
Date: Wed, 6 Jul 2022 15:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 6/6] blk-mq: Drop local variable for reserved tag
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
 jejb@linux.ibm.com, martin.petersen@oracle.com, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
 <1657109034-206040-7-git-send-email-john.garry@huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1657109034-206040-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_065758_978894_D47ED56A 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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

On 7/6/22 14:03, John Garry wrote:
> The local variable is now only referenced once so drop it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   block/blk-mq-tag.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

