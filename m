Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2611C35E04
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D682084E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nbz8anPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D682084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=nbz8anPygR02vu/WHYU6zHFTe
	NU2Fyc6ttCQhigEOevuv5LdsrqwyzWlZy+X0xCXWip0hDeYed3WIi5UYJWRYnE59g3EDQSlN1uCBk
	jiaGggxVys+IzFFArUUdtos2KLEchyFleG7myt5fZ9MM9RfpvwWuYkSNDtGf+WcP+qim1Ot8e5vVt
	CPN1iBpjv/T3aFbiERPjVamoWjjUok5nZ9octbjYKi5uO71oaZFlMA6oHa1IRz/rzgcUb0HMrgv0r
	FGC6gmoUx/2apv5qYaysHyS5bswxm2jXiTMlW5MosVqamvNLLY0c7155km18JahH6UcFzmOBCQToF
	ENiiW2JYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6gna-0003cB-OW; Tue, 25 Feb 2020 20:27:22 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6gnY-0003b5-3K
 for linux-nvme@lists.infradead.org; Tue, 25 Feb 2020 20:27:21 +0000
Received: by mail-oi1-f195.google.com with SMTP id q84so657504oic.4
 for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2020 12:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=S3uVfex3VVaWVRB6MMowVS054fAbuhVIGD8lM2GmPHbIGVQMjXDxB1DlsYYX1/ABMn
 hcuYvfW9xOJjiuu9Cs3A2ZpxHxpeubRowOma+0tP+JMKQSD4jRXxBBY9QIsO1QWWzT+c
 trgKTkwQwFziZQR1m5SHBxVggLM/kKLZATa97RKqRQtqahhJISvctGXLLdZfl1kTVi1u
 aphK0p2LqfyEY2HwR1WGSj2daJpF+atk19AcACywMkHZSe+E/ED42btMQsgTxWh1Cn0y
 bvuUeLo+N3irDaBQAOoq8rVp7+wn4Xr2zXAklHDZ1Y+Ffm0cxFFQF4FzMI4yDcvYRtg7
 mYtQ==
X-Gm-Message-State: APjAAAWOwGTr9P56IWVz/q5RB5f4ZiQrjph42VbiXL4+IRFuRXV7i/Pb
 n7JOryyFPHDGEbRcMPaZcfE=
X-Google-Smtp-Source: APXvYqyROWUo5SzD7NtdqshCozJhgly/q+D3L3kxZ/rHRQxy9ulUXAagqEYFzIxQCPlP1WYvCdSSSg==
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr619804oij.0.1582662439094; 
 Tue, 25 Feb 2020 12:27:19 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id k18sm5565777oiw.44.2020.02.25.12.27.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 12:27:18 -0800 (PST)
Subject: Re: [PATCH v1] nvme-pci: Move enumeration by class to be last in the
 table
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20200224093823.17534-1-andriy.shevchenko@linux.intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <afc7c5dc-f5ef-2944-e427-48d9f4ade86f@grimberg.me>
Date: Tue, 25 Feb 2020 12:27:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200224093823.17534-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_122720_140503_01A071E8 
X-CRM114-Status: GOOD (  10.33  )
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
