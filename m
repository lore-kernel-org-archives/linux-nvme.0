Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE2FC2BA2B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03948206F7
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="POZK8qkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03948206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=POZK8qkDs2gWJ5wjew2ZrHJdS
	ovf6lBCLhOWPBqfT37yhwiCs4ABdVORWI/iG9CklFUbwcxkapY/LYBIbPAuUcUjTyQn92MaFmtDuv
	n7pTma16V3EwndWbDmqrRZ09m579H+O/vQMRcGwDkVMDzMNa3Qo9srveaog1hSsGAuvzITRPuKY+n
	hpCsWLmLkPn+PBFu2H/m86lWyHpjLe3tq2OKGXkjWxczhP4DKnDwM6wdBprrMhabWHJeTRukvhpP3
	CrVr3A8DODup47jYcYaVh721msuppGTVlEO7icBU/Ah1Zm4W0sojH/+jx8kbAeWt0RJeww/Wnh3uj
	cbvdagRnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMoN6-0005x5-3c; Fri, 10 Apr 2020 07:46:40 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMoN3-0005wT-Cf
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 07:46:38 +0000
Received: by mail-wr1-f51.google.com with SMTP id u13so894111wrp.3
 for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2020 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=eCRcL420FM9DS/FHuMUsR21XFn+Z5atGiQ+EGafV3cN882D8BpHZL4xSxUVtX/lezH
 KfWSCOw1X0wdJNL2YeMqy6ZmgKV94VPV2CKwIRFAjVxQOB5L753Ni9R/OegrK0NRhXFm
 BbWWmQeTIN75cqnHasx8IShcM5QeUaMy43sxKaGdhTPKj+vDvaPdjugetXpyFe06IPoP
 5nRQqiZFhgVMSvLjeqMnQ2jrPEA9SCL3xAVeOCVeyJxSmoY6f6mYzBBhK4w+2Lse+sJD
 DSjVP4Tn6mQJt6P5lLZA4fkHw5RoLAU+e5dnNf7OJ5Z07ctridMYSaiLRqv10xPiQ/pt
 2eSw==
X-Gm-Message-State: AGi0PuY6YDZ9Q0tYi+MfSNTXvpgTTIb6HMzJEPgt53MQrcrQQqaTkL+K
 Snc9hGOonsqq+eVfAa3dBEa2lznW
X-Google-Smtp-Source: APiQypKVn81Ri4yX7tr1CMjqfVzBwt/UZkaSsUiiH1EFUZrFyeulbk1dY62BAAeEad+hcqmS2tGOiA==
X-Received: by 2002:a5d:66c4:: with SMTP id k4mr3469202wrw.53.1586504795984;
 Fri, 10 Apr 2020 00:46:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9052:1641:fbba:d9ee?
 ([2601:647:4802:9070:9052:1641:fbba:d9ee])
 by smtp.gmail.com with ESMTPSA id v131sm1774389wmb.19.2020.04.10.00.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 00:46:35 -0700 (PDT)
Subject: Re: [PATCH 06/10] nvme-multipath: set bdi capabilities once
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200409160908.1889471-1-kbusch@kernel.org>
 <20200409160908.1889471-7-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <91967943-b27b-26c8-0d72-806e6d509def@grimberg.me>
Date: Fri, 10 Apr 2020 00:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409160908.1889471-7-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200410_004637_424403_1EFD4E61 
X-CRM114-Status: UNSURE (   7.76  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
