Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7698C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DA461027
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DA461027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+PAw64nNcAo8UymCphdzn+Thpujo8F56vxnLB5rPIKY=; b=pyaFaPeXA4sPWx
	YkBC5nRmiyKJskOT8JOvCf/PuAOMjovK89zgWEo7ew1NLbXUNRwBW6FO7bdOEpy3IqMtaLNkfbRTi
	7+Cec/z/Yv9dwhEGPSXY9ULTavd0Cly6ry+L5fd2V0P3IHGuXmwUZaWRUHHVUn3lXEv33G9R9kxLv
	qmhzEr9isEPzmmXmW2algAuknNaqvfBizrEOBbIc+bUri/kTbEYSK/FOb8Cjtji6Qb/8JtlckfQMH
	APw94jmI8EkF1rIEDwf+FmtA6ekhKnsVN8rtuj3DujCdgc4eKFndOrWcGeEqDv11ePt3M1iMx25yK
	qd1litepD6QsLHUC4ASw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqh72-00ACA3-P4; Tue, 08 Jun 2021 19:10:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqh70-00AC9C-AE
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 19:10:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 06BA561108;
 Tue,  8 Jun 2021 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623179406;
 bh=beXrWUmJ/DeDzNcwkMAHQNTc8EyAukeMvuIL3vxiiGk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DFtgD3Wq+gf0mRStPNaQxMy7rcX4vsrqPWvjnZ1O2jt/eap8l+LC9GNUxKvi3vfak
 vmlFFrJ8tvnrfnfsPqUv5oF2l/0EoRI44woL19eSbIST6O8moBQ6r08W8Q9B+k5Nci
 BsFdmeM1x6n+RG1rDXSkAP1CangZJK5Wm5zFRmZ7JnQAcTbhlb6tlysf802JDPbDsG
 O5ngHnv2DQxMrSOKhFW3W0mqsxYxzbtELTkhiBhQUVnFdF/FB0TG53KaiCvPEutUJ5
 4xWad7gJ5q/BhoNGKU4Oml4Tqs8b/8ECNj0GHtQh63ObfW+jkJ8rqA/OSjzhZCSASz
 trO4T2CYXwG1Q==
MIME-Version: 1.0
Subject: Re: [PATCH] nvme: NVME_TCP_OFFLOAD should not default to m
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162317940597.2276.17237091802998795532.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jun 2021 19:10:05 +0000
References: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
In-Reply-To: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: davem@davemloft.net, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, okulkarni@marvell.com, hare@suse.de, dbalandin@marvell.com, 
 himanshu.madhani@oracle.com, smalin@marvell.com, pmladek@suse.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_121006_391745_7739E6EF 
X-CRM114-Status: UNSURE (   9.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue,  8 Jun 2021 12:56:09 +0200 you wrote:
> The help text for the symbol controlling support for the NVM Express
> over Fabrics TCP offload common layer suggests to not enable this
> support when unsure.
> 
> Hence drop the "default m", which actually means "default y" if
> CONFIG_MODULES is not enabled.
> 
> [...]

Here is the summary with links:
  - nvme: NVME_TCP_OFFLOAD should not default to m
    https://git.kernel.org/netdev/net-next/c/762411542050

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
