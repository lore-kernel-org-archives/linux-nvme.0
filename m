Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F950D116E2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AKSGwxhA9FhWbGjj1CB8Cj9PigkQUpQD2SeR/Zt3QiU=; b=UU14sYti6IZe3khgeoTmbn/3w9
	D+vboNYu4oBjUKieObfbwY7aqF7BjVI5MIXccGFhjbdtyAj0wbaMOZEDokC2O5WYVs+zBDpNv5cYJ
	fzpjIHVQosCDrCdbS0gHP393NzwR+RTiD8gfNn5YyFR9RjaFKA4sCT9ojyJIXnPr6AjaEiQvMi6ar
	EAHdKGpkGjTx8VnOBeVsPdwHtcoFoX8yNFsyoVBFrvlAa1/yxqL0w/LA0I7R5hl/BjPDPlGKLOn8y
	cYI2L2lu0pH522Pd+2VbwSiUdWxL4FWURIDMiQyV4lmrt/FNIcAcBaQFUvkyTwNsObz7NsCUmFOmq
	gCC8OXeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxUN-00000002zXg-0dtr;
	Mon, 01 Dec 2025 06:34:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxUK-00000002zWe-0oqA
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 06:34:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69E736732A; Mon,  1 Dec 2025 07:34:14 +0100 (CET)
Date: Mon, 1 Dec 2025 07:34:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/4] scsi: sd: reject invalid pr_read_keys()
 num_keys values
Message-ID: <20251201063413.GA19461@lst.de>
References: <20251127155424.617569-1-stefanha@redhat.com> <20251127155424.617569-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127155424.617569-2-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_223420_380628_84F20107 
X-CRM114-Status: GOOD (  14.41  )
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

On Thu, Nov 27, 2025 at 10:54:21AM -0500, Stefan Hajnoczi wrote:
> +	/*
> +	 * Each reservation key takes 8 bytes and there is an 8-byte header
> +	 * before the reservation key list. The total size must fit into the
> +	 * 16-bit ALLOCATION LENGTH field.
> +	 */
> +	if (num_keys > (USHRT_MAX / 8) - 1)
> +		return -EINVAL;
> +
> +	data_len = num_keys * 8 + 8;

Having the same arithmerics express here in two different ways is a bit
odd.

I'd expected this to be something like:

	if (check_mul_overflow(num_keys, 8, &data_len) || data_len > USHRT_MAX)
		return -EINVAL;


