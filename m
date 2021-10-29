Return-Path: <SRS0=7cDU=PR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7613C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 16:15:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1A36044F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 16:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F1A36044F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKXUH2KRwO4V5xMJ+T8M1TeZFj9xrcQY7R7PFnzsrsY=; b=oXSw2LV2JR1t0rcTmyuxeRxTOQ
	Z5PsFoieKcjgYu7lsFp24jvbxwkQH+qqxoa+AHDRDC1AfGpgPv2tUWVsCF4yph0aErDcZdqFf7qPW
	CvE9R1RzZaZezguVtchDatxXYdPOfEutGajUd0fHlNB2FhGsphjHTe5/Y4fnMlh12eL9jSwjSnzcH
	fO89PyaHNaRHycLqWE2lkR5NoDZueKlaw8VNa0uO86HHoSlUL1umpVLWpGXhsbeGT9yPK01RvgXWM
	y5g6zxmw9Zac/LFyaxg9mp01WLUnSqxzHf4LkHzsdjIw9It3dYcZln2UbYibt7RMSa8gq8tOgr2is
	1Chc8BbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgUXl-00BRBT-Pu; Fri, 29 Oct 2021 16:15:49 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgUXj-00BRA6-4b
 for linux-nvme@lists.infradead.org; Fri, 29 Oct 2021 16:15:48 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 v1-20020a17090a088100b001a21156830bso10983972pjc.1
 for <linux-nvme@lists.infradead.org>; Fri, 29 Oct 2021 09:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jKXUH2KRwO4V5xMJ+T8M1TeZFj9xrcQY7R7PFnzsrsY=;
 b=HbfLQLn1AONHeQhXyUyCuJ9BvhFuQ8KkVdhbHC6cp/c+WBrBKiYeBO+t1KUVJIlmkK
 lqIeYx8WK/aUTsD9nPoHBeJ96Z9twfyHD5gnzS10dKA4a0Nc8HrwH5mO87J117PTR2ry
 nS3f3S8HxzJw6tdUTL87TmNMr0gYyADdNok+cRVFDeH4WWVmDxKp8ujQIFvIcseJMdxl
 Hr3dMyeMJNnHSks0Uyf2HOqE1iWMt7oe7yuPb9yq3m/PEMQLljivMmPLAu3F9ydZEtA6
 w8z6L0VeyZu7msM87WvjrXW30818amQcGie13Y3cmrLF5+h4Lme9eQkiv/E2YKL5m//T
 kmcw==
X-Gm-Message-State: AOAM532Xmqp+8LiMMnlu4hRG3Rcoueye63zLZ/epYiq8VBwmyykVK6Nw
 v/LX1thXDYFWJcWObgxZqqU=
X-Google-Smtp-Source: ABdhPJwmiz+YImWEBzmpCqKfSuiQbDI0Gd4nWkdhrFsTjLBkZ9Q+upPQOIKIxvtxSPGosOf0hyw62g==
X-Received: by 2002:a17:903:248f:b0:141:5a79:ae48 with SMTP id
 p15-20020a170903248f00b001415a79ae48mr10311651plw.12.1635524145387; 
 Fri, 29 Oct 2021 09:15:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:7346:8d3b:12d0:7278])
 by smtp.gmail.com with ESMTPSA id a7sm7087948pfo.32.2021.10.29.09.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Oct 2021 09:15:44 -0700 (PDT)
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: Hannes Reinecke <hare@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <ba6c099b-42bf-4c7d-a923-00e7758fc835@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <5edcab45-afc6-3766-cede-f859da2934d1@acm.org>
Date: Fri, 29 Oct 2021 09:15:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ba6c099b-42bf-4c7d-a923-00e7758fc835@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211029_091547_215415_BDE29C73 
X-CRM114-Status: GOOD (  10.90  )
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

On 10/28/21 10:51 PM, Hannes Reinecke wrote:
> Also Keith presented his work on a simple zone-based remapping block device, which included an in-kernel copy offload facility.
> Idea is to lift that as a standalone patch such that we can use it a fallback (ie software) implementation if no other copy offload mechanism is available.

Is a link to the presentation available?

Thanks,

Bart.

