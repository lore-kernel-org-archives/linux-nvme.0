Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2EC3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:49:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209182070C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B6eLmGh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209182070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4bpefSDkpofVaO4nZJioibeU+dcf33ZLoz4rurHoiYI=; b=B6eLmGh7uHzVhgfjrh6yyjAST
	xXIP4aJnkKm12ivvx6+hAPNd9oMxjmfWLF3tjXEFdc+jamTl+06lIM7uVtDXWROP4BXHcAwE+hYAs
	udEg5MsUdOde1qpzybj9souCTjt89TvHUld89ONVdw06X7SGuoOLiNdgoAqT1Ukn+5JA8MawpMo9m
	Idow7FhTqtY1R6wn/yO9rcf2Tg8hq1/z/Qi4Shh8Q2bnR+zDENHOT8TOX2gx8MvSYYB86XFhpqyKs
	eWP+nq5QjTenz+p2feVvaVtORputni9H8cYA515c0HGOgKV95KViPQiUFgIfpAz9bIOqTvZ32kz4L
	NhxM8qu7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBN1z-0003Bk-3d; Fri, 20 Sep 2019 17:49:19 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBN1w-0003BJ-Hy
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:49:17 +0000
Received: by mail-wm1-f68.google.com with SMTP id x2so3426009wmj.2
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 10:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hh4Y1fEKTRc3yjilF0pcbs2N3LuLrLG5fSKvc9JYpFg=;
 b=hH7YoEQIPZTf+YIJl63oI/MZHVg9MwH/lod3/OmfCcWI96w1rLO35T+cMn35F17dRt
 rv4Uy9J+bysLamYuJjJi4kap6kTrqzSZ0sZ37aklFSPlB1f0LlyRg2n76Be60EVfzNFY
 eE5f4DfzxtgChyvII/rAx9+gfLLl7Ev0WdYALOmxppWylkXSR6qwEd9y+Da9DtVt3hrM
 F5/2deTL7JshX9rg8qwiZSrRuPaC9SA6ly512ETyOIPVdQITRRkyDxOpT/5FVOTosyRP
 NgwjVgTSskyJXJfNNYb5/NU8QZtyl9IasZRgGTdsmJil2w0LuDLq9/+JZvRvcipOOHZv
 J0iQ==
X-Gm-Message-State: APjAAAW/7lZcZ5ET4r3Kzn6+H2s+H5oQZg83N4lMI4x7NS/cIVyruFb/
 H10qvJx5Ika0an+jt5bEQuE=
X-Google-Smtp-Source: APXvYqzgIK3mQ5KOdUh5W4qd0f80EXl/07sgMHoNtVATu7NRoAkhHwfBWFQOPRVTxGE6iyyOZMU71w==
X-Received: by 2002:a05:600c:248:: with SMTP id
 8mr4185967wmj.110.1569001755063; 
 Fri, 20 Sep 2019 10:49:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id z12sm35100wmf.27.2019.09.20.10.49.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 10:49:14 -0700 (PDT)
Subject: Re: [PATCHv2 1/6] nvme-pci: Free tagset if no IO queues
To: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-2-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d6c5e276-6479-89e6-4a59-5e950ddf2fe5@grimberg.me>
Date: Fri, 20 Sep 2019 10:49:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213431.7864-2-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_104916_595698_D2B30FE5 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +static void nvme_free_tagset(struct nvme_dev *dev)
> +{
> +	if (dev->tagset.tags)
> +		blk_mq_free_tag_set(&dev->tagset);
> +	dev->ctrl.tagset = NULL;
> +}
> +

testing dev->tagset.tags and nulling dev->ctrl.tagset?
why not check dev->ctrl.tagset?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
