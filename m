Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4BBC4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 18:43:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90E922200
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 18:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0Fq+fe6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90E922200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SV3F5qk8mle4ciluk3+EiTJ+s0yeQIHvFNYi6o1LyJw=; b=0Fq+fe6Lm7/Ez1ujjxTvKz2SJ
	vKlQ8d1PdNau7+ct5bBb3eKvp4fjMtgP2ySc03uVHjH68SLsd6pci0B/nJmBkM4koid+PxWQLGgzW
	5uEJqC+93XpeF3WYumkNDrBAxAFHfNdCGOb2cM3So7dEEUfILV5y70gw+8vSv9IpmImAqQvJF2aHY
	UJkELL1QuQMXH0vThI8+VXDwOxuedZG2HKyXWmm7hF1ADP422vVaENXkP7LJL1yfLicrVSfGI/0NE
	YWCau5vI6Z+hqskww6OhToupRe/IPIO+SnFiHDQIO0ZdaahB51LWGwyImYUmP+Tm6xsnEqopM8rdk
	U5hbTrBFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUwbe-0004hE-7j; Tue, 20 Oct 2020 18:43:34 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUwbb-0004gi-OS
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 18:43:32 +0000
Received: by mail-wr1-f65.google.com with SMTP id e17so3439842wru.12
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 11:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=udXwdun9lwI3Q+t4UG6OCw/Ljz/fo8NwT78atEJhyTw=;
 b=fX7EeDXFyd8g0Yxmyn2PeDUBKPsSP4SSl9ppj+p2SvZy+B5H+E+k2ScZ+6RcCatuQz
 jRKhI7HLqKybtUo/t2bvkHJ0Ea4/ZRtlhcOc2rVCeIZCKXMnE1RjL3p0HRbQAxGPmo6k
 5t/AJEUIbtIHVWrpMCuallEnULf0Z9IAYl/CdrS/5UGp30rE11mIt7U/XedE0Jfko7QG
 F7TqxPcGOcKV/w6z3jbWUp8PGeIxoVorRnlI5Gn8+R647aNLP1kZi98sEw/m6yRnnUMH
 gexkSOaRWDTssYePdFQ/mwlBIMoliZQsuBTUHUJKo1se666IhAXRGDApOmuT90G6H28i
 ZYkw==
X-Gm-Message-State: AOAM5337FtwxqeVRUBHRN56rmLncU1X1u7R2I+fH6yv245t513mSk0lg
 4OFMuVZyNulBb+iw6Wie+CE=
X-Google-Smtp-Source: ABdhPJzqwnmbTbTYxVi+8OZMl76malbcQa1uIYyL3XVxHtjsEiTFIjTFEdhQehWRSiwUEb2ccEG1Fw==
X-Received: by 2002:adf:8285:: with SMTP id 5mr4876399wrc.330.1603219410562;
 Tue, 20 Oct 2020 11:43:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:16e2:6f16:c01c:df28?
 ([2601:647:4802:9070:16e2:6f16:c01c:df28])
 by smtp.gmail.com with ESMTPSA id b7sm4197697wrp.16.2020.10.20.11.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 11:43:30 -0700 (PDT)
Subject: Re: [PATCH 0/3] avoid race between time out and tear down
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20201020090808.27702-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
Date: Tue, 20 Oct 2020 11:43:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020090808.27702-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_144331_799992_69299C7B 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Avoid race between time out and tear down for rdma and tcp.

This patchset overall looks good, but we still need the patch that
avoids double completion:

--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 629b025685d1..46428ff0b0fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct 
request *rq)
         /* fence other contexts that may complete the command */
         mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
         nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-       if (!blk_mq_request_completed(rq)) {
+       if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
                 nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
                 blk_mq_complete_request_sync(rq);
         }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
