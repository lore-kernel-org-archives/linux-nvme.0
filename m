Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79EDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Mar 2022 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kvgns/YlDo0vpvFknphX79mvF67+VFJcLl06LDvNsrM=; b=3rpP05q+Fh34e3Z4+ON5nRob2A
	73p8H00WO9XCPl2mN69QG/6WWPjLfwm+E9jvActr/dZqCws7RJsaKigtBP9wWY9gZg3IhsVf9Rquo
	4ucKeYfSIBtItw1MQhcm6aMLV0npLWkCEgtIqGz8m9unsj2L2JX7J4skEYVa5z9DvkXGoPy3Vf3z+
	Z21IqDKEzg8vPyhJHk08pzKxXogZhsEUv0+aFcSyYfmaV2sLFFwIrYkCKNeYyIsqHZzVE/6JlNbN3
	68SYfmXtqrE7b5M5ymyzNbF/2U2Wim4cT70VTSgkfp4hVnLn5sUv3Yqj1rdwOktt0E9Gv0kL+AsSj
	VScfsMzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRJ8G-001Nvu-Ha; Mon, 07 Mar 2022 19:35:00 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRJ89-001NvZ-TH
 for linux-nvme@lists.infradead.org; Mon, 07 Mar 2022 19:34:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8828DB81698;
 Mon,  7 Mar 2022 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2150C340EB;
 Mon,  7 Mar 2022 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646681691;
 bh=Kvgns/YlDo0vpvFknphX79mvF67+VFJcLl06LDvNsrM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fu2ZlMXzitDWAQ01ZFHTqqwokCMbErYBWePakLmsNTdU6gZPLz1EpG/h36SuDNFtH
 +WyL9Ulswhfxm1l03o6mZnBrNeFZ3Snch3DgdUGOA8F+KqlLQweDk2eApCRhOLueQ8
 +veMHeuAcrzCMozh0qHoZukKcK0AW4tRmXWeujoFhyqIxGQWjtOPdICTptOOaH/SLQ
 oZJzd9Wo4ELIfaYz81RmPrMVcn4b4z04ALWvaxHzRyrCVXOb+TwFq50zmpAockh0HX
 Dv5LwMd+W/Q8PCQQ5GMebS3bGl70L5hQDWVyscfQGqu3BXUDoJaMP57VH7dijdazE1
 XjPHl3JVwoLWw==
Date: Mon, 7 Mar 2022 11:34:48 -0800
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 0/8] 64-bit data integrity field support
Message-ID: <20220307193448.GC3260574@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220307_113454_112525_4168650A 
X-CRM114-Status: UNSURE (   8.77  )
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

Hi Jens,

I believe this is looking ready at this point. Would it be too ambitious
to see this applied ahead of 5.18? The block layer provides the focal
point for new capabilities in this series, so I feel it should go
through that tree if you're okay with this.

Thanks,
Keith

