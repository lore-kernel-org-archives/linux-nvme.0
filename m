Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A876C2BA19
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E742084D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mOvLm1ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E742084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S1mJCXv9d3hD8Ec1q2GPRvOt9h2eHpbKGXkOy2dRzto=; b=mOvLm1qlXwIYyo
	oGKHaetty+yIKuG8lX0kdknlx1VyIqqrpxwwLYTazV9QBv9hiNo4tyaG7J1xIm2ZUpse7yQnshyQc
	3gk86wZrzVZ5Kyw6T2WH+e1rxnF4tHoB8kWTlIgmRqmbnQEaY5ZODj02f6VDTmbSqeYksOFw1Ki31
	h7uriOnwj83NgeO7J0ZGyj0R7OHLLNhk9oH5f3oDf7Ox4fhaqmv5nHa3OpBJbQryUIb73sDa48QTo
	2KSZhGhZ01TIcBHEKRGXwRMGnbQLtJecPuWlRoIZwJeGk1cg8EyHrh8gcNzJKM7krsVJ+y3l6vgFk
	GpyuCSQHysfXMd+puiPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQksg-00020w-AA; Tue, 21 Apr 2020 04:51:34 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQksc-0001yz-0W
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 04:51:31 +0000
Received: from mail-pj1-f72.google.com ([209.85.216.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jQksV-0005qV-Sp
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 04:51:24 +0000
Received: by mail-pj1-f72.google.com with SMTP id bt3so2184721pjb.4
 for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2020 21:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BLtq2QdjOzCrJMLFZ+hejhyptyhEVzibl60GGDinzt4=;
 b=FJW/y3XPStOq4NA5hNsbsNw/qnDBhdQcoDi1eRlAsbqoXT364wU4vyZtwRHIpO2kbz
 wBDmZNjBnkfu6vbWhf+KHIAriKUdf4vgO0z7RAs6IVcA7B4bHHYjP0wwe10ynK9OiSX2
 rtqN2zFmVjAB1qcKllYYbn9CFiJQyhc3FS61PuF7OEOtQ9MpcpeLTVYUiEtUwyASMGPA
 QpPiKbyurVGowGM+gG4EhhAfbXSAJsbKdg4fxeFU/siVk4bb6indADklf6zKWQRikYA/
 Jw9lcLPj1/P8hdCN56BHH5W9srWePCoNab7opxGRdChO4KkLgjStMH5PDkixhFzNCwKh
 8vzg==
X-Gm-Message-State: AGi0PuZlRxSzjNmsuV7T7EPkPxTeig1VGCwksXppfSLwsIWl9BPmrzkN
 amJ0Excuz37rPm2IAy9q14Yjn6RAsNhJbuKFRhbCuT9pvkRjTt+h3MpyhDRAPvttvkJl6tRkWpq
 0jFFjE+IyTlqNXuMFCelM/J394HzINgEyrI/btdiQBDBt
X-Received: by 2002:a17:90a:7349:: with SMTP id
 j9mr3358499pjs.196.1587444682538; 
 Mon, 20 Apr 2020 21:51:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJDvmMZav1WQf4l8MDQtC6CWJ9V2og5hui0h4wbn2cbAwgyAaVGbvnQ6aHap5W2YJ/VGNCNOQ==
X-Received: by 2002:a17:90a:7349:: with SMTP id
 j9mr3358482pjs.196.1587444682263; 
 Mon, 20 Apr 2020 21:51:22 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id mq6sm1074269pjb.38.2020.04.20.21.51.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Apr 2020 21:51:21 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nvme/pci: Use Discard instead of Write Zeroes on SK hynix
 SC300
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200417125929.GA5053@lst.de>
Date: Tue, 21 Apr 2020 12:51:18 +0800
Message-Id: <33565F7F-307C-408C-861D-72517F564967@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <20200417125929.GA5053@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_215130_192451_2E777C21 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, linux-stable <stable@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Apr 17, 2020, at 20:59, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Fri, Apr 17, 2020 at 04:36:41PM +0800, Kai-Heng Feng wrote:
>> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
>> command"), SK hynix SC300 becomes very slow with the following error
>> message:
>> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>> 
>> Use quirk NVME_QUIRK_DEALLOCATE_ZEROES to workaround this issue.
> 
> Do you have a written guarantee from SK Hynix that it will always zero
> all blocks discarded?

Raised the issue to SK Hynix and waiting for their reply...

Kai-Heng
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
