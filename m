Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE4D2E9D6
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Up9Gnrh4n7R5wBSr8F6m2vqJTReb+PyLIz41KQS9eo=; b=Yvl+ixzLgsUt0DfTDVNGtf0fEI
	y85HdDPHhaMD2dRqHFwn2LNEofQ8zIa+i/BcqvMklW7LOwhZxlWMmCTIC5cCk8+Lgt1k2QfZlAjAX
	tlGE++XubyNZoJwgzTPX8VQWfMRU9eBh8Nge7kBYqQeU6YWaB55eGISHiA9xcqMdBqba8kNVNEc6b
	DlE68tPHzEa8e2gBdt86ci31wEOfFNsIhRzTPXHkPach/Sho6xckQt/Pw1Sy3EhOsbRjYm8m3IJec
	j4gcfFux90PymAVObStaEeHvSMJEO3FZW+7ZbY5Y2zhpCOYTOj+3s/TyYKWvriGF5WAHLSbLe1FzA
	MxDSiGQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARrs-0000000HKEm-0TAE;
	Mon, 11 Nov 2024 10:42:00 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARrP-0000000HK9Q-0Mpq
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731321688; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=3Up9Gnrh4n7R5wBSr8F6m2vqJTReb+PyLIz41KQS9eo=;
	b=SVtyjnc6KyH6ttrtoRQhWzAScHSlod58bfr3F2OEO/0Nrt3zWl7l5hVRDS5hHjseSGQR9ICmScsWQtn0b3E7zoN/GUKC8MEepW69OOa/6hqqL5qYY3lGHwaWXIbhLlhysAOoONHd9DIstUporsqvhQlfNgc69XTGFY4z82NCzFE=
Received: from 30.178.82.47(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJ9Q47K_1731321686 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 18:41:27 +0800
Message-ID: <afc28a3c-ba3a-47b4-9b7b-917348d95810@linux.alibaba.com>
Date: Mon, 11 Nov 2024 18:41:24 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3 0/2] Introduce service-time multipath policy and
 document
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20241108085449.49972-1-kanie@linux.alibaba.com>
In-Reply-To: <20241108085449.49972-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_024131_315999_155153D0 
X-CRM114-Status: GOOD (  10.31  )
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

Gently ping...

Best Regards,

Guixin Liu

在 2024/11/8 16:54, Guixin Liu 写道:
> Hi,
>    This patchset introduce a new multipath policy, service-time, and also
> add a new document to introduce nvme-multipath and all policies supported.
>
> Changes from v2 to v3:
> - Add more detail to message body(Christoph).
> - Add a document to introduce nvme-multipath and all policies supported.
>
> Changes from v1 to v2:
> - Use atomic64_t to replace atomic_t (Keith).
>
> Guixin Liu (2):
>    nvme-multipath: introduce service-time iopolicy
>    docs, nvme: add a nvme-multipath document
>
>   Documentation/nvme/nvme-multipath.rst | 83 +++++++++++++++++++++++++++
>   drivers/nvme/host/multipath.c         | 53 ++++++++++++++++-
>   drivers/nvme/host/nvme.h              |  3 +
>   3 files changed, 138 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/nvme/nvme-multipath.rst
>

