Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105E0C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zYl4LS3T10+mH2eMvuncSlyObsGJiGiQzZLsqGZMz0=; b=jFAlRTPoJ7rNPsLTr8ma3Xbr0R
	rWwsrjICZ79xceEhHCjEY/SKjqR1fkrO0N4GC+iIJVHc9LxFA5ye2qq76a9SVUkZUNmNV7qA1UThn
	hVQhWA0qIT1DcYV4QRlPVsik70PN+k1r85RWt8A8Bd71PZX32DsS+jEgua4tUwOz6ZNSXmS29C1GG
	QWdDZQ7BWOSvpr9kt71T566hwAXgsTCCb6XaWmdEJLENe5ebGSW/lorys90KLgFEIDsDi1ZnNONk3
	xplUun6jghLmU70AmB7MIliwgOyVnt5aXs78tTVWh9KUIPvnMs2Cs7ckp0Wd4tE5MULywASysdKYD
	91BKujZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAPWN-006T6e-2E;
	Tue, 05 Dec 2023 07:07:07 +0000
Received: from mail-m127159.xmail.ntesmail.com ([115.236.127.159])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAPWJ-006T5P-36
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 07:07:05 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by mail-m3161.qiye.163.com (Hmail) with ESMTPA id 2CB79440395;
	Tue,  5 Dec 2023 15:06:28 +0800 (CST)
Message-ID: <8d53e40d-a725-4fb4-805e-1d1e009f83c4@easystack.cn>
Date: Tue, 5 Dec 2023 15:06:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <ZW6yskpdzy8uAp3u@kbusch-mbp>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <ZW6yskpdzy8uAp3u@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkseVkwaGkhOQh9MT0hOGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8c38ccb37800a1kurm2cb79440395
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006SBw6NzE6ThwwPBIyFDAw
	OBhPCShVSlVKTEtKTE5CQkNCS0NCVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFITk9DNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_230704_197048_10EDE670 
X-CRM114-Status: GOOD (  17.22  )
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

As far as I know, according to current implementation of function 
nvmet_parse_io_cmd() in drivers/nvme/target/core.c, nvmet_req_find_ns() 
is called before nvmet_check_ana_state(), so I believe currently nvmet 
is returning NVME_SC_INVALID_NS once namespace is disabled no matter if 
ANA is supported. In nvmet, a disabled namespace acts like it does not 
exist. nvmet_check_ana_state() requires req->ns, which is assigned in 
nvmet_req_find_ns(). If namespace is unknown, nvmet can't know the state 
of its ana group either.

So, to be better up to the specification, nvmet does need to 
differentiate a namespace is disabled or non-existent?

Moreover, even if nvmet returns NVME_SC_INVALID_FIELD to the host, the 
status code is still translated to BLK_STS_NOTSUPP, multipath won't 
retry either...


在 2023/12/5 13:18, Keith Busch 写道:
> On Tue, Dec 05, 2023 at 05:40:35AM +0100, Christoph Hellwig wrote:
>> On Mon, Dec 04, 2023 at 09:37:56PM -0700, Keith Busch wrote:
>>> So the controller through that path used to be able to access the
>>> Namespace, then suddenly lost ability to do so, but some other path can
>>> still access it if we retry on a failover/alternate path? I think your
>>> target is returning the wrong error code. It should be SCT/SC 303h,
>>> Asymmetric Access Persistent Loss (NVME_SC_ANA_TRANSITION), for what
>>> you're describing.
>> Yes, assuming ANA is actually supported by the controllers..
> Even without ANA, "Invalid Namespace" is still the wrong status code
> when dynamic namespace attachement is supported. If the namespace still
> exists in the subsystem but not attached to the controller processing a
> command (i.e. "inactive"), the return needs be Invalid Field in Command:
>
>    Specifying an inactive namespace identifier (refer to section 3.2.1.4)
>    in a command that uses the namespace identifier shall cause the
>    controller to abort the command with a status code of Invalid Field in
>    Command
>

