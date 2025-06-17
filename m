Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A007BC71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WN1R5VfiWGCKUV0AAkhpEOMhRr090TnaklLFKdhfw6E=; b=IuTwH2YSN56L71
	VTqF/cjUaEu4AxRqmjy3WBgusVEuN4wFqWJLsJ9GWC8/XZfYEVcEcmBqLJHVmixRdqm5PP9s9KFn2
	2jHQVM16E+6oLruV9cYJ0xUtvCoxyiT6tf6+uniVVIB5xM8eVfNex0YEcTaQLymniSVy8dpkgrlic
	VBLQ824n6q2TS4x9IOyQE9E7OvIuQWRmh0fGzKFL4dIGrPK0Uj9AKI1yJleOCA0rNwoH6/qMggx+q
	AsydQn9W7vhnpOChaxiLiJCSNDVThDW+aukktt/CdY7yAF9Gd77U3a0tGYqlRa78duy8s9UUySrZa
	uzdEoB0RgNTG2jDmPGvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaC1-000000083go-2HLE;
	Tue, 17 Jun 2025 17:33:53 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaBz-000000083gS-3qnI
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 17:33:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8A624A51999;
	Tue, 17 Jun 2025 17:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F0C4CEE3;
	Tue, 17 Jun 2025 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750181630;
	bh=Zp21o8ResSkQXCqervR5Dp0pKb5AqFj/c5jJefTfVOk=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IVR+pYe+nAtQrorraWGMsmGCwN3EmEtpyU5blxkJwzQ9qmnLnlGJOPEe7lthmh6eY
	 bHN1omymjyDtrxoaOvvRjtl29KhL48hkB9KmKEFRptZHZkV/YbzJpZaH87+aelD7Pm
	 pdoywMvk4TCZY1cxE5Z2zic71JOKu2XZVUIFIDfirggYH2F73gwvKOWta9Efq8xg3d
	 g+yiaiYIYE1TFxp10i2uJ7kEkLeOveY3yfd5Slny2//LUyHB/jYaGj8dUKkvanOUak
	 s89bKrGDEPCiBwtAgdHRIcBP37DiXp+UidTvi5+PzUaM5CA8oSxVQw4k3md8uW/5Z8
	 0b7vQ5t9iaVNQ==
Message-ID: <500dedd7-4e66-49d2-8c63-91d6a07f2e43@kernel.org>
Date: Tue, 17 Jun 2025 19:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
 <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
 <20250612050256.GH12863@lst.de>
 <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
 <20250616113355.GA21945@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616113355.GA21945@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_103352_023356_E199A0C2 
X-CRM114-Status: GOOD (  12.56  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 16/06/2025 13.33, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 09:41:15AM +0200, Daniel Gomez wrote:
>> Also, if host segments are between 4k and 16k, PRPs would be able to support it
>> but this limit prevents that use case. I guess the question is if you see any
>> blocker to enable this path?
> 
> Well, if you think it's worth it give it a spin on a wide variety of
> hardware.

I'm not sure if I understand this. Can you clarify why hardware evaluation would
be required? What exactly?

