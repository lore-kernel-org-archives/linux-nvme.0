Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043ECFD2F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIcqczMHM4ZO+C7Zhy6g90zlDnolECQh4J7KHYUJgIE=; b=yMM9beqiXEtJ85wFRo6r0C1XAj
	ljIE89sSjsMkxyIGJ4RiOkUWP/78nhg0zM1r1stBDKNwptw8bX/nKwtt+m35LUdxNLlJXWAsS7a9S
	C48P9iM9OO7RdymsTLDcQko77RdB2n7dHDVMjMyv7C6Bq0HXFQKxgKfBHS5plyxa4bsEIFkru5qaZ
	e6tyOz+/s8knhbWg222qgvx7Wvdc49fjDFW+W6uwvTF5MqmfWeDANjwanzwes5sSXQ7XvOoEwBXgR
	7Z8uvGvJez0M1KZgcrKEv+3OZ1LljovuU6UPSPg1xsdo4m0jjETerbm00czDOnRh5gWjqyDw45h6t
	9dfISJ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJPJ-00000004rtS-182Z;
	Tue, 02 Dec 2025 05:58:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJPG-00000004rt0-3Zcq
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:58:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 080AB68AA6; Tue,  2 Dec 2025 06:58:32 +0100 (CET)
Date: Tue, 2 Dec 2025 06:58:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Mike Christie <michael.christie@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/4] scsi: sd: reject invalid pr_read_keys()
 num_keys values
Message-ID: <20251202055831.GA15965@lst.de>
References: <20251201214329.933945-1-stefanha@redhat.com> <20251201214329.933945-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201214329.933945-2-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_215835_066850_252DF1F0 
X-CRM114-Status: GOOD (  15.10  )
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

On Mon, Dec 01, 2025 at 04:43:26PM -0500, Stefan Hajnoczi wrote:
> +	/*
> +	 * Each reservation key takes 8 bytes and there is an 8-byte header
> +	 * before the reservation key list. The total size must fit into the
> +	 * 16-bit ALLOCATION LENGTH field.
> +	 */
> +	if (check_mul_overflow(num_keys, 8, &data_len) ||
> +	    check_add_overflow(data_len, 8, &data_len) ||

Using data_len for the throw away key size is a little confusing,
but then again I guess compared to all the surrounding code that's
harmless :)

So:

Reviewed-by: Christoph Hellwig <hch@lst.de>


