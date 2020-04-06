Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6981EC2BA17
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 17:04:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DFF249B7
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 17:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HuAxFKDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DFF249B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=HuAxFKDASrv0pbn671MNVn1N3
	a/8pXUZuaQCnWJSkzsThPp23/Rzt/BGe14Hob75t2QqUVJ0K74CqiTtKCVLH2ukMeAALB/DKDFFF/
	Fmbt2tRo9dXd7ud3PJzwfT/UxA1or21ov2jxzJcIAnZh+wfxTu1eFaO6srt1PdRrKFRzLtGUTnP7R
	MM208KJxdkveORi963ic6zqAxWvvq7iLbQBRGJ4ERCzZ9sYvzYdc9Q/MoXagcZWwms2sEIdSdMm0+
	OsbRLXiOzuLlSScYopR//BpRsaiv9mY3dkIqCAFEfs0p+LB3IABXveP3BDKiHlKNSvAzLIEzfnTpn
	aCg9GEDhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLVAT-0006Cd-BM; Mon, 06 Apr 2020 17:04:13 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLVAQ-0006Ai-IP
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 17:04:11 +0000
Received: by mail-pl1-f195.google.com with SMTP id g2so46034plo.3
 for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2020 10:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UA9iMKtcRzk9OKdnK4aYkuVi6Q4NcZ6oaDXiBzF06nHWU/9j9dQr24jFRH95pWyJVh
 350rfjuf+hZaB3OfNSMJo06f3azpvFeG6HIb3Z017vHs1NYbOq13pk+htFYS1BY4JyTL
 X0ObMtFW5IZrD+Es7BXjrLEt6L3774qfeCsjrhkemyNS37XSZrlK3JVOkcIIoksQiyA/
 7TUGdBYERTqoazLGoNfsGv3nDo5WnMD/9zETNrfnZf3KFdKfkfyjWhrI3ZoO92Tvk9gO
 9L0p5tCPDDvudRQSNUYG65IywLxJc+1OpSy1VL0htNSfaUZX4dhZBXXd58HDDcGLAF1a
 4ESg==
X-Gm-Message-State: AGi0PuatM56JBVD7nASdT/45hrJficIkdoEgHiBri4LLNp8w+/KaEp1F
 oHnpL7O2Yse855bgAVFJgZSNQ6ka
X-Google-Smtp-Source: APiQypIYHZCAX9bAG9l/hgy33ZC0vmLYMNE34WLuZglILDhkq1oue33dg19lqSeOl1ebOR0eHgOVoQ==
X-Received: by 2002:a17:90a:15d6:: with SMTP id
 w22mr244256pjd.173.1586192648943; 
 Mon, 06 Apr 2020 10:04:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e891:e4b7:ccee:cfaa?
 ([2601:647:4802:9070:e891:e4b7:ccee:cfaa])
 by smtp.gmail.com with ESMTPSA id f6sm12278551pfk.99.2020.04.06.10.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 10:04:08 -0700 (PDT)
Subject: Re: [PATCH 2/5] nvme: clean up nvme_scan_work
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200406121352.1151026-1-hch@lst.de>
 <20200406121352.1151026-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17f375cf-15cf-69ea-ab2c-06844cf4481b@grimberg.me>
Date: Mon, 6 Apr 2020 10:04:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406121352.1151026-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_100410_607524_49F27FA2 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
