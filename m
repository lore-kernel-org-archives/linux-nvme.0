Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:22:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F1664E13
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F1664E13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c0bugV3jVPsUV6j/AvVtpCqU6VhX2+LDAuelRxCObF4=; b=tjGq60FMX3Ses1LGLisG9XCK5
	jk1NbH7QWcnO7l1xW3GYAy9vYaZWwydx/Azbp6+NtaakmiRdyktYAd28F0f0LvjlPsLQc4MOOc6LI
	1cMtVqMy6xAxjAicQ7lEKSligta78rEEMRrHynbtaj7FulJvzpthI+71ODRFztRkWZ9tYtCHWke7k
	cJVH2S9NLgRxDcl+6fK1xtR4hvkSe5Numo3w6zliSiSRZqBEYCHQ2+UVdDgVZLYWAvXXB4tVWt7sY
	MYVBHMiFoLx9bydZsjTCTygHuiu7AU/akimlwVpQvOKc0Jejx8lHI6iVfy9kyu4QPCXLmBRE6XVco
	0xwp7qG/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGbq-0001tU-R6; Thu, 11 Feb 2021 18:22:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGbo-0001sq-Fl
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:22:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDF3A6736F; Thu, 11 Feb 2021 19:22:27 +0100 (CET)
Date: Thu, 11 Feb 2021 19:22:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme-5.12 is crashing with fabrics discover
Message-ID: <20210211182227.GA25786@lst.de>
References: <f4f56a23-c458-5a4c-457d-d9478aea854a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4f56a23-c458-5a4c-457d-d9478aea854a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_132232_636396_C8E4B729 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 02:28:32AM -0800, Sagi Grimberg wrote:
> Hey,
>
> Started seeing nvme discovery crashing since commit:
> a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")
>
> Not yet sure what's going on, but reverting this commit
> makes the issue go away.

The patch below should fix it.  This came up before and I though I had
already queued up a patch from Keith for it, but it looks like it got lost:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d387..4de6a3a135759d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1167,7 +1167,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		if (ret)
 			goto out;
 		bio = req->bio;
-		bio_set_dev(bio, bdev);
+		if (bdev)
+			bio_set_dev(bio, bdev);
 		if (bdev && meta_buffer && meta_len) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
