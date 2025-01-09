Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D6E77188
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NcMaIxB89aXYU0HrYQ/juYoMdoNOTBUAqo/G4Be15p4=; b=b//Hkoym11dpqbHVPWrwA7SyDy
	eQ5Qphszx0Vyaa3IprHGrqg5afKc+VDU+er/40f00G6Si0AW89SMSrVGGdJl7UMrYtUk9pjRkZIJu
	y+4keJpsaUt8KUMW9M5Vcf4HEN90u7+sSfhLVNXTBVKs2XDVnIZPdW2xAr4m1Zu1LbkwFclNedjRo
	iXBAPZN7SSBDN6hJ189mNLcemKlktncS8LpmVq65OXrjkYFcOqFSgRlbbjM/C/NI2RuOFzPhUew7f
	EHz2MU/sjgOVan512xtaF0L7swb8Jk7Cf/BhThWGFtaqYPoU9+khCvakoF6XPLia4NNnGnsF/WYnb
	i7e1ESNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVhTx-0000000AKa9-2gaL;
	Thu, 09 Jan 2025 01:37:09 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVhPB-0000000AJnq-3dso
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 01:32:16 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso574461a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 17:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1736386332; x=1736991132; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcMaIxB89aXYU0HrYQ/juYoMdoNOTBUAqo/G4Be15p4=;
        b=YmWPb0RmACKUUkh0k3e2bHU+bqMGywQ1oJn8WX4MnCCN5UIrFRN+GNQmuXG86MvWhq
         xMRcddMHXLhHMp/gw4gGDekroWyaxUer6Ig5a6KMZAEeSijPDQ+cmNiSQd9nxyK9tuVY
         OWK9Byd1h587DY6eWAzaeSb9dg/8uLgIQdhQWT3EII6dLCAVBLYnXX2RhSj//DdNatem
         nE7BgVauDkBTGSqvz+0LRPu8YlXMf+UC0rF0IG+OCezxW5xgoT3P5bJUjdrvQZdH0Xnd
         KzWY0hHdcbdY92QeU/1PLD7B4JaIOuDCC7ht3gPE+IpJUGbQfw8z4nWhZmcC2pwlCd0o
         7K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736386332; x=1736991132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcMaIxB89aXYU0HrYQ/juYoMdoNOTBUAqo/G4Be15p4=;
        b=utni96RQsq1BnNekO2KmGoMSYl94fpxG0q1N3Zp9ACZvEPXC3xpl8FIyQ1HmRCvMUI
         ZXgRj57fxibaJrRlV/+Hhsno6YlbIBE9ykOKowaYv0JoqtYh6jhwep55jEB01a9IQZ3U
         vhsw6g8HTMU4E2scMJfNmeRv/6nrW7g+2DZtOHA2klxPuQdMaZg1JawY/OtiC7tBjCb4
         i9Yg16FvzpqzkvkZqjNbSD2cJJWgb0HPNg+CN73FaRRVTMILdzyYPuIWb4usKPH/M97J
         rTaxpp8hN8Iu/OX23DQl/NaZzo9V/suL0D8DYCYAhgLOoN5QRCNsDQrq5JX/2JZ1FLcT
         zKHg==
X-Gm-Message-State: AOJu0Yz/Yxpnw4r3WnFpofJCzQSooLXWAQkcgweHz6/paRuZ4ZOYxSQp
	V9MPfnkkqRufY4hQ5DtjxSvWGMM5RmljquYxP8Q0jKf+Y4xnyUXblOXvWZTTtIk=
X-Gm-Gg: ASbGncv07L14e8X31aQ1W+Lddp+ev8mfYxiaB9oyI9fLnPuRmd9PfRmsA56RiY4KXtp
	D1Ys96h2U3Pr1IrTAG5zgce34gjAyC1DIfgcHTwX3koeUGHUH1ZXbb/88VNXklEGPMSWP3l1evM
	SmIilpp6zVahvjV0BwsG7NV8PMxUHjmrumA4qf9BZLoMVIgIZ/VCqkAsVcoEBbpKadb1FKz4scl
	SnmF+U2yNw/KdVf7b71x1Zvv1jLXc5Yj55QQNhGcvYe8mB5h1BAPWxW3XBsL0cFmcZxulwAhjYv
	DBTcbYWBCeO+ZcG2sBNF4tQ+nML2/NA87A==
X-Google-Smtp-Source: AGHT+IERItTVilccsc5DojWYe/uV0P+F6n8qrBNoNDpbE0qHsRtkGk1iJvW3sm5lRqm37ICkNdryLg==
X-Received: by 2002:a17:90b:520e:b0:2ee:9d65:65a7 with SMTP id 98e67ed59e1d1-2f548f447b8mr7523880a91.29.1736386332228;
        Wed, 08 Jan 2025 17:32:12 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21a917441dfsm905895ad.96.2025.01.08.17.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 17:32:11 -0800 (PST)
Date: Wed, 8 Jan 2025 17:32:10 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	randyj@purestorage.com, jrani@purestorage.com
Subject: nvme-fc: Question about __nvme_fc_abort_outstanding_ios()
Message-ID: <Z38nGkThjH59LFrf@ceto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_173214_135198_C4F67046 
X-CRM114-Status: GOOD (  11.72  )
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

Hello,

I was looking at this code and I had a question about it.

drivers/nvme/host/fc.c
2473 static void
2474 __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
2475 {
...
...
2503                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
2504                                 nvme_fc_terminate_exchange, &ctrl->ctrl);
2505                 blk_mq_tagset_wait_completed_request(&ctrl->tag_set);

nvme_fc_terminate_exchange() calls __nvme_fc_abort_op() to abort all active
ops with status FCPOP_STATE_ACTIVE. I think these active ops map to in-flight
requests MQ_RQ_IN_FLIGHT. After blk_mq_tagset_busy_iter() returns it is not
guaranteed that all ops had done callback functions called on them. Some
of these requests might still be in-flight.

blk_mq_tagset_wait_completed_request() makes sure that we do not have pending
completed requests, but it does not check for in-flight requests?

Am I missing something obvious here?

Why we need blk_mq_tagset_wait_completed_request() here?
Is it possible to have in-flight requests after the function returns?

Should this call be moved to nvme_fc_delete_association() after all the
requests are aborted by LLDD?

Thanks,
Mohamed Khalfella

