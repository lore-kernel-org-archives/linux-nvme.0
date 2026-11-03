Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A1606A338
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=u+6YTupB;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=u/k7ywt1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kG7hbsIs0LGHYzA8KeJZi3mrT6QUwCifRqpQmdUsJ1U=; b=u+6YTupBJYWqtS
	PbXHMKl3lYG1ghY6CzsSYZu6nfiB9Dhi+0ln0+pCSXcjrPZk+6yPLYPaexvg+w8YxPk9Cht9Ck2ec
	8PbqBhNTUySdtjrAGVClvcDiAcb1hAHUbHDrlKNBvWM7WLGrugfop/5m8RkT18LfBU1UasuSdeXFZ
	0E0uDJlj6YcAS9ap7XswOWkWH1FzHEbNsme81hXweWtWTKgLVpUUNbKp1IoAkAC8mmNgiauIpG1ns
	8H8yqwX3kUVzxWlmiME2quu1+jR15pI05YU8B7yTbqel8km9lRcOj2LOpMpxsimGiznWjJ09B2elw
	Lb4XmjnbusNj3+Hm1d9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAyq-00000001lui-2HTK;
	Tue, 03 Nov 2026 09:39:00 +0000
Received: from esa.hc6817-7.iphmx.com ([216.71.154.88])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAym-00000001ls4-1uzx
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 09:38:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1793698736; x=1825234736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6l1B/IO5jaLbJkNRw753wWhduj0VS5+axdNT27du1w=;
  b=u/k7ywt1LvQnb07+yCuN5vzuABGtboaTZkYcUweoydeSBKdyiNLQr+dC
   msEQEwhxvwxmsPRgftO0OD6MYg59hiWInslwmJtWlS/c6BNA+TQRWGNdc
   aCSAggjrV2UUUES99pNIzcPkIlLp8bUqZhTb4/iK8eOJtHHXcYUGJxH+I
   YsfTdxnyt5DdOJrFh+ia8mo3OWte0HsT20E06KBPAXqyZPB32tPRY4irL
   1JQCVh0xjcNWouePy32gnA6IJkSyLPUYE8wLBvHRXNGKdBGTgugNQhfWK
   75IrVUXqft0EawaKQYM3gNPoJGklTVwt0L2vn/6PvT+rVwqfTyz6w/owj
   w==;
X-CSE-ConnectionGUID: hHecj7gDSeCMXet0e8y1Fg==
X-CSE-MsgGUID: uLkj3nt6RqCY/c6zpTGjuA==
Received: from unknown (HELO uls-op-esaep03.corp.sandisk.com) ([129.253.192.43])
  by ob1.hc6817-7.iphmx.com with ESMTP; 03 Nov 2026 01:38:56 -0800
X-CSE-ConnectionGUID: 4pY+36qmQEu3C4eJ+icacg==
X-CSE-MsgGUID: uAYh9mm1SCyVCzP2kyJcgQ==
IronPort-SDR: 6ae9abb0_Na1vQwTmASuxWjFOCcpBh+se+6Le8cZnj6cisPkodOpb/lx
 E8TFoIV7GGCVt8wVpUtvCGGse70z0rpl5Stum8A==
Received: from unknown (HELO uls-op-esaip04.corp.sandisk.com) ([10.15.0.10])
  by uls-op-esaep03.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:56 -0800
X-CSE-ConnectionGUID: OS8w0ffdSo+rDeEeagDNyQ==
X-CSE-MsgGUID: i8IWh6yWTCiN8bzbLaoTOQ==
SanDiskIronportException: Internal
Received: from ulssdxvpxsnip.corp.sandisk.com (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.9.34.160])
  by uls-op-esaip04.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:52 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>,
	GOST <gost.dev@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Avi.Shchislowski@sandisk.com,
	Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 1/2] block: add BLK_FEAT_ATOMIC_WRITE_MULTI
Date: Tue,  3 Nov 2026 11:38:49 +0200
Message-ID: <20261103093849.203851-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_013858_893540_4AEEF32D 
X-CRM114-Status: GOOD (  12.98  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 01:17:11PM +0200, Daniel Gomez wrote:
[...]
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d003a9d2d1f6c..92efd4ff67f26 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_features_t;
>  #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
>  	((__force blk_features_t)(1u << 15))
>  
> +/* device writes each atomic write boundary window of a command atomically */
> +#define BLK_FEAT_ATOMIC_WRITE_MULTI	((__force blk_features_t)(1u << 16))

With this flag set, a request with REQ_ATOMIC may now carry several independent
atomic writes rather than one. Code that looks at REQ_ATOMIC on a request (e.g.
blk_insert_cloned_request(), or a future SCSI WRITE ATOMIC user) needs to know
that. Could the comment here (or Documentation/block/) spell out what REQ_ATOMIC
means on a merged request, and what a driver must guarantee before setting the
flag?

It might also be useful to expose the feature in sysfs next to the other
atomic_write_* attributes, so users can tell whether merging across boundaries
is active on a device.

Regards,
Arthur

