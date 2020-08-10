Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99274C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A73522D6F
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fFCT0CIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A73522D6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Y60T+J0V2cRlrmsP8DQcCztJhvzxR1XFtDWxSPjtxg=; b=fFCT0CIZqGatNa/CESeL7+Y28
	M6Z5T7o5WMH3MXOJ+IN1A/SzeRUN/w+W0KmW8dnq1WRqq0sfwdG2GW4JrS3g+iCHgubZiG8JNYPG9
	bG6oPCv7yDF286WnrnfDYFxZlZInqocwXB/7/PUONZ/LKYHk138Oa5n5WVuklYDEKyq3W5BZbWkaf
	BbsW/YUo1ck7hE5HF+9yNg4swYcU/7hJyEVCfwfPu25tykXhB+TfCXfHgbB1xzKaVd++bui8ypgvN
	217U6/7F3LP3RQU06QZjEmimWJJqU79a0516PO3O+7050vp4/e/Qo2DMeTg83KnlXLPNDVaIBLc9c
	w75Bp7gvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k59sB-0005f7-4a; Mon, 10 Aug 2020 15:38:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k59s7-0005dx-ND
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 15:38:00 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8B80AACA2;
 Mon, 10 Aug 2020 15:38:16 +0000 (UTC)
Message-ID: <1899fe01e1eb5c23270541e1833b12365818c150.camel@suse.com>
Subject: Re: [PATCH AUTOSEL 5.8 70/72] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
From: Martin Wilck <mwilck@suse.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Mon, 10 Aug 2020 17:37:54 +0200
In-Reply-To: <20200808233542.3617339-70-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
 <20200808233542.3617339-70-sashal@kernel.org>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_113759_866285_A833CB7D 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, 2020-08-08 at 19:35 -0400, Sasha Levin wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> [ Upstream commit fbd6a42d8932e172921c7de10468a2e12c34846b ]
> 
> When nvme_round_robin_path() finds a valid namespace we should be
> using it;
> falling back to __nvme_find_path() for non-optimized paths will cause
> the
> result from nvme_round_robin_path() to be ignored for non-optimized
> paths.
> 
> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/nvme/host/multipath.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Hello Sasha,

this patch needs a fix that I recently submitted to linux-nvme.
The same holds for the respective 5.7 and 5.4 AUTOSEL patches.

http://lists.infradead.org/pipermail/linux-nvme/2020-August/018570.html

Regards,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
