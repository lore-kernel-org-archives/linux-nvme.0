Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E8BC47422
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=; b=dHxynsfeT1fCiwu7JD0rzGimdN
	i7AtsBTkZB8dASxUjANhxHOD6ptsl6UuN1AiwhZbMmMPI25Qu3CDVlNmIL860o4W11Z7P8o59bWmz
	EgDu6E99nKzxxXQ08/eLNjRjDySsGMEJfs0G+tmz4iZibjplQOHWuV1FCLQOzXUJ77mudet6G/djq
	Ye1v3Sxg/SQbylcdGRzafHGdjr74x0VvdRYheT/yHgMnSwSyayHahQHM7s0X9yfUjKx+WPghJt3ru
	fkPKfnrV+bSrzmIhiEmyy2S1XSHh4rXR9Ka0drajWvFwlsG5LaXAkt97lpzTkTnNOI1ppXOBq/Gac
	+pu9xrcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1j7-00000000d3u-0xhS;
	Thu, 25 Jan 2024 15:33:13 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1j1-00000000d26-2A3h
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 15:33:11 +0000
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d374bebe3so1106105ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jan 2024 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706196785; x=1706801585; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=;
        b=wNTUkdjPrq70o1LmfwPgKoYxx7D9HsXLpEq5ZJ2UrSeed8EPmQfQaAMlYubYvPAmZj
         ATQ0LDvrurA7fVd7KRgaFImXTsQDp1qOcgUxOlIogNfFX5ywEfz1ylm8nWG4dmwXPpOC
         LakPJz6R+jLG03zvymOFSDcPo90da6PQvG85GBt/2GtefjkEt2y6YW/eku3IBZpDCQ8K
         wv2Cj9FeTk/DMVy6CbifoJZAnxacYzuUxf/Q82kI9GINMccYtJFJyS9RIJkqAN9eeYuX
         uWGqx8jGo7Qjb1elQghNOzadDqgN8wDUq6JfkxnQHenxvC6L8P9Xcm2c1rovfLEF8nsD
         S9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196785; x=1706801585;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=;
        b=QLzbfDYpPlYUFHVW1tn9oq2Tq3GMGLTNAaX1DJ4WmXIb2VeLRivxpDQ0bP2SjWz5uQ
         CdxdDih4pQ+ljMTjb6kERerlOn/xj22mCLjUewOHXJ8dvLmVSpaw8c2GLs8gmV0OBgyK
         wms5AhmNZChvhsq6TNrCUkhSftlHfw8XfVq3V/PJObvrZAp4Zh+otul7iDAXULYVUp8J
         GLyIcZjejltV5l4V8oNIiwVtfqcWeZYBdm7FEG2sTe7n5S91y49MJT0n7KFNI5L9SapZ
         +zGbfItpzwY1ssB1MeivR9b1sky+2sxLFRvpYj4nh+wPe7UEWwsK0gjjqAQfA7IoHn7S
         rmTw==
X-Gm-Message-State: AOJu0YxPnQHg2xYhgods93t4RyU6AnIYir5CF67Pr2Hfu+lfdmcO8PwU
	ANBMEpsqZNNdYZNCMuCpM7mugkUwmsctXcyxBfJPe3I7UDCdjAFt2FnKLmuHrH5cy1UH/iYBR08
	TIr8=
X-Google-Smtp-Source: AGHT+IEPDP4wlMUesm3T6swHGmmcjQRDschl7iPCjHlqz6YnohGuMWD6YQvhySNTMCgUMUqtlAouVw==
X-Received: by 2002:a92:cd83:0:b0:361:9667:9390 with SMTP id r3-20020a92cd83000000b0036196679390mr2591825ilb.1.1706196785198;
        Thu, 25 Jan 2024 07:33:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y18-20020a056e020f5200b00361a70e112asm4860771ilj.59.2024.01.25.07.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:33:04 -0800 (PST)
Message-ID: <1872ae0a-6ba6-45f5-9f3d-8451ce06eb14@kernel.dk>
Date: Thu, 25 Jan 2024 08:33:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <ZbD7ups50ryrlJ/G@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_073307_863631_3D0BD47C 
X-CRM114-Status: GOOD (  16.37  )
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

On 1/24/24 4:59 AM, Ming Lei wrote:
> Hello,
> 
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:
> 
> 	io_uring       submit_bio  vdb      6302096     4096
> 	io_uring       submit_bio  vdb     12235072     4096
> 	io_uring       submit_bio  vdb      7682280     4096
> 	io_uring       submit_bio  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> 
> 
> May this reorder be one problem for virtio-blk and nvme-pci?

This is known and has been the case for a while, that requests inside
the plug list are added to the front and we dispatch in list order
(hence getting them reversed). Not aware of any performance issues
related to that, though I have had someone being surprised by it.

It'd be trivial to just reverse the list before queue_rqs or direct
dispatch, and probably not at a huge cost as the lists will be pretty
short. See below. Or we could change the plug list to be doubly linked,
which would (I'm guessing...) likely be a higher cost. But unless this
is an actual issue, I propose we just leave it alone.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..ecfba42157ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2697,6 +2697,21 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
+static struct request *blk_plug_reverse_order(struct blk_plug *plug)
+{
+	struct request *rq = plug->mq_list, *new_head = NULL;
+
+	while (rq) {
+		struct request *tmp = rq;
+
+		rq = rq->rq_next;
+		tmp->rq_next = new_head;
+		new_head = tmp;
+	}
+
+	return new_head;
+}
+
 static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
@@ -2704,6 +2719,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
+	plug->mq_list = blk_plug_reverse_order(plug);
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
 
@@ -2741,6 +2757,7 @@ static void __blk_mq_flush_plug_list(struct request_queue *q,
 {
 	if (blk_queue_quiesced(q))
 		return;
+	plug->mq_list = blk_plug_reverse_order(plug);
 	q->mq_ops->queue_rqs(&plug->mq_list);
 }
 

-- 
Jens Axboe


