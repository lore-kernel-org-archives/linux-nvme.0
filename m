Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65649C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:09:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322A02076E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JaBvDjPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322A02076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tY8uK0DMm3BnlgS+4p2mFWo5zLhaRkEBo96Uomh63d0=; b=JaBvDjPqUsLCNY0j06fBXqv/R
	0kWYN1DX7eRh1htVAEc1WQ6kaUV727ekYdUcl/uIz4hyOWkwwX5NEOpV4rkHOYCxDBqZBLS9frRt0
	EICeCKhSYEvgUcv4l3ptV3DQBQvg2G4vDXgazmPh7lLs5ca0K8BbzloVBYW7svkC3x1Q+IHfjVQCa
	zR1tPQg37AguBnMeGSwU8ulYkj4j6G8x+Y5yHIUEy0zQK0zNk+DxVlkgOICnehf8DenHvU3FM9fvw
	XMNuzdUfvrj8oPvDdzaj0Ag9br9DNwoZ7BKGqK9W+9/3sNDNAnOEjiuuiw+ldvYeswkS0JUORukvd
	aSpNR8/pw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k86z8-0007aC-FJ; Tue, 18 Aug 2020 19:09:26 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k86z6-0007ZG-Ns
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 19:09:25 +0000
Received: by mail-wr1-f68.google.com with SMTP id z18so19257621wrm.12
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 12:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ql7PmzAUcwWog6SDJza2XCcGdOGk7m64GsYNtNnJlRQ=;
 b=GHzmO3uQCVZKmoYxvdtTsu2qHdxwX+YxsXnfUpax6dSsH68VgckYN3PYCeRF4OorAE
 HGQEeWuov/oZpkHxF/Ih1JQCFlDbNJpWqDQGrcV5rhTTwrw3vQEI/pYFjewxAHe542S+
 qzDOi5H34YAhBPCEiKcCo6r7/xEupPavp0fpPNfqiTxPGBBszzhn/3HRznG/Dgpe2klN
 rR/W42UPPWrVmbOHlprTCYmyJ4b23BSyBhu9xZdxovE3Z3akNRmRYHYiezaIxX1aUy4f
 k6hc2PSMUFDB7zrxvwkTBugRcTgepnXF+TyoFA3ySBHN5WobJLHATIBf+pDhlvmFNza5
 a52w==
X-Gm-Message-State: AOAM5304cAxX7QNrBfffzF1FtOxv6bEBrYKwYNMiUJfC0zCJAVjK97g2
 347b2g+C3z7rHfyqfPX4n5NHxAehuZ0Zug==
X-Google-Smtp-Source: ABdhPJyMBzrGiZp9Kk3wYXEU3HiS4DuJfv2hUHu6SV/l09xElslkE+OPMfFCF8knltvP/yW/SrOOew==
X-Received: by 2002:a5d:526d:: with SMTP id l13mr20407298wrc.279.1597777760841; 
 Tue, 18 Aug 2020 12:09:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id f15sm38252787wrt.80.2020.08.18.12.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 12:09:20 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: fix PRP pool size
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
References: <20200818175159.1727735-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e167503f-d95f-bc1c-aac6-dc9da7c1876a@grimberg.me>
Date: Tue, 18 Aug 2020 12:09:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818175159.1727735-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_150924_807942_8374CF69 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Queued for 5.9-rc

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
