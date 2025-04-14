Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE542C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=t6n62gYUQsnyIM3WRr1qmkqtu/
	t2yykR+zE7ek0PDphtvDWI6STk38VOEskOXKJwwDSTIH/AM+WC077dCyACNHPekgfpX1OQkdOMtRu
	OIBFhW2T4Fx5LWqSTR7svUyfdXVbiz7MbbWXXs9ytD6tIeVmEVtFcW1Xr7CC9JZt3NrY20mZG7hhs
	FSHAA+QcRFRY6IBPhc8Xeq1L3I1gdJW9U9FQ60xFFPLy2tsPpvdAvMM7MB7wapISNDYo31oK3ytSa
	PUDL84eyjeMKrIJfYOWnURds+oJYbPKwOEDkYR7G2xJZ8B/XxjLnEM3VLAIqDIuYIKsRiS1MBJzJX
	DrvlU/6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rzl-00000003gqn-2pXX;
	Mon, 14 Apr 2025 22:09:37 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rxl-00000003g0F-2F5C
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 22:07:34 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2aeada833so950946866b.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 15:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668452; x=1745273252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ivs8LEwiClTp6HrUMiLJPnM7eKiUYd/ASlPoyLGZUX6TX6YSs3xq/m6SQ3mk87OAhk
         WmlCLAsXcrosxOaesahaR00sb20balGso4IMNNqpEnxPa5L7cjVTDefOwoyAl8x1DqB+
         /5uGRDi5kgdrkFBq/SnWzjcgUbUg+0NH0weTT0FOVXtsY/qNWQ+3AaUOY+vFA91upDvB
         qJB4YNsiOPkpUunsektMEpZYAC0Z4Vq0PAAM0AYhZRWkJ7Hq2EHSh745+0QjJp1Cly5k
         7DK8ca7Upz3prlgsYNSFSFx/wI0bFkaibU+f1leHbSVTxVPdnkAae45pDrYr7iN1i5I4
         MWHw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOITg1XSjHo7smHY0Qm/1gVmkC79HZNalb3l7rQKZoDdcxxJruNENmps1eQpMDQZFjqriVw6WvnJv@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9Lqd6aHVVTGtmNwa0VgNX3t1sciWVUcgwgW7x5rEeHJFTaGBQ
	qC7zRR7Cxb5zLBln+iGE6UpVX8Pgld5dtcu/3JLHNtpkK6kwmzm7
X-Gm-Gg: ASbGncvavTZ2ItjAPUshg9wjyU4v1vIg4SnD32cU3JwzM7F/ipWixxyshcwAXOCWvnu
	9fs3BnCUixXqEzVNs6NbeG9GLMk0aCbDPrim9jbmm3HGAAR02WrklsLqK3+Dvop/xrZh0PTjcQS
	SF2G3gjIce1dwzWu1TXyrF2cCNyQalGN9yQ9n0vjheOapHG6jtzt2ZzROde80Pi4kY5RCy1BD4d
	lkUv6xszWZBkvJpy/uufOMaRm+ZabfdOh226djqKDLI8U5GymXvq+sIli/BhKQYMlPiqG9E6eb0
	RFIUPOAOzUrnrboz8kBbescxuvT4anfKv79lj9MDkFnOvEfd7e3f6LBA1oehbOE/WCa8JIcq
X-Google-Smtp-Source: AGHT+IFZj4iDJJXAIv4Qoo3kRrnu//pI7ung5Nqa6kAmkj3GZ0l//RFn9e4UIeTzc84BJzAHTyVDqQ==
X-Received: by 2002:a17:907:a595:b0:acb:1fe5:434a with SMTP id a640c23a62f3a-acb1fe5495cmr28291466b.14.1744668451855;
        Mon, 14 Apr 2025 15:07:31 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c021f2sm964103266b.86.2025.04.14.15.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:07:31 -0700 (PDT)
Message-ID: <59e528b8-a3dc-479c-9f0f-31856c76fb41@grimberg.me>
Date: Tue, 15 Apr 2025 01:07:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the
 controller
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-3-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250408024733.690966-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_150733_563682_87FFF64A 
X-CRM114-Status: UNSURE (   5.03  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

