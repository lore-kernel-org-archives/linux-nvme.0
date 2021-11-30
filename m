Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4183AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBxj5FD0ymdk21R+gzq5TJJArcWyNbE3Sp1lSKgwnps=; b=bpvtCvv3qEQT2YsY3dvKvRRvYG
	zSVXFQ5fkfmLojbfeYyuZd6d+e/OaAswtxc5oP1S7udpbD5pzZ3a1wWZ+z9Nl/u0gvkgf53W9aLIC
	sn2L25pwBXWh/8zu7eo0NPHJs+BM6F9+tr0T51/4U5CRDEmF68RRq9SvEJCNiKVI7i1zV1a06gOoV
	FuMw5O2HDfRQOTV9MG6BXrEv101R8xQMbgIU/mfSiPUREky8GJRvrHM3TUbSySJ6wGJHhI+iWcyr3
	A/pWSpjHsvMq1FD7G9cYcGXk6Z1JsOnUCasHniRrckIVghLrakbgET+LdLI+2N88mcFXvKdbYFWs6
	gadhBWfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrwp4-003p7c-7C; Tue, 30 Nov 2021 06:41:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrwp1-003p6e-GM
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 06:41:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A668568B05; Tue, 30 Nov 2021 07:40:54 +0100 (CET)
Date: Tue, 30 Nov 2021 07:40:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: luanshi <zhangliguang@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
Message-ID: <20211130064054.GB10268@lst.de>
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
 <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
 <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_224059_722888_34378726 
X-CRM114-Status: GOOD (  17.62  )
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

On Tue, Nov 30, 2021 at 01:04:55PM +0800, luanshi wrote:
> Hi Keith,
>
> 在 2021/11/30 0:34, Keith Busch 写道:
>> On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
>>> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>>>     	lockdep_assert_held(&nvme_subsystems_lock);
>>>   +	if (strncmp(subsysnqn, "nqn.", 4))
>>> +		return NULL;
>> This seems like an arbitrary way to decide not to check for duplicates.
>> Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
>> broken controllers?
>
> Yeah, add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk is a way to resolve the 
> problem. I do not
>
> have enough controller in my hand, I don't make sure all the controller are 
> covered. And there are some

What does this broken device report in the subnqn field?

