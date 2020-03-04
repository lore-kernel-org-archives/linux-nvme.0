Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8EC3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:12:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40D8215A4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HsDbvESm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40D8215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lQfwBTjdXgdQIHq+4kZasxmhLxcAwKTZ9cd3u85MfWs=; b=HsDbvESmGtkbPJJk7H/z9vOIn
	JC+gksNm2xpPc5YAr0m1ZR+9Eh7LWKIadvPPBg+mdMW9tZhgS1qfnXdLeivLyfcy0bfgtcKbj1aIU
	kTDy1zOubHJZQF0q6FQEMFrXLJuemL/0pRIEi5HlVVdbv1QGh8BkIcjvuUen08CmKAKVZVUe+hTDU
	6o85B/SIWkab2+unOEaCPNnOpGwF2JzZcA2X9TXYzvcbnsTv9yzrqBhMR6vac4KP+ywBy5wDmKiyZ
	hDy5pt6tClz2Fh/HpNfTFlVrNxYBub/ArZhQiONAA6oCHuWawD4SbD9/EOPojD1mZ5MQTpVSYfRFY
	VGlsodAhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Wcu-0002KM-7n; Wed, 04 Mar 2020 16:12:04 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9Wcq-0002Jd-Tx
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:12:02 +0000
Received: by mail-pj1-f53.google.com with SMTP id np16so515158pjb.4
 for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2020 08:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OfbWj39Lc5Lt7SX5ER1kwwduCXGN5iOIU0hVtYMDbz8=;
 b=WfgzzcjQhqKA4Tr5pzPn3F4Zm7lS/TPCFAOARUqc7mzzzmmWaGwKiwgVUH5AP/5AES
 2xze4/7/c0k77thq4YIeQ5gOs2X7O9le8n3dohBjjQDQluuMQhDygM60ctt/h4Qci243
 8GqZssDz8uJkQscUTH5yb75vRH9GcN+vZJd03a/6zvPIoBrtTTwmDVdaBF9gjYoCcHA1
 TdzJKZegrqiTLC+byuHxN48DqJYQVUS0B+/01q1XTZkGMqvppj4we9YyWAlcZDPUn+Fx
 pNlepArUdgFu6JTudAZEnH6KtE6DDZCHg9nHxqauB1syd2ILiBt34/UEuPwXd7KEqk/F
 80wg==
X-Gm-Message-State: ANhLgQ2UdmOdwZpW8h03q8Ed2TkDWBskzg4XSgrry0hMgxvGGywa60Hb
 e0yEnenHcr0v7S7Iopt9Zf4=
X-Google-Smtp-Source: ADFU+vvGabdFQ+k82pYPI9KJktiWvX+pKJCMqC7hTypuQEg9b6hsBh0Mf9q7YOHCqVKJclHJPRUKOw==
X-Received: by 2002:a17:90a:37d0:: with SMTP id
 v74mr3763406pjb.0.1583338316226; 
 Wed, 04 Mar 2020 08:11:56 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id z17sm17078005pfk.110.2020.03.04.08.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 08:11:55 -0800 (PST)
Subject: Re: [LSF/MM/BPF TOPIC] Storage: generic completion polling
To: Hannes Reinecke <hare@suse.de>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <6a263bd4-8989-b766-1d33-7b57f4de0c7d@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <048834b9-041e-6d4d-3e2e-1489a72468c9@acm.org>
Date: Wed, 4 Mar 2020 08:11:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6a263bd4-8989-b766-1d33-7b57f4de0c7d@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_081200_972741_6CF485E0 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>,
 Keith Busch <keith.busch@wdc.com>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Kashyap Desai <Kashyap.Desai@broadcom.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Himanshu Madhani <hmadhani@marvell.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/3/20 11:17 PM, Hannes Reinecke wrote:
> there had been quite some discussion around completion polling and the
> fact that for high-performance devices it might be a performance benefit
> [1][2]. And during discussion with other people (hello tglx) the
> reaction always had been "Can't you do NAPI?"
> 
> So the question is: Can we?
> IE is it possible to have a generic framework for handling polled
> completiona and interrupt completions, shifting between them depending
> on the load?
> 
> My idea is to have a sequence like
> completion polling -> interrupt handling -> threaded irq/polling
> IE invoke completion polling directly from the submission path, enable
> interrupts to handle completions from the interrupt handler, and finally
> shift to completion polling again if too many completions are present.
> Clearly this approach involves quite some tunables (like how many
> completions before enabling polling from interrupt context, how long to
> wait for completions before enabling interrupts etc), but I thing it
> would be worthwhile having this as a generic framework as then one could
> start experimenting with the various tunables to see which works best
> for the individual hardware.
> And it would lift the burden from the hardware vendors to implement a
> similar mechanism on their own.

To me the above sounds like a description of the lib/irq_poll mechanism? 
 From the top of lib/irq_poll.c:

/*
  * Functions related to interrupt-poll handling in the block layer. This
  * is similar to NAPI for network devices.
  */

Anyway, I'm interested in participating in the discussion of this topic.

Bart.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
