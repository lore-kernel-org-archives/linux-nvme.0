Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE2D6B6DA
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 21:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4DMBOXHUsK1o4aXcsj1mIAeGTxICrtIEl/X4S9aMmM=; b=z6FMcbOgTmLY8BBgBjEGIx1E1k
	Wt+V6+g32dgpA3LfiGD234PDcrm9O6iGj+BETVvrdromkIbPVYwg/aGhA4TOC1IBQ92V8Hg/Ihfs/
	/o2mXvcI3KnuooxpTujgTY0EQB6OsCC46O+bgIic7kNJH7WrcSOJX0W9PeC7fwJMjlV/MbxnKu69a
	YN8QkDQdcP+eZgy1QmQDo2+mVxUy7Rxx8JVAgUBQevleWxNEMxf+tSqM3M9h3gYe04upMB5ke2Njh
	2reu0mvV8KHJ4XmA0X5E/N7exEojXe0km0Mvb1yQfUpCVgk2RD5SGgO2Trro8KVM6T8B5b6DlGL0T
	M/FQEdsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6G2l-00000001o8E-3dHj;
	Wed, 30 Oct 2024 21:15:55 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6G2j-00000001o78-0qss
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 21:15:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xf0KN5GvpzlgMW3;
	Wed, 30 Oct 2024 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730322949; x=1732914950; bh=b4DMBOXHUsK1o4aXcsj1mIAe
	GTxICrtIEl/X4S9aMmM=; b=zox8MNWgMID5qKcjZdijr0DcLrVbE5phS46vpu24
	wrFxrcFoUCjZa2CDHmNRcfuOEvopYpTxUde44SD4j7i5fjKckz2WLPCYhxf96jYt
	uEs30sP8COFtc0ARm32FHRAGZeHmslxs5iW3+2aJs8fTPL+mwdS5ROGgpDsgkYyd
	flVIYEV1A1/kLmVGL2GYC/9Ur4dqBcVHn3gxyPdUjiuWDdGFwRC48zT8oShGWppD
	F7f2l73E52JY4WcXgOKj5lpGAOglQ4k/2+r8uABoqeE8J4/GNyUQvcDI1a2UXZOh
	iQnyofz45pN9aPpmgSsxjLqATqaSJ0eCNuHT6JgMPgawEQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Khb2TIHA1NgX; Wed, 30 Oct 2024 21:15:49 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:dff5:f005:4483:ce42] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xf0KH031BzlgMVx;
	Wed, 30 Oct 2024 21:15:46 +0000 (UTC)
Message-ID: <4ee729b7-a3c5-493c-bcda-feb3e9aab5ff@acm.org>
Date: Wed, 30 Oct 2024 14:15:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, javier.gonz@samsung.com
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-5-kbusch@meta.com>
 <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
 <20241030044658.GA32344@lst.de>
 <ZyKTACiLUsCEcJ-R@kbusch-mbp.dhcp.thefacebook.com>
 <7f63ba9b-856b-4ca5-b864-de1b8f87d658@acm.org>
 <ZyKY_xdxcM2aSMow@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZyKY_xdxcM2aSMow@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_141553_295211_7F8A3A18 
X-CRM114-Status: UNSURE (   7.91  )
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

On 10/30/24 1:37 PM, Keith Busch wrote:
> But if by "not atomic", if you're just saying we need a barrier on the
> bitmap_copy, like smp_mb__after_atomic(), then yeah, I see that's
> probably appropriate here.

smp_mb__after_atomic() follows atomic operations. bitmap_copy() does not
use any kind of atomic operation.

I'm wondering whether introducing a variant of bitmap_copy() that uses
WRITE_ONCE() or smp_store_release() would be appropriate.

Thanks,

Bart.



