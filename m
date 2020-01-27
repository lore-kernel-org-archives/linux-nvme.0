Return-Path: <SRS0=UxdA=3Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CADC32771
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 07:23:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB13B20702
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 07:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dtl2L1C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB13B20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fo8xsUWapmPNYoyqhJWUtO772aMeQxahnPmG0VeETc8=; b=Dtl2L1C9C8H3J9QW/Sh5CMrqg
	CcKccD7s/87ZKmeWvQRDTxch+eBhelxfLZIS6ykgbk5xbjdbUnJxngDISNtJqCDlpuNP9Y/Ih4Gw1
	roYcvwh4TUPBx+qteT9FNm915iXF7hSgEeJ0S8ObeUfYPYFyYztJ9h6dh+fHvT13HpwxoJbzXQ9KV
	OeB8BB8goRGIVDOJsnY90uW9+8WVBoFLAvYJa7n68Ua06CQ7tPSC8izf7jc7L17cJ9TS1yDNFsc7T
	i3VucMRH49mEC0oa0sbcBXP3UFcvK/NyJHpR0r0j06zfNWc7Q0fGEvVf6iJHTz3DLXSBlqjTAQcsj
	mRX8TAC4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ivyk0-00084t-Pt; Mon, 27 Jan 2020 07:23:24 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ivyju-00084J-Ur
 for linux-nvme@lists.infradead.org; Mon, 27 Jan 2020 07:23:21 +0000
Received: by mail-pj1-f68.google.com with SMTP id m7so1822864pjs.0
 for <linux-nvme@lists.infradead.org>; Sun, 26 Jan 2020 23:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VK9xzOJqjRJygbIwnAbSUfIOA7qavg02Jacdfsz5qe4=;
 b=otVnA54DFXX2LXCejsY1nQTJJmVSnmnnFdbk8LTvQQ5qTCimxJHwFt+fvlLz1SAcht
 RLHc/N65itYbLVATZLnbexM7pbQKOzMv1bieAPl6TSv0OQrg68X7kxdxW3h4I1qSMWBT
 TZTWE1DdPygAVBEy4NXecx0+xEiO/jc4z4M7KGLTKt1zEjLLm/eoKC1iHuWPF9vem1nl
 qDozAeJuhUV1+PUWLq/VrBdFUmY4n3trjdKPFn2lIi7UDSh71aNEg86IVoWejTYN1qMJ
 aasxUAiNVL6Sy/gJV2+2lic3dMIoV3EJA737NMa3niHm7nQ46vlvCs6okZrFyWajKOPl
 FyLQ==
X-Gm-Message-State: APjAAAVdlU07oxNTUg57RU/TXXnxXIhDCxv+AvlvZmO5aOfRvwkKsyl4
 o01prlrN4Xi1hRC+/JUTYz4qMP3v
X-Google-Smtp-Source: APXvYqyYO6nZEVI46gbwstCsLzK6uhRbQvr/yOTI8TvKq7GNLaAM2MC60FB5mZNfFE5GS+BMAvIY4g==
X-Received: by 2002:a17:902:523:: with SMTP id
 32mr16507209plf.148.1580109796028; 
 Sun, 26 Jan 2020 23:23:16 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:fd41:47a6:c3c9:b0ce?
 ([2601:647:4802:9070:fd41:47a6:c3c9:b0ce])
 by smtp.gmail.com with ESMTPSA id f30sm14675310pga.20.2020.01.26.23.23.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 Jan 2020 23:23:15 -0800 (PST)
Subject: Re: [PATCH] nvmet: fix dsm failure when payload does not match sgl
 descriptor
To: Christoph Hellwig <hch@lst.de>
References: <20200124173942.2744-1-sagi@grimberg.me>
 <20200125212352.GA5407@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9e22a00f-dd13-8ac4-ac00-d22a361bbb6d@grimberg.me>
Date: Sun, 26 Jan 2020 23:23:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200125212352.GA5407@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200126_232319_948800_17A96F27 
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
Cc: Keith Busch <kbusch@kernel.org>, Dakshaja Uppalapati <dakshaja@chelsio.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +EXPORT_SYMBOL_GPL(nvmet_check_data_len_lte);
> 
> Why would this need an export??

Copy paste error, I'll send v2

Thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
