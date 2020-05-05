Return-Path: <SRS0=DhF7=6T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC47DC47247
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2020 23:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D1420658
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2020 23:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bt+k7LWG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dzFseQeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D1420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7axfIN4xRjH9YdkUmWZDZhFStAR1e01DyA0TckCekGY=; b=bt+k7LWGzjOXOIP2npfAo562B
	1smWKNoxzO+CBh4FA+kv5AoB/lRFwALO6zO8DyoVnopn30SZSr964nNd3q4QDCeYQw9PWZQUdNFfn
	Ywc9EYYRw7f4UTOZ+AoxioFwy2Ehw3+BMoTlrB32VXFj61417XT5pKZyoGIdWxGX6WSQwJBXpYK5F
	LM7xXdf/QjyMjXLSYZF9GFNMpetoxfi459Au5FcwHhU8Dq1gfgLDz9NWkDnybJzconunOxfcjuxvC
	7RkFIj5nv5o2INE2oIRsIztnTU/w8HFT9rGWKli/o7hC3NIfEdr316OHhqq0OmiH9c4KWEOvJFZEu
	Seza1iswg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jW7LC-0008Rg-3u; Tue, 05 May 2020 23:51:10 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW7L9-0008QR-Ly
 for linux-nvme@lists.infradead.org; Tue, 05 May 2020 23:51:08 +0000
Received: by mail-pg1-x544.google.com with SMTP id o18so1769093pgg.8
 for <linux-nvme@lists.infradead.org>; Tue, 05 May 2020 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WS5W9O86FDcFZwP3ZK5xJvm/xduC3npF8limraDHqnk=;
 b=dzFseQeQ8UGYULNzZlFTxd1DTcVJUmJRfRHEPVWRd9WbXWvREVZTF3ADQpEUDnkA4c
 JILF3jzWHyhaOYj8nWrMCDn756JPTHMuQz+t+f5zNq7kQ3jMthNZWp8AF/l1zoE+HSbR
 gcOp0uxlvmzc8nmLkYefBOT+p6RCEqdbv52IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WS5W9O86FDcFZwP3ZK5xJvm/xduC3npF8limraDHqnk=;
 b=fquxhLtXvS7KM+PKlE7YFEfsmQ39iOiSLz0UjG9rQSUu8uNRGM1VOfI7bYvIISbZH9
 aHASjsMdk2wO66LY454TxlToGT6ez8Xu+mfUTKN8sJSg84wRmkpgq8vPFWrit84xo5an
 734Td10fQiS+ppnmB1a/HI5lPC5pUS+pugmzPNeAQVmFZg5z96DHaeW9w3953PBorQ3R
 TKC7Sc4JjSgO5ib3nZ2bngoRx9HpFSqF98L1j+I/8Wga32XQedRhE2G57ZB3j75vONLv
 aMP6gJueP4mARqVvMYeVBaenLBIxq4CSpx6Et/ZHOvl3cKkt9Wn27DLidyrbUeJnVVpx
 9GGg==
X-Gm-Message-State: AGi0PuY8OM9ZqDau0xVIGoOF1UOcozNPrfbgUoneldkOSs5ZUIfdz8LX
 zLOn4gKYVyEVxfnPXeoiDNMK3w==
X-Google-Smtp-Source: APiQypJfIMCVYd7y8PIM/pLIK37IlnkXgLFlFIVWX3iZKir+LK5RhdHDFVNzvKqVHVD6PQf24dTdtA==
X-Received: by 2002:aa7:9ab3:: with SMTP id x19mr5371069pfi.141.1588722666568; 
 Tue, 05 May 2020 16:51:06 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id o11sm189974pgd.58.2020.05.05.16.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 16:51:06 -0700 (PDT)
Subject: Re: [PATCH 05/16] nvme: introduce max_integrity_segments ctrl
 attribute
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-6-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <0deb0516-0183-e7a5-0e0c-668e589438e7@broadcom.com>
Date: Tue, 5 May 2020 16:51:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504155755.221125-6-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200505_165107_720600_547D7686 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/4/2020 8:57 AM, Max Gurtovoy wrote:
> This patch doesn't change any logic, and is needed as a preparation
> for adding PI support for fabrics drivers that will use an extended
> LBA format for metadata and will support more than 1 integrity segment.
>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>

Would have preferred this was known as max meta segments without typing 
to pi. But this is fine.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
