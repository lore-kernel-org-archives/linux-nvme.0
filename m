Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EBDC677C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=; b=hoq5JijvP4S3r5ntfEgUi1XXbi
	FtwOCDYqXG0J/NdvZNtFcE5PkpN1WKoEX+bpnVr5KBCzlfhxuPmSdm0xWdc46xdsn24D7zlEzEl6n
	v2jqxxXMvd+8gLvjjKb7QKRFvhZhrkrHejF5Z298QIMVBQ+5IckwGYzIPQehr8AVNi0JnrD4WLkvk
	mXfk0/BiYlWM80+QQgctsXmTXO40HZKHSfx7T0c/G5qealH4Fqy5z4xPieA0B3m/miUiQsG56Vlqc
	wKpNQhWLtZhwyrQldoMvm1p3exoUn6RtX4V+vNjBXbUffNVrZTsbUqXzbeRnjwQAGByL9TyOVyHgH
	Zal4/t/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPO5m-0000000AZEp-2dJJ;
	Wed, 11 Jun 2025 16:14:22 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPL0k-00000009tX3-2jYI
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 12:57:00 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3dddbdef7f0so30871165ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 11 Jun 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749646617; x=1750251417; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=UXNk6CxYTEcgL5XSJSvKZzamMkqtmbwBidY7R++Zz9fS8mx71eHnHgkywTE3DCiSCa
         h2KLNsRxM7Tj+F7Pcys7yJ07TUihe6yrmDkFLS9Lyk4NOEwRfT086WdyZJ1+QVNRG8s7
         S+ESPOwS3LgJYrbMdL6/p2YnoAaUWAd0TUtqeMflE4o7a7SnXp87/AOTqraGcZCRWMdn
         euvyam9eFeiRHKhYXdAdNS/848oS4gzzQ6UncKrzkS742cl3VcGNcyk75d4lwKQO4V5B
         Uc5RI9fxd2QJp2AwjSvGilOw7ZmlnLTAP0wIDc17p8bLt2rVlQad6Bz34HUyd0IscUpR
         LNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646617; x=1750251417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=UtIS3bRLO78I4btOhQvXGaUyGXr7gMTBxJp8KGnAXsijogUZSSWNHusm9v59NaJD+8
         R5dzksJlF/q/f175/EQ7R7/KpDKquf5ny4QFIVSoYfXSGIC3rBUjImymK3SARf3kty9T
         rCP89CTE5XHFY78Qdroa5+bms1HvheqOTgRQIN3IJNzkpjDufR0ru0FyMpymIxtiEkSI
         +zMEjUfU4aFuZ6So/tDWfuYFxsasNExK2knKT+Oy8FIcAFIY32Yw4Qv2drhOElAo/3o5
         qRwxo0oTTgh9cV8bxctAM1dCQD67EDS2lL/3JvA98CBT9ExlI2r82nAAipcaU1h9bHN9
         1wKw==
X-Forwarded-Encrypted: i=1; AJvYcCUJD8v7cSMc6ue6tmoyigYpVWPd3L9GFT/28+kd522VDI+0l6vL3AjYEOjFGxA1yZOauZTfpIXHeHtm@lists.infradead.org
X-Gm-Message-State: AOJu0YyeZ6Ewii2WV5egH2OzKuFV3jxh0yvq8ePJFrrgMmDJ+DxBP2/O
	NaEbxHLywlqvdvPq6mS2VfyHWt4W6WW5yNrVWxU/44e1a0wPe/5MJm9QvPY0Hg7nfGY=
X-Gm-Gg: ASbGncv0gnAE/EZ7soZeXAJX4Y0k+k05m7VCV4fsfkaPGFMlTszvNPq08dn0p5CK4cy
	zDHkIxchYXQq4L/0DfS76zjEcnluohal0B13CTSeVfuRnZn0ccuFm+9tOn5TlTFO5gNwK5t8GKi
	gLqNMLfvxzFVBxP7lUDQeALvR4BeYIGIiSnnfDiJYpYTxaM8RfTQFRTObOEQzQWMRvMfU+dab68
	uYQVrFlpVvlrftz8eV6KL7IuKohSoPonGoVvy3pUjFDeCJ4vL3xR2gE0SDf/uh32mgtzy7VZSd6
	35rbr54X8TxNI0Vsi+/8RQYyxgyJ4GOSD/kHLmuL0RZZciOf5ljwenoNcTR18zifRD+PoA==
X-Google-Smtp-Source: AGHT+IERz9UEhN3gPoO6s9ZO+TGganlwoJirBS1zd34gle1XGHdmdK7NOLrIX/f0q//+H5iwkCSLYQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d9:668c:a702 with SMTP id e9e14a558f8ab-3ddf4d5d68emr25015895ab.9.1749646617386;
        Wed, 11 Jun 2025 05:56:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf4768c0dsm3851505ab.55.2025.06.11.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:56:56 -0700 (PDT)
Message-ID: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Date: Wed, 11 Jun 2025 06:56:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_055658_696593_B817776D 
X-CRM114-Status: GOOD (  12.16  )
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

On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.

Rather than revert this commit, why not just attempt a tail merge?
Something ala this, totally untested.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..708ded67d52a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
+
 	rq_list_for_each(&plug->mq_list, rq) {
 		if (rq->q == q) {
 			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==

-- 
Jens Axboe

