Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8018C38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 16:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E442083B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 16:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W7f3BWU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E442083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zL0kQx1CtUo62i6lKkC2W0PUc/CGiEh7BnVRg95SPo4=; b=W7f3BWU71n0QZmUKxuIbAPo9K
	vYIQxfipP6jZ1y/LZ9FKDxlngTGXYQoPdkbKHgtv44IY4pmfuMcWJm+KRtbialAjsA8hkKaw5z735
	SJys+Vya8QuenY7C7PYVwfJnvSD+7hv/gaXb+HrX9jaOozYxN/g7aUr4bR4g7ju+FzMDR8kuylwN8
	rw30/xfOWYpKIPfZz66oGaXx89C1hsC/9QlSi+6zuboCugX9LVtUNQQTUMy5kkA32LHRsxShT6pgb
	mEftBYlCoksRi3UZp8ta2do6qtesTuTIQo487baxD2LJ4daoPE/IegmNIjzZj05wJqc5kCb8mfkLD
	guGhRqisg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWjFQ-0003h6-M8; Thu, 07 May 2020 16:19:44 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWjFN-0003W4-Mm
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 16:19:43 +0000
Received: by mail-pj1-f53.google.com with SMTP id e6so2829976pjt.4
 for <linux-nvme@lists.infradead.org>; Thu, 07 May 2020 09:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=26DV5j0vhvAAps3AObRWA5ysWfbcjtkcbMx67teUEWw=;
 b=Ho1iBtKt+6Fp96vPE/beIkWTe4GYhI2JAeRjyMlE5eP7R1ui+GSC47MUSiWaGEKdZt
 OVPzQb6AptJvopxl8MIvxJi44XXvHwkkzhy+ahWG9kb+sbk3RjCbXH07Hyui68Gic8iB
 yrUC1HBzKfjsQLGtSnGXtDAksUnrrQQ/RzCgEbxK73CBlJmLKQarORBkl34/FcNVxcey
 WfGY6n60DtWFzU5/zzZ3qiRYpqGglHCMoEoIGcwWecnUmkVhAUjM0nYHTua6aLouMGKw
 m1Sgh8G/WRFrTOTt8SZRcxeLLNAtGAigxnDiiPE8u3OdjWRYSeGtpz65nQv3nUxDglh8
 jL1w==
X-Gm-Message-State: AGi0Pua5wQtsNZHsJu4Gpw+wifkJOYtODH8Ncf0rowo7P24U2pmDrpE5
 TZfDZeQq0EZL5O8FSHliDXYj/X06
X-Google-Smtp-Source: APiQypK8PhWq/QwJtV+4wo22c4HLNoO5Gd/0HnVV5rh3oAnn96zq6/tmDL6ltr8XX25Smb1fXF3Odw==
X-Received: by 2002:a17:90a:a0c:: with SMTP id o12mr890376pjo.29.1588868379267; 
 Thu, 07 May 2020 09:19:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6507:baa2:4de7:40e9?
 ([2601:647:4802:9070:6507:baa2:4de7:40e9])
 by smtp.gmail.com with ESMTPSA id m14sm4048212pgk.56.2020.05.07.09.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 09:19:37 -0700 (PDT)
Subject: Re: NVMET Target with esxi 7
To: Grant Albitz <GAlbitz@All-Bits.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <a28d8b24ece54f8db6e21c78f0bb5aab@All-Bits.com>
 <711adc2d-dda7-d58f-0884-2c6578e6c333@mellanox.com>
 <4ae82f486cac431caa6928e56fe5e452@All-Bits.com>
 <f9460444e88440c280df5c277383dd73@All-Bits.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <263971f2-dc9e-fc53-06e9-9c3c80ddb8e3@grimberg.me>
Date: Thu, 7 May 2020 09:19:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f9460444e88440c280df5c277383dd73@All-Bits.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_091941_746271_38D35F35 
X-CRM114-Status: GOOD (  11.63  )
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

>   Hello,

Hey Grant,

> I was trying to configure vmware to connect to nvmet based target. I did not have much luck. VMwares official stance is a very small vendor list. I did see the recent additions such as metadata info. I was curious if anyone developing nvmet was willing/able to test nvmet as a datastore target for vmware to possibly add this functionality. At the moment I am not sure if there are a large number of reasons its not working or a very small check.

The linux nvme target does not support fused commands so there is no
support for VMware currently.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
