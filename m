Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3A0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+l/9zzb4iRbzShyylXB3XH1RGzL8AFsTr5k6DSNS9uA=; b=bfS7wer6CosGmf3zm+Zda0xZ7b
	5+5OR6z5jc4yhesvUhPEN/N2aN2XDq0NAtiXksW3vCFe8KwBvo7VOV8ZohbxOzaUqoEqt7GvZHTXs
	5D4wfiafdEgQbFXqvxESCNEBzcM62N2PSkJTwQBwiDPYU3E7dRd0wHx1T0etMRvF8C9Wf9QaEzey+
	rgD5W/q2CFotGEDW58p3+gCQeE+12gMCux5OgaevVCRjhdMLqyIvHtb6bO+FLN9+5E0d/AUH/kpKF
	gZR3U3zcReAlnO3S5Qcl5dI1C6+FudrTLROwOr4G180zO0VeDVlWGPjwz3zRbzHsK+4OlbLbAg844
	yxYvOZCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7gr-008XS9-Nt; Wed, 02 Nov 2022 06:57:33 +0000
Received: from smtp-27.smtpout.orange.fr ([80.12.242.27] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7go-008XQp-LZ
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 06:57:33 +0000
Received: from [192.168.1.18] ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id q7ghoDgDmjJi0q7ghoGZUx; Wed, 02 Nov 2022 07:57:26 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 02 Nov 2022 07:57:26 +0100
X-ME-IP: 86.243.100.34
Message-ID: <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
Date: Wed, 2 Nov 2022 07:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
 <20221102064747.GA8903@lst.de>
Content-Language: fr, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221102064747.GA8903@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_235730_884974_F368EA76 
X-CRM114-Status: GOOD (  11.98  )
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

Le 02/11/2022 à 07:47, Christoph Hellwig a écrit :
> What are th other 29 patches doing in this series?  Due to the lack of
> context individual patches from series have to through /dev/null here,
> sorry.
> 

Hi,

in each patch, in order to give some context, I wrote:
    ---
    This patch is part of a serie that axes all usages of strtobool().
    Each patch can be applied independently from the other ones.

    The last patch of the serie removes the definition of strtobool().

    You may not be in copy of the cover letter. So, if needed, it is
    available at [1].

    [1]: 
https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/


What is the best strategy for sending such patches?

Should I send only individual patches?
Should everybody be in copy of all patches? Or at least of the cover letter?


Some patches have already been Acked or even applied. So I'll wait a bit 
so that things stabilize before resending what is remaining.

CJ

