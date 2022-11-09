Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5C9C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7eZkGD8fHfM5VNtBf1hWt98tpjxxJV04aFIAPwU6cs=; b=CE4ZBcKopenTDLxEMSxy/w8DUh
	zSrZ06Sx66IUl3eXkykCuIzxjn7GlBZSyu8FWVpZHNZWM3qHlItDZU2gTYHPZv7m8dydyPdsC8Gu6
	YDOimzrx4VY8UezzidsLGqWN4GZXShtWyMGG2Mwwyqgm1KslYnAMZ49zn9/6ZEuG3rAlSVWNHousp
	AOtHSHWnQtR+4g9U7xStsVWizHSi9EutDpptYXrqBdd8Dk2n10bZD6HHtkbjhiRzzZxCMBbmHPQK5
	KufYLB6uPv110v5nmLhZsaQnnujssFeI32xXzKJvspsNZ3Y+eG280wgZQtnoQdOUAbstY+eC3+4K2
	FmzMMIdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osea6-00BAWE-Dq; Wed, 09 Nov 2022 06:29:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseZr-00BASX-4a; Wed, 09 Nov 2022 06:28:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7557C68AFE; Wed,  9 Nov 2022 07:28:44 +0100 (CET)
Date: Wed, 9 Nov 2022 07:28:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 07/12] nvme-pci: factor out a nvme_pci_alloc_ctrl helper
Message-ID: <20221109062844.GF10528@lst.de>
References: <20221108150252.2123727-1-hch@lst.de> <20221108150252.2123727-8-hch@lst.de> <b3cea6d6-f76e-8295-3537-a5b125b74bf4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3cea6d6-f76e-8295-3537-a5b125b74bf4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_222847_345116_1725E289 
X-CRM114-Status: GOOD (  11.67  )
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

On Wed, Nov 09, 2022 at 05:03:19AM +0200, Sagi Grimberg wrote:
>>   -static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id 
>> *id)
>> +static struct nvme_dev *nvme_pci_alloc_ctrl(struct pci_dev *pdev,
>> +		const struct pci_device_id *id)
>
> kinda weird that nvme_pci_alloc_ctrl return struct nvme_dev. Patch looks
> fine though...

We can call it alloc_dev instead.  But that whole nvme_dev naming is weird,
it really should be nvme_pci_ctrl.

