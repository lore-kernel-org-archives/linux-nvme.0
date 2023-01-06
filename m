Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2BCC54EBD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 22:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SL5CM6lTlaQHHI1bmsPCCVPxAY0au15n5abe/FQT3nc=; b=WMfpPez6zuer1bjxhtL5a6Xgtg
	FU+GOqAofPOdJbdLtNerFZrkJlydZdvUSLFzfOnotMV0/vA5Yxl8yJd5O4FuR6ix6zB2dzpiSdEW+
	7SMCHpjrO+6yvja9JNTmg4iGz6DGhKaDJ07hwlxzTeilhww7gKhMox5Of/IQz0dcOZPlycePzjyEI
	MTIq0N2p+UdzXiaE3i/XdrrjKVT1h9AtJvWKwpf7nM7DK1qyhZcGysIzE6P5RqxvhPrwBOSAaEhDS
	yYAJ/e9dNA1sQLHPz2G37DQrPcDEmlyuNnQAJhKLx50E8mV28uuD1J3PznQ6Wgbb4Bkxh6VCtmF37
	YKONVjCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDvIg-00FIxt-0q; Fri, 06 Jan 2023 22:34:58 +0000
Received: from mail-pg1-f179.google.com ([209.85.215.179])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDvId-00FIw8-B2
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 22:34:56 +0000
Received: by mail-pg1-f179.google.com with SMTP id g68so1013850pgc.11
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jan 2023 14:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL5CM6lTlaQHHI1bmsPCCVPxAY0au15n5abe/FQT3nc=;
        b=bgw7Zlvyw3HshIAqa282W4sNA7nRq/1zctbKsC+cDuK5hbd/gYvY/RrotKj7iLHZCO
         HZSAgRu6GKOo1HXzlRNMRX3glg8xpST3zwKc7bJehEl6R+tDVew+DlHaxOedUUUcNq+z
         XdoebIOo3jZjKkPdXtmIn2arB1ji/FQnTfgLdXDhiFJn6+1CmndGppiiYJ1tJvMhq42b
         ebk0E8M2hv1MUjfYwjXr/6TEv5z/vOQb/XjQDFmUN8x2Oh26EvwJ9uVNVOXUhD35EHSi
         ns8BsWlN9FqSCzO+d3BmwJykRAWLT+xap1D5sTcEPqFr04t/9rTAixeLM9KilKPv+gL/
         /vgg==
X-Gm-Message-State: AFqh2kql09jQkGdUESf8LWAcl4DPJpxqhvdxu7xQNcW5PQwCmL7iO9x7
	2EEG0j8zhZsKWctW2GVUWKA=
X-Google-Smtp-Source: AMrXdXvz8DmkTBfjAMd1ozT8pHBw5/b6wdaTed0SKRZNVvC3PYsvERMHsoJSt6vghLCnFNKh8DJLdg==
X-Received: by 2002:a62:2903:0:b0:57f:f2cd:6180 with SMTP id p3-20020a622903000000b0057ff2cd6180mr54274027pfp.0.1673044492663;
        Fri, 06 Jan 2023 14:34:52 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:23c3:f25b:a19d:c75a? ([2620:15c:211:201:23c3:f25b:a19d:c75a])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7970d000000b00582197fa7b4sm1597733pfg.7.2023.01.06.14.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:34:51 -0800 (PST)
Message-ID: <895e27b5-60cb-39f4-ce0c-774379453418@acm.org>
Date: Fri, 6 Jan 2023 14:34:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 snitzer@kernel.org, dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_143455_413594_52007035 
X-CRM114-Status: UNSURE (   7.85  )
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

On 1/6/23 00:33, Pankaj Raghav wrote:
> Remove the superfluous request queue check in bdev_is_zoned() as the
> bdev_get_queue can never return NULL.

the bdev_get_queue -> bdev_get_queue()

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

