Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DECAC2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:29:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B3A20857
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XCwND5XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B3A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JPtFJqLdzopmaDe0+MvRhlrrssAbH+nZuPqUXg2oeFA=; b=XCwND5XLILgekAUmZ3ueDytRd
	9kvVH4mfVcYXx2QLhYHWqloO1AaDhdhBdcIR74785s4modbjfO3JfeDLkshB4r7iFIw+87jAv2WFg
	CwmvGH+e8qxyUxvm88dDGLzAsjOQjOk5/ED8gs8W1k6E2kmu+VAZRaKKiD4C4pWkRwNHwc1ZY3b5D
	QWLhAUWr6oHB3pcNHh2mdwCRsBT5/2TbLzue05+ASFKRRE+T1ydy0AxqPx4kGgpkl8Fauft1PvgAq
	2KvBBSo1VsQ+roE3P/XnmWCUkH0CVZbgr6XVJjzdMPOopkemNSxFGX/N3uqWDNEC070guEC1ZBDsO
	U8PTqeV3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khP1U-000118-80; Tue, 24 Nov 2020 03:29:44 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khP1R-0000zj-DM
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 03:29:43 +0000
Received: by mail-pf1-f180.google.com with SMTP id x24so4812484pfn.6
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 19:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tk7+VHs3A54MHBNnCv10uKUdSrI/jE3yN5ABibRDiUY=;
 b=ZTkBUz07nPyI55W6CNOcam4MUhcFbjxhaUnMO0Oc7bF2ZOtpBlaUFIE5wiSDkhMFl4
 mPaFTOzSrm4iSFZU4hihII+F3BDzev5ZQrI2TLjlfc96CohsdiTSDV6BWNs4KCw67Sez
 9LheCqQQeixiRCgKm6wVSmID3rh5aQEIMvtFienUI1qGSHgVkls1SuCsFNDK3/B0sMzV
 82ppxK58ygOKnPGiqjOEW56lbB4y7DzaiYi8BcWeELlcC+mCZR0frBXg8wFYeMWEd0L2
 a0+Yd0J5rOEHAS0wuk3PvMejfNK3ddWQ3GWRpDOhQTTj8qFUEAC1sl1DIwTQSJe7F2gU
 cIMA==
X-Gm-Message-State: AOAM533BfA29ORkW5oy6cUNdHnM7TpodSDtfNID5r3K8qpwBagO30JZS
 WX+uRIEOb9lAW/NjkDG1LiQ=
X-Google-Smtp-Source: ABdhPJyKNuXF8srsElWxl86G5Fv8L7MJYCVGyM5K556Aqe/33OS8zCTCadCOeAMy+wSk8rwc6jhmFA==
X-Received: by 2002:a63:161a:: with SMTP id w26mr2058225pgl.17.1606188577594; 
 Mon, 23 Nov 2020 19:29:37 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id 3sm13007624pfv.92.2020.11.23.19.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 19:29:36 -0800 (PST)
Subject: Re: [PATCH blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-5-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <6f235fda-3d68-f0cc-f714-5c1daf67c28b@acm.org>
Date: Mon, 23 Nov 2020 19:29:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-5-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_222942_314410_9947E915 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> With bellow commit, the version will be updated base on the tag
       ^^^^^^
       below?
> fbef6555 replace SNAPSHOT with auto-generated version string

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
