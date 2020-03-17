Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22107C10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 16:04:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED48B20724
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T/2914+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED48B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MhON0GqNFqik4SPg+N9vOLlsyHQGwi+OxdPVYqVB68s=; b=T/2914+RqrqHiXd72bkTV/BAV
	7uPUqD/xlImMlLO7P0MoMdaP0q26oMkT4nqwttXSIgt2nsUKHZ8vRDQlJkl/EHeGrqkJ60povhdbC
	vAmkj0lTMr0omdxx13oBU0I2OaP8s8qht4dd45Ti0UC72vd++71gUJm0suhFiVt5sZwzx7fbUmvxx
	9j3sw9ulO1heURdbJrpqqf41uRYo+9QLT/qpkfcWEmwmAvVq0ZtwHlgpeA+0kq8yjHf7bcLJszX46
	f/IgSdpCYiNsK/9SKauOWTSb2OgTz2uoC3ePADTNL3+wLYGMn8fGdZTrK40pR4639G1r2JaqhjewT
	S40E26tlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEEhI-0007bq-Jn; Tue, 17 Mar 2020 16:04:04 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEEhF-0007bK-RQ
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 16:04:03 +0000
Received: by mail-pf1-f171.google.com with SMTP id n7so12208671pfn.0
 for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2020 09:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zaqmSU7pVQacdkrogINHa+leDGYLEH4AwcN6oMad/6c=;
 b=VVh1hQUz9w7VbxrifFicw1QIb9K2iRWqGWHdUrw5wRfwF8ROuV5fGW7pHbvk5p3EyN
 KLc9roQu/TW09TARVfuzqYvIhBEkeT6vs7jlqIGKd0zIJLezKwerV3Ll8D4QGyMHHziv
 OyNkN/H/I9R1qlYyTcUypl8aPT6I0oJGsiVlfeigzQrmHOh5oglF5gBoOvvuhwTE+8s5
 yla1bckbIj3sqGZ6PNQgS9MlLHlP+24DLksLRp/PLnAJuUz1bIoiUGCQJ4gAQUE3mmkb
 SHtNIEEZxEz/LdM5NG2DWTQtepTMfJyhwGwR9qabD2ZbTrtesAr1Hah/6HbzpKGqSTed
 A6Ig==
X-Gm-Message-State: ANhLgQ0odgQGYe5GHLRXUvBXUtDAcr18tC3No9KIf/AvSj54pI0bzWoh
 UMUFECWiCrNmto5qKT857gHFop+H
X-Google-Smtp-Source: ADFU+vs/2udCc4tTHwUfkYFVi59jpBl7zqx4RQRkghOcbVmJvmxBzJ6ZkSLewMeseYC5EqKZkOeWEA==
X-Received: by 2002:a63:be49:: with SMTP id g9mr5911104pgo.30.1584461040531;
 Tue, 17 Mar 2020 09:04:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:29c1:6aa4:fe4b:2f81?
 ([2601:647:4802:9070:29c1:6aa4:fe4b:2f81])
 by smtp.gmail.com with ESMTPSA id b133sm3239806pga.43.2020.03.17.09.03.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2020 09:03:59 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To: Christoph Hellwig <hch@lst.de>,
 Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
Date: Tue, 17 Mar 2020 09:03:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200317124533.GB12316@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_090401_886785_E8690F57 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: linux-rdma@vger.kernel.org, Bernard Metzler <BMT@zurich.ibm.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On Mon, Mar 16, 2020 at 09:50:10PM +0530, Krishnamraju Eraparaju wrote:
>>
>> I'm seeing broken CRCs at NVMeF target while running the below program
>> at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>> same issue with NVMe/TCP aswell.
>>
>> It appears to me that the same buffer is being rewritten by the
>> application/ULP before getting the completion for the previous requests.
>> getting the completion for the previous requests. HW based
>> HW based trasports(like iw_cxgb4) are not showing this issue because
>> they copy/DMA and then compute the CRC on copied buffer.
> 
> For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think that
> is a good idea as pretty much all RDMA block drivers rely on the
> DMA behavior above.  The answer is to bounce buffer the data in
> SoftiWARP / SoftRoCE.

We already do, see nvme_alloc_ns.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
