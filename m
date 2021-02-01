Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323FBC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:28:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E64D64EAA
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E64D64EAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xRTZLP4UuRm55LO9b28WMDOxccyO7Xr3xjN5Lx04RLE=; b=M33ej3n88fcoaIA8I4T1akjh1
	PipeNHo0Z8joaIIvNj0IJZNzknfKlKilveTmiI+zurH5Vvd9254DWsc4EOZPgnFJMYxKJTX0BNDoE
	KQ97K3jxVk/Yt6WQRUZf5hZ2Nvl+XaLI6qTEEcuSWrT+RDBgsqrmmrspWWAzXAmrEDTBgcvdDmxyh
	jq1BajYxfgybzm5uJUf0/IlHqhANzLzUU1CfxcFnqnqGqeg6Q6x0BtBb0pjGXC3g/ldF9+pjMvIUS
	5tRBZHjkmDuvbodX5DFDKAzuDaE/iwMHNIUOMaFyxtKjIGIkRyWcAAGrKVmTLF730HMPpxT9e1V3k
	17vDfU97g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6czl-0005yv-42; Mon, 01 Feb 2021 17:28:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6czj-0005yZ-Pe
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 17:28:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 395D46736F; Mon,  1 Feb 2021 18:28:10 +0100 (CET)
Date: Mon, 1 Feb 2021 18:28:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 04/10] nvmet: remove nsid param from nvmet_find_namespace()
Message-ID: <20210201172810.GD12054@lst.de>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201054138.34324-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_122811_955431_8A3CECF1 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jan 31, 2021 at 09:41:32PM -0800, Chaitanya Kulkarni wrote:
> The nvmet_find_namespace() takes nsid parameter which is from NVMe
> commands structures such as get_log_page, identify, rw and common. All
> these commands have same offset for the nsid field.
> 
> Derive nsid from req (req->cmd->common.nsid) and remove the extra
> parameter from the nvmet_find_namespace().

I'd merge this into the previous one as that totally changes the
calling conventions anyway.  Otherwise this looks good to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
