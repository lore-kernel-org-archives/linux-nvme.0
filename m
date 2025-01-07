Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875EDE77199
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJHmW27rYOPdqfqrMno1We2nyjzZF5RM86uGIWVVK+s=; b=wqnTWN1dLQsWO8ROeKOkxw5rO4
	5qpx2eX9A2qJ0a8eELcvW5uwlfHf/eNYh9x8Nv4OiButAOuur/zMSEyL/QTFO3275wDmrTsJCXSww
	qbN34tW7X2CSeIKWipAIOi579l75FPjZru5ERbP1/KbQ9r6hnLGB6N95w1Bg6JMWRSIDA9i5E6f2Y
	WwrSU1qB91A/Pb5DEkqqpxfZgqIpGLt703grL7PfTZaIThlF44+V2Jn7y7B372uzVSDADmw64wCOd
	N/tSK9saEaJeHMCcLwn3mfLgUWJ3f7mPWz515ZObC+2zYC8gaTSkWOxC8R7ueLMi6g0AOL+Cck4Sx
	ZNzWgmTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6ll-00000004KMr-3il9;
	Tue, 07 Jan 2025 10:25:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6RN-00000004Fyz-38MA
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 10:04:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2332C5C5DFE;
	Tue,  7 Jan 2025 10:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98D5C4CED6;
	Tue,  7 Jan 2025 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244241;
	bh=rUve2nznfdJENEEcSgWwkof690ekE/iRC9z9WsHpcLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PA7cDLkyurapGnj8vGoiTcWIYoZrgj2LJcNu3/RwVpCDzqg47G9i3B5XHmroIH86A
	 9FQq7oHCRHUqnNLtuhNAXn6fH54CClksh0MJz9rZNPWQepCY4i8qg9D24npcAJJwq1
	 zo0kY3f9dsGMISWf0lpMBNc6zXYCVtciwqcqPjFTGCw0D20Dg7BFOfYUwe2mOnJyVb
	 4oLrjqghFC2PVOUQLfaWwOhDBzzOJ5235u3m1hhtZBIIGcfwh8D1znoZjchZKm0JDT
	 0NY1IYQ02tN/YWPwKR9C/EzVQQMKu9HjzYWXrk5kOHWsVmZH6t+G3z3u+eEs2gW2NV
	 T8B31lFjitg6w==
Message-ID: <a3c969a5-276b-4e14-8115-765991c560ba@kernel.org>
Date: Tue, 7 Jan 2025 19:03:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix docs for freezing of queue limits updates
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_020401_831329_C7FFD2BB 
X-CRM114-Status: UNSURE (   8.27  )
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

On 1/7/25 15:30, Christoph Hellwig wrote:
> queue_limits_commit_update is the function that needs to operate on a
> frozen queue, not queue_limits_start_update.  Update the kerneldoc
> comments to reflect that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With this comment fixed as Nilay suggested, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

