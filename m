Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A396CC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=1dtlLou/ThtfJ/E28X449Flpjz
	1QHj+lXx+x1osgo/SL0lNMOSm80zo/IF+C0ToCM9ViVUegyrNO1MJiH6DWvRjviw0tNyb6ufaUN7d
	IDrpww70c/1vAwCQZ19XWNbo8qPBpQB2VoViLWAskXgb6wOykMRpNEEi/GF6m8L0LpZVpSGVpM7lC
	Czv0uhbVYzyPAlDw+n4RdvnyZbuyfTABeW/A6UI2ewRxbIMJMNk2jOk1oQr9vpBJeMkJCQp/hQGH/
	6NAC1gHQLMONvUdyDqCjDVk6/ZVcqkVpFf9h17vQ022L973ZXibYabLW85uhMfew7tfU/BgajvJn+
	r+xYYFQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oJm-0053g3-Ca; Mon, 13 Jun 2022 17:57:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oJj-0053dd-CF
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 17:57:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C78768AA6; Mon, 13 Jun 2022 19:57:25 +0200 (CEST)
Date: Mon, 13 Jun 2022 19:57:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ning Wang <ningwang35@outlook.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI
 TiPro7000 SSDs
Message-ID: <20220613175725.GA15847@lst.de>
References: <SG2PR06MB33380A046A4E047A37B1153CCBA39@SG2PR06MB3338.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB33380A046A4E047A37B1153CCBA39@SG2PR06MB3338.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_105735_612773_B608EED0 
X-CRM114-Status: UNSURE (   7.86  )
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

Thanks,

applied to nvme-5.19.

