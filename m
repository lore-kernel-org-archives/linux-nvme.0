Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4EC1975A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 19:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B692051A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pksGKWFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B692051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4b9KbtNIUqAOa1WZ9ohVwd+/yEuvTB0P6C5wVRqoNLs=; b=pksGKWFycVPykColnbm3HBgZi
	1t7SBTpSTF3CuG80jMnjgesIHRAm0nvlvJiq8Taj5CRoJCQLWGtAezX9fj19BdLLNDwYoWzZv3yoV
	bP0LSKpqDuhsJXRNBy2xMqTHD6ZQZV4wPulRouzO/74pIN88nIPt3aR2osimiprPSEa0AHECcpZnO
	rMYPU9cYCTg43pwu/mZMe9jGaFKsLERzeyYw+0wfLLXRyIAn81p6q+fu915I3EkaKjVmw34i70fI7
	oL3JlSnRT724/C+cFkHDEs8HwLwIEvDG8UNNIHyA/gRDqkeuNvR2+8DPXmZ8NCWS6+CmMsNcVj7z6
	rWLTBXt0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEHyM-0004ks-CC; Tue, 17 Mar 2020 19:33:54 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEHyJ-0004kH-LV
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 19:33:53 +0000
Received: by mail-wr1-f68.google.com with SMTP id s1so5516889wrv.5
 for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2020 12:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tGF1AP9wuTljWGrzhtbqei8g10fJ49+iakdT7NknjKE=;
 b=dAa4fImEN45wJt+2I5PxzLjC5WzLDPfhInCLoIMdfXUgmYrE0gH4BhwYhGw0z9zk/W
 CXiJhN96b74C2ZGm82VEbJ3iXlgb+nDUkEqjkihqVWOh7gaPKu4grbO93MjAH4ZKKc+O
 OFuGqa/QPt6q4O2ZxGKv+tkdhgMtuQ8ZR9ZfYnf7qhh3jcWY2b51DGQKML5Mt8DoYCai
 Y9389tjQWzTmX4i0iJbB3rZlXt8W7/zyAEvXvxyqKfiHSTbh4zshe5wkaPHCRTDVEfQl
 0ETKwR34xXC9eFE3s45zX2J7kSQCrr1+cUVqxCRhqtY/JiEKt1DZinbvl0vBlEuwEeYF
 +F1g==
X-Gm-Message-State: ANhLgQ1luujOXstiRvzY25Xn7VWv5u/ljBybYIALnWwuroTn8paSJesH
 A/Tkp3ZWkVr+Q3/6Attl1P8=
X-Google-Smtp-Source: ADFU+vtGc54xQl2qkaVng8B35498da2QRFht/t7nTlwt3sL7/sWk9Z5pE9snJjZqC5/ob4qcLVZK3Q==
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr663061wrb.90.1584473629799;
 Tue, 17 Mar 2020 12:33:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:29c1:6aa4:fe4b:2f81?
 ([2601:647:4802:9070:29c1:6aa4:fe4b:2f81])
 by smtp.gmail.com with ESMTPSA id i4sm5914217wrm.32.2020.03.17.12.33.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2020 12:33:49 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To: Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
Date: Tue, 17 Mar 2020 12:33:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200317191743.GA22065@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_123351_704704_38FDBEBD 
X-CRM114-Status: GOOD (  14.73  )
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
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>, linux-nvme@lists.infradead.org,
 Bernard Metzler <BMT@zurich.ibm.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
>>>> that
>>>>> is a good idea as pretty much all RDMA block drivers rely on the
>>>>> DMA behavior above.  The answer is to bounce buffer the data in
>>>>> SoftiWARP / SoftRoCE.
>>>>
>>>> We already do, see nvme_alloc_ns.
>>>>
>>>>
>>>
>>> Krishna was getting the issue when testing TCP/NVMeF with -G
>>> during connect. That enables data digest and STABLE_WRITES
>>> I think. So to me it seems we don't get stable pages, but
>>> pages which are touched after handover to the provider.
>>
>> Non of the transports modifies the data at any point, both will
>> scan it to compute crc. So surely this is coming from the fs,
>> Krishna does this happen with xfs as well?
> Yes, but rare(took ~15min to recreate), whereas with ext3/4
> its almost immediate. Here is the error log for NVMe/TCP with xfs.

Thanks Krishna,

I assume that this makes the issue go away?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 11e10fe1760f..cc93e1949b2c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -889,7 +889,7 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                         flags |= MSG_MORE;

                 /* can't zcopy slab pages */
-               if (unlikely(PageSlab(page))) {
+               if (unlikely(PageSlab(page)) || queue->data_digest) {
                         ret = sock_no_sendpage(queue->sock, page, 
offset, len,
                                         flags);
                 } else {
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
