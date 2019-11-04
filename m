Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110B0CA9EB5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 15:32:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B4720848
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 15:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eY79YOYD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vnh43AVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B4720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jzUfq0rb8YgwDDomch1hboZidiuGr/qP/WIWCwRI9+s=; b=eY79YOYDjM9H7b
	vmpxnJRJ2KWwwGi757uBXYJ01KWX6rM6AkP7xKf9AlHONM/RzR1rkxHNBvwCwHf/AuZpR/7MnfyWK
	UzwRZey8LnxMySr6Jq/j86RptbkI5hX+Hi7RJVF/nAqJ2nyxhsELV+XeOoXnENr/hW+jjsTqsGoNj
	gzLUQDYvBwIg/YmxwopZkMEBwu/YAQupjPwAXrBmKyM2TLMsNpoFn7oQlG/i6m5+Fy9Ol3c03afD7
	3cad9O6ZlgVTDEFGjEfQiXVmnuf4M/B0Z3RejDzlQbUHPZZl+i1QeoiUAkkgw4Qaw8COtkewly/zc
	FAw1SKYZGL0wRc5mW9iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iReLf-0004e1-Fa; Mon, 04 Nov 2019 15:32:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iReLc-0004dQ-Du
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 15:32:53 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 25ECA2080F;
 Mon,  4 Nov 2019 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572881572;
 bh=hkH19nt9y9SaoU01HpS8NIZ2H9MH31Bv8tkTZlbHbPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vnh43AVaBsx8AFEejZriwjhRYdnEBMbh/bTK006mZot0xb4E9wL9Q+f4lkCkrtm1A
 e/D7jsxdk6Y35R06u9L7Bj1MaJ7nmJnHoAqnDfy7mqDJDQMJVVEbgu1NQ/bZjuqJuo
 CcTT7LmzbL4GHAXUPztm64W6v9UEFwHpjg/TCRn4=
Date: Tue, 5 Nov 2019 00:32:49 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191104153249.GC26808@redsun51.ssa.fujisawa.hgst.com>
References: <20191031050338.12700-1-csm10495@gmail.com>
 <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
 <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
 <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
 <20191104150151.GA26808@redsun51.ssa.fujisawa.hgst.com>
 <20191104152916.GB17050@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104152916.GB17050@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_073252_489887_609D705B 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Marta Rybczynska <mrybczyn@kalray.eu>,
 Charles Machalow <csm10495@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, axboe <axboe@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2019 at 04:29:16PM +0100, Christoph Hellwig wrote:
> 
> Except on 32-bit x86, which does not have the padding.  Which is why
> the current layout is so bad, as it breaks 32-it x86 compat.

Yeah, fair enough.

Charles, let's just define an explicit padding rsvd field and use the
appropriate struct for the different ioctl's.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
