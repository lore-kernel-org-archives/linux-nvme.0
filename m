Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD4CC3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:18:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE1F215A4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OPPooHUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE1F215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LKX0ZTI0BGO8uqHO7ZNcSbtVE3a0+3B4tBXYH6H0aOg=; b=OPPooHUdpgqFCg
	dh/4RwaE8klLKuzA2CmtPNd5G7vjpfbBIlhOVORa0halfUJKKChyhLxnjjgLgsKcVUSz3iZbGzaZH
	7ChSoZCT1N/iRRDg/4TMGM5955Y4meTwMr4PqXMzexkNFRxiT1mEZwLdXKU5ySA7EVboY1+0HJD7G
	2bzbvQoTnefRn4doRTjdPmcMZa7HSYNT/HUuqadDmnTXK6LWZJp+FMpytWwThM8dSM0Zz3IIk97D3
	kILnH3j4BV00EkELgqyqec0q6XtAQXt/wr74BevRRqHQ/ltR02Csn1HfVHc/UGDkGQwEuDWspZEZ2
	ifHzgMmgpdBc5vJVXuiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Wiy-00061Y-UE; Wed, 04 Mar 2020 16:18:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9Wit-00060y-8Y
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:18:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AD37C68B20; Wed,  4 Mar 2020 17:18:12 +0100 (CET)
Date: Wed, 4 Mar 2020 17:18:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 2/3] nvmet-rdma: Implement set_mdts controller op
Message-ID: <20200304161812.GA11453@lst.de>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-2-maxg@mellanox.com> <20200304160105.GA10897@lst.de>
 <2e4190bc-a12a-5eaa-af53-01889f2fbb42@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e4190bc-a12a-5eaa-af53-01889f2fbb42@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_081818_741897_30528AEE 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, krishna2@chelsio.com,
 jgg@mellanox.com, kbusch@kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 04, 2020 at 06:15:55PM +0200, Max Gurtovoy wrote:
>
> On 3/4/2020 6:01 PM, Christoph Hellwig wrote:
>> On Wed, Mar 04, 2020 at 05:39:34PM +0200, Max Gurtovoy wrote:
>>> Set the maximal data transfer size to be 1MB (currently mdts is
>>> unlimited). This will allow calculating the amount of MR's that
>>> one ctrl should allocate to fulfill it's capabilities.
>> Do we reall need an op for this vs just setting the field in
>> nvme_rdma_create_ctrl?
>
> This is target side :)
>
> But we can add it to .add_port and limit/set it thorough configfs as we do 
> for inline_data_size (with default of 1MB).
>
> Let me know what's preferred.

I'm always in favor of avoiding indirect function calls if we can.  But
I don't think we need a configfs interface, just do add_port for now.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
