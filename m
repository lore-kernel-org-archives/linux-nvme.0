Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91526EE0AE7
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPX8zzTrkGz3yv7G//UVKB5qD77q4k+o8DUEprofAPc=; b=AV3CMvyxgdR3YcuWJLQxecn0JO
	0bAVUeFpehXT40b3tGPt8Bf3nrS3beGj/ScfbjA3bpWmg1tayHHylmI9G884TwT3JIC5+m2zt9I5N
	HI3BhyEDA9upfHat9oNGr3GlnmEYZ7T9O48TuEeE90ARzMlnceoatOPM576XvObb0nRTfTu6jv4qL
	uEbDYb5QN+eFie4U5iJvlasSdAH0IGvLEQj8RlY0ncPJE+OjQW1N4n+YD8gdcTf3Z2E1Gr/xaKkFo
	2wor+AmWyQq3PrnpIH7nndrmHzoOyaeA+5010LGI+JQmcgldo8/xntpWxwSOQ9MhP2iALEJnSrAny
	oEDsBQrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj27-0000000CWGQ-0PQo;
	Sat, 07 Feb 2026 14:11:35 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj24-0000000CWFs-2Fft
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 14:11:33 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483337aa225so771605e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 06:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770473490; x=1771078290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPX8zzTrkGz3yv7G//UVKB5qD77q4k+o8DUEprofAPc=;
        b=SWzci6KotYiV3AeTA1KAotRYwO83Yu3NDw2610rx2uyn3wvHeN2OiD6NT8EoLQ2ExD
         TTiIgTTQnA/cC0kMZC2rwnmTbnWPmEGVY6GDMyaiwZ5cf5yLBA8y689Bz+J9VSA1oin+
         IbLZ/6hFO8lgxgwyqnyzEGukt5uudFzFrGfby3etKeFippn2YuahPcZD3Bbt/QJlC1ba
         wxEqgrjwgJk01SEtowZ5tEUzjKN9by3zS3YLj3p3wh0u/3dMmbzRpE/pVpvdEVeyQ65w
         kK/BObv0vEQ7Z/cRlUFu4BFXPs79s5pKDRnX28tJ3QtP4Pq0NgEAwk/A4fhGBm88fEHF
         aQGw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Wqkk+QLu3Jni6E/OgE7kudJV7rx/tu84SQovI1jm8YToyyt2KY0v93763fWXGT5gZxtr0g8o0ZQV@lists.infradead.org
X-Gm-Message-State: AOJu0YwbPYXrY6Stuhs71judmib8+i3phjwNl8Iql3cKDJ6lUn5lIayv
	eFJqD5RTMe/PuaSp4BkO2FxQSXZrTfQYW8dJzTyvUC5/sl6oL/+v8y3L
X-Gm-Gg: AZuq6aKWoccjh02jQrojipgaR8at+wzietOnJ9ybkoWmu1uFPb6kBd2TocyP2E4pK72
	S/DkNcWyYqLz72Cmcu/t4MoV0SXZtvKI/Um2rWDnQPMsfw4eEEIJxfPeTESvUwjqu5wJ/NtiZE4
	jnPah+xivdIMfjJVowaWkpbdxykwD/W8lRDjmYfkWC4L2BPPqnP/WfTBR2llWYqJi6NupMD+X9A
	TgRltYM2hTnKsafq1ramxPnLgpizNiFgULqFfBO5EMIigxFLcaIJqLj1H4Eu2aj+IcqtSzgUx8m
	F4sJ6P51aMPipFV/QAUB62OF/r3V9j4/bAIRAIAwkWx3E70upaxKZRDxvvcDsUHw2pOJX4sePao
	Ljd10puUgavCj3HAYgp72WgdyZoYCRUb5ZkQmtx5e3/jd3MfBOVb6iHK5G5MeL5RTT2XZI25eZw
	s5bncrRDVdBURWt1A/UAjMOLPCe4ellKqgqkuMOcHBTNs=
X-Received: by 2002:a05:600c:4590:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-483201e25e3mr75177385e9.11.1770473490190;
        Sat, 07 Feb 2026 06:11:30 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d345c2sm274012695e9.6.2026.02.07.06.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 06:11:29 -0800 (PST)
Message-ID: <f958e3af-6c85-45e5-8e3e-c9822f5a2d62@grimberg.me>
Date: Sat, 7 Feb 2026 16:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260130223531.2478849-4-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_061132_585515_CEFD4684 
X-CRM114-Status: UNSURE (   4.72  )
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

Other than Hannes nit comments, this patch looks good.

