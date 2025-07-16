Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CD8C83F1B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/5V5UaJq3dUpAXahwLqyVbFHMK4RRiObrv1kmUFlFA=; b=NIJmWE/6it73MNOh+n5/Gffxjy
	JzbdMJKo3XqSrCKne3QLjfmyNWjhaGMm1tfto2rX4cCMD4H+2azFGblrvkpGKGZ4DeUU+ah+kkxdF
	by9BMzECGUoo2cj24+aDxVazvyOUUruoNzNn84/yDuIG0pKqGEDX0h3+Q3e7d22/YFvvXQ+TJtN86
	IARIg39BXlvdsBdjyxTr7b94CZiMhLoYX1FZjDcnghu/P+rjAlmroBsGcn2wwsFux/gOiTLkjiUGs
	4mi0m/YqzbyUi/LZ2yvLzhHvtXdKj7akifBaMESJVl9ACcNQropvh7HX4lmCn4yBUTsUekC132ddH
	2s2Nn/4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucApP-00000008oO6-0Urw;
	Wed, 16 Jul 2025 22:42:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucApM-00000008oNl-3EsK
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 22:42:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 170DB5C0721;
	Wed, 16 Jul 2025 22:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDF8C4CEE7;
	Wed, 16 Jul 2025 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752705735;
	bh=BDU0QwTkYYYml9+wrEWCNYH/PF64qV4ohna/oUUOVPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wtd610Ub7xDxqlPgIABnXwl8AZ/X7mBkpugWp9h0NbAETlokzYYM07xSKyg0ss/F5
	 uB+KAfi/wTOFiJqS9ZAHkL0uyKZzZV+DJ1ihkv0BF8AANuyNexf71HmJ+jImZ53hKs
	 TqYi9ebap+ZnZMi4yf3vmAoNhtEeBl0e3FwjsYtk8+9YC1XqACY8CTIosupZihv42g
	 n9UIQ83DIT1h+JGz+I/MjhPlEVF6OTXeO09pNBI4ERBlVle6Kw/XLqnTpjQ88FOnKG
	 mBtC5CNWk2htlR1nBCD5rZPU0MKYydpkpTcMyTyD/xHR+fmimq6fmc+m29SMlFsKqa
	 aQ+7Qy4y1/Xng==
Message-ID: <fee4f767-301b-4650-8607-28fce17924ad@kernel.org>
Date: Thu, 17 Jul 2025 07:42:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: "rick.wertenbroek@heig-vd.ch" <rick.wertenbroek@heig-vd.ch>,
 "alberto.dassatti@heig-vd.ch" <alberto.dassatti@heig-vd.ch>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
 <20250716111503.26054-2-rick.wertenbroek@gmail.com>
 <ba009e79-e82a-478d-bf2b-52b964141c11@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ba009e79-e82a-478d-bf2b-52b964141c11@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_154216_855962_9531E0A7 
X-CRM114-Status: UNSURE (   8.70  )
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

On 7/17/25 06:56, Chaitanya Kulkarni wrote:
> Good catch, looks good, I wish we have tests for this part of target
> to it will get tested on regular basis, not the requirement, just
> a thought.

qemu does not have a PCI endpoint capable controller device and you cannot link
2 VMs to communicate over PCIe (one VM as host the other as endpoint). So unless
you get a PCIe-endpoint capable board, you cannot run this driver easily.

We can add a blktest case for sending an unsupported command though. That is
easy to do. But FYI, right now, running blktest/nvme group against a pci-epf
device, we get a hang... Shin'ichiro is looking into that.

-- 
Damien Le Moal
Western Digital Research

