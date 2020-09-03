Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A4C43461
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:59:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A2120678
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2VtqWKFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A2120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=myelxH4vqYZkV+TnSBOG6hcrBbDvsjb5PNkg36yN+Gc=; b=2VtqWKFX4WA6kkCREG1auPpe/
	kOzp3MriinqVzG+pxRCvS5PiIdzAlX8pGx92PhAkNQEoSTGwuuRKQXB669hyHHrt3B8MzqOtInj9c
	FpdDSrOJgOY/2sewgIp+UUDFfSDxYpuW2MHDMDS8LE00coRds0ApTYlz5zdoQAnSJQKoJ+tKHADlP
	A5+VBl7fcDBbryk6gfwoxW6Ipd0HtdEW2T1pEwFbck4lqqcCEQlzdBhWv1OFo8yFpcdaaHNuY5oTE
	a+rib4u4RYEtbl3RfL+zVaJPte/0jb/6DqP903qmkuYHf/uJZKX4WZDzxGZMaYYa2uyy8hYc8Ldlj
	OBXmtBKHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDxGf-00054W-1v; Thu, 03 Sep 2020 21:59:41 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDxGd-000542-HJ
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:59:40 +0000
Received: by mail-wr1-f46.google.com with SMTP id c18so4737556wrm.9
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ivftT5JA6/pSfHGFCicggdsVATHYc67pLDeA6p6l8qo=;
 b=lxmsx0eCN9uDxmyOBIPk4e0drBoNOMTn3mSjfz5pzOIYjNDprUm39buM3ZCcnixGVS
 kN7Datl3zYbZ5smc7/icNOrDpttNriG0gUOY89X3YTWO5lELOGDjKwRjiwESTYhKHzAU
 mnf1pbLpbE2zfLBoufsuZkzXIzAOjFjRwFgBGDAbylS86waQuk8V7isB1cYy3Q+4KEwC
 tgF/2hATdLAuXQnotf9jBO2aQ6YpMDFM6ZaOLTU0ogkURVBiuJfdPfcsCGZJDf7oeNPK
 Id5fmnAXr9rzkTnpV9BTf1ljyPgClIa/Yoy9EntPYqLToZ8kB1EVYRSAUSfr8b0J6HMx
 2D8w==
X-Gm-Message-State: AOAM533diPHzfgJ0ZZMdCT3Ehq4J8e60XeLyyuAzJU553vd667sPuGF3
 kC9EZ8YdiEsqxsT/XUZjKwg=
X-Google-Smtp-Source: ABdhPJyrdJ/n5NIbsf/zuGkL0HTpU9ZSMEFsU13KKGAn3fg0orGWuWMjGuMArd7RwdQKughjPJsj7w==
X-Received: by 2002:adf:e407:: with SMTP id g7mr4407321wrm.349.1599170378230; 
 Thu, 03 Sep 2020 14:59:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:79a5:e112:bd7c:4b29?
 ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id u66sm6722492wmg.44.2020.09.03.14.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 14:59:37 -0700 (PDT)
Subject: Re: [PATCH v6 3/7] nvme: make tests transport type agnostic
To: Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
References: <20200903212634.503227-1-sagi@grimberg.me>
 <20200903212634.503227-4-sagi@grimberg.me>
 <846fa009-5687-5532-236b-e001fd7a8200@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8421bc71-8055-c9ec-d699-795a5d4b30e3@grimberg.me>
Date: Thu, 3 Sep 2020 14:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <846fa009-5687-5532-236b-e001fd7a8200@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_175939_588916_71525F03 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> -	_nvme_disconnect_ctrl ${nvmedev}
>> +	_nvme_disconnect_ctrl "${nvmedev}"
> 
> Sorry... looks like you fixed the quotes in the wrong patch... The
> quotes here (and in a number of other places) were removed in the
> previous patch then fixed up in this one... Maybe run "make check" on
> each patch individually?

Darn... will fix shortly.. thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
