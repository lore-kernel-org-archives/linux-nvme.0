Return-Path: <SRS0=l4SY=6N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93985C83000
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 00:07:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6160F20737
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 00:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMvDFmG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6160F20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=cMvDFmG4RwaMbLGf2ztLoEMxt
	eNaPrUkuzlXhMwozSIXoUY23qD9XrES2wz/G38vqu/7ecr1KEJ7txUB3QISZtLZuDnAcE2DFzrXSo
	v2oO2Ib6sq6hQzg8tJ0N00wxiMugcvyfOH7isQvRj8yUG5Xtk2GCf6RnAxeUjVSpDLAc9UP17Gz57
	Bl6butb+sJiRP1LArW3etJ9gmYZhhEyLc3j/BLXjoLXbRzlYCSnT8AddwTvEEbAoWwcr7b+amGDEA
	5g0HXYS2n1+2LweEaDOPlTAgTYttVffeqGMRQsv5A4cBe+dvXAwaDNej9pYTIJDxL4noNHXD8S6eW
	Vuq96HFjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTaG0-0007kp-4c; Wed, 29 Apr 2020 00:07:20 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTaFx-0007eo-Vk
 for linux-nvme@lists.infradead.org; Wed, 29 Apr 2020 00:07:19 +0000
Received: by mail-wr1-f47.google.com with SMTP id f13so358672wrm.13
 for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2020 17:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=K95GmB0SdNCKcG5HnUmd8Sa+QccGLU9EGkNWh6AOaAkF+vN+J4QnFOn4osPoXIE/3L
 76x1jO/lK2KcYO2INA+hFq+6tgFUJ2aTupko6ic//LAh40dS8ISfb7W3pXo7YY0sBHmS
 zQW97PLfCNTAvh+GbI0ftQMxppzZHs6yQWHZNNOxp3klmbLADjYmew6QXuuLOFB7OEEf
 27UhwCpb1WIJbqjDDmWzN85kgTaxqdygBLdBom2aGuLhF0HRw6rfHjI90mLbyK4tiMUJ
 j9fXN4TqR+Dbr1RY1bGUUYCei3isR33Rtu/sEmvSKyT98NfAImHN5w9N8E8uMiKuEkpz
 G6GA==
X-Gm-Message-State: AGi0Pubs3KBXms23GxpHWuSy0d2qqnkKYCOOHW6RikgKEB/84/hudr+2
 ucNHZejzcj6N+4dAMee6p7NDn3nT
X-Google-Smtp-Source: APiQypL+ytgy3sOT6vQUn2OMnaWMN7RKyr6DbK+7JjJv2E0rvPVD2FRT5E5BrNF7eN+KecGrxpbOtA==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr33828709wrp.183.1588118836384; 
 Tue, 28 Apr 2020 17:07:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5185:4503:ed8e:c2bb?
 ([2601:647:4802:9070:5185:4503:ed8e:c2bb])
 by smtp.gmail.com with ESMTPSA id b66sm5361357wmh.12.2020.04.28.17.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 17:07:15 -0700 (PDT)
Subject: Re: [PATCHv2] nvme-pci: remove volatile cqes
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200428142156.2269926-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d7c959c4-4b74-6def-1328-60cf0846270a@grimberg.me>
Date: Tue, 28 Apr 2020 17:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428142156.2269926-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_170718_020254_5D1B18EE 
X-CRM114-Status: UNSURE (   7.67  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
