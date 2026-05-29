Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F4DCD5BD2
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 06:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=; b=E7+4SFdwZByeo1XjRImEjvd+EK
	1f5v0AWIq2gwpWIHoJbgk1G1KQ4hkS5xGbJZqBJzEApcsB3zlxYIayKBYGHJCB7uN5oda3w/fOVQw
	cn+tOA7O+rIVVKc0eaPuc2O+VRvdbPkmEma19SFq/u4osOzc0SA9ZDq6im4KLsDhMjgeajzqs2Yod
	A9Pl12nICrwZ5mbDJaUtJhw91nZ3fk9IjEvGHx4ATli4Z6153qFSf0ONX/Yvq707ZXr3fRLtMBOiT
	FAVj7jQStq9TdKwiHZMHnOadMom3oies9Gqr3tNy+mmW5/YMah4tBll4vCVWs2T04ygOKzm9ri+3+
	XpesJe2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSqyE-00000006pm8-3cfG;
	Fri, 29 May 2026 06:45:26 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSqyB-00000006pkw-1Dtw
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 06:45:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E576266F47;
	Fri, 29 May 2026 06:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780037120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=t0iz5BRKXWdsSEWHa3rj+u4/+i2ZOjAHjRrsExfQHjs8lH7LnN5F/qQaYSGiC/3e/dmFWM
	6YCbHFBS5obGZIl62ruSzz+2gsZ6W6exB3tMsqyhHk1AwfHc0imeMAqNx2+KtMtAXxwZ5T
	F28uH2gkgm63iT3cN1BI/JIGMskTGuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780037120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=fp1y/pB54Vrz/Gb3TnWm5e81o1BdVG+PTYhbL3hYbvGRKEphT0G94xAwVPzVFa/xVZrV+E
	20Mfe7yIX0SvAKAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ojfIjkYI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mxhtg3sP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780037119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=ojfIjkYI2nuF/7Y9I3HXPpfSAdVFyF2wj+tTT3rH6IQSCd4S8qHpxeeskZ90XoMJEG9Kt9
	ZCNkQsg8ViBgBJN9GZ8g8CgM2pkNqiK+tCXOJgrTzy9+v4jTaSr4CVWpfFuDV35LM5pn7N
	BeBEfFMVT7+6Fa0WSWZFsPSM/gSAux4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780037119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=mxhtg3sP8KzGeSU/0ymb06q22HJ+tACNXXIH+2p/Oq0CyaFARXUnxhZhzIEFkQOULfL4P7
	A7SOsUwjZi6qZHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9C215B1E1;
	Fri, 29 May 2026 06:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bvg5KP81GWrcLgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:45:19 +0000
Message-ID: <b8d1fda2-a2da-4b35-9bd5-941834f26c32@suse.de>
Date: Fri, 29 May 2026 08:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E576266F47
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_234523_501069_092CB268 
X-CRM114-Status: GOOD (  29.08  )
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

