Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E375BC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXzapRBF0XP9dqhOwn1urD+qb34Omrr0zBsGvVTpYtU=; b=eTIhYcZojMuDTOn9KBm+XYLFx5
	n9iHZGfdv2VB+9sDkCuwUHYg12EjdHgrLNE4Ud1HcDsm2fCnBFZqUyN6tnKRpL8wCfMVJ4HFVpQSF
	kcr6G/5/6Qdyi45oMqhabmeogyNaGT13UpOX0BNaPBGmVXIqKCOAjZwy0S75N1gdxFhVZ3v0JsqOf
	mOO2jJvQAOxYTse+HVuOpxXG+++EJgtD+z3ZtS5pVOb1UgmGjtwrWcumMKFdsdT1N2MBUU1KQ02yo
	iU9176B7EUGCqGG8+t/a9kKAiei38Y0QHphwwxss/+5uVzGGxhIuDYC4f63xJjliaMzhwTptyBds2
	onOOfhNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFAHs-009jBa-0d;
	Mon, 18 Dec 2023 09:51:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFAHp-009jB6-26
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 09:51:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4E663CE0FD5;
	Mon, 18 Dec 2023 09:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF6C433C8;
	Mon, 18 Dec 2023 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702893102;
	bh=0ltLchd8OdyqGdbUKNCnj2CSZ8BI8m8JXNh7/DpT4q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BxCsjQnuJnhh0O1R4P1jparwYYvwuJzUuts6R9qqR4wY0ZeR5eIdS4bVLOC3EMYJJ
	 BoNRgH9yCu1zFqd3LLzgK0zPtMOLNLbFZHNMmde2Pk9uWDlZcyYUwWCoGkWamIj7z+
	 6rpUoxGi/7Dezk78J9tb+fqCtwrVgkcgKlv4uAYpoF3EewrSfEDGhTfzhUFIDrJCpj
	 /rkjWbHMaVlrNZ0o5NVjhXyj6Av1WNDiETUSkftHjyCb/1JHmJmwomRMHYhW23/dPF
	 a6basN5WJgoh0KWx5ED+pMlx2XZ+osDMzmdwFSeSiaUlHW4oCGvwgJVT6ls7VRD6tS
	 +zPJRqAvMhajw==
Message-ID: <572219b1-c528-475f-9219-8027a3790563@kernel.org>
Date: Mon, 18 Dec 2023 18:51:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sd: only call disk_clear_zoned when needed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_015145_860441_70882D59 
X-CRM114-Status: UNSURE (   8.90  )
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

On 2023/12/18 1:53, Christoph Hellwig wrote:
> disk_clear_zoned only needs to be called when a device reported zone
> managed mode first and we clear it.  Add a check so that disk_clear_zoned
> isn't called on devices that were never zoned.
> 
> This avoids a fairly expensive queue freezing when revalidating
> conventional devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


