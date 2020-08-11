Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7137C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 20:56:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C37A2076C
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 20:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izxi7tG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C37A2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=40UVOCD8Qj7g2wcKk3QnYSW6zGKfnQhQxPiWp7S5zVg=; b=izxi7tG89Q0tgOC7qTfyUpe/N
	vWZQRV+0JImqS0Cibebs6cWjQQZsxidPvSH1XT7jEhSt7vVeBYk+NVdUt4GYGM/H30znMtx+VAzcm
	gTfaDE2Xl4OW5wrAcz71JQ4+UrcN0yuOhtxYzXQ1BszaUi2EPc4ZNo5qzv+6w6jMc9/YajOlz8XFV
	qXQC17lxwHVvMwYUfGzGTV02NyzWTZ2+hC+tQCgpXTApMESEZHoRkZMsy29JBd/0NjTsv0lKufnTv
	GWSQS3B92O5uP8fTG6/vEnaolRFzsYH0z6ZtWMoX40UEolHmOkq6FAL3SLZFD/C4gjGQZB2TTZnBl
	edAZkKqpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bJb-0004tB-1h; Tue, 11 Aug 2020 20:56:11 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bJY-0004sm-7v
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 20:56:08 +0000
Received: by mail-pg1-f196.google.com with SMTP id v15so7210231pgh.6
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 13:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7/XUmkSJ+96Yng6NiE2IgVm+Y2ym1XHJvEVV/pOG8Ik=;
 b=EQTsd9GT+4dGWtyZ9ZV3KAxeINIXGgQtQy7QZS2p8vR7o9Zw428K8vS8qSmL/apFu3
 gopfWhLDGAAzB7Id7oyZocPBmYlURaqDjiBSOtKOjBfpG/TbCSQePurjrKZuenvgs5KI
 SkqRTtBSdxdhfJEO+Y4ife3Z/ihD32d/C/xvNzxn/gorzGZ/Ow1x7xabtRqkI97fp1d6
 UOYcaFVwftEBAfBS6LRamZ/Y6YvduhPmsuPsrBZjYAof92rElKF1fK9Ww6iis6TQJaRc
 EQEm6b+opyCRVcMbMgn0fs+/KuUshUx9wRzrDvA1uRzTcLlOJXKyHOPKx5s4Ln7Dabaa
 Hlfw==
X-Gm-Message-State: AOAM533aTcolvp3o4IoKu0moqHg1EUaX+OPOJJqa/54G+qD4s4DjiMnc
 yYcbmsLs9P7TS2aiSKLZwqA=
X-Google-Smtp-Source: ABdhPJxw5MKeZ3nM+tTfHfyPSmp84ihj3CW0qSZKmwnXB/t3q4xH4PB3tw4v7SY57agqLiTm/3uPkA==
X-Received: by 2002:aa7:8a4d:: with SMTP id n13mr8552045pfa.143.1597179367059; 
 Tue, 11 Aug 2020 13:56:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9?
 ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id q5sm60561pgi.31.2020.08.11.13.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 13:56:06 -0700 (PDT)
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>, Hannes Reinecke <hare@suse.de>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
 <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
 <20200714110435.GF16178@lst.de>
 <52eec097-606d-1e2c-edc3-81b60807ad5c@grimberg.me>
 <45d34d7927354b6393859048c257cb86@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad7afffa-40b5-6cf8-6dff-21a32328c552@grimberg.me>
Date: Tue, 11 Aug 2020 13:56:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45d34d7927354b6393859048c257cb86@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_165608_310950_840B11B6 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: Keith Busch <kbusch@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Commands get stuck while Host NVMe controller (TCP or RDMA) is in
>> reconnect state. NVMe controller enters into reconnect state when it
>> loses connection with the target. It tries to reconnect every 10
>> seconds (default) until successful reconnection or until reconnect
>> time-out is reached. The default reconnect time out is 10 minutes.
>>
>> To fix this long delay due to the default timeout we introduce new
>> session parameter "fast_io_fail_tmo". The timeout is measured in
>> seconds from the controller reconnect, any command beyond that
>> timeout is rejected. The new parameter value may be passed during
>> 'connect'.
>> The default value of 0 means no timeout (similar to current behavior).
> 
> I'd like to remind you that this improvement is pending for commit.
> Pay attention, please.

I think we still have a question to why is this fabrics specific, and
if this is needed in fabrics, why is it not needed in pci as well.

Keith? Personally speaking, I also share Chirstoph's opinion that
if it's not clearly fabrics specific, we should try to make pci
and fabrics unified.

Your thoughts on this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
