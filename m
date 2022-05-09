Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91122C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofW+TJ+ru5RRPVhBci35f4yLD63TtqsXQxRLXxRpilI=; b=JbNSCvmlS2eBBDsVI5G9Lj3oau
	UWoy+WsqXXlLkt//r3Op1SfmDs4SKCbYfvnrdlYVwUcCXcAk7A+Vc9z+UDp3R7FZHXZuNesOwKO4v
	hQHftpb2FUSE9viiswq+py2kRUQxfw053Xu8uPAnEk2t7egCzOMj1yS9BXjpQsfb40OjPkEcv6Ls5
	Z7Ol4f6FPXubj7mQI2GfY0rVehgKktC0mvORyFoKxfHW7ATJefmP12tsMUNNwZB5CY5iwY0jE22uY
	XPguYQ5YA7tjKy57UNG+XGooMmNNmBWcARHBKxDWnsdRY6ItKY4woLhRm1aZOtbh16MXWpQjtQfOG
	pnEKj+Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noB28-00GOtR-Pp; Mon, 09 May 2022 21:35:12 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noB25-00GOsh-6H
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 21:35:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E41E9B81903;
 Mon,  9 May 2022 21:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D379C385BB;
 Mon,  9 May 2022 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652132105;
 bh=ofW+TJ+ru5RRPVhBci35f4yLD63TtqsXQxRLXxRpilI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yuaj8choabnFt0bmkHwAJm9iN7WJy5DGg/nSxib4CY7KsA5A2DfPbBrpgxPmhxPpg
 dOdTAPpV/Zlmfx8rBeNNuw8c9GAEpETusEWQ8Iyoqqs43DMoU4oi0UaQ3gORyMOTTs
 b/lDmpVKqkPhVObNkliuhcSeconykIa/0+uc0Kckz4D75ZaSzR7cOgQo+8o+2P19zg
 7okXHLa5kr8Nv8pZsKDWn7okAIkS5/2LtA+hvkxGCxeNlgnWIYJ+XgDrfsKy6jpSrP
 pANZo8cQx+UmYQjObV8p2qJub5WJiqpObfaieb11o17dT4y5fQCtqXzTOwzxzm8HY7
 Je2iE2c64iPig==
Date: Mon, 9 May 2022 15:35:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi <mlombard@redhat.com>,
 linux-nvme@lists.infradead.org, cleech@redhat.com
Subject: Re: [PATCH] nvme-host: tcp: do not read from the socket if we are
 performing a reset
Message-ID: <YnmJBhGzuHiJ6oqA@kbusch-mbp>
References: <20220415101437.292254-1-mlombard@redhat.com>
 <31923ed3-3d6e-b25c-6971-9d5cdfd4e057@grimberg.me>
 <14f3b14b-b228-7758-a556-213cd07f6593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f3b14b-b228-7758-a556-213cd07f6593@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_143509_440375_CB92D588 
X-CRM114-Status: GOOD (  11.72  )
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

On Mon, May 09, 2022 at 05:22:12PM -0400, John Meneghini wrote:
> If you agree the above patches are needed we can give them a new v5.18-rc6 based kernel
> and ask them to run their test again.

I think it is almost always worth verifying if upstream has the same problem as
something downstream. Since you're so close to the current upstream, hopefully
it's not a problem to compile it against the same RHEL kernel config that was
being tested.

