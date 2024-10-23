Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE92CFA466
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 20:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tikC23ZN49es6vkIaJTP2Kf+7jsYtoboJd7ao1i1Q+w=; b=SQ7wTydyBXeic7zP+vKKRM4Hfa
	ELCyrm3nP08omFkd75dvqX6JdkJ0gUR7TssUHCtGRHwXPlVR3sF6ESkAPbUMTp2uVEJa0IrVwzwyn
	NV+pnXDn2Ed4FYqH4GGh2bW6+LSpB2H8aj0TFs9BLg6DNIOM0B3Qs249/BSLrO0g9j6m+e/OfvRO9
	Z9Mx3/n77v/a+Il3/APf98D+tGVa8YVRYtEh0uZxmtP7B9N3CL3k7wMlERjwh6WMSoFEIuNGQuH0x
	0+VwnNGspMdtnyu+fe7ylxYaa+Fhk8N0fS0P/jlpjnnxjD12bGR77F9wcYdrcj3oahTd3z3JEt3N/
	REOlzFdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hsJ-0000000FooI-0k3t;
	Wed, 23 Oct 2024 20:22:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hrn-0000000Folh-3Ud6
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 20:22:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 31F6B5C5D82;
	Wed, 23 Oct 2024 20:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72B2C4CEC6;
	Wed, 23 Oct 2024 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729714922;
	bh=HZcomkHnC3M/yqL2IME9eWySqJOM+DKvMY/+1dLN1AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkJhYLtZloBHfiPmcCBkBIl4WTSZhuBFtLaJvIx49gJcJFYU7fUAwo8h+lH7k1g4j
	 yMcRaaLnv4AI7IvzNqy97fbpC0Ef5+pFssDuTlNwr0WinWD9nybpsmALLF2zOXEIRo
	 TF7tMmuDqLGrdws4WIP/pc/PhnotKqRo32vGFNFl/l76jp7haz65P9EU962RS/JTXd
	 l3hNTqUD2UaEqPkylMUsPSZijWuWGQx23gbrHm0Wu46VZF9n1WZdHNSTvefvM8X7F8
	 FlF4RkaSNW9WtkLTmUqS7eAq/r5mPH/bWW0irII6hjgFJFc0NvBYTNzU8kzn051vsR
	 0QRlLvQp9ap0w==
Date: Wed, 23 Oct 2024 14:21:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>,
	David Wei <dw@davidwei.uk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
Message-ID: <Zxla500xnmoKVrpB@kbusch-mbp>
References: <20241023155048.634988-1-kbusch@meta.com>
 <cb19f610-b6b3-4dde-9d1a-88446dc0615f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb19f610-b6b3-4dde-9d1a-88446dc0615f@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_132203_955507_ADE5E67C 
X-CRM114-Status: UNSURE (   8.69  )
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

On Wed, Oct 23, 2024 at 08:01:43PM +0000, Chaitanya Kulkarni wrote:
> @@ -1774,9 +1773,9 @@ static bool nvme_init_integrity(struct 
> nvme_ns_head *head,
>                  return nvme_ns_has_pi(head);
> 
>          if (disable_pi)
> -               pi_type = 0;
> +               goto out;

I'm not against 'goto' in principle, but I try to restrict it to
unwinding an error, and this isn't an error. I know, personal preference
and all...

