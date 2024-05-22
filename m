Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7333AC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cU9lo1UVYAsBYpaXNyB0nusQJblktp16A2fFJKmRjRA=; b=mSJNv8VHvQCiadRrPVxSS162r6
	aWgOpGayDyt2jdNNfw+bHVwC8kaeM0DLUjOftcBKs/7fmAy3NK0qYk6DLedasR5+NbbsDZnCYZ0Ay
	P9/vsSAbEgzN/oTaEAjqfFLyC+bIZ78jotHmJW/Net0x/7RdXGGSuAoT4/rZV/031Vaz0y+7oHCC9
	Iwzm79+y1lEYLnIbfCp/941kFzR3RFJGfcCiqc5M/B2feAf1DcQ+c46gIzUa2YTfDAvzfHa11RIWg
	zk0CU9ZvAdj/s4ItwJVcnaOp4CMt6iLoqccyeV7vi8qIvqkR6wbZrscSVzqVd5gWM7e6bS8BoTyJc
	OT9YKrbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oKQ-00000003SJb-2HrK;
	Wed, 22 May 2024 15:56:34 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oKK-00000003SIK-3tWt
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 15:56:30 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso11767295ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1716393380; x=1716998180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cU9lo1UVYAsBYpaXNyB0nusQJblktp16A2fFJKmRjRA=;
        b=fQ1BWTrGMeabRAokgNurEDMFttc0FQYyPnvbzSmcFogj+gLrORrgboae1vT0Ri1REC
         CblQSUTaripR7s4BtzlDPJWVheqajBFjSB5tCreoy4h2SVsdZkYvw5e3ImqcuR2NvyYF
         EQ0bKYqItIU7f5MsF/+XvGyGqlVSU8DvEZiHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716393380; x=1716998180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cU9lo1UVYAsBYpaXNyB0nusQJblktp16A2fFJKmRjRA=;
        b=Y5bh8adZeaaIGpXqq7zKl/Bg005atq5awqIQjPBUcA6qAHe+TBOwGqSB/3FjoDMQeW
         QUipHBdvBhHlCWEHJSKxBNiJ9DQEJayGkIFjTZz3mgmlEyE0Bo2k6yPSsB+dW3NxGRIv
         OUBGTSkm4OeCLzfENiFbP7cskZNNLQpCHZg1NJMI/upUViX4UwKOVzXnGNjzB2nVMzgW
         Hy6wviOVT5ZgetEPaQxhyEDmLxBC3+yxfet04uHKID89pWlWx3LLfuE7BQv5GPYVr+9K
         hZ3wTY25i7oV5KPS1ULRdSotnFaKUuuNGrMiHDj1H3ggRfJcqSqtRlYfPCAeg8Q3XIwV
         KA9g==
X-Gm-Message-State: AOJu0Yw8DEB8Z7nwLsVf5H91DjapBJngkNPhmt1KoWiT6g3Q4ky826Q5
	5brWDYDGR1vb3ngCFJT74lDzK1FcQECDnTHZGjxRaLWt6+BZ8FzOAV0ebvHH8NU=
X-Google-Smtp-Source: AGHT+IGjVncAPRwSQKFhw5aNZ5nwEyGQbXHzcTmYBxj42FjuUMxyw2oW2vRzRChwybXiSggDqmpP1A==
X-Received: by 2002:a17:902:f610:b0:1f3:3265:2fb0 with SMTP id d9443c01a7336-1f33265329bmr9627615ad.22.1716393379776;
        Wed, 22 May 2024 08:56:19 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30c9239d2sm34951375ad.53.2024.05.22.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:56:19 -0700 (PDT)
From: Jason Nader <dev@kayoway.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Jason Nader <dev@kayoway.com>
Subject: [PATCH 0/1] nvme-pci: add quirks for Lexar NM790
Date: Thu, 23 May 2024 00:56:13 +0900
Message-ID: <20240522155614.191849-1-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_085628_989235_4795F9C8 
X-CRM114-Status: UNSURE (   6.76  )
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

Hi,

This adds Lexar NM790 to the quirks list.
Other drives in the model line-up already exist in the list.

Kernel logs before:

nvme nvme1: pci function 0000:03:00.0
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: allocated 32 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
block nvme1n1: No UUID available providing old NGUID

Kernel logs after:

nvme nvme1: pci function 0000:03:00.0
nvme nvme1: allocated 32 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: Ignoring bogus Namespace Identifiers

Other info:

>sudo nvme ns-descs /dev/nvme1n1    
NVME Namespace Identification Descriptors NS 1:
eui64   : 6479a74b40200c00
nguid   : 00000000000000000000000000000000

Jason Nader (1):
  nvme-pci: add quirks for Lexar NM790

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.45.1


