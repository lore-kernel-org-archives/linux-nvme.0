Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E5C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A9F206BB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMsyrDJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A9F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qi4RPV8C6sBOJP4tesnLNmLb8jT9ITPPOE4eV+0ntOM=; b=XMsyrDJ7bY4PJ+sFSInEimRMx
	GGMLvQRQNkgWbuVcwU47lAAxmeLphv3cQcC9TI4NWJHCYlzNswi/nDGj6OkRc4OIru8HPvl0et8bw
	0vNhl1oAKlP0uHi2WQWsEwz27XDaDMtDpjwVAK0+S4IWl4fM26KtjlicSQzFmRIWLqfiI16JwgHYX
	7/TTj3xOMio17zC2zQasSxFhBNCPpqtoOOuCfXzy82kIB4JcKFXpk4DFfbymHHV0vjN7mYCQ+OmoU
	DzmYAF5R1Wa8KdVubdkusSoP4aofsW11iF5aMjUwWDCctxSUGCmi2Bk4kLJfoaLxaDNmmKgP45/10
	ksHHMQtqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5yly-0004tO-St; Thu, 05 Sep 2019 20:54:30 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ylw-0004ss-AV
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:54:29 +0000
Received: by mail-wr1-f46.google.com with SMTP id h7so3289939wrw.8
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 13:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZllE0gIBJhpo05kcIgz3B2wrvprdqJzTT5m8KUHoNB8=;
 b=uGHUaipKHpAez4G3YP5lve3Fpkkh9+lLFSMgaenddlXrasx1VV+IcOZ/r0Um/pu9RB
 t07RQzl9DzweTqlAJkUSQhMqW2yI6qUKV/ayDv7LLet9qaBckxbURb3gv3tHmzzHw9Ih
 TN6uQgWnLx+TEI2oPEP5qxuOaZaabg62JMNNeaK7tQEdikl8abTp+gA+S2B8yjXGe0yp
 mM71Ti3W6xhPkfzKoskLgMk7V6mhWZYCaEoWXJ3jlS9M+kq6kbtQczyDiwl7mBCDfBLS
 RFnZNU6j0PHomOKCiB6pGWrAXMFPrM15GL8GYgL0D2RwXyz+5r4nL15ET11AsgZu8O/P
 a1kQ==
X-Gm-Message-State: APjAAAXtidUj2kBhOn2Nbr7m9tdKO8tKiZTb+/+9RzLdqdx/9Bq/fGr+
 RN9ONguQnxwEzqyaP742ths6YYDe
X-Google-Smtp-Source: APXvYqwiBhJHRNM263x1v6IXqCmw3woJ3rBTFzNpWREjsOeG8Ud+Dyku0ZqxeRKaibBKJHrqGliW8g==
X-Received: by 2002:adf:f186:: with SMTP id h6mr4116341wro.274.1567716864631; 
 Thu, 05 Sep 2019 13:54:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id x17sm7209495wrd.85.2019.09.05.13.54.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 13:54:24 -0700 (PDT)
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
To: Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Omar Sandoval <osandov@fb.com>
References: <20190905174347.30886-1-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2b48ae83-77ff-9235-83b7-98469f591c8e@grimberg.me>
Date: Thu, 5 Sep 2019 13:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905174347.30886-1-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_135428_365954_A26631FB 
X-CRM114-Status: UNSURE (   9.14  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good Logan,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
