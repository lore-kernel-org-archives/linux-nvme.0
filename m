Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290E7C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2PiCbkYRVqpVujiGkvIBicv05leWnBgsVKuMQ1I/uh0=; b=D/Zawa0kP7x7a/3SZhy0TXlRmM
	W4FaSZcyIJFC8x9lByON/NUMMxX7XdRWqg2aO7oaDYFls+6+PwiULkeoNDgkE3LZqNxaLbYwWD3w5
	i0n+TnitGi4oAMP42bkGxt6JJLTqwGZF7WAGhJ9vPE5DcysPZSGuH2+ku3sgIK4YLduf466FlRSFu
	FpFgG7hGI9BIrnVilioSPNsRaM8hDCXPtfvDfcwQXvFKHfxHwXmEOzrYKcVFXl6L+cqp3RdJTXbb8
	FzCchIiklLpSKR0KF+4mVuM3sp6jUxihjuzv1HlgLI3CTgYng2j0pYXSODYBeFO4AShU4ou5T9Uye
	UdmDX5sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGurA-00000007eVS-1lM6;
	Tue, 11 Jun 2024 06:19:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuZ9-00000007cFX-1hVO;
	Tue, 11 Jun 2024 06:01:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4355B60C78;
	Tue, 11 Jun 2024 06:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61916C2BD10;
	Tue, 11 Jun 2024 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718085665;
	bh=SwdezD+VbbCE5IbMCIb8XIlsQn00OdtPFM8sRr4ztZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zr2vvzA/p7vYbT1k0uSBle8fVBLgAMu7Z8G2rZTtwcHwZJBLkdKFIjTMoJNCzigg7
	 HTTeNcLNiD8mOl1bIMJSt8wupoDF5SVZaTY0NG2Ov76mIgZZigWXzzY7XVXH2QtfH1
	 x8KGc2pS1U1PRUpHUWYyhzSKqD5PI1im3Hi8m7vBLaJJJ9qEpljyUtR6RhIgyapNwR
	 oXmNiibgRDzuOY4ziojjhBQyINExkUL4KDOxUOXHRojL4EJXnDtsoUuvYOOl28n8tz
	 mMTtS5NPXLxyTGNL4ivwnqnaNnzfQN6jrGtKZFwmi4ccqOatSNqZrVoj3XSteIqnUe
	 tMfkIjYNQxDVw==
Message-ID: <89258309-c77a-4b82-a5a1-a4f08f4e119e@kernel.org>
Date: Tue, 11 Jun 2024 15:00:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/26] loop: fold loop_update_rotational into
 loop_reconfigure_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-8-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_230107_710811_DDFA46D6 
X-CRM114-Status: UNSURE (   8.50  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 10 Jun 2024 23:19:24 -0700
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> This prepares for moving the rotational flag into the queue_limits and
> also fixes it for the case where the loop device is backed by a block
> device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


