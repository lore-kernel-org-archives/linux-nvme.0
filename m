Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2551AC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 19:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EC720663
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 19:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XleI7hdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EC720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q+m/dFjli1ZkA7HEGH9btt3wvdZ/3vXr/NMw+JsJG5g=; b=XleI7hdZdfC0SMnY5l2FYraXL
	sLBpEqCZXJBQ/xJx57wuvPcwXoeC5QW9qR/YVTeQDFZEURsfGtljoLQmJf7QJJ1JyC+FCTOeoNhII
	GyUFBiX31cUt7z8oK43u69IDZ04rhbnGboneKTijgmrVfZZIPOD1DgfEni1iDWkB5Z8xhU+3avk2x
	jhaT2NWSbzY4bb+WjvRKSqw47j2YKXkSsEuHywni3jnaHzKtmWQ9I47o2ldOL8Yg+wzpDlgSfQCtQ
	TgAwT4CTiU+GyzP3xJbnrbiNxKYMSXAV3ygre2K2JgsjDL9vcJapz+AOxnSHO4LA2CRScQDwaCI5K
	XZeLZL+rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGozq-0001sW-SB; Tue, 24 Mar 2020 19:13:54 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGozn-0001s8-S8
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 19:13:53 +0000
Received: by mail-pf1-f170.google.com with SMTP id z25so5464632pfa.5
 for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2020 12:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1bi/L0ZqFdOezooY1G+SkOEMzmqFylcrRo2c7lw7CaY=;
 b=qKXsYgObfKIxTh5W8Y8v4jd/sOCBZbinxOLkoZbDHnQ/OZpZOmnJ6vjbpUnvv6wBhw
 5atvUIL3OVdDMB9zw8ugF8OB2ZP18qDA40FiGvUKZXMS6ahQn/OihJ7Wr6ztWVyAGogI
 thAnprFr/Y3TRZcW4nrT//vEQVtQTTbE6y7evIh25e5Ybfc8RobCtDyTvolo+ESsNOhY
 8+PQbm/Bkxd1jAcJQ/PdMFOUSD+UcDymqqo5u6thGKxg2evXRNV6yiEjlHOQWFG4o9eC
 IMc7uCz23m7H2E0/muTwYAVLpd4aCyKUSCruP5fVptV0GTkQnGWcVIiNe4wYUPhDRu/W
 9QNg==
X-Gm-Message-State: ANhLgQ3N0GtqsFUPh7jsktcOXVvMaqiFTPTcEkx4M/ywSrQLw2Gb31HM
 1ihajnzrYLZnTyXLs148M7Q=
X-Google-Smtp-Source: ADFU+vsbypR70JPvJKtXUdJBn6KIgTnO+a/7LgD1jSBH7kKbFL6DvdBGN119tXVoNBD3KAfQeYsKJw==
X-Received: by 2002:a63:6841:: with SMTP id d62mr27882725pgc.86.1585077230300; 
 Tue, 24 Mar 2020 12:13:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id h26sm16792500pfr.134.2020.03.24.12.13.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 12:13:49 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
 <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
 <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <112775b2-ef19-7e8c-630c-22bc529536cf@grimberg.me>
 <MW3PR11MB4684610CA3A664EA62EE7780E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
 <e9a4b2c7-5dec-296d-be6c-880afa8869c3@grimberg.me>
 <MW3PR11MB46848AC6E0AB0B10A2792704E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4dd58cf-7f9c-1ef0-b88a-7df181af35bd@grimberg.me>
Date: Tue, 24 Mar 2020 12:13:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46848AC6E0AB0B10A2792704E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_121351_909789_C06D44A1 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Does the I/O timeout only happens when you run polling mode (hipri)? Or does it happen for non-polling I/O as well?
>>>
>>> So far have not seen a failure with io_uring (not setting hipri) or using libaio for same I/O pattern.  Only when hipri is set have I been able to reproduce the recovery failure.
>>
>> This also reproduces without the POLLING patch correct?
> 
> Yes, I reproduced the original reported failure on the baseline nvme-5.6-rc6 branch with no other patches applied, running in polling mode using FIO 'hipri' option to io_uring engine.  Also could not re-create failure, as indicated just above, for libaio or io_uring NOT using 'hipri' option.

Is it possible that when we poll there is not enough time to process h2c
data pdus from io_work? What happens if you remove the deadline stop
condition from nvme_tcp_io_work?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
