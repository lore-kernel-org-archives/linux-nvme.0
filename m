Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4D3C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:12:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6FD23132
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W6IjGrXY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lGPLsaYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6FD23132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	References:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YTCW+Qlafz6svu2RboGVaT5v9fGRn5/Ymm3KpHF32lc=; b=W6IjGrXYhJESRxTmx+qu3VNgI
	1f83gV7FMDwHzjE/Bw/hU3o4d4M7iMqjlZN8EcFxCdnKRj93fGI1vuVjJQ8PtOzhd4OMpbWmigbCS
	jXMSjFNtvHlGXVIvWeJLtebPYRGIGrF592n4CV/ym6yEn/nonf52IPRtG2YdjRdEAIPhRfa9heEth
	ViaXgX0jqLiEgk8j3T5IrODUl/VBGo9z+NQ+Vp754FaNMIcGNWCgDoG5XxmwUSt7ia+6iu40lPXWQ
	984uPDCZ849WufVASpOlX04c1cfIV4N6lBUvEitSqC+EM6hz6yShDVxkqbwDUJjedex0DLzw2X0Hq
	Er977w3yQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3iVL-0005S9-CU; Thu, 06 Aug 2020 16:12:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3iVJ-0005Rl-EW
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 16:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDEnKVUVHLBwqNZyg18qFmzBB6zuAfBqVlg4FFYr7hg=; b=lGPLsaYXeuFnOgK5G/usoxF2/C
 bCpVB7Gc//RT7r1lIIlpZMheuRzVy/xUltU1mlHL+ZY5VIacxyxmjyy5lGL1d6P5xkT7Sv5g/Zm2+
 rVSutzM/KIv36saWmiLnYQ7kv/43uVISsNMFLUREOoiKt/mA1plmw+qMnZDD3oytrGq59z5HZ1ou/
 lh0sHRImW4CCJf65EjKXNUqQD7UuWhPkPNCZPcYVj4N6CqpCyN3dsaN10mEaht9eoL8X9/p6l9nLh
 R54S5AcqEVQGUWOePUCaS8Bk6ZC2AxEw5yhp2vP5tc24g6JYZkHO4Lra4+BVygOqCord4m5cmLSdh
 EC38qJng==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k3iVG-0006NU-H7; Thu, 06 Aug 2020 10:12:27 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
Message-ID: <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
Date: Thu, 6 Aug 2020 10:12:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_121229_591316_1C5B920B 
X-CRM114-Status: GOOD (  21.70  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya,

Thanks for the fixes but can you please CC me on bug fixes to this code?

On 2020-08-06 9:42 a.m., Keith Busch wrote:
> On Thu, Aug 06, 2020 at 12:31:50AM -0700, Chaitanya Kulkarni wrote:
>> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
>> following Oops :-

It would be nice to have in the changelog what was done to trigger this
oops.

> Suggested changelog:
>
>   A passthrough request may be NULL if an invalid namespace is used, or
>   if the allocation failed. Check for a valid request before releasing
>   it to fix a NULL pointer dereference.

I don't think this is quite accurate either. It looks to me like it's
just a bug in the error path logic. If the namespace is invalid, it
doesn't even try to allocate the request so it should really just order
the cleanup correctly and skip it, if it's not allocated.

I think a fix like this would be cleaner:


diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a260c09b5ab2..96bc9aa11ddb 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -239,7 +239,6 @@ static void nvmet_passthru_execute_cmd(struct
nvmet_req *req)

 	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
 	if (IS_ERR(rq)) {
-		rq = NULL;
 		status = NVME_SC_INTERNAL;
 		goto fail_out;
 	}
@@ -248,7 +247,7 @@ static void nvmet_passthru_execute_cmd(struct
nvmet_req *req)
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
 			status = NVME_SC_INTERNAL;
-			goto fail_out;
+			goto fail_put_req;
 		}
 	}

@@ -275,11 +274,12 @@ static void nvmet_passthru_execute_cmd(struct
nvmet_req *req)

 	return;

+fail_put_req:
+	blk_put_request(rq);
 fail_out:
 	if (ns)
 		nvme_put_ns(ns);
 	nvmet_req_complete(req, status);
-	blk_put_request(rq);
 }

 /*

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
