Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F79FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orYLV74myWaoCuFdxuG+YIOSQi/jLHDnNv5ILovKS84=; b=1ORS28x1lCTP4vjFn1YCGQWtXQ
	TMArmP6qJy7BQgIWFec0i+Q3Hd6C6LOBXPbwRFlVqeHU0nf5BPDX/Z08YZtH1hgHnX+Mu2yvSospx
	p2gFIY4tzGEUD1SPn+MfCiAb9ZUx9KKtETFlWfR5b/UYmd9Ajn7b0oYEMinwNArkIefCLt+nDWrMJ
	6g0cXR6Y3H7rO9hD/2tucbCENggIEWrEqfC4RfGfvHXkrRAxgHfdCt7jqv/7YDYpJoiYefGdWqaxi
	EzNh7Gqaao/H0uEH0kiD5sa9mXLL+wCAMATsxiFmUICPeWodX/fvesZBLUssJDyY5tay8FwoTgoac
	y80cVueg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHj62-00Acrx-21;
	Mon, 25 Dec 2023 11:26:10 +0000
Received: from mail-m12829.netease.com ([103.209.128.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHj5y-00Acps-2z
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 11:26:08 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9B6634C02DD;
	Mon, 25 Dec 2023 19:25:26 +0800 (CST)
Message-ID: <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
Date: Mon, 25 Dec 2023 19:25:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHklOVhpKSE0aGUlCQ0pIQlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSkxKT05PVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ca0b8fca3022ekunm9b6634c02dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQw6DRw*Dzc6IS5CCwM*IgMw
	P1EwC0hVSlVKTEtITktITklMTU5JVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFKTUNDNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_032607_194545_C34AFD72 
X-CRM114-Status: UNSURE (   3.61  )
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

hi all,

any updates about this case?

thanks


