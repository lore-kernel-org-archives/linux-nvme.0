Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F83C4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+lzZ8AkCkUIQEVVo8TqWO505Zy3thrTHkdq07g4zMFQ=; b=fZhztoJ2SLCQaVPVa/1mrAms0M
	OvJjmK20h3ZIVGQR7BnVZtc2BcvQJJOP5zUggv2rCp4KXojxg4SZoGFfQw2WLOBNqRdskm/24Wa8b
	5IFsl7TcESmrIiXyk7bkOlHlXZdvRfJ+ObGE8FVx3OpMGAWqkqEfNS1FY6lbMvNvmXx/uGGrVpb59
	d/eBFYiHYismqgZD0OzGWQ29pMqccy55V1NCa3UcecWMwVjkkqe/RSWmfwQ7HaR0qKRpJQyKsMZfI
	9HuONlC13KZZDGhb22CHS4CXD5faEvl5JZnu2uE9+HH/C2V3s4OPwUTCC+3QSkb1fJJPnGdYf2mj1
	6qt5qbIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0m6E-008Rks-AB; Thu, 01 Dec 2022 16:07:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0m6C-008Rja-Ca
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 16:07:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 09EB5B81E50;
	Thu,  1 Dec 2022 16:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD00C433D6;
	Thu,  1 Dec 2022 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669910861;
	bh=KAePmZ9MJni+50xI9wehP5nzoTea93teMnKTI5B9upM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh19aRjJrhgKrEVLf+Zq0EohdconKx7q5RkhzLlKfsGV0PvZNFLr9n9ALifBezp1L
	 523FLanlL7bJZ+5odMXNfTUH8jxoA5ST2R6qLlwjV9VgB0VXGa+DKSoJ3yYiEE1o6O
	 0TNFNfsW8JR+kTewj5XDr26uzbGBOpnUzbm7JjyCa/Zm5zb3z5q8EbilktfzSU4jXU
	 RtLk5JSNAznuyeGXvOFjyCX7FpmzY74V1vQlTNPw/WAGf7Mahjhhy/N0RVmM6SzeQi
	 1RPchnCjszNFpg9LB/IwYIzjBiFGLenHMQljyX/Rx02fE5JsEUxG+FRp8WCC/KQzIV
	 4FQ+qyFEUBmVQ==
Date: Thu, 1 Dec 2022 09:07:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, joshi.k@samsung.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't allow unprivileged Write Zeroes passthrough
 on read-only FDs
Message-ID: <Y4jRSqY56zjjlVsx@kbusch-mbp.dhcp.thefacebook.com>
References: <20221129090016.1311006-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129090016.1311006-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_080744_595538_D474AECA 
X-CRM114-Status: UNSURE (   9.83  )
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

On Tue, Nov 29, 2022 at 10:00:16AM +0100, Christoph Hellwig wrote:
> -	if (nvme_is_write(c))
> +	if (nvme_is_write(c) || c->common.opcode == nvme_cmd_write_zeroes)
>  		return mode & FMODE_WRITE;

Write Uncorrectable should also be checked, and any future opcodes that
can modify media. Maybe use Command Effects Log's LBCC field instead? We
can preload known effects for older nvme's that don't support that log
page.

