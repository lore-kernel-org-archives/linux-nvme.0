Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44424C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Mar 2022 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nw8jHmlXzY5Mu3BhMe5bZ2h9BPqth4ykbFL0wurydVQ=; b=WBYrDP+3ad4vmQiFor+sLCZo3I
	qmG1lacxDC3sTAKgnvqOx0FjUW0lAyIHR3Y6v9mFD70SF6QsdNSFgXyP+yKONOAhth39OMMRo0y4I
	diEa+22S/di0POfMfHPE9G4V6h6GwvzuSGtomaRhpmy5lredT8u5JxIHzasQmHUQ8+BVrykbMLJhG
	gnpqR4Nrh9cOlZA7pFaP5dqHEYl9SCgKzMOt27Vd7+WPQYnGQc3KnqJb+ao9I5ibKF07qOyKBiD3s
	tHQvQ/ECT4ZQ+5yyLEcPpTcnWwG/MVFa1d8YA1AgV80yUEEHLoACxdAZeoIWwYyP5ZwSXbGfEd2Ph
	TId7cf/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nVGbB-002W5V-Cj; Fri, 18 Mar 2022 17:41:13 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nVGb2-002W37-4c
 for linux-nvme@lists.infradead.org; Fri, 18 Mar 2022 17:41:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B5C6AB824EF;
 Fri, 18 Mar 2022 17:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C420C340E8;
 Fri, 18 Mar 2022 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647625257;
 bh=y1kSwAeyUIPDD0WUz6meKPi7vm54XPFekIW69rri3cY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HCL2ClCbITt12Y9eqokJetjwA0tRnCwNDm412G4Ql1rs+kWvAlzVKXsC8JYDGSL6N
 U95VkEqvnmbPNsg70bQc3bXxthHOUgXO69AT6NvQY4n1qkVYJ9GG//g5fduPgexaPE
 0GZszFFZisqQiqD2OYD4MfVPlOx/c5HSdQS1g6vgGdX6g+HWh44YlOR81IrVV1mpVu
 WIvlIaxL+7EE0zpw+10uHxyJxhabj6naed5nh4COB+flhrzzD/0ZxLE5Ceryx4Jyrh
 vlVvBagxU0tJXKlRUdk78I8efZb7AM7NXI1xG8GhoEHVadnigj7Y9fV0kwk6Jynhgf
 FReVWA2JgrjHw==
Date: Fri, 18 Mar 2022 11:40:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] nvmet: remove redundant assignment after left shift
Message-ID: <YjTEJx2Uk2RN1+p5@C02CK6Q3MD6M>
References: <20220318013014.90698-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318013014.90698-1-colin.i.king@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220318_104104_366335_84E2F748 
X-CRM114-Status: GOOD (  10.92  )
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

On Fri, Mar 18, 2022 at 01:30:14AM +0000, Colin Ian King wrote:
> The left shift is followed by a re-assignment back to cc_css,
> the assignment is redundant. Fix this by replacing the <<=
> operator with << instead.
> 
> Cleans up clang scan build warning:
> drivers/nvme/target/core.c:1124:10: warning: Although the value
> stored to 'cc_css' is used in the enclosing expression, the
> value is never actually read from 'cc_css' [deadcode.DeadStores]

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

