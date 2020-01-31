Return-Path: <SRS0=aqmC=3U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC8C2D0DB
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2020 00:48:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5822082E
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2020 00:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="syLyzEzi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2RsxGpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5822082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5q0hHCe1czBxhK06W5gFjBmaXM2NTnBKh0WQt1jEJF0=; b=syLyzEziUuDdhe
	YveyGqTXTYuJqMzKu/ov72ZBGmKxTyf9t7ZYdrPMZWsHBqlZzepmK1V4LDfDciJyyO89ejhi987ks
	1YM6xseCe5lIdcM5p2EdbFGzWul1wcYwVAO0Cy0tHC2yszdmPsE8aZlHftJUngJDGG72q5ihMf3Zt
	VciBiduUxVsQ13j5A3QJ1IvrS1/tAcVLHKiUsFKhemvBhDWwsBUAkHjSRQ8Dto+nEIsP7Zw70HjHZ
	LtrwBo1LuVdp/tAPd4tlViJ+Hn1PvJFUm0gS0283gJiS1SER95z9Mo1r+xRb3IGBzNE5FkUUCHL+d
	VTmMqbIFMroCtTY1SLLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixKTz-0007Eu-8J; Fri, 31 Jan 2020 00:48:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixKTt-0007EE-GL
 for linux-nvme@lists.infradead.org; Fri, 31 Jan 2020 00:48:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F7922082E;
 Fri, 31 Jan 2020 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580431701;
 bh=TQDrnxfydARlwryZCN8QfAITTjsDqH2ymdE8fF/67DQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l2RsxGpBRDquBZ1DSSrCTtCgMGKyESb3nL2/LdFIUXrGM/WwvFUMjJWNZD9e3QAnK
 GMzSS+zUiE1dos+bXOucJefpkbtlHht6p4/yc2RiAWZa7eEtRipGS15w3ETLexdmEY
 Bl+/d99LA6j+bJ5GEddw2+tDNCiTz0Dj1a0OIJrM=
Date: Fri, 31 Jan 2020 09:48:18 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme-tcp: Set SO_PRIORITY for all sockets
Message-ID: <20200131004818.GC8673@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR11MB2712E7D933721CA54EB18365E5360@BYAPR11MB2712.namprd11.prod.outlook.com>
 <675e24bb-8a91-6612-887a-2a0a38a57cda@grimberg.me>
 <a82b08e9-75bd-e14b-7d30-7414df1c90c4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a82b08e9-75bd-e14b-7d30-7414df1c90c4@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_164821_577050_EC65BA56 
X-CRM114-Status: UNSURE (   8.59  )
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
Cc: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 30, 2020 at 02:51:13PM -0800, Sagi Grimberg wrote:
> Keith,
> 
> Unless there is any other feedback, I suggest we queue it for
> 5.6 perhaps?

Sounds good, queued up for-5.6.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
