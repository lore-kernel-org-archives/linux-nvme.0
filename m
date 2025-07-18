Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE17EC83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 04:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9vrmDwC7GSP/HjwfL8hCun60jTbZ7dfzJqbKNj2D+M=; b=DmjrN80E7MdAkz5IdDr24L4Jfk
	TLGvUV+tTK7KqN0gqYHU4sLrv6HaPMcD27Qsqg1ma9qyKBgUbSdHmWDotoPCyniRb6/3bUOiyCrag
	lgyEzA9plJ00OkdA5fl9yVDH+sj92Uva4Qy3zrCF1XU7EZyHclaODkhqb2dCayTSXr7V7K5iOuvUk
	ezq9EDGy0r1jvZgiM0J52eCo4ieruUW1WgdfKp244vl8OvSY+yr078YNToV5Sl6qTZdhZapGGXvoS
	HdGnKJVmuqtWfw/SQjeAjeQQYKbSM6G7p/crb0Yw0RdJTx98ZZRHlBuy6YzkCQebBKNPfgEgPRTpP
	QBQYt35g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uccXf-0000000BeXI-1bAk;
	Fri, 18 Jul 2025 04:17:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uccXc-0000000BeW5-3EEI
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 04:17:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2D2025C5600;
	Fri, 18 Jul 2025 04:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD53C4CEED;
	Fri, 18 Jul 2025 04:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752812267;
	bh=LOklqSzGHoQD0d7uT40vyIYyMJHO3OMdOsB29FK9GbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lnJdt8bBIYjq0rWnPqDQzRXiXVd40nRloAeNETT83Tm7l4WS3RaFOtPhVv7ra4xOa
	 B/tNKa69+dvAGsT5ves1g2w2qU7QGP3b4vA4SbNBr4JMLkhSQzYjXTsdNwCsn1Qjl7
	 W+YHTyTVTaBelUMyiFkKYWYPE2mQ3RNyTkVPo/hKNjUBvoPmmKjORYB+1qnP2Ol6nJ
	 Mg7S9pBeGzqEPyg0fHQpz2JS/beMSeJarN75mQo/oqPTGY6TLhHHWeYdwlipWX1JN7
	 2wq6cwubagcA2FRr4Xas++IFqtQw+XDkhjt1+/wpD76D1b2LHgcZIdYm2RBkOiK0xU
	 Fz1Uh/UA4U8cg==
Message-ID: <f80ffee3-60aa-46d6-bd1c-7240ad171ee4@kernel.org>
Date: Fri, 18 Jul 2025 13:17:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_211748_850612_9336A618 
X-CRM114-Status: UNSURE (   7.62  )
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

On 2025/07/18 9:14, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.
> 
> In the future when support for LID=0 (supported log pages) is added,
> GLP accesses can be made smarter by basing such calls on response
> from LID=0 reads.
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

