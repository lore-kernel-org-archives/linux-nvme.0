Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486A1C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:29:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3ED20759
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uqDhzOmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3ED20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZRPUnHqfNgfzqeCXwW+cIEYOJiRsnQDqxUwznY7MA7Y=; b=uqDhzOmAYdQaOXA9zET/LFGPd
	HPBN1vpwPRzI5qheG8PMbQww2aqpMbS564fR0MDFOt3dyK0iW6et8SfFzZ6IHSEMtoUSPYMjVbfDl
	rieiVhjFwX7CCIXIsPDDTjpiMRCwc2zF3ylGRH2dnCr3QPZZD9gi9/DZab/Wk9fEQFteQ+hunx3Hp
	xYL7tLzZPq2fGi/odnc63QItCIsCJEDujp17rRVmvkquaTfpraPgFFCiB5tdPnJXZ6+KalSPIwckG
	MXIwfRDYr1PxtFPCIPNll188tcsI3PgOAzhNMv7C9U8MezOC7EWKS1NLpEtv+AZwY3wzCVFHB5qg5
	wLI77yILw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB1F-0002Sw-4L; Tue, 29 Sep 2020 08:29:53 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB1C-0002SI-N1
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:29:51 +0000
Received: by mail-pj1-f53.google.com with SMTP id j19so1102297pjl.4
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MacSnNLK3Cc/JnobwrFyRYLLrxMg48/rmkjmCaBoAms=;
 b=akIp0QrXrls3kDG/nw6zhyU4H51SWoyPPShp8+ONz2QA4VKg+l90FocMhFZHwvLqRu
 1TU+XJWM33+aKHYIPiXb7eVCjeh5vc17lCXjlZFOacjCsdOJPcjqImdfN7tC8MSRKaFW
 uqnVh4TyV2UjWGJgzDBP1/z3VQyTkv8eCKBU7NsGaa8S3cCyXRSBON118GYRiBo+D0qo
 BxT9dsrA0H9dHScXN0loHzbwvX/HXWiQe8K9i2vrbvLaoJtHyNjGqdambxlDeIyDBpLx
 UoUUmKztb/X26twkOSYKJIHAhkgykYB2OBcUK6p+Pq8ErwBRLBL4bH1Pxk7NTCEMwI1P
 ++vA==
X-Gm-Message-State: AOAM532PVkWF0LpeqZfvU7Vs+TbhmAPc0NF3DlhGZ0MdI6dczp/4qhHP
 k+8FDw0z0g9TTn3MMg5XAkE=
X-Google-Smtp-Source: ABdhPJxPMu5OKwSv8In4tx17a+7sUV6olpA+xE8svqZFjX73SkqsyurPN8swpmNd6cxQyU0NLXdmdw==
X-Received: by 2002:a17:90a:69e3:: with SMTP id
 s90mr2803374pjj.130.1601368189542; 
 Tue, 29 Sep 2020 01:29:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id j6sm4328319pfi.129.2020.09.29.01.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:29:48 -0700 (PDT)
Subject: Re: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b92cb028-ef1e-97d6-01d3-e31cc47dd220@grimberg.me>
Date: Tue, 29 Sep 2020 01:29:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_042950_754050_08500D97 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good, but seems misplaced in this set.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
