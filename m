Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046F4CD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oq6D02CsHfdX5BDuXKKvULIIXk1wOK1VaHh0cItQXrE=; b=1bwQPyyQEp5t41Bk3uwpzJPJdg
	zJSgiucjPwctxdrM/Z6AyS7AThJJC6UDop61Ld7dG9R5AXU+iIOmzaGv9Po0jBzHHqnvVHAgOBwbB
	ILvB/Eq275IejcOp6tvade8LK31Xv18VZ1tKjuFk8TzoNcxhuTgd786lGTG33LiACn43XL1XPV/6z
	BM3218MOmo4au5liO/DriC7W3+HSBIy031CeGVD6BdRhxissE5KSCavgIASqcPASU5Wn+nUN2gbwj
	vYNYHR9QR2YXfJ6FXsglVrvB4rt5aIPdKHDPxXEXyy6k7ZdTUL4ZHw+m7Gc+TBGEHIXsRGLkVmlC1
	AaY/fTeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAGu-0000000F5Vy-2gw6;
	Mon, 02 Sep 2024 16:51:20 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAGr-0000000F5VG-2o17
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 16:51:18 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374ca65cafdso570301f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 09:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295876; x=1725900676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq6D02CsHfdX5BDuXKKvULIIXk1wOK1VaHh0cItQXrE=;
        b=cN5IBq6cQqR0dyENIOsEkQ6Tq5KHU4+uTmRPu2C+MQp3M6Mwb7ubS4gqg9pKw8W4wX
         dCw1zgBwVF6b/y/guRTTaHg60voPGtHOvHPQnCYh3TnZbYhefejXxSdMES6qAY+K56oL
         tKa2mOFzBNdhfpei89YD6HnyVWGvChEGFCfreZBPDGONbhx4QmnVPUfbbOJPhvj0GGzx
         q8DbICpS8rL+7yitT8o1hB47Jh4nwr6f7jwlTVhICXZ/e8USzPDH1DNEXK/AfAk52TTH
         5Zz1fE476lus0KXYDYwFxx69cHXIt+s/aaDuRiVxduKPi1WwLEOgnpY+dial2x/b3j7s
         /Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCV9cmZhWtZEOQpJWlK9SeTUAj9mgYtWRWTCWQCTAmeVGFClKSSLgz3AM1cBL56jOp1qi8fDYHYHzEvo@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2QkJQUPEMnY7wubgpjp+68b44i2N1VFXXTuYIOtpIMbCFWviO
	oLNG748VJ2MleudCycUZvBe4uYrVw2SSGCIq2trbV1Quyiv/A71BG85nAw==
X-Google-Smtp-Source: AGHT+IGWySG+Ccp4wROqgEFTcYD1Hrx6z3kJxNfGDDQ1rC3//Ps2mhrWneCWvgFof+8m3XJgH7PYpA==
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-374c269e0d7mr5852050f8f.22.1725295875404;
        Mon, 02 Sep 2024 09:51:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9c692sm11913915f8f.53.2024.09.02.09.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:51:14 -0700 (PDT)
Message-ID: <e77db352-6b33-4de0-b8b7-d989cf33ee40@grimberg.me>
Date: Mon, 2 Sep 2024 19:51:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: clear 'NVME_NSHEAD_DISK_LIVE' bit on
 shutdown
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902111548.41430-1-hare@kernel.org>
 <20240902111548.41430-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240902111548.41430-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_095117_739821_53E852CD 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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




On 02/09/2024 14:15, Hannes Reinecke wrote:
> When calling 'nvme_mpath_shutdown_disk()' we should be clearing
> the 'NVME_NSHEAD_DISK_LIVE' bit to be consistent with
> nvme_mpath_set_disk_live().

I have to say, this looks redundant on its own. The nshead is
going away so it shouldn't matter.

Your cover letter suggest that there is a hang, which I assume
this is essential to, please describe how and say what is this fixing.

