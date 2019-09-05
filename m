Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6AC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BC820825
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R1PNhU9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BC820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2TYK/iGmdTNxOsb8F9Xqi8estt2k1xT6Z2+Oh+Sikpo=; b=R1PNhU9m36eWjTxj1LmktWIDr
	vnVUmEW0DKTa2GbAqeze/OIZzia+BbocjrTkMVokaWfZ58oOfA1z+zg7qQ91TsauqbWjxuHkj94Q6
	+AJftDFFdG+ei+Bz8XYUFvMT9/1Rvy+qtVDC+dDWliPz1/B8rZqjA3nB4a0xnI7re+bIPz8SWbk+p
	vSsmbAShblO7kanmqvSEHcWrrZccyPCHR2yVRyJgh11rxMLn88BwTXdYLFiYIbKCGTa//7hsCfpXr
	hI5TTJBePajQVo3qChl7DMW1FIevBNdFmOowOU12EtLA9m8cVcvcq1KB4f4CgcaO03xMP/ZtEjs46
	bzTK4oTsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5yJH-0000Ym-OZ; Thu, 05 Sep 2019 20:24:51 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5yJC-0000Y2-Rt
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:24:47 +0000
Received: by mail-wr1-f67.google.com with SMTP id t16so4228718wra.6
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 13:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iYgAX3tAYUcHUi6e3LFDNQ02jire5NFmMFI5kL6SKF8=;
 b=tNOV8iNl9/cKtIuJaag4uDSex+zHH3uaP41GYUWMAYxWdxGkoMbZQ2fZPgt/foFPVx
 tyvZyevWPESeUgOLg5T0rlLRJVrpXrTtTMvkB7dMQ21uJoqcasxnuXbKK4x0jnIuQHj5
 BL3IGOQSFhx+UaLMweZ9ccqSH5oxFmAOhaGfNoaatWnUvmKSA9OOgSkmASqge/fZREYV
 msF/ZaKkI+T5zz1wr6XX+8NSmvaTaeSYgyf+KXb2tlCU5QKgcpUbXqeNzl6NunEAwINk
 91M7TUlu1ZS/napKZW3hD2BFzkmL8qGTrstW7TLbd978603me4vGT1Hz7xPsUiyW1mjp
 a4kA==
X-Gm-Message-State: APjAAAX2Fd3k1lMsRoTsxGVZHaZXqg6tcZaTWgDa8Elo4A48bBUIMf9v
 VvD/Ye/EwbvKacaa0pW+TNjLYVfl
X-Google-Smtp-Source: APXvYqz/MEPUGexmt7VO/RpLX1gyzW/992tfaTRCPipDr+BfDtDlBBTdEIt0B5o/3qQ009eYINU1ow==
X-Received: by 2002:a5d:558c:: with SMTP id i12mr4285820wrv.8.1567715085621;
 Thu, 05 Sep 2019 13:24:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id s12sm4404969wra.82.2019.09.05.13.24.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 13:24:45 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme-pci: Free tagset if no IO queues
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20190905142607.24897-1-kbusch@kernel.org>
 <20190905142607.24897-3-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5183cfd8-5143-2378-13f5-02c7a70bf3e3@grimberg.me>
Date: Thu, 5 Sep 2019 13:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905142607.24897-3-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_132446_897601_C8F3308A 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> If a controller becomes degraded after a reset, we will not be able to
> perform any IO. We currently teardown all previously created request
> queues and namespaces, but we had been keeping an unusable tagset. Free
> it after all queues using it have been released.

Is this a resource thing? or is this causing actual troubles?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
