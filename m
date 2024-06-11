Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C92AC2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1x28cs1vNnTovmOEZshDr4sXK3dLcchrq6+7Natc4C0=; b=EuTtp1RVZLgrs+jORDRdG/O+YR
	J735KEvruOcyJt/Gc/F3inLTusqU8QyIjYwlFIDmfKcJlHwKDhuClhErWXzsGCtLALxFygRZvhgzP
	XzPNYg9P9Qj/VyvQ1wPM6nO0HhF0FzDqKKHpldokgW9G+2J+osipDZJ3EgOuGYabkaOWWQjn8o/Yh
	+ZnWBjWL3I893W+s65ZbPBXzZZRYLUtsQCV3G3bn2gUNnFkRIFXrGArvCiDB4lVjAg/Vk3xWhV0xZ
	Mqmt1d6Hc3KdX+yx32sGNK4h4WrY4UEHPbJQrUF8BJHCrfi33Q//Rw9Wj7pAcGzCgBbNG0mNTtC8t
	5qMI9eFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHEyI-0000000AwDO-46vK;
	Wed, 12 Jun 2024 03:48:26 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH71O-00000009yBc-2lX9;
	Tue, 11 Jun 2024 19:19:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VzJPg1skBzlgMVP;
	Tue, 11 Jun 2024 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718133535; x=1720725536; bh=1x28cs1vNnTovmOEZshDr4sX
	K3dLcchrq6+7Natc4C0=; b=aLYYpUIO/Gxr6+oqIDEKMSeJEI9bEPlY1LmfpMwQ
	E2zY/jIjQz06DLuKS7/oqPEXBkmWPwKJXv7uV9mIl2KYhZCemVl03S1oSnwY4qxi
	j0LRHUdBHYckWLy3gMU7t6sg6PZRzo7w6uU2MvHhI0f4HAtEwdZgsvVAv0FAT7p4
	EBEjjdqMwYqi/U4rE0KUxNAQvcj1p4UprqA32cXd2cHFp7mwER3riMRLdMFdlrrT
	vPbUR/NzJad+yqXUxUvzt01I+FlnPsokOOQFYLX++R6LD2ksIREkny28AtjzGpS9
	3ApefM2xSewPQ14QhJuxg0s5WeeRKuj87Ridc/j3ANOv2A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Krn5mVvq-SSd; Tue, 11 Jun 2024 19:18:55 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VzJPL3DslzlgMVN;
	Tue, 11 Jun 2024 19:18:46 +0000 (UTC)
Message-ID: <fc9fb8dd-05e4-48b8-ab01-d1dd84996df4@acm.org>
Date: Tue, 11 Jun 2024 12:18:40 -0700
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240611051929.513387-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_121906_904343_F77D000A 
X-CRM114-Status: UNSURE (   7.15  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 11 Jun 2024 20:48:17 -0700
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

On 6/10/24 10:19 PM, Christoph Hellwig wrote:
> Since commit 7437bb73f087 ("block: remove support for the host aware zone
> model"), only ZBC devices expose a zoned access model.  sd_is_zoned is
> used to check for that and thus return false for host aware devices.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

