Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1D2C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4pqQ5KyXYJB+dDuoUlSs40wgmurfVCJ8mfsc/vYL8Y=; b=ml3n8M6jqBf16rrtJkubNKqkNi
	SlvMsjj6tB4zT6Y6SgCIPUy1pkt8PGe+DtXfO3r+7IOk3V6xxY9JlnLtVyD5MZoFEz/2nMG4LXq1k
	eEY3jFm2tf0qCZRy7bwuSOJtM36HSvxRwKlLuIyYGjEqz9UUvSfCFUBHOuTS1im1SCmKlJ4OzymVw
	sN93teS0L+Xrk37d5DFC+8uJyGs1FaGzoQou+ipke5/sl3ZI+WzEjJTI4EdWkxPIhvq1oLbQppMxk
	1oKneJtiwahmTIwi9WicpJXW2ZRrGJIEIIZHDfPJV5+8ifcnhC95NUl1tP/1wRkdXjmO8sxT88czk
	1XEt5Ksg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm88O-00Gf0e-2L;
	Tue, 11 Apr 2023 07:09:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm88L-00Geyk-3B
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:09:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CA801FE07;
	Tue, 11 Apr 2023 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681196979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4pqQ5KyXYJB+dDuoUlSs40wgmurfVCJ8mfsc/vYL8Y=;
	b=CeZqePJfGEkO+fGVK6gn447eZ3PpF0vwNwfcP+IJ6RNKRVjBrYgg0Ikxl0GMFoqqcwQj7I
	bEMxjTRd2q9BVAPKbDd7raXLb19Xqj3EPo5zpnA9q/1tZkXWGPg3Z05rb3k5EZ157yP1Q6
	YVpBEm5Jl1CNMAhEAwGKhnOLutALV4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681196979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4pqQ5KyXYJB+dDuoUlSs40wgmurfVCJ8mfsc/vYL8Y=;
	b=kff8OHDkYt/AqYy4cGPnc44Uxrf1Tqwvz6gD+ZSrUyH4IbPAINjtxXNgNi/CvvSBjKFmVs
	kRn3tisU/a73sXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 318B713519;
	Tue, 11 Apr 2023 07:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HOSTCrMHNWRxWwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:09:39 +0000
Message-ID: <67a2b445-b905-387a-2271-244838ef1056@suse.de>
Date: Tue, 11 Apr 2023 09:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 02/18] block: Rename BLK_STS_NEXUS to
 BLK_STS_RESV_CONFLICT
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-3-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-3-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_000942_164404_DB7FFB70 
X-CRM114-Status: GOOD (  14.45  )
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
> BLK_STS_NEXUS is used for NVMe/SCSI reservation conflicts and DASD's
> locking feature which works similar to NVMe/SCSI reservations where a
> host can get a lock on a device and when the lock is taken it will get
> failures.
> 
> This patch renames BLK_STS_NEXUS so it better reflects this type of
> use.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-core.c          | 2 +-
>   drivers/nvme/host/core.c  | 2 +-
>   drivers/s390/block/dasd.c | 7 ++++++-
>   drivers/scsi/scsi_lib.c   | 2 +-
>   include/linux/blk_types.h | 4 ++--
>   5 files changed, 11 insertions(+), 6 deletions(-)
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


