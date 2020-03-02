Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884DC3F2D7
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 17:41:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219A422B48
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 17:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTGehcDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219A422B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=FTGehcDjPuYpJiEHjn78zMkAe
	p3fckZive6UauFofLz9KXdXj2acOX+D3xVirS87E5z93onyUZ96tc9EfMYmM7Yl5y3QYpdh2Ps9HT
	gIDE2NhpffLhaIaWxjBioABBFqwxezcPBLxZY8AfuD+o470aR9GqpVZHJk4FCJ5MzteL5jJ6p58Eo
	poNa4B9UU6B9lLM9Dd4K+QRCy5Cu/X0SS+pqgv8zaM0zTP4zvh6XmDqcJPxkXsrsQh01J4ucxPsuF
	d+bBn+wFZXmPXbtUQo4/a2P4JyVOTgMmDEz+QEjsVHTYG7ygyGFbm5tiafc6nuVRDWi3Txpzr4eD6
	pZ9eRmT3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8p4Z-0008Vp-5K; Mon, 02 Mar 2020 17:41:43 +0000
Received: from mail-ot1-f44.google.com ([209.85.210.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8p4U-0008TY-CM
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 17:41:41 +0000
Received: by mail-ot1-f44.google.com with SMTP id x19so62350otp.7
 for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2020 09:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=hloOS87ejAB/q6Yqx1dgMhv/y60KYFmeKjlcq6xriQFn/mbks4i62s+zNHPDJZzMrE
 2mj4zvjd96MQTbAsR+n1rTdLcDlYAGL+teLXwPXgWJHtJI0s09GSj17sllifUfiYRWGu
 QLBIJGuBEBfBAAwRSAI4fHJvS/N9c4WipRVfRCFcutWUf78qZCyLuLIfIJ4J4YdDNWJu
 U41AOP2RjB2KmKnRLNXMI8KgzMBywCP9S4SeadRrb+SaZHzEmYb/+Xp4FiazV865/s/d
 VXXOpw0bX7Qav+uRp9FPebUeZHbXMT/1v8b/EFJgW2MHEgatq6xT5wSNSwMeyUWgPdFl
 yrLw==
X-Gm-Message-State: ANhLgQ0mPs4O+BesjeVr9k+7iMhO+FX12gce4Dh0+jv4fjPo1AUVskim
 suxmwaiQfiU4j7mEnjLRn3HBM0s4
X-Google-Smtp-Source: ADFU+vspbyF85YpwfawF7tUSKd2CXsK29H/wVlg07phPwE2s+fqx3IR9NY6T8FzDKM1pJSqLF9T0bg==
X-Received: by 2002:a05:6830:60b:: with SMTP id
 w11mr249761oti.350.1583170897331; 
 Mon, 02 Mar 2020 09:41:37 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id n64sm6785136otn.35.2020.03.02.09.41.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:41:36 -0800 (PST)
Subject: Re: [PATCH V3] nvmet: check ncqr & nsqr for set-features cmd
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200301002841.3959-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b80fc04a-a10c-7967-80df-05e61ab0106b@grimberg.me>
Date: Mon, 2 Mar 2020 09:41:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200301002841.3959-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_094138_447359_D4618E84 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: amit.engel@dell.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
