Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DB5C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Mar 2022 02:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHHce095Z+cMMKE90z3st8GfylQGCRwqvgLzXY2KQ3k=; b=dlMYGJtKJXU9hGibtwfhbgr6jz
	ioniHesVJRQb3twJEy3Z47t7+ax2hIrgyIQU2e36XHFqhWQrpAAy+ZygSiyRV7XcqRM98kQL1j5SG
	W4iqQ3eIgPNEgnjw4sB+CFmLwnUEO2p4CyMKHp+4q2eRU3AItu2DvG1lJyk/uF12V74kjSC5qiGt7
	5A6ET3wBXi12Q6W//h98yjXQPLZJ1FbdnVWu6duDlyRNiBQbSqmkEraikJuvspHwDmsRBpNZz87sO
	abD7lSsIIq1TYZqEKST4sA2q/DSlDYoJy/iNQRRJcymUnHqGGYzSN/0edb2Bs1SauTbCEpnXaApKr
	cUYJb2qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nV2dx-000CNj-Vt; Fri, 18 Mar 2022 02:47:10 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nV2dw-000CMy-6l
 for linux-nvme@lists.infradead.org; Fri, 18 Mar 2022 02:47:09 +0000
Received: by mail-pg1-x536.google.com with SMTP id o26so4106888pgb.8
 for <linux-nvme@lists.infradead.org>; Thu, 17 Mar 2022 19:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=yHHce095Z+cMMKE90z3st8GfylQGCRwqvgLzXY2KQ3k=;
 b=e4esWQq4NmSxkwXv2sqcgG8JpNP3nGmnaKZqkMPdAoRV+iF+1Nxk+/eKQEUK8EnmyV
 Kk1y1Y7l/8Ld/iPiI9cH/FxPjefkXOfVhdqaTyAeMlwg5QToCWSifxGqEw7FHzLmQDJf
 2W9ISug8XRsyYf81mRY9Xixi5H51D2sNK9XkfUekInKVE82hB9VpWHw5kY0Odm7SvQ1Y
 3/Q6zMkYFXTnzLiCrBFHuoGQx+triCWxpI61t+LicydFp0HxQx0fCBd9WLHuGBYsuTi0
 i7xb1YFy7Fgp7XjMIULHvVr5ZPZW5L9WEpohjcPB/4JhvvmitGrixBFhdf8ggHQURzj3
 AHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yHHce095Z+cMMKE90z3st8GfylQGCRwqvgLzXY2KQ3k=;
 b=52nknWvbDonUMq1B/8ysMVagHY6W1lAzHOgbz4+9wzYOKt9OIJl0aIt1fF+J75fs96
 eZiGK7I7yr+xtRRQDqw4ZVJDVI2Tt8FTTkmFs4zGbA6qAn7ER7iI2swGhLc7u/lE7g+w
 xEhhy4wMw0bLMd7EslMw06ZuDaLktZai2ntoi62EHjMho7pobkPBzvnbAAwLMUDM8g9y
 BTI/OnCri3Ma9ETzFQVuUWInsEdsHR/pYGo+mX3BZi0kPxs+F0K27km1mIBAqVSZh8zm
 F6abf5Nceozk177cM49fQzh6N5Hah804OCbXqLz//gBDtvttxr8G1whO0S3E4D9q7e84
 /Tjg==
X-Gm-Message-State: AOAM530TzzH4gfGQnbl7Z6aZP/BetMsVAgeFie8SMipnu/DOCYp+y/t4
 uAdHtcQVUSLsaFcaTQO4BEmZ/Q==
X-Google-Smtp-Source: ABdhPJw+LjoCQsY5qugenJ+cnDZOuejYF1SQfesGpmzqOhfpTyT+Ly6jPqb1DIN+ujPfOIEdnAyLKA==
X-Received: by 2002:a05:6a00:14c9:b0:4f7:763b:2efd with SMTP id
 w9-20020a056a0014c900b004f7763b2efdmr8016623pfu.55.1647571627260; 
 Thu, 17 Mar 2022 19:47:07 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a63e750000000b00373598b8cbfsm6210563pgk.74.2022.03.17.19.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Mar 2022 19:47:06 -0700 (PDT)
Message-ID: <0657d1b4-fedd-09a3-1ab6-fffdbd158b6d@kernel.dk>
Date: Thu, 17 Mar 2022 20:47:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.18
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YjNrAsjvdSd+abfu@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YjNrAsjvdSd+abfu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_194708_303009_59B1093F 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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

On 3/17/22 11:08 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-17

Pulled, thanks.

-- 
Jens Axboe


