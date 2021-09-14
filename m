Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D95C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 14:28:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C01B60FC0
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 14:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C01B60FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NSFAACAaxUYx0bd2/AA901Xr+2PxP5F3LWqrgjqoMx8=; b=Ot/hlcKdL2Qq6T373670KCO5eD
	yuirzinxKQzefV/o40Cbz4bkFW+ehiIFn5QUJmmu5csAX1rn61YcqJDNPPFZGhmMEUvZN/be9lGbC
	f1r+KlRYOBxtoUcCz7BYHg3r5z47goi7g8LU04uY41hye7P9gCa9Rhh+t+MNEggHdlpKzm5Ysn+09
	gmDoMKPDdJ9uiAKLlMVKogbbQih48MFhy2g/LK+X1g2WtnnV6r84IQw5HabRuiCsPsDGqm/U0Vu9F
	XyiPCJzXgN+t6lHcCnvJeQtNsddIJ+6bUFDkg5ZbtUgZ33+ERWgahO0Y742d01Bqv+kAwmQvDjLIT
	IhsQG3Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ9QA-006064-Oh; Tue, 14 Sep 2021 14:28:26 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ9Q7-006050-P4
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 14:28:24 +0000
Received: by mail-ed1-f46.google.com with SMTP id g8so20222764edt.7
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 07:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kicEnr2Cugeg1q66CI/wvoiBYIFJN2vXcDbJaUW4tr0=;
 b=G01S5gtFHZcaliNlCp4WH9Jh0MzFdNmS7uQ45mfUz7k50xkIMxMWuidrwnXKziGg61
 VMlF0V+LHXH1DPSZM4DL31bTOQxEu6GYGa4c+lvgp6jBvCANRGBmMplsLf8sav9sMPq4
 LgPX7rIa095qyTvdAAgKi3YsqtwdEZ2ZqdjbejSzEJMRMnbm7Gq8qe+YeAJNjDlTxf9I
 hKadZ0tHc4z1lYuTq0w22BGYlIuTiqHC7wHKGOCdVwFzcD/YjHKpnzsOzMSKjnyBmiSV
 6w6+wpbPjsX4ONho4tdoNN21yueOBWK0fYlXRANNnYvkWPzcdND9KSmieqcZnFJexP8R
 hDcg==
X-Gm-Message-State: AOAM530hiSPQuNoeeiePiRxSrw3jgxej8cGtHNMMrUe6Plxi8Ye4YsuD
 2jw1J999u1QemPl39hCoj08=
X-Google-Smtp-Source: ABdhPJx/TtwjqUpck2gI5RgHPPw6P8avek2CfZ1CWFvY/bPMA1mWlaDBKIKo2V5dnfBmLBqhcPI+wA==
X-Received: by 2002:a05:6402:150a:: with SMTP id
 f10mr19579705edw.318.1631629701787; 
 Tue, 14 Sep 2021 07:28:21 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id bt24sm5011798ejb.77.2021.09.14.07.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 07:28:20 -0700 (PDT)
Subject: Re: [bug report] nvme0n1 node still exists after blktests
 nvme-tcp/014 on 5.13.16-rc1
To: Yi Zhang <yi.zhang@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org
References: <CAHj4cs94pDUfSSfij=ENQxL-2PaGrHJSnhn_mHTC+hqSvPzBTQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ca405578-5462-0ab9-91ab-de9d42ee0570@grimberg.me>
Date: Tue, 14 Sep 2021 17:28:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs94pDUfSSfij=ENQxL-2PaGrHJSnhn_mHTC+hqSvPzBTQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_072823_862751_B6196644 
X-CRM114-Status: GOOD (  10.91  )
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


> Hello
> I found this failure on stable 5.13.16-rc1[1] and cannot reproduce it
> on 5.14, seems we are missing commit[2] on 5.13.y, could anyone help
> check it?

Was it picked up and didn't apply correctly?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
