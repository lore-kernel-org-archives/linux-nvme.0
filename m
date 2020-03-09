Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA558C10F25
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 19:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ABB2465A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 19:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FmdPTw76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ABB2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XgL8LPrPMuVnBw8jLYaJL/yUKvC5XTzOmXEGomx7Fn4=; b=FmdPTw76ClGERAvvtEo78rcWO
	+10A/ICzMW2R1cjV7MaKwUpJpbd/FKoCCMPdS3tPpOKoRkS9GaqzZn8vwXwErQnhc268L6uj6/2r/
	VlZiDder7cNwccmhGkW2dFBUKHTJfLBWlmv/jIiFnkoe42AAmU4/ATYyxGT3CLR/FslrwFVgB64Ay
	JCexUDKsEfOYktunsP7KOXm3bXXwxNqsgo/+Kn0L/XxIdDAKRtWbOnH56zGOiGlCWYPfmjNY7OiiU
	BXrEcJQpxovUoxZj2iP+CUCcDvud9Rm/sefVGkZLmvuOeXUOjjwRZBbzh5QDl6/iVstvGqdxGKgl6
	DUwtH4cOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBO8K-0000wc-7e; Mon, 09 Mar 2020 19:32:12 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBO8G-0000vx-TX
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 19:32:10 +0000
Received: by mail-oi1-f194.google.com with SMTP id y71so5991845oia.7
 for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2020 12:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hwH9tspQSNCYVH8lBO3hglwoi36fOtJJXepCDBSLFac=;
 b=qWVSGU9Pjv5NYTY+wglWymanrVeLW3GXVjT9D2UbsTLUzU0ITTt1mDGuk6Rn2ifJJ/
 fscUTz55u40SEIZLccAd7AnlgwnzhIH7tpLEdMqqyUGiA2JcXan3TBRA+fUMJsxhSuSi
 SpdUlbIb8C903n9XWNgNV0DbilXjA1Ww+7JLKRy7Hmtu8PGMlSGchhIErVUUJ+uk8f9A
 j84poNnlfsT1ZUvd9I/b1jdaRoarnNaZf6xjwFP3HNaCjCaE5bjManwuuOY27mbG8/U8
 6XsvPWCPA3kNWczciZnFShDT/JBgtP+hIN9To0fzvBQcZd6hrFcX/r4bCsn/Q0xuszZd
 V9lQ==
X-Gm-Message-State: ANhLgQ1ZGfj7+4c69WUxtwDqNUu8lWMZjIzUwbIOxsWDq8asA50Zhc+m
 apsgXSgVprrlBEQ2irzYgJE=
X-Google-Smtp-Source: ADFU+vs83HB0eZntpM44/5FdeD6Dsw5KIGf7B+jn80/O/yhX2ChjuKb6yGMktDMEp6AeQE0mHoGHtw==
X-Received: by 2002:aca:4ecc:: with SMTP id c195mr547243oib.123.1583782325574; 
 Mon, 09 Mar 2020 12:32:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t3sm4903240otr.61.2020.03.09.12.32.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Mar 2020 12:32:04 -0700 (PDT)
Subject: Re: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <79eb6f31-1c65-7920-5e66-8ee9a6e81aae@grimberg.me>
Date: Mon, 9 Mar 2020 12:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_123208_953786_AA3B28AA 
X-CRM114-Status: GOOD (  17.92  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Mark, thanks for reporting!

> Recent attempt to use the 'disable_sqflow' connection option displayed greatly reduced I/O rate when queue depth of 1 or 2 used.
> Verified this behavior with nvme branch 5.5-rc baseline with no other patches applied.
> 
> Test was using FIO, engine io_uring as follows:
> 
> fio --filename=/dev/nvme0n1 --time_based --runtime=20 --thread --rw=randrw --rwmixread=100 --refill_buffers --direct=1 --ioengine=io_uring --hipri --fixedbufs --bs=4k --iodepth=1 --numjobs=1 --group_reporting --gtod_reduce=0 --disable_lat=0 --name=cpu3 --cpus_allowed=3
> 
> Specifying a queue depth of 1, result is 4 IOPS.  A queue depth of 2, result is 9 IOPS.  Queue depth of 3 yields 54K IOPS.  Without using this option a queue depth of 1 will yield around 32K IOPS with all busy polling disabled.
> 
> Interestingly, noticed that with the following patches applied to the baseline branch, done to correct a different stability issue, I see the performance for queue depth of 2 change from 9 to ~27K IOPS.  Perf at queue depth of 1 remained at 4 IOPS.
> 
> - io-wq-re-add-io_wq_current_is_worker
> - io_uring-ensure-workqueue-offload-grabs-ring-mutex
> - io_uring-clear-req-result-always-before-issuing

This is highly unlikely to be related...

> The 'disable_sqflow' option was enabled via script echo operation (see below) to /dev/nvme-fabrics along with other connection options.  Verified via tcpdump trace that target received flag indication of this option and it's expected appropriate setting of SUCCESS flag in initiator received read data frames.

There is a problem that I see with nvmet-tcp target usage of msg flags
with the SUCCESS flag optimization.

Does this patch solve the issue?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 1f4322ee7dbe..af1889641d45 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -533,9 +533,13 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd 
*cmd)
         while (cmd->cur_sg) {
                 struct page *page = sg_page(cmd->cur_sg);
                 u32 left = cmd->cur_sg->length - cmd->offset;
+               int flags = MSG_DONTWAIT;
+
+               if (cmd->wbytes_done + left < cmd->req.transfer_len)
+                       flags |= MSG_MORE;

                 ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
-                                       left, MSG_DONTWAIT | MSG_MORE);
+                                       left, flags);
                 if (ret <= 0)
                         return ret;
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
