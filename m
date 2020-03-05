Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862CBC3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:55:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5867F20732
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J+Rex5kO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5867F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=J+Rex5kO/xQ8ay49TvGPZEcRy
	0kdT4aDdaOEm/45HTzxEdcC5Ja/JFHCmayKAUHohLMBTvdDc2YQPBsyopyWF+K7MhLp++Ovmm0wH3
	A1uyu1HFcbho7I2hAJMkdSR4KkkNZq5k1yZPUj6FDa+4jP+99kb7ErWxfljH+CpRwj39y8+8NAbT+
	cTz4kMDx22loFX+rGY5eWGEwB8zy760hEPTGkbyLaavWaSiW5WfM3cYxt4bnl6umhWFoaINl+h0r/
	nJEjJ8/VlngYCiYNwdLt16fGGLY5+MK3JR1RS0A8Cqqanh+rwqs2JlIIg8+L7Kry3FYy9Zu6+I/ko
	1zDWMrzhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9xWc-0000kJ-2P; Thu, 05 Mar 2020 20:55:22 +0000
Received: from mail-ot1-f51.google.com ([209.85.210.51])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9xWZ-0000jc-GJ
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 20:55:20 +0000
Received: by mail-ot1-f51.google.com with SMTP id f21so234184otp.12
 for <linux-nvme@lists.infradead.org>; Thu, 05 Mar 2020 12:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Gy6aVWhYeh1dcSqmYtQVid5FH+yT2LkkxkGR/2iRkZHb5Op0Qj+EwilIkERrtaXNxq
 u/xM5ERMHU6wbZKz+o+10bYo/PybtDrQ5+AZgrqKPKImjWAdvqTyMr7QqH3VUwB4kEuV
 k47y8mseMmaviIMTp6KALi0z6IyTa2hqi8jctLxX9wJ/BOOXZ1rHeSoF/M33RH7tmL69
 N5ZQQ4wRK22jKGCiYhG5R+SdXi94em7aGx6On++udf6xmAj+bc6JSQyATUOGljgig+2K
 614w0Iehs0P+sYQSJVhAA04KndFBpT+lARiDuxgP1uvtUo0n73xQvziWiIEzP/XunUwQ
 6SjA==
X-Gm-Message-State: ANhLgQ1/C6XvDnxLf1SONbhSp54iz/zSEWAA75N7RiBZV35whNK7hm8S
 EqERCfL8xMIxZljSsQgr6Gh1a/hV
X-Google-Smtp-Source: ADFU+vtmVtPUNaAY706n/N1SjQLKY0ELsXTpf7J9+1mkJctgle9C9fCOy+pcjgZ7xlCHbwYhy97X5A==
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr330814ota.10.1583441717980; 
 Thu, 05 Mar 2020 12:55:17 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 93sm574355otp.80.2020.03.05.12.55.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 12:55:17 -0800 (PST)
Subject: Re: [PATCHv2 3/3] nvme-pci: Simplify nvme_poll_irqdisable
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200304181246.481835-1-kbusch@kernel.org>
 <20200304181246.481835-4-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4f2511b7-5f9b-28e2-6015-f236cc43a3e4@grimberg.me>
Date: Thu, 5 Mar 2020 12:55:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200304181246.481835-4-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_125519_547332_EFA32275 
X-CRM114-Status: UNSURE (   9.64  )
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
Cc: bijan.mottahedeh@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
