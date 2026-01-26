Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE53E63C8C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sUDiUui7nwnan6OsV5OPA/bfEo5yOkkUlqV1T5qFDis=; b=ABX0om9Ix1J6n+wP/Cys13wuQO
	cEn+wwkjAQGYNd0FonlMHNoVrmEnIhX7lhmHKte9c0ECCCf2sKTXRQDGtAvTB2ayag0JockqntCpF
	UOaupMQRlySgVTIuru2DiVo40b2bcixUt9NGuWDoENEQ7hrh3o5wc/6Ilr4BCc1iVlrr8qxOfr3G0
	PFg9e8S835JPXoL+0gDhB7oyhj4zqfFxY4rHQWVCJOqRs5wp93Z1B5fJVvmfPVi882eFVY3xjkj2W
	1q8kv7CMl8Yj7m68DJYYgpXf/xkpr5YjMvuRB5VvdzTzqCY2Y5/l/2u987V7NuATefKGbfsNyn2+d
	suEpROPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkM8f-0000000Ca3d-3Af0;
	Mon, 26 Jan 2026 12:56:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkM8c-0000000Ca3C-0f97
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 12:56:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F665227AAE; Mon, 26 Jan 2026 13:56:06 +0100 (CET)
Date: Mon, 26 Jan 2026 13:56:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20260126125606.GC28035@lst.de>
References: <aG7fArgdSWIjXcp9@kbusch-mbp> <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com> <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com> <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com> <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com> <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com> <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com> <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com> <fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com> <c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_045614_367249_BAB50FFE 
X-CRM114-Status: GOOD (  15.59  )
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

On Thu, Jan 22, 2026 at 10:16:53AM +0000, John Garry wrote:
>> - Recommending other vendors adopt the same reporting model, and
>> - As it was already proposed earlier, updating the Linux NVMe kernel driver to disregard
>>    atomic write support for devices that report a non-zero AWUPF at the controller level.
>
> Yeah, we can just stop using AWUPF always. Or can further consider my 
> proposed change to allow AWUPF to be used based on an opt-in, below.
>
> Keith, Christoph, Any further thoughts on this?
>
> https://lore.kernel.org/linux-nvme/20250820150220.1923826-1-john.g.garry@oracle.com/

I'd love to drop support for the controller-level AWUPF.


