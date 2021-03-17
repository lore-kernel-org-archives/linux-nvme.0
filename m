Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D055C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:19:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E3264F4D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E3264F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=14Z1Ddrg0wnrAiLsm6zqhH5e1lNIupg8Lai0IgzEfoA=; b=FF9uKDlofpViRsKy2dHJQDnsT
	qPEApjHmicGqjeG5ONVDaJiGOqx9sfOEbtGtbXPHvkr+mCcOvFDaElfLukABsSvhDzqWbtqBlzyAQ
	TUldebvssume0sZ0d5IoyEY6DDPLNgwZoLwu3JqyRpfGqFvDdycsxbuVYnOkeOijgJ26wqngyd+lP
	ede9hZ2mC6zYA6DfRFJ90gnMLjf+r1d3uoVbB7n9Ymff5XeDO6MRfZ/J4q0e3nWVOOT/EIQeBrZqL
	9tvmUX90eNZKZn2obiJ8VdNwWr6N4sCiZab1bgd4MAMO93aO4Fs4CXzQbg44JT1hdeqhBF/FpWZh9
	uh1PMywIg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMJuC-0024tU-Tc; Wed, 17 Mar 2021 00:19:20 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMJu7-0024su-OS
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:19:18 +0000
Received: by mail-pj1-x102e.google.com with SMTP id
 lr10-20020a17090b4b8ab02900dd61b95c5eso2230915pjb.4
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O1J+8wt1Vex75dEgxL5C7ce2IaDlNSncFbSUGBD61z8=;
 b=Y/GDAX40Zm/L4eIzGRizE1tVIKthcps9AY/tIc2QL59ixoGbtI5tYWwnmj16S6oAhg
 0zi1IrVJ/hqK52gICSB4FtLKK7v81VrtQFmy9GgPuBzbBVovOrnJb4WvBYJH2txABb1a
 /PXKwI72x19qiZcLX4bKz4odbpn9XQgmnI6fsaYBt74dKHJTGYfzC962Chy74rVzNIf9
 3FYQ5Sxy33ypQLuAlqIlPIdWb2NHOIV5LP+t4ML4+o3HRt7JCO7EYE66G/PJ/rYpQ4X5
 Pq5GIcOUBeGWjtc8XIB9+icsJD+mFhPq7MKNl0ZI6Mo/2lP2PCjxO6ZSzZkT1ZufPdie
 R4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O1J+8wt1Vex75dEgxL5C7ce2IaDlNSncFbSUGBD61z8=;
 b=mY43dISp1b5od9+3mrVlSENTv+MQkUYSQ1cY5Z8vQOCkRYC6ElgyBYyzK+liZ+t/Uw
 eDyfnM9SpcS8OoV9NZz1lZZsewJQhbMbvX0+0NXbxXeDFC6wzVmZEzWauecdRIiwnAMm
 p5yKnTmjkRBRQuA5VYUCetEWlGx18gFqleLNyjPsQdMtzONEHzrdRMpa3ojopt2XmlCZ
 jH/6/UCqkSZ3tkCqTl+6EmgOk9vMCwaT3K3yPBSRTKdzKNrLj+/cNZ88aA7MoiUdsefr
 eM0jhDL6zh00F2p8KU7cUGn2itIkztV24Za6R9gZiP0LC0jFxqNMT4bGwyY9I+kcwnS6
 tvPQ==
X-Gm-Message-State: AOAM533OSS3AXlvLsY9psjjUoom5iDAz2iUsGozFrnyZ2aQhx/3RX4FO
 nHlbtZNkOa4/wgSngdLDOhQ=
X-Google-Smtp-Source: ABdhPJxH0cYtc1vFGxLt76xFDy8mqKgKbY2Ttz539NWkKRYLS2cKSdINZZxFAhUZ/hMXp0+kjd37QQ==
X-Received: by 2002:a17:90a:5b11:: with SMTP id
 o17mr1694215pji.32.1615940354365; 
 Tue, 16 Mar 2021 17:19:14 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q205sm18727437pfc.126.2021.03.16.17.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 17:19:14 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
 <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
 <20210316020229.GA35099@C02WT3WMHTD6>
 <21bc3b62-967c-6cb2-c9f3-7da479aef554@grimberg.me>
 <63ed162c-77a7-105f-5f29-47fcd32f57cd@gmail.com>
 <20210316212559.GA4161557@dhcp-10-100-145-180.wdc.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <ced0b93a-3867-0756-bdd9-ead73c34b2e8@gmail.com>
Date: Tue, 16 Mar 2021 17:19:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316212559.GA4161557@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_001915_955035_D119872C 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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


> 
> One more question: if the controller is in such a bad way that it will
> never create IO queues without additional intervention, will this
> behavior have the driver schedule reconnect indefinitely?
> 

No.. in fabrics, there is a max controller reconnect timeout that will 
expire (dflt 600s), stop the reconnect attempts and delete the controller.

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
