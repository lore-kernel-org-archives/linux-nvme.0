Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE640C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ohvImXlKvSC9tT700xuGbO+j5g4kFQBGKugnSkBS2Rw=; b=vACYXLrcO9b9r8dF7Coq3QHJru
	WzP8ZJaTrnAMqJH5LGtp85RXk0bA9w8MfG1DS+7gL/3KhI5czwGdg2A5SmCFN4gz2K8w2fugN9uKi
	qF860qDfL4CL95VqgjnWjuQHL+zkIZsgzhoByGb/EOvar6OrpM6qaKv0j2iqNRuzMY4mwg2a1klyN
	U5C6KqCImbTDb/rClQrH6T55UMhsk4LhOrDPx4iVbYAxdE2mZEtQUwsKXBbRg7msfVqmwmPecmh9f
	wKOUY0rD2VSIRH4KG+sgs6UJhQMSpV46l3QN76GG7CxWt7bpNQdwzv8KarWmjqbxHepKAeFTbPNsj
	9tqz9wAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuN3-00000007ZiP-1TmV;
	Tue, 11 Jun 2024 05:48:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuLF-00000007ZRQ-2ynT;
	Tue, 11 Jun 2024 05:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DA72160C78;
	Tue, 11 Jun 2024 05:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6E2C2BD10;
	Tue, 11 Jun 2024 05:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718084804;
	bh=ExeLOYUGYjsXp3wdbBqJbcQ6b1Q8a86JlJB2p9Et3no=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBxCLVZAQ2Cg02C5kvrfE9AgQqRfV0Vp9wUF3fqyRhPTMqteB7yjcEcGuYnFUrdIw
	 Nu+HCmDrsEWaDY0FS7c46/3H7ATl/iGMVLCSF+Y1IXagrNKa23K/U8gLfuLZVv+pfk
	 se724bhlH7gvtfrzVvNU5z4sgOI97FPDkZ/i4w+FATTtdCE12k8Vsqx39K60DyqVqK
	 eKEG3WqOVb470PJhBzxUxSx4QvapUkoaIbwLZb4Jn2jRXEpSQbkqLj2jPx5RESJvRH
	 5VCPbFYE05UT1aOpVYJIEWldcQvGMdLjZeDXOZ3CBVDxeKuyv8iCzyjAX6fSrOkmTW
	 QhoVFafzbn1yw==
Message-ID: <d50efca4-ba29-49f9-94cc-5bd4795f6e38@kernel.org>
Date: Tue, 11 Jun 2024 14:46:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] sd: fix sd_is_zoned
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
 <20240611051929.513387-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_224645_823650_55B346B9 
X-CRM114-Status: UNSURE (   7.53  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 10 Jun 2024 22:48:36 -0700
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
> Since commit 7437bb73f087 ("block: remove support for the host aware zone
> model"), only ZBC devices expose a zoned access model.  sd_is_zoned is
> used to check for that and thus return false for host aware devices.
> 
> Fixes: 7437bb73f087 ("block: remove support for the host aware zone model")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


