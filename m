Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88734C27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbeMU3HXyh3KgvxlW1b0chGKtCCVDfkoycQDGmv9s9Q=; b=dgcMVAu6e6FKZgdwGxRCGdpZEH
	ELcTrsQ2bblKHicwT+kycpQTMG9IHobtsG5JxfVaFklo5jMFnEt39iEz53zrKlvlqkr7WtoJUudZK
	ho3ZzbBInX/PXgj7us1wtH36STZSx2RoEPzXhzodLaysV123IK0hKDAxDSuRON8SAs4rt9v0cPHZx
	H6LMdkAEeTy8QWdmA+WFbjS3CqLEQA3F6QerwoImkLJX6kG5nlNahh0ExqQoxKbLT5aW4vLAlpNiz
	Ub1rsIWkU6RMqssQoI3gWufLxGgDCdCqr9tKbbjLCd2/nBuvAaqXR07DwR0rTbS6UR6JFM+27sOXg
	JwBTJK3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtJH-00000006oaM-3LkF;
	Wed, 05 Jun 2024 16:16:23 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtJE-00000006oXm-0uT3
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 16:16:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvXdV0zfRzlgMVV;
	Wed,  5 Jun 2024 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717604169; x=1720196170; bh=rbeMU3HXyh3KgvxlW1b0chGK
	tCCVDfkoycQDGmv9s9Q=; b=B1G+9Q4rI3c7YMkVyZKJdrogq5ItO3Khy4C+pnto
	5ieTc77UgyBluAbOyoPxkuZKvMw+AhgVksavepsbUGSHMAIkDrBrnu0oEsEulHF2
	X3E+8NtQEH1xWdL0EIFg0hYp6oubnCPIKKtmI2ROjXa8FS1kYtjVW/3DBmi/6cmp
	wO6E/ldd/jvisjCD5r3Dw9MM3SX6EZoH2CFJqmNKHuYQtzUS/1iOAzgZl5aqSuMB
	006MiAZo2nC5eTSldFvzB54+DmJcvZyOmilAjEpsWuoMRIAYHwlcOEWh2T01uUyg
	15b+Ir2Fs3K5vtzJOtIie7akvVS8mfhGgjf/MBxhfZMnbQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aL7ltNKIChlW; Wed,  5 Jun 2024 16:16:09 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvXdK1zbMzlgMVS;
	Wed,  5 Jun 2024 16:16:04 +0000 (UTC)
Message-ID: <c717ce88-9c3d-4992-a24b-8f6c9db4fbed@acm.org>
Date: Wed, 5 Jun 2024 10:16:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] block: remove the unused BIP_{CTRL,DISK}_NOCHECK
 flags
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
 <20240605063031.3286655-3-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240605063031.3286655-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_091620_405320_713F8FA0 
X-CRM114-Status: UNSURE (   6.77  )
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

On 6/5/24 00:28, Christoph Hellwig wrote:
> Both flags are only checked, but never set.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

