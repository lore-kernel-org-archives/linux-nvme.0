Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3470CC6B19
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HwNY1rgM6q4Ctj/+3tD0gRogjIimRT6p7jVBUT2kqPk=; b=KQuzeusqkXi8lA2wjSbgHY0rIP
	A/7bhAd+8RoXmRQgNZwWKwiL4wZffUv4RQNkL/hdfiuWfsr54zsErKF7ImZkgZXLTAdQDzE7lQzGC
	AfZ49Qut6tVE1M+ctRP5mtHYE+sOsU+Ib8EQjwGYYkLHwGMheqZ/u8KXeOh94GqC14EdUrX4XTmbs
	t+AEqRIj/a9n/05WHkSQ4Xv6AQH4jS4i+WB069kTB5evMXtF8T/3jJQaFuf+dF6JAieCrrOnQj/S8
	jfCsNpifkLdkhQ3PHy3iLn+delZ9FI0JCye4a7d+1drE3gEbP6ub6v8wUjE4bH35YrdfKMIeOPKQ6
	KPgH00JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeBA-0000000DEN3-30oy;
	Tue, 13 Oct 2026 15:12:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeAv-0000000DELS-0RLJ
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:12:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D6F160A59;
	Tue, 13 Oct 2026 15:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511BC1F00898;
	Tue, 13 Oct 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904340;
	bh=HwNY1rgM6q4Ctj/+3tD0gRogjIimRT6p7jVBUT2kqPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XUYw4GGNTknWnm65i6mHq+XLq9CcfwRdNYS+uR0S6mPSBSBLfdwVmzXO8EiGiPfxT
	 6JJJ8/AdSVzOEvFRwgN8EAb9ag9sKNgcb+WWfUKYL+1UCcmoEUVqhd5huncqDVVdbi
	 qeDUhKZnj+MXP5OfWjtyxYc7Nd5hMzmLy0aIDKZFkyry86AMIZ/5XYIpClsnQSwmvi
	 HsI/LEP6Ysr8va2NNnSuqMPSVRsb68bLrkcAEFGkrgi9fl7qEUcpGeE9u6wSHLvAYF
	 Cx5/Q5qDlMsJiy8/jvk0q6r4WNpJoXqIOHEWYvqOqw7F678UilyZa9NhOuAVi98d/O
	 M2B4UCPriv3hA==
Message-ID: <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
Date: Tue, 13 Oct 2026 17:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command
 completions
To: Christoph Hellwig <hch@lst.de>, Andrea Parri <parri.andrea@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-5-parri.andrea@gmail.com>
 <20261013142736.GE14759@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261013142736.GE14759@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2026/10/13 16:27, Christoph Hellwig wrote:
> I think this looks good.  Damien/Niklas, can you test this on hardware?

I do not have the hardware available right now. Niklas ? Can you test this?

-- 
Damien Le Moal
Western Digital Research

