Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A22D3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBn6K4KZnCY0Yxou4W+FGn+th8k+F+/5VdjO8yXNhFw=; b=hbzicAZTm+eq4bM33mO6bdIqHv
	FD1GbO2Z2dhknSOfQDcQhn8wrpVNlUzzveb7mDzSxm6XsaLjBlyTM3SKTDxKyQoje1LdPhMS+Hmuf
	TrXQRhfkW66lExqGjJL/p5mBl18kMm8rAlRx7O04gG2qgsqJNs7GGSRwIJBljJEo8PbmCyVt/2CfQ
	ziVY406BCKnX/B0xz5UDArxDEZmGfvePg8k/NZWBXNiP3iynbxygF055IhAoGtPBIOIPPhfi436MS
	6wjibwVbRUS/YYd2MaFkKEUs6YvA+1js02TPZlU0/91F21RFF+Cnmhw3KC2/51PHEvfcPReN42K7F
	kzDZ7XbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dQY-00000005UQS-2BB7;
	Sun, 20 Oct 2024 21:25:30 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dQU-00000005UQ0-3xTk
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 21:25:28 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so7136445e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 14:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729459525; x=1730064325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBn6K4KZnCY0Yxou4W+FGn+th8k+F+/5VdjO8yXNhFw=;
        b=sTef22EpAjnMRD0/l+9ASN0zBwjY7am6T8BobVKD7frZiB/iXLEgBCa8lg0pr4nWUZ
         ztNqz3PHE31d2IEwKTyukTT1v/oTF7Bz01iMwcvqISThd929oFVm4BqwpSFNLbFWD6D3
         030hdDK6upsm+k8IbiTzfNrqf73VMInyigovoVWI19SsgAdagzjEt+dgvsvghyHto2wN
         6WcKXfFBJ8KErf+c2GSYsiIgSuED2TxRZl/8F3Z3AmYJTvEfu/OjNRWFJyacInbM0rzF
         ii+dSOmtLRKjoA9iFvDd6y8BAKmKNdtkgW+Y0TkWZCGX67w3anVrggSRmGney+/d64iM
         GJzg==
X-Forwarded-Encrypted: i=1; AJvYcCUG+cUZLs/v0YnpxWQSzVWFQ5lsMekHoBnq4V+5mtPMxTB2/vG9g4j3aebr7mC2AVJiiu/0+EwUOgtf@lists.infradead.org
X-Gm-Message-State: AOJu0YxzzfcX8c6eU46dpTGVyrfvwsyCaowOVujnQhV0ClId6IBsVKyX
	Fp2nXOUZnTM/w0YkopANwXfEAMNqYd0uJWhQIGqygX3B2HtaB83C
X-Google-Smtp-Source: AGHT+IFtrJCzlz0z0djFv72MUW7o9jSkK+ZnXNL/7PGcCRVWu2xSW/e7Nb8Efh4wVBq+302s3jx6JQ==
X-Received: by 2002:a05:600c:1d01:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-4316168f28cmr77354645e9.24.1729459524967;
        Sun, 20 Oct 2024 14:25:24 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570a97sm34914795e9.9.2024.10.20.14.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:25:24 -0700 (PDT)
Message-ID: <6905cfbc-2ae2-487f-aebf-e4b944f2dda4@grimberg.me>
Date: Mon, 21 Oct 2024 00:25:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
 Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <20241018051410.GE19831@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241018051410.GE19831@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_142527_036280_3DBCA0DA 
X-CRM114-Status: GOOD (  13.30  )
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




On 18/10/2024 8:14, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:40:36AM -0600, Keith Busch wrote:
>> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
>>> max_hw_sectors based on DMA optimized limitation") introduced a
>>> limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
>>> (MDTS = 5). This restricion was implemented to mitigate lockups
>>> encountered in high-core count AMD servers.
>> There are other limits that can constrain transfer sizes below the
>> device's MDTS. For example, the driver can only preallocate so much
>> space for DMA and SGL descriptors, so 8MB is the current max transfer
>> sizes the driver can support, and a device's MDTS can be much bigger
>> than that.
> Yes.  Plus the virt boundary for PRPs, and for non-PCIe tranfers
> there's also plenty of other hardware limits due to e.g. the FC HBA
> and the RDMA HCA limit.  There's also been some talk of a new PCIe
> SGL variant with hard limits.
>
> So I agree that exposting limits on I/O would be very useful, but it's
> also kinda non-trivial.

I think the ctrl misc device attributes are fine to expose this and other
types of attributes (like we already do today).

