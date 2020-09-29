Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B2C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4345F2075A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvnRLxMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4345F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=hvnRLxMKk0uMdDI9fu/vqyC+r
	EDEXppk277RZFV/+Yh3YhexD4AsLq4QxTskV8L/YSzKnin4bUnVV0UPW+wGi/50aMbF1tvI4/4cZR
	aHdOqYE2gl0WKhan2wAcqkgGBq4KANt7VnwI/d7CvOZ9V03T4Ab7CJ8ggaaM//nndnp+9OtvYstyA
	OxnrmY16IIfdI/GpcHuOjpdtlBcO91KzB+6BahS8bYGPpCQ10wtv0PSydxE27icrGGlPlEDjeDq6A
	Rx78HMOeivFAUy9YqD/8qeFnt7e8EDzj5o4LvSJtdhCOQCJ8BH6XRdMtDPEQ4gyVn0dLndVEKgfvY
	0bzxclDHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB7f-00059r-R5; Tue, 29 Sep 2020 08:36:31 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB5r-00047o-KW
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:34:40 +0000
Received: by mail-pg1-f194.google.com with SMTP id 197so3263861pge.8
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=HqFz/qHtlXZ1Tcx32Qm3la0az3kIJmA7YTtQqnhlrZkxkhYj0lrmq6Q+Jxp5gHnsik
 ayuX80/tTJZRhEug9WROajD6fJTLEdjZ08p1RA8RoeCpDS17uoKoE1o6Riycd2tSP3be
 tk8jG3OvJF+9iDO0TcYG4NZ9GPPXfDoh3BXxHGbf0dN8DU2aVXujFAa/JLQR/+2QUOjN
 IfIzLSATDRYwKcWPHtxXy64//G18A56Q+wOEyN4moHvHRtzwLNxKQ6ckCqhJVrLPjqVZ
 AqDynsH3Tcaq4gSy0oapzipwt3CMBbzPyzFsf1pxvq2uvNPCXQDcJTqblII1RWMgXLk+
 7Vrw==
X-Gm-Message-State: AOAM532Cjqa5b253rh52VMpn+z7hewcDf1Z/U7mhmdMjqkaMUdNeCucg
 E4uFJnkCerttn084H+3GKdE=
X-Google-Smtp-Source: ABdhPJxyx1DZuarDy1/NcwGAQq5s6kSLupu389kLeVNC7YA+ZDNeAtqPwkhLziUin/nr7XMlDtTXYQ==
X-Received: by 2002:aa7:9e43:0:b029:142:2501:35cc with SMTP id
 z3-20020aa79e430000b0290142250135ccmr3013367pfq.44.1601368478333; 
 Tue, 29 Sep 2020 01:34:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id j20sm4321185pfh.146.2020.09.29.01.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:34:37 -0700 (PDT)
Subject: Re: [PATCH 05/20] nvme: rename _nvme_revalidate_disk
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1e1773e-ba50-e7d0-2686-5c8b22065fc9@grimberg.me>
Date: Tue, 29 Sep 2020 01:34:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-6-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_043439_741603_8D39E34B 
X-CRM114-Status: GOOD (  10.55  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
