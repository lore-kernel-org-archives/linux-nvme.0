Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0111C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 06:36:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EA160F6E
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 06:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54EA160F6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4y214S+AJ6DrAODTI5Yp3LLXJvVbcoDjZTuh0K3r+/8=; b=deCChvpnmDpk1E
	/ds3qCmDkMCqLSRbVfRNxYeUURLFTT6B35G8Fcy0ocDr7gWjwQn0EQwmKKxL2GKNwRyg+z/mZ5xdc
	2zwxyCnGIIa7eTtWb2M/gsCveOedtEh494DilKJ/qikz2gwq+iP6TUbI0hOnmCpa8KNguAXDvmDiY
	GQSBmOfGkJcyTQOXa0aKu3QKETXZ/szOJcNKhbbFxyVw74wFq8nv6wZFcfloTT3okeVCcTmyqGt3j
	XCdE7+eNiEAqGnVSFXjk0qpxpGIvuAtDL2Fk2uBOqDnz0uE1fFpgcl2rszPF2Qj6gTsVSmOSg5n8h
	QktmJ9WUViQPL7HhGITA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSCu4-000hk6-BI; Mon, 20 Sep 2021 06:35:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSCu0-000hjX-Sv
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 06:35:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DF1EC67373; Mon, 20 Sep 2021 08:35:34 +0200 (CEST)
Date: Mon, 20 Sep 2021 08:35:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20210920063534.GA26999@lst.de>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210918215729.388968-1-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_233545_122008_CD022979 
X-CRM114-Status: GOOD (  10.28  )
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

On Sat, Sep 18, 2021 at 03:57:29PM -0600, Anton Eidelman wrote:
> +void nvme_mpath_update(struct nvme_ctrl *ctrl)
> +{
> +	nvme_read_ana_log(ctrl);
> +}

What is the point of this wrapper vs just calling nvme_read_ana_log
directly?  Also shouldn;t we propagate the error here and through
nvme_start_ctrl?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
