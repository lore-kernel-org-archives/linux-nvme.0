Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ECAC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:MIME-Version:Date:Message-ID:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07xQWyffa4Ix1g/pvcHIWfwGdtig1uyAadKbd+ed3as=; b=EDFlRMffZk/Axm8/QLmFpmCfh6
	gIqWubzutqqlxkZ6LMUI/Q2eU10m2hWYiPW/0ZJpgAaUiI9+C4cmPrkqhIparLc0TQsnGxpJQDqjK
	M7VPtngoTbjIYQS3YFeUj32fjl8fFE3r5dUVPH+e/oFBuLc5pYk0ZxbDxINdM8pDoUgWWMvCyp+qd
	SzLlDwWGKf9DeYjRi4X7wTawLzG2EuyC3Vr9qS1kOgVaPVzCR2vJclBHyWnoU8HK5d6EDLOVan/yU
	g1seWkZV19CjwMjPO+Ss9rkkY/nkecMhGDnZu4AnDhflO9iVzeJ3kExxx74xHBhm7YShucsj7uNpB
	cCD6n7ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiIhw-005J2J-Dy; Tue, 11 Oct 2022 17:06:20 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiIht-005J1L-GG
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 17:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1665507978; x=1697043978;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=07xQWyffa4Ix1g/pvcHIWfwGdtig1uyAadKbd+ed3as=;
  b=sK84kPbf+O2rivPW4J7gYunk4HavC6sgq3cSPEXmF6QOyWnnuF0QbaDk
   cWSBQq2E8sdwoEK9KEPPJhl4v/yec/lChTH71YS2h82kxgBfCLJVTCC9q
   jH9pA5nys8FsxPqKAXfl2ZSScIfPWEQNZ/io/hSKKOdxlNt2sJ/xa+yfX
   c=;
Subject: Re: [PATCH v2] nvme-pci: Set min align mask before calculating max_hw_sectors
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:06:12 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com (Postfix) with ESMTPS id 5E2D49BC32;
	Tue, 11 Oct 2022 17:06:10 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 11 Oct 2022 17:05:40 +0000
Received: from [10.85.223.213] (10.43.162.213) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 11 Oct 2022 17:05:39 +0000
Message-ID: <8f451a9e-3324-c7d4-cf61-a105fd087192@amazon.com>
Date: Tue, 11 Oct 2022 10:05:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "Bacco, Mike" <mbacco@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Park, SeongJae" <sjpark@amazon.com>
References: <20220929182259.22523-1-risbhat@amazon.com>
 <EB43F4D1-BFD0-408B-93E7-10643B59F766@amazon.com>
 <b73250f3-2dd6-36da-4d69-3149959f2e67@amazon.com>
 <20221011060829.GA3172@lst.de>
From: "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <20221011060829.GA3172@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.213]
X-ClientProxiedBy: EX13D41UWC002.ant.amazon.com (10.43.162.127) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_100617_726624_B5C90855 
X-CRM114-Status: GOOD (  10.77  )
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


On 10/10/22 11:08 PM, hch@lst.de wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> The patch already made it to Linux 6.0, so I'm not sure what we need
> to review again.

Oh, I never got any email that this was being picked up so sent it 
again. Anyways thanks for taking it.
We need this patch for 5.10/5.15 stable kernels as well. I can send 
backport patches to stable tree
maintainers unless there is a way for you to mark it so that its 
automatically picked for stable trees.

Thanks
Rishabh


