Return-Path: <SRS0=9AXB=K6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C02CC4743E
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 17:43:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C09611CE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 17:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C09611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p8dhJcE7gaz4U76bXo4Be2oY6hj9IMAT9QmAh/9eOyQ=; b=wHjJ2vIi9cG0ct
	LbDB21qSV/wdd0TpBtSR2Wvif5QmKEXECaTT2b9U/XG8tJ3nyPW+GseQ8GaxTc/9DOUtT9sFcJ5xf
	tBDpDQZXQVFmHyCgq7IBqv88irZLqAVMKnVCUKQskbXsdvxcD8HDYUaZFXroOBFimt1wjdiFmg7LI
	rBVwm6KwGpsa6Zeii78oe9m9a5WobmBHw+9NFyWGwE3jmpGhDxl7/EAtMOhTuzCkbatBj+O/tXBDN
	Wmxj0iyNEdIOL7mhPd4fC2I+DygHi2kX+DDqAfqL8OkeEHcivUsYwB7+W0ABbwMsWz9FguaIkfuZ+
	hgvAQCDYWhnvdtGjGSbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lpDqz-00Ej8H-PT; Fri, 04 Jun 2021 17:43:29 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpDqt-00Ej5A-VF
 for linux-nvme@lists.infradead.org; Fri, 04 Jun 2021 17:43:27 +0000
Received: by mail-ed1-x52e.google.com with SMTP id dg27so12043425edb.12
 for <linux-nvme@lists.infradead.org>; Fri, 04 Jun 2021 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QzM9hRQ9yPLBo8yltzOsaJJDpS5Eg+eNbSkbpJeCOPs=;
 b=AhdudWhNLVtfqdVHQ46Zw54IW9N32wRucN6KBsEpo3OKfGF9l56tMXkaK9E+w51qdD
 mCA33ErtRKMZjDl8uFDjDJByh31dllDQATXRZ2Vd7SitdvrQUq3eR9FknCjCHO89PMBq
 sDFjU1XhzH5Db9zDLchYSeJpd/Dyf2qj2V99k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QzM9hRQ9yPLBo8yltzOsaJJDpS5Eg+eNbSkbpJeCOPs=;
 b=ZOQznpBgdjVivymAomFK3q/kTlzTweJtyiRnNRYclvi9zlHpW3MrBS/7EWZE9xwgzb
 tImh+ZDaN7QmEL/JjlSSXhaVdJ7B2x+ibc14xKYON1HUSmKTV+cxXbMU8TBoObX/73zu
 AUuq3I5C7fIELqpMlHxvHq8Ggxm67IzhGERrze8LHfuwMdjD13BhgJzjExHDcFZV8o5E
 blIjmNknQsZDKTtmKjFQ6rHO61lQA/wcJlz+5nvDwmuTIMM9ATqDPTtQ7zsp/wTEkgAK
 C/SyEuDFFBGFGBSNkoKsf15epHAxCBq74Q4xCLX8bek03Uhru1eeZ0Gtp/BZZLjDwykx
 NaJA==
X-Gm-Message-State: AOAM532KcbLKAgabq80XcjBDF+kqFqW/ccYq9jOtEpi1NlFaSoPwrQ5P
 SewCVFwc0R3rs+9JXVuUm1gdKyDd21f9yVoi
X-Google-Smtp-Source: ABdhPJwdNSzU09ZtTL7xyfzZqQnGFukAUc8LnGbJT9NEBpwai2Pt9gi5wqdwvQ/DnGSLHRkVxlpwgw==
X-Received: by 2002:a50:fc84:: with SMTP id f4mr6002043edq.252.1622828601059; 
 Fri, 04 Jun 2021 10:43:21 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44])
 by smtp.gmail.com with ESMTPSA id h6sm2897edj.91.2021.06.04.10.43.20
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 10:43:20 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id ba2so10352815edb.2
 for <linux-nvme@lists.infradead.org>; Fri, 04 Jun 2021 10:43:20 -0700 (PDT)
X-Received: by 2002:a50:9346:: with SMTP id n6mr5878355eda.365.1622828599683; 
 Fri, 04 Jun 2021 10:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-2-mario.limonciello@amd.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Fri, 4 Jun 2021 11:43:08 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
Message-ID: <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, 
 david.e.box@linux.intel.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>, Prike Liang <prike.liang@amd.com>, 
 Julian Sikorski <belegdol@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210604_104324_042146_8C2E791A 
X-CRM114-Status: GOOD (  11.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 4, 2021 at 10:54 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> +
> +#ifdef CONFIG_X86
> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> +       {}
> +};
> +#endif
> +

Is this the same matching logic that Windows is using?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
