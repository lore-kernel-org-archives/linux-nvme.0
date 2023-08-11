Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F1C001DB
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 22:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o52cWlwXR3N6/ms+y9tYy0bzSVEqexTODJML7eEO/+8=; b=TGA4xCExdtNs5wpeOKqVVIt43P
	sE+2kA7ieG5YE8fwRecCnobLo6kFuxNI/Akga3D0mzdyXUVeMljCei65XhfJYkzm0PBdovgOBYD6U
	H8gv/N4XAbfIrGw/2lfb6y+ZoLHUrc3AL0uaaocEFc289btBVdyybKEzuPeCl0EhjZ29Onyt3LndJ
	KeuNu3jc1mvQLF1Ry9P/D12/uUQoO/xjzOCyC5BPecpieyksH5uxQ2psxpJAD0ae4NnF8OmZGRjQI
	QDdpIiEOmnQeRCDJBWenlAOwDIVMojjMpx68pNzhyyA96nY7a+I8DfWOs8L2HNLf0thpoCa9ZSEWT
	cET5u/rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUaLf-00Bl56-2M;
	Fri, 11 Aug 2023 22:11:11 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUaLd-00Bl4N-0I
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 22:11:10 +0000
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso18350125ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 15:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791868; x=1692396668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o52cWlwXR3N6/ms+y9tYy0bzSVEqexTODJML7eEO/+8=;
        b=NXjI7eeVR3WqxaTST9lpXatrJaEez6R2Gu7HV0I/qAXDf0+FklEs0KR24YBdVE9pyb
         b4C9musbdbz79PmYX9XU6HnCaXA8lNpmou4RZuqOR0DFNAKKZAMyKTHxo6gP+VBMFYUQ
         B8aCQdcwWtolxojsNRCUV/CzFDAcVihVRgPkNFp0DLzs+4ln+BhYwtdrBdtAvGaROO2V
         rg6n7cGpoTnVL6iSKqOTJmfwBwoTIqBci5j43RSz8JlZMzPVKl+/vyILUWdPN7PDRJ28
         U2ODiXO0Z3Mf8MY77uMhen/8gOYPcWEnAf1ixP/bSQ6tr27wrDuf4KrvE8pA3allQEYW
         4AOg==
X-Gm-Message-State: AOJu0Yy7Vzq+L9uiCLw92h6VMsuk7EC9QdyVOoZaKQS1qc0+jZ+uXnZ6
	UQoJNzsbppI0+hiBKcKXIz4=
X-Google-Smtp-Source: AGHT+IGO1cYq9ryCeUR18SdH4aYD4OVeMcVgDFSRF+fdG4TERHS/ZNVH28DIGQxUbVu84B1GJsMb2w==
X-Received: by 2002:a17:903:185:b0:1bc:2036:2219 with SMTP id z5-20020a170903018500b001bc20362219mr2795385plg.41.1691791868121;
        Fri, 11 Aug 2023 15:11:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001bc53321392sm4413845plz.69.2023.08.11.15.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:11:07 -0700 (PDT)
Message-ID: <57558d7b-4444-b709-60bf-5a061cd6c3e9@acm.org>
Date: Fri, 11 Aug 2023 15:11:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 04/11] block: add emulation for copy
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Vincent Fu <vincent.fu@samsung.com>, martin.petersen@oracle.com,
 linux-doc@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6@epcas5p3.samsung.com>
 <20230811105300.15889-5-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-5-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_151109_131515_1508211D 
X-CRM114-Status: UNSURE (   8.27  )
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

On 8/11/23 03:52, Nitesh Shetty wrote:
> +	schedule_work(&emulation_io->emulation_work);

schedule_work() uses system_wq. This won't work for all users since 
there are no latency guarantees for system_wq.

Thanks,

Bart.

