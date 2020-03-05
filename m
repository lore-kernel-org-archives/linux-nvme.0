Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8DC3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:52:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69E220732
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wx05lsjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69E220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Wx05lsjvZ1WbmLL8OfFhMPSL4
	d2pyqdVqhoiE1DxDKD0oCLZtJsNQK53oHq0Bi7hdq3IbEl1yf9ODcqv1l4kvzvOclBnr7fx+vOriW
	1cDvA8PwqPA9CHGLmr5lDVr0g/POIHveZ+jT0iIWZ8Y3duw3VToRW/HEfyacSaA2qO0prC5Q4uo0J
	rhUmjvdfqQ1Zw2cKP/Djxj1JfXjkdS3Pl/xhV8NnQ3zcHgq67LPQfzebYeBPc2d+DbbtXXFalUFDp
	0AW3W8BbX+q8BlBcREzJWOVZ9wSMsuupSJyOI2qWin4HiNp1i5SssWSsiryd/hK5URS35x3ze4Hdc
	74aYebAKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9xTv-0007Ll-4c; Thu, 05 Mar 2020 20:52:35 +0000
Received: from mail-ot1-f52.google.com ([209.85.210.52])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9xTr-0007LK-OW
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 20:52:32 +0000
Received: by mail-ot1-f52.google.com with SMTP id j14so283323otq.3
 for <linux-nvme@lists.infradead.org>; Thu, 05 Mar 2020 12:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=OBfzAxBGhsLgJFc6PL24X/29u+rRDqin9Te4crJ1gz5uwIbwferonw6yQmXqzBle3c
 qar6/KqRJ9NcJT5d4J8KknZFIaaERZlkQzTnTwYnm9o8XNUAaVdQKZ4kRv8X3sVE+jr1
 yrWISqo6gn3RMw5P+zC9JjDfFtwwtuKMtCthIn0/q1dze2GrQFrlpF2qYWA+f+THyF6Q
 nWIy/f55xWrskV01bcgRMJCOcDJlvWfVxvMBXEloTs97yMuLKjmH9AMLeRp9Z+A2PaDt
 83MrtH3ANkus5BEXG/Uq5QoEovolhtoWjsvKrDzBPIGiAC5bFECj1vZkSCTld3atWvym
 wAHA==
X-Gm-Message-State: ANhLgQ0zAZr4hI/czBJV3+lQMFJyhEu8Ze66ZQi1oD/CYHLpLb2F67uX
 xNg3yO1vfPtow0UsDKN8Zyjv9CiI
X-Google-Smtp-Source: ADFU+vuHTpcuu4qQWQo8z97JzyaUV5TK/3Lta/d57EwXITfO4ycqjqHkpLv4n+6YcZYWfpUwKciasQ==
X-Received: by 2002:a05:6830:1245:: with SMTP id
 s5mr281338otp.43.1583441550403; 
 Thu, 05 Mar 2020 12:52:30 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id b11sm5355456otl.38.2020.03.05.12.52.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 12:52:29 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme-pci: Remove two-pass completions
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200302194616.2432-1-kbusch@kernel.org>
 <20200302194616.2432-3-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a9204717-29d5-6710-2272-b35984c8717a@grimberg.me>
Date: Thu, 5 Mar 2020 12:52:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302194616.2432-3-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_125231_804219_5DC0F755 
X-CRM114-Status: UNSURE (   9.96  )
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
