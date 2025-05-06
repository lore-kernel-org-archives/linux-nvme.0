Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FD2C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1615jluscafzK1UNljt/mfbyy3aiQH9Q1sULAMhxfU=; b=jLqqP+0y9BxyYyWsLiSMURWGwO
	mAaBe0x9POX8gBLRR1kuG/yCfWMBA/AIw9AawUglLcbvNrX50bmpSMScdV3+9DDsh63DYUFqc49hS
	YvFGz/bXc//OPvqKfZgB5jNdLqgXhh8wrs1ZhhpXnfP2lr1wCFB/8NS2Rb9V7DPbNgkF0uKx7rU4q
	81mltNyquFwApA5rVPRFGUn4EJ4j6PrGGFRapKD8khHU1C1e+gLtEOPFIrutInagAQyae9gDFf+zL
	OlTtUuMLZMGU4AF39SOJjo3xEJauQBlzT//nZsWFS+6mLbU1ELssqdPZmCRAROxtr1gVjvInjCeGV
	7mL3opnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOh4-0000000DLU0-0rYQ;
	Tue, 06 May 2025 20:15:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCL7u-0000000CfNb-1GiV
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 16:26:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6845B44D57;
	Tue,  6 May 2025 16:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811B1C4CEE4;
	Tue,  6 May 2025 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746548797;
	bh=ZjL7t4BsSulzlwJzRDQ/LXLV59ln6cU8XfSSUAZxHBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iort1L32mdtiprBQnnykO9ASrBPh/VLReTrk2dBR5A+C1npSh8Fqb76YUQPy01ecz
	 PRzD3S3HnCpZNEzIrfZp2XU3u31kDSSsGljaVvFaKoCvPolcpmZU3ig8KCJSNUthi0
	 Iwvn+1+oyiDP2eaF/NFcZVNEpmByjWFWPKtHlF9VWRPEX1AXrzFBI9C3vBl87mpBGo
	 azAeFB5TpAm3puJhQ+KP0Ivdq9hfQCfWROOCIn5wwo7kItLKxYcxAGUi+2RLhWlmAZ
	 EcKAPIO4XDBLu8kKpS7pIPCcWpq8sv1s6HbTEd6JpovwHfJQD/d7QU7qBucZD5Y6oM
	 qGuw4iLmEi7eQ==
Date: Tue, 6 May 2025 10:26:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v16 10/11] nvme: register fdp parameters with the block
 layer
Message-ID: <aBo4OiOOY3tCh_02@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20250506122651epcas5p4100fd5435ce6e6686318265b414c1176@epcas5p4.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com>
 <20250506121732.8211-11-joshi.k@samsung.com>
 <CADUfDZqqqQVHqMpVaMWre1=GZfu42_SOQ5W9m0vhSZYyp1BBUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqqqQVHqMpVaMWre1=GZfu42_SOQ5W9m0vhSZYyp1BBUA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_092638_362272_EBA8EEC7 
X-CRM114-Status: GOOD (  10.40  )
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

On Tue, May 06, 2025 at 09:13:33AM -0700, Caleb Sander Mateos wrote:
> On Tue, May 6, 2025 at 5:31 AM Kanchan Joshi <joshi.k@samsung.com> wrote:
> > @@ -2225,6 +2361,12 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
> >         if (!nvme_init_integrity(ns->head, &lim, info))
> >                 capacity = 0;
> >
> > +       lim.max_write_streams = ns->head->nr_plids;
> > +       if (lim.max_write_streams)
> > +               lim.write_stream_granularity = max(info->runs, U32_MAX);
> 
> What is the purpose of this max(..., U32_MAX)? Should it be min() instead?

You're right, should have been min. Because "runs" is a u64 and the
queue_limit is a u32, so U32_MAX is the upper limit, but it's not
supposed to exceed "runs". 

