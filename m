Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C8CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yo6BT+3P2il8yzbLTAdtUbKTczGcaWZFFDMleggcyvs=; b=4t01R2Hohymf30x7LUeoV+LBkl
	aWv9u2x9e1OZBNnfyQ2mGsUOlULVCAkkoJd1Anm+EZK5K5SSOT0qf3rzZhO/TGMtp6ltI4f6NoVgf
	R9ns+Ca9IpvU20nhS7sUpsFf4a6JGF4+uQaDhfy9bkG0Qx017TMFjz0f1Huw2/aXHO+1y3GvKG5Nx
	Pkw41jDPO2r1M7HOk0Zc63gY5pSlQe5/ULT0Q2afYwlodbEvlrblKpkyMQLTdrQCPSzUL8qsLFH/u
	PvBxThV/uS7B+QDHUirWy1W3ch61Uifi01No/vkbPuyGUtNETXey8GBw48aHgCc2DpVDeHe0+De4g
	jsrNoqFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbPFG-00FjI4-GN; Mon, 04 Apr 2022 16:07:58 +0000
Received: from marcansoft.com ([2a01:298:fe:f::2] helo=mail.marcansoft.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbPCj-00Fhqr-Ay; Mon, 04 Apr 2022 16:05:23 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 8A62D41F28;
 Mon,  4 Apr 2022 16:05:11 +0000 (UTC)
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
 <20220404155924.GA9764@lst.de>
From: Hector Martin <marcan@marcan.st>
Message-ID: <216d4bde-9463-a7c7-7d0a-57ea157aa280@marcan.st>
Date: Tue, 5 Apr 2022 01:05:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220404155924.GA9764@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_090521_565304_BE38CA4F 
X-CRM114-Status: GOOD (  14.65  )
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

On 05/04/2022 00.59, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
>> The kernel hard limit is 100-character lines, not 80-character lines.
>> Maintainers for existing drivers are certainly free to stick to 80 chars
>> if they like it that way, but I don't see why we should still be
>> enforcing that for new code. See bdc48fa11e46.
> 
> Because 100 is completely utterly unreadable if is not for individual
> lines like strings, and that is actually how Linus stated it in CodingStyle.
> 
> Your code as-is is completely unreadable and will not go into
> drivers/nvme/ in that form.

That line is 81 characters. I'm sure Sven doesn't mind fixing it, but
"your code as-is is completely unreadable" seems uncalled for here, and
rather unreasonable.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

