Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFDC2BA19
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 08:22:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1297208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 08:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OjNkgSKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1297208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TShqSxyqZMlsI2qibv9S72QRbxxSdJmyAnYG0eEGZ78=; b=OjNkgSKm8BaO/PgUZUtw3+dqg
	2yx0/H1ORQCUks1eSGbmdI8otxaoYPm+Ob6+yj2b8P1kNnLdzZfDuA7K4A8IyhYSrJqcG9tMwLypY
	jkNBBsxe4DN93XVLx0U57g/q4xOeRO25hPpriatSDbuDJ1nErGUcd8esV35JVOi5EDXaTus2v5n7n
	u3IYuu/um53kEwQiuHXL80vBUIy6VjuCZhb5GBlbEwRrhqHySAzkSYYFE8pYdBDy+GAukaGQ7Yl42
	wrEEL5HIZzW2fhR9Y6cPG+/l1UIn3B2JozoofgtzQ8FoGygLFtyWM3a3awtjk3wdVP53Fk+5kVjRL
	MjXqv13NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRX7t-0004zw-Tt; Thu, 23 Apr 2020 08:22:29 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRX7r-0004zU-37
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 08:22:28 +0000
Received: by mail-pl1-f196.google.com with SMTP id d24so2068717pll.8
 for <linux-nvme@lists.infradead.org>; Thu, 23 Apr 2020 01:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=473AW66mVy+pUi3Y0dZE6gR/jEwyIoKjnj4RVAOR4pE=;
 b=jE+GS4o9b2saYkl/pTcaxmZko8h2oYOrvvJSn3QzgV7besyff96TVk9xABxABJqQSG
 Pk6oFZmLnvYqJqgdhjZpwfDhVPG35H2e3MKxKr0YxVMW5hVQe0MRUtunqPLukbjrwfxx
 YUEnXZfk04165CPdWbVKaYdaFXIAVby8HDPrG0ILQECWe2yabpNuTjz/xwct9dWCOdee
 RRmM1pagXmaxfYdPZRrfFYjUOwaQH8cXfaz5GSXdEOZSWW9Ryjq1MHO9HPbIL5X7DkdX
 7MSJlirBS/qsBoEfk4drVWkD1mOBxkJhCsR1gK/y2eAmyVD5quRRqBusxlfsPC/p1zOX
 KTCQ==
X-Gm-Message-State: AGi0PuY4nN1gQvCd3QON9pEO+fmLmrxAOyMEaPUh1eTpDHHYpTPULpFs
 0iFaTCi1ZNmSVyGR66+wG5iWIQ/4
X-Google-Smtp-Source: APiQypLYaJecr/QQhLRpmZ6ZbDXiJjLrAoZ+5RL+UyLOw0GPNm64RJ2+kMebIaIjuaCLgYxfj+DgFQ==
X-Received: by 2002:a17:902:7286:: with SMTP id
 d6mr2763332pll.241.1587630145461; 
 Thu, 23 Apr 2020 01:22:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ec9f:3a3e:8aef:64e5?
 ([2601:647:4802:9070:ec9f:3a3e:8aef:64e5])
 by smtp.gmail.com with ESMTPSA id a13sm1819481pfo.96.2020.04.23.01.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 01:22:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] fabrics: allow traddr to be host name for ip based
 transports
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20200401215344.2519-1-sagi@grimberg.me>
 <20200401215344.2519-2-sagi@grimberg.me>
Message-ID: <fd09956c-2b96-4b26-bb38-ebf00bf48156@grimberg.me>
Date: Thu, 23 Apr 2020 01:22:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401215344.2519-2-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_012227_130870_FA75958D 
X-CRM114-Status: UNSURE (   7.55  )
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

Any objections with this spin? Keith? Others?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