On 5/28/26 17:24, Achkinazi, Igor wrote:
> When nvme_ns_head_submit_bio() remaps a bio from the multipath head to
> a per-path namespace, bio_set_dev() clears BIO_REMAPPED.  The remapped
> bio is then resubmitted through submit_bio_noacct() which calls
> bio_check_eod() because BIO_REMAPPED is not set.
> 
> This races with nvme_ns_remove() which zeroes the per-path capacity
> before synchronize_srcu():
> 
>    CPU 0 (IO submission)
>    ---------------------
>    srcu_read_lock()
>    nvme_find_path() -> ns
>      [NVME_NS_READY is set]
> 
>    CPU 1 (namespace removal)
>    -------------------------
>    clear_bit(NVME_NS_READY)
>    set_capacity(ns->disk, 0)
>    synchronize_srcu()  <- blocks
> 
>    CPU 0 (IO submission)
>    ---------------------
>    bio_set_dev(bio, ns->disk->part0)
>      [clears BIO_REMAPPED]
>    submit_bio_noacct(bio)
>      -> bio_check_eod() sees capacity=0
>      -> bio fails with IO error
> 
> The SRCU read lock prevents synchronize_srcu() from completing, but
> does not prevent set_capacity(0) from executing.  The bio fails the
> EOD check before it reaches the NVMe driver, so nvme_failover_req()
> never gets a chance to redirect it to another path of multipath.  IO errors
> are reported to the application despite another path being available.
> 
> On older kernels (before commit 0b64682e78f7 "block: skip unnecessary
> checks for split bio"), the same race was also reachable through split
> remainders resubmitted via submit_bio_noacct().
> 
> Observed during NVMe multipath failover testing at Dell on
> 5.14.0-570.23.1.el9_6.x86_64 (RHEL 9.7) and
> 6.4.0-150600.23.53-default (SLES 15.6).
> 
> Fix this by setting BIO_REMAPPED after bio_set_dev() in
> nvme_ns_head_submit_bio().  This skips bio_check_eod() on the per-path
> device; the EOD check already passed on the multipath head.
> 
> NVMe per-path namespace devices are always whole disks (bd_partno=0),
> so the blk_partition_remap() skip also gated by BIO_REMAPPED is a
> no-op.  The flag does not persist across failover and cannot go stale
> if the namespace geometry changes between attempts: nvme_failover_req()
> calls bio_set_dev() to redirect the bio back to the multipath head,
> which clears BIO_REMAPPED.  When nvme_requeue_work() resubmits through
> submit_bio_noacct(), bio_check_eod() runs normally against the current
> capacity.
> 
> Same approach as commit 3a905c37c351 ("block: skip bio_check_eod for
> partition-remapped bios").
> 
> A broader solution that moves bio validation into the queue-entered
> context and eliminates the set_capacity(0) hack is being developed
> upstream, however this minimal fix is suitable for backporting to
> stable kernels affected today. The link to the mentioned patch:
> https://lore.kernel.org/linux-block/20260519172326.3462354-1-kbusch@meta.com/
> 
> Fixes: a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Achkinazi <igor.achkinazi@dell.com>
> ---
> v2:
>    - Corrected race description: primary race is in the initial
>      submit_bio_noacct() call in nvme_ns_head_submit_bio(), not
>      only in split remainders (which are no longer affected on
>      current mainline since commit 0b64682e78f7)
>    - Dropped incorrect arguments about submit_bio_noacct_nocheck
>      export status and BIO_REMAPPED propagation to split clones
>    - Added analysis showing BIO_REMAPPED flag does not persist
>      across failover (nvme_failover_req clears it via bio_set_dev)
>    - Referenced upstream RFC series addressing the root cause
> 
>   drivers/nvme/host/multipath.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 263161cb8ac0..04f7c7e59945 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>          ns = nvme_find_path(head);
>          if (likely(ns)) {
>                  bio_set_dev(bio, ns->disk->part0);
> +               /*
> +                * Skip bio_check_eod() when this bio enters
> +                * submit_bio_noacct() for the per-path device.
> +                * The EOD check already passed on the multipath head.
> +                */
> +               bio_set_flag(bio, BIO_REMAPPED);
>                  bio->bi_opf |= REQ_NVME_MPATH;
>                  trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>                                        bio->bi_iter.bi_sector);
> --
> 2.43.0
> 
> 
> Internal Use - Confidential
> 
... or you could introduce __bio_set_dev():

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97d747320b35..5a2709adeea7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -518,15 +518,20 @@ static inline void blkcg_punt_bio_submit(struct 
bio *bio)
  }
  #endif /* CONFIG_BLK_CGROUP */

-static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
+static inline void __bio_set_dev(struct bio *bio, struct block_device 
*bdev)
  {
-       bio_clear_flag(bio, BIO_REMAPPED);
         if (bio->bi_bdev != bdev)
                 bio_clear_flag(bio, BIO_BPS_THROTTLED);
         bio->bi_bdev = bdev;
         bio_associate_blkg(bio);
  }

+static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+       bio_clear_flag(bio, BIO_REMAPPED);
+       __bio_set_dev(bio, bdev);
+}
+
  /*
   * BIO list management for use by remapping drivers (e.g. DM or MD) 
and loop.
   *

to avoid all this clear-and-set-flag dance.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

