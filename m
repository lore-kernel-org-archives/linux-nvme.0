Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C9CC433E2
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:00:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A928020870
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y8tJaaWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A928020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Y8tJaaWh4e5N0vjfI/NGglxnX
	peqUKl+uQowEytD7ePC1nPXYRxPOzBZ27goXiu9PcQ5HBGiU4Djil1Vc4LAio2kghARcIZ46Vh/Zb
	Dw26rSjMY29cwN3mHoep2JcdraLuDIVvN/PVYA3o2Alky65Eg2ks2he4FhbvRSt7tgj14fyZJcUuX
	/XrEY8ZWl1TH3EeMcpqkRT2+HTbxQkuGNmzj4QWH6aguCgXHrpKHpNMx5Qma2mZ9sMMyuHpHwPguu
	1dpTSzXQN/3kOucHIcKT5JXAiP1CzYbtI/scBP81CxkCFuuA4YUXsmYIKIoeqwsKn6wjdunDJeDM9
	DOCmVPBZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrydE-0002Qs-Tf; Sun, 05 Jul 2020 07:00:08 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrydC-0002Pe-GV
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 07:00:07 +0000
Received: by mail-pj1-f44.google.com with SMTP id b92so15664288pjc.4
 for <linux-nvme@lists.infradead.org>; Sun, 05 Jul 2020 00:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=JKAX65Ry1EOxTUm2q/0DeVq0edvVgMELaLJInMbdgXA6utAv5s8acC3TYDIF5oGS1j
 M16HvG8XWinmSIlva9ni2WegIrS9OR0M0dIurDxAjxFt9jdhwwbYwRkOXtFMBY5b6toF
 +Kx7dxsbnsg7kc19Gd2GBgLoYUNFaYSmyqQKM1UqJ9RGaObNQUtxDjjuPmn7010HCXl9
 CWLDosydKOhUeZ5m59MqFKRswuQeIipC8nhAHd0GmD6MXGKq8OtbN7IoXsTq5/PVfmL4
 jUV8j+24TOWxT1SX//QyPq7gKIwnA7kyBnC7jsOiZGsGRzARe494/HV2IeiaYdEU/yTv
 Zg/w==
X-Gm-Message-State: AOAM532T247hxkUm2fVFuxLkx075crtNHDlJJP/gtrTmfShfMLl0+HdD
 mmFkTa14ZM7mMGk8hi2PrdA=
X-Google-Smtp-Source: ABdhPJw/x44WohlEVYRxaffxVXKB7Jo+/UwG26L+YFUWlVIBNMuhpgZ+YKJo7G+yhFx7I3IGWu4nVg==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr38278459plb.236.1593932405488; 
 Sun, 05 Jul 2020 00:00:05 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id k26sm9119800pgi.16.2020.07.05.00.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2020 00:00:04 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
To: Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <096528d7-78d4-ef90-9a42-0b5ee574740d@grimberg.me>
Date: Sun, 5 Jul 2020 00:00:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_030006_588497_CE8D3CCF 
X-CRM114-Status: UNSURE (   7.57  )
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
Cc: baolin.wang7@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
