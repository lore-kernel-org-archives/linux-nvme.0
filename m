Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A1EC4CEC9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 23:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72638218AE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 23:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FJ9tErK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72638218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dt/sq/+/La3qdguifu7iSF7afXDFGVhNVyioO+WPxeg=; b=FJ9tErK1wJ7aka7MOqQiAHciP
	E9fHKNeBo+csYE6IDjaVvbYCKa0PFb4x+54ZNXzlOQQonV03yhyihNLodXKqRi1Ag4JsnLgZqGG6L
	rKwkmLGyX5Mu5OHAnAve9mWuxgMjsyOZ62xni7WUUsOK+qTJHX1fblMv5HFSjsYtZ6LCBrixHN0e5
	BlD0nRc+6BXc14HM7kMxuRyZer8bRNotAobUunQGzeJLIafgjWpqTB9xcFXhsUIcvEhvmahGisGqn
	O+SV++0FR8aqSnRWAPfRf7LTFyDGp2ZXueFR+AWBRfZAdzZ3MT5scggv/EMm0xb/aUZrA2OztPEBA
	GZno82Mbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAjY1-000502-Eh; Wed, 18 Sep 2019 23:39:45 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAjXy-0004zd-W3
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 23:39:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id b9so1159901wrs.0
 for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2019 16:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4vlEG+ZKcxG0rZW4gnwqwcC4Pdh9BOuassBEU81b5+g=;
 b=Ieyav+pNujPLe0VK3gBS2Lh0YubUxZS/aH6LKW4I5lMzE3d4/ONAnT5ikW+X2d0np/
 2yUppEn7wkUi5vXo3lobBnwgakDLYp/lXrYuFH1H8c0c+oDnPKOUfDhH20HcjS7ANlkp
 Ugf2v3+pKvp/ru7W+EVKNQcBFhAViM81Hil+zfAkiotTA6XbHF3wQN+V9w449qxlIo3W
 p98tppw+mlAGc7EvfZZZQbK75JKmj/1XYrpT2sv5CPTO7SX3foG61srdI0pI5eTq3NlV
 AxEAm0Wasi6hnUvZdsTVdM8tVb1JjLpkkuBdIOSwqlDpBMl5DehFy4etXPjYlFp9lYbF
 F4Iw==
X-Gm-Message-State: APjAAAU4ZFFoCN7IQwqBw0pG33JlLZ6VJddHp8K12Kpy3ETpcLO+iWLu
 B5gDVOzzz/+5dQUfx+PVdKq6h/Ky
X-Google-Smtp-Source: APXvYqz5C/D4hU3Nv56AM0kieozYCiDchSRDfG5R3wAPhtCogXEFKrQXiIIu7x2/TYd+NkLchXLaSA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr5045744wrv.240.1568849980764; 
 Wed, 18 Sep 2019 16:39:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id f143sm6660959wme.40.2019.09.18.16.39.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Sep 2019 16:39:40 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: fix wrong stop condition in io_work
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <B33B37937B7F3D4CB878107E305D4916D35C21@ORSMSX104.amr.corp.intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <570be145-037b-3236-0b18-4812df7650b9@grimberg.me>
Date: Wed, 18 Sep 2019 16:39:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B33B37937B7F3D4CB878107E305D4916D35C21@ORSMSX104.amr.corp.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_163943_034846_7E9AC686 
X-CRM114-Status: UNSURE (   9.03  )
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

Thanks Mark,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
