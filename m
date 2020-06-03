Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD261C433E1
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C20207D0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K60Sxnrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C20207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=K60SxnrtVT9biHjRM39nIUJGT
	2cXjeC1vF4vzRRy5b1ltjqR+JwPFJShPrxiGUpdBwv39w9JMCKJCKpGiKcuWqKb+0nKoRmW8UjXaF
	7TR0O9IZJbCjGTq/Qj4nb/Rubg1GPzDwAFSrOjXAiXxdfUQj+iD9DB5aJ/8wQqYj8djRoBPLFEtm7
	NKugjJLzyUiXz+Z0eWDIQtLmEzgNspb3sV7RNyQkUj8vKh2vNtISDuDJeqAb5sMY2DPawfbRy0dKv
	Yp5Q+RS3aKWyV1gH9FdchEYQk11nwQ5XJnBuYFoWw/Pns8WKYTfBfoqVOjeLwh8PBtlLWc7cVjP2/
	VlH8WcbJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgabq-0000hb-PF; Wed, 03 Jun 2020 21:07:38 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgabh-0000Uz-8o
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 21:07:31 +0000
Received: by mail-pj1-f66.google.com with SMTP id fs4so131001pjb.5
 for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2020 14:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=aYp11A14JSGNfkLpedSLlnwO1v9QE+2qso8CSfpzCqncp3jjpaE3T9FbzmjY7ipv2q
 RXt2kqz4ejwjt/t+ND5XhiNNnHoulmPoNz+w/pJOZytNjhzj+eZxoLTblSOOjHlqJGO7
 9OI90PqjkIDz6FfMOtTpxZJH9H7+uQlNW9LNLcQdq7TCXEJ8jCAX8i8Y5zSooa4O70PT
 ibSmJtusS4RtLlHyAflWMmey1hCzUGcSujNDf6pqNEHSl3pHUhEazjcO0t5L/rVaa1nu
 TvtnzIVsDWD8/RDVq97WFxP7Qip1DvExNMz7a9CT3A3NHjlU2EcFAVrRBmpmQ9kHqKqO
 K59w==
X-Gm-Message-State: AOAM531uRx+A1pxNxW/YT15XSOUSEEwZMALqKwR4oTKyFbYAowjLK3kO
 jSMqyFbFIXDwE/elom9OrUu+lo5FcnQ=
X-Google-Smtp-Source: ABdhPJzaimKIPAAXEKE3Qh6HB8VnS91U+DcCX5yNwFVTbAjOyx3vYTKOgrcSZJVAUZndWdfXCsnRNQ==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id
 d23mr1974439pjw.233.1591218447979; 
 Wed, 03 Jun 2020 14:07:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff?
 ([2601:647:4802:9070:5409:1488:6d95:bdff])
 by smtp.gmail.com with ESMTPSA id r1sm2249874pgb.37.2020.06.03.14.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 14:07:27 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-pci: use unsigned for io queue depth
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
 <20200602024114.5153-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0bf9afe8-d34c-58ad-20d0-bd498029a336@grimberg.me>
Date: Wed, 3 Jun 2020 14:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602024114.5153-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_140729_399021_2F940DF6 
X-CRM114-Status: UNSURE (   8.56  )
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
