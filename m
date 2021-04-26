Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8AC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 03:02:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E2A6128B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 03:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E2A6128B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UdAgYH6sYNO0NdfDoT8jNJVZbIiMnHnica2HY6hHdUQ=; b=cOovdOvJiw1SLsSj4xAAsae38
	u7LuQPyQGiXnWZeg1wzx82XQITPhXtYnYqZo2pSAPq8gqHw02PFhroblSLhnKm/qQLzTFIk7SEXv7
	mOSBfbQJTZRCO4Rwh9anobLeLN/o0ma+0W2jvTZ5kJm2UruFA1cb84F4/wp5vhA4GjrKbY7y6+rme
	sVvDRdVjwmO5565y6sJYb/naxbjamHHxtGmeNGlxmH3AYpjc455G4IYsLcEUhF2PpemzniVk30e3w
	L+Xv+gbGPb1AtKojb6eHmjZh66CNm1WahVP+wRh42N4PBPqulHiH5tP0J93JkBqJMqvexeAIK3x8r
	bbTxSZQeQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1larVr-006luz-7d; Mon, 26 Apr 2021 03:02:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1larVp-006luk-Ci
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 03:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=44tYBXpMJOj6uug4aHLosXVD7Ko43yBzkFNYGvgBtf4=; b=vGceQZtC9IQA3YjgZAd4J0eBnm
 /d7mGJi2UxznviYlcN9VWsM8unas2HPPKAWdEvMuL+13NMYZKThdu1Y/XczxhoPGqKrWSs3xZdWV8
 fKZPkmmUHsbbOWyJrl1hQbjMyCRfRaJXwoDAgf+OSq4I3F4+djvuHgxEU//QgzjCRA2jXfP5szKA0
 HSMfJQW9ripQ68VhcBB1iCHbCt97fmC7ga3xjYWJICWs3PsamDJp/JV43MIXkN/NXRylRMDU0iBxg
 VsVTZ++6P5qIoS8nQ2EJKuwbEoQcW3FIaTqcXWQbLI8w+MqKwK0nIujqDm56qgSGSLF5n6o+vdSQS
 Eg2nNFBg==;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1larVm-00FhXz-MM
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 03:02:15 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 e8-20020a17090a7288b029014e51f5a6baso4312693pjg.2
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 20:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=44tYBXpMJOj6uug4aHLosXVD7Ko43yBzkFNYGvgBtf4=;
 b=n79vmIl1FVw7jLR7OEam3He3Mt2IKQ2Tic0xY3DnxDsdHXJmdCgwaEtwA4FxutuoFJ
 379D1UdxtACLq2uAPuuFQZZT/0ozMhVlONdVg3fgz0C6ZPmSma0iFL8s9x5AKgDXDBlj
 v3luNysFmvdzzqoyvbdZfyr4W1ute8VskDMg4gIQbZVfnxpMIJCDBXa6nOsKEeopi6O4
 4xUf4eezrW2QPACeQvbdc4zCpQ1dgZEaXAK+xgT/rz+bZrbkjnC3PCvgWc2jpbKyI7/O
 K4baub2X0v8ojgGbYk+RXWyN1j7sajR3omHEKIH/dn1uug4CiyJVf9+BWSYIOj9m1pRv
 ubWw==
X-Gm-Message-State: AOAM533lG06SnxkeBGHQ8a9dXCe4zdnqmL/bd+13/LMqW9KAcSPdtYNU
 ylf+Lih2huYnC5R9bM29o2M=
X-Google-Smtp-Source: ABdhPJz+ysOlfkJtBfcRv+ndSFeTd+BoaeSmicszK2REp+u2UKtyTPccALK1rRxd/tcfmvishyQBnA==
X-Received: by 2002:a17:902:59cd:b029:e9:a757:fa3f with SMTP id
 d13-20020a17090259cdb02900e9a757fa3fmr15871007plj.46.1619406133400; 
 Sun, 25 Apr 2021 20:02:13 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id a6sm10117111pfh.135.2021.04.25.20.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 20:02:12 -0700 (PDT)
Subject: Re: [PATCH 6/8] block: drivers: complete request locally from
 blk_mq_tagset_busy_iter
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-7-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <bcdfc3a0-f5fa-dc06-8067-4349a133e531@acm.org>
Date: Sun, 25 Apr 2021 20:02:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210425085753.2617424-7-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_200214_757591_BDEAC18F 
X-CRM114-Status: GOOD (  16.89  )
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

On 4/25/21 1:57 AM, Ming Lei wrote:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index c289991ffaed..7cbaee282b6d 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1568,7 +1568,11 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
>  	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
>  		return;
>  	trace_scsi_dispatch_cmd_done(cmd);
> -	blk_mq_complete_request(cmd->request);
> +
> +	if (unlikely(host_byte(cmd->result) != DID_OK))
> +		blk_mq_complete_request_locally(cmd->request);
> +	else
> +		blk_mq_complete_request(cmd->request);
>  }

This change is so tricky that it deserves a comment.

An even better approach would be *not* to export
blk_mq_complete_request_locally() from the block layer to block drivers
and instead modify the block layer such that it completes a request on
the same CPU if request completion happens from inside the context of a
tag iteration function. That would save driver writers the trouble of
learning yet another block layer API.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
