Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5963AC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 00:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9h0TJl0Avk1YBZOtckTmz7fFurCrXRlcjDl1DFEfCY=; b=ZdbTfoZUpuPPLwDO3Rag2MHohh
	YJos+nNSBLaL16IF0Xbz7nXKRaEH7waKiNn1TiPhK8smX8bfFjvMxQ7nMS0mpjuXixuhJ1oJORdpy
	x75C+fksqvcrHbKmlLPlvxevER9w5lK3PAL+QEI3h4vqzBbnmkt3w8QyoRYPRrLXkP/Tm9lOah8wt
	KYLZ6EHn/FbM81rankxA8CggMWpIyLcDbCl0ImkfeYgEE4Ig4As4eFTUMnc46m60x5op1ILlZFR7d
	eOSdJpZ7jY+NhYaOV6YSuMQP1Xy7O5Xk1euTxXILleJX3ECiic2yIbAVOTo2gHzODqNSusBWHKhBq
	zlXZhCPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv4dh-0000000EcGd-0bWN;
	Fri, 12 Apr 2024 00:19:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv4dd-0000000EcG4-2xmy
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 00:19:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 574956219F;
	Fri, 12 Apr 2024 00:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627AFC072AA;
	Fri, 12 Apr 2024 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712881168;
	bh=XIw1C5UrfJZG7RekgDhJXcNJ8d9mFC4P1pP8HtXGvKE=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=ANXhkrFbziMQWEQ1uraEfPHEwqJP8AETkc3u7Bs+JkPvZrwr2UF4sFqUPI2wP+UwT
	 +KEJlXJrzwh+4EZ8kiBkoIGD0as4PEcBSnu+3zJeLosS04voma1EtWHe4t0EOtAPwA
	 RykPhXj/bmpGzhFkG8mR2Ao79QVCcAZgFzi71JhnjJ2vJXs+246lJCgBq5Imlu5b98
	 zysVsHrSVQbbK1EL4o4rHUIlTNYW6DuWxRxDvItGhJYk0Vv5+NrCyF+jHPuIgHtf9e
	 3iBb/z4yKrRjdQS2ceaFf2tn9GLkFMS+UWHkTGrhreYnEZT5LHNlU+KnQqVVpDKMYk
	 61RsqFYGpfEog==
Message-ID: <b7f17167-0312-4548-9aa8-e6b08df67f80@kernel.org>
Date: Fri, 12 Apr 2024 09:19:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/28] Zone write plugging
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240408014128.205141-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_171929_936091_2EEAA077 
X-CRM114-Status: UNSURE (   9.95  )
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

On 4/8/24 10:41, Damien Le Moal wrote:
> The patch series introduces zone write plugging (ZWP) as the new
> mechanism to control the ordering of writes to zoned block devices.
> ZWP replaces zone write locking (ZWL) which is implemented only by
> mq-deadline today. ZWP also allows emulating zone append operations
> using regular writes for zoned devices that do not natively support this
> operation (e.g. SMR HDDs). This patch series removes the scsi disk
> driver and device mapper zone append emulation to use ZWP emulation.

Jens,

If you are OK with this series, can we get it queued please ?
I have a couple more patches I would like to send on top of this and the longer
it soaks in linux-next the better I think.

-- 
Damien Le Moal
Western Digital Research


