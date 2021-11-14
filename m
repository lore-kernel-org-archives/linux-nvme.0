Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF56FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:38:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8873761056
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8873761056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQeOuSju6icUpzFtl3J+ujGxpswGwYgIxsd9Mj/dXtY=; b=iRDj5A8ed6VgARRodW4zGwv54S
	MDouxb3WBYSzih8yQXiDws3EyPzvUEEHYIKjSR9d19/bUZqBYd0bdpA3jBphjIvAroMY5QXG+7J/L
	WMFB7WR2HK19I/FerI5zwh7Mesb+mgo4aCjtHlZLyMsvCmBVIzBn9ZKBvBpfjv38kRe8tkr4pv4mV
	HnfcxGfiB5e9z0rdEKfIVreII+DeKO7l3zPzoAarPV8itgcmZvS6emjgh2WCpwS50LnJBGpq3AnKC
	/dz6IJftL3hSIv3MuTWVaDdtZ+fJwyS+c45ReEo27/9CWEI5YLlDa5FdnlnbzmeFRstYawwxOK88W
	jpFiKoDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmCuH-00DXS2-E2; Sun, 14 Nov 2021 10:38:41 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmCuE-00DXRj-Vo
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:38:40 +0000
Received: by mail-wr1-f52.google.com with SMTP id u1so24335626wru.13
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HQeOuSju6icUpzFtl3J+ujGxpswGwYgIxsd9Mj/dXtY=;
 b=FRp/VoEBbLn3+zVRiPVPozifh1sG/kkt6naorrU6gkhq61n+tZmPz1ss0SMlCt0Q7x
 zfOj//yeWHbIP9L6ALJC9Y4Pzf4lEaaNAcoOvDFZHRylODrm8y4au5TBNV6PnghxDR5y
 PnQbqmobiCzLUL3wBRkjgEmreE5XVpqz2bazTKyN+cplFNaOhtqGdu8bFtoRN8MgV/9+
 5P20AAJii88G1WuFEPYsFzxLnGPfJPY/4N0rayLcdwtmQnQ2Uk/z1P1Rt5iNmo+eiwd3
 J/6kcN1Qc4yhoiBwlpPtpRUJzfuSMt+bzoW4CXU1I8pga5Wm3fkPDUtZp/rXPmjwr/Hk
 wEdQ==
X-Gm-Message-State: AOAM531QveFT8cZpxKuVCo+Ry39rH2wn8MDlI5McxJXb58x7nqSI3Wqt
 fHBFu5Y7YD+bNDq0tiozGIMquwRGMgo=
X-Google-Smtp-Source: ABdhPJz9YDOd/RZFdR+VR3HKJQ8dx/xc26UZvF4mi1nGmEwpSak70J+WF39KfMC6xZnBcyxdC5UQOg==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr23478185wrt.233.1636886317616; 
 Sun, 14 Nov 2021 02:38:37 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n4sm12859168wri.41.2021.11.14.02.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:38:37 -0800 (PST)
Subject: Re: [PATCH libnvme] Implement 'dhchap_key' host and controller
 attributes
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20211112130053.97493-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <550af202-0a01-63dc-0c71-ee893d880cad@grimberg.me>
Date: Sun, 14 Nov 2021 12:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112130053.97493-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_023839_057178_57DBDE89 
X-CRM114-Status: GOOD (  13.32  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Implement a 'dhchap_key' attribute for the nvme_host structure to
> support the 'dhchap_secret' connection argument, and a
> 'dhchap_key' attribute for the nvme_controller structure to support
> the 'dhchap_ctrl_secret' connection argument.

Hannes, can you add an example of a json entry to the change log?
Ideally there is some sort of documentation on what is the
format and how to populate the config file?

It is unclear to me how the user is supposed to work with it.
Is there a dump config functionality like we discussed before?

