Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7E4C27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLeXGXOESgYIgwE71qSal5CBHe6oz9PwFy8FG1a1Dpc=; b=fpOBCNBQj0XgYA2fLDFke3jgk4
	EUDjqeZ5tmY+mDK5LA8k5sNbZf5R7TJNrAconx6JpyK13H3DHhv7LH6yfIJgEcjXTTGbUghJW7weG
	YThQjKcDkDPT6nyez302SzdInvAt1U0Q27mJsIfWWGePOokELxRDTG2J7YMH9GLC32ZUKWmUc2ZRb
	InoBXbL8PF7stWjqR9uNYQkZb05YjmDzMA+PvEZLpiCmrs9h7Z2pfW2bSGHAW0Gcjha9M7HR3v31I
	1F0LcUqMcDkzK3G5NtcjhAVgvyoqAvcZ4QEeH5JK07/gbOvRiBCHmfDraj8Ew2+h7rWLsV/DSsVra
	FLTzKbWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtY8-00000006rWm-0RM3;
	Wed, 05 Jun 2024 16:31:44 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtY4-00000006rWI-4242
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 16:31:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvXzH3qxqzlgMVV;
	Wed,  5 Jun 2024 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717605093; x=1720197094; bh=xLeXGXOESgYIgwE71qSal5CB
	He6oz9PwFy8FG1a1Dpc=; b=rR5gUlWJQFipRCu76uDVoIk2bggN8nR17hl64A5z
	PpccWJOwEIvZ8Ex+LUw0PcKsrXqqF3M5efiqI3Q2rtmvaaAQyxL9+k9KTE5fcyQB
	d/LVhRYVtcZ1XQu8EFtRrzgfi0IlbTRmp8NLyPzNA2d8V5XuFMFGvZV0SY6X9PgD
	QBPVDj6K5GX7b//Ykz87l7X7G08OU7+voZeKAlmCsrKfxX41liJ8NQEIHHoA/5ku
	cPm5cm2FqpuuEz+D1ZkHQV579m3Nn2KfTEcumkXC89P57yvfR3QgY0sDMwF2UiyZ
	8Qd2aPSw6Ogn8SR39nfaxGIKkeBeMh34qT0wzi8F/AYq0g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QGnqC7xNcTmT; Wed,  5 Jun 2024 16:31:33 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvXz51lmjzlgMVS;
	Wed,  5 Jun 2024 16:31:28 +0000 (UTC)
Message-ID: <fee6338e-4aae-456c-90a3-228a19fae58a@acm.org>
Date: Wed, 5 Jun 2024 10:31:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-5-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240605063031.3286655-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_093141_142301_F3F9ECA3 
X-CRM114-Status: GOOD (  11.00  )
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

On 6/5/24 00:28, Christoph Hellwig wrote:
> +const char *blk_integrity_profile_name(struct blk_integrity *bi)
> +{
> +	switch (bi->csum_type) {
> +	case BLK_INTEGRITY_CSUM_IP:
> +		if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +			return "T10-DIF-TYPE1-IP";
> +		return "T10-DIF-TYPE3-IP";
> +	case BLK_INTEGRITY_CSUM_CRC:
> +		if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +			return "T10-DIF-TYPE1-CRC";
> +		return "T10-DIF-TYPE3-CRC";
> +	case BLK_INTEGRITY_CSUM_CRC64:
> +		if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +			return "EXT-DIF-TYPE1-CRC64";
> +		return "EXT-DIF-TYPE3-CRC64";
> +	default:
> +		return "nop";
> +	}
> +}

Since bi->csum_type has an enumeration type, please leave out the "default:"
and move return "nop" outside the switch statement. This will make the
compiler issue a warning if a new enumeration label would be added without
updating the above switch statement. Otherwise this patch looks good to me.

Thanks,

Bart.


