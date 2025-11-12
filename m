Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1346ACCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xuLJZJ0srJr0qohbWisjbQ6zTqQW4JQo+1GwbmOw6s0=; b=UYflGJdePKJcoEnWI9S/3Yh6vp
	PceZujJTZPhtRUBYeX+ulz+4EV8ciXd7msPV1Itw+XQCIko/wR0qcnGvlQT5VGnAg2uUbYn0vuqfz
	jfTLCKXFpKcjOxVZlqrm1hmYveZKVkodKtb5OyD8wciDo6xJJHWqtJn5nBdYnXMN24uqcY6guXxcp
	vWhBU85TtciZnC/vIiQpZRKSIBgy150ibD/wXzJ/crm0puFj9DT+cUSr5ZLtbn7kha+RMc2AcSLIa
	v4p6hgoyw76CTuoO3HMWerD9FS/kZVqeWL6LxiNzFhsvxC94eruzUDFxejlJCbQmXifhVk4Dm/yS7
	pVHIY6zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4sh-00000008FVg-3qT4;
	Wed, 12 Nov 2025 07:03:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4sg-00000008FV3-0xuP
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 07:03:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E2F5227A88; Wed, 12 Nov 2025 08:02:58 +0100 (CET)
Date: Wed, 12 Nov 2025 08:02:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251112070256.GA5276@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de> <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_230302_409204_E2F0BC51 
X-CRM114-Status: GOOD (  14.49  )
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

On Wed, Nov 12, 2025 at 09:32:00AM +1000, Alistair Francis wrote:
> > I would suggest just allow writes to the 'tls_key' attribute; any
> > writes to that would trigger a replacepsk operation.
> 
> I think the `tls_configured_key` is actually the better attribute to
> write to as that is the one that updates after a REPLACETLSPSK
> operation, see v2 patches which I'm sending now.

Just saw Hannes reply here and saw why you did the current version
the way I did.  Hannes, please don't recommend weird ABIs that
make error checking and future extensibility impossible.


