Return-Path: <SRS0=UA0h=2G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE57CC43603
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 15:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9316320665
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HOYDGs3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9316320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gObwF9J23MYtrXDkFCrR7xJPpThR3PZ3o/TVXL3KBPU=; b=HOYDGs3ndHZ4pn1Tvv0fMGjUU
	aqp9HtsB/RChux26P64Cl9lTlHtl/tmF18WRn9vBcBpa1L2WwrF6uP+Mpzjc3YXoySdyzoFOSyXOY
	2/HhOMAm+y1hsXdGoxxe5ud47vB9ao2RpYhPMCOxvCW0T1YIJ0FyIEqp4DhO+kFaarVwep4n5fEW3
	sSDXJ90mXsDp/RabgsbRFwJC3hlRuzx5/FYXwVaFUUCuy+glW780jt5gJM9eLcnHAcM0PYyjdvXYa
	1cXDzbjb/DQJCuJY6fWvnKeMt2gWRqyg8AMD/VhoH2aTDZj32AwYBnh7Rw0E2FX9u9PxXz/x9eGI/
	ZuKoBEvxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igsTn-0004Xw-Ia; Mon, 16 Dec 2019 15:40:15 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igsSk-0003VU-C2
 for linux-nvme@lists.infradead.org; Mon, 16 Dec 2019 15:39:12 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 07:39:09 -0800
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; d="scan'208";a="247073498"
Received: from unknown (HELO [10.232.112.29]) ([10.232.112.29])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 16 Dec 2019 07:39:09 -0800
Subject: Re: [PATCH v3 1/1] nvme: remove unused return code from nvme_alloc_ns
To: kbusch@kernel.org
References: <20191127171743.32730-1-edmund.nadolski@intel.com>
 <20191127171743.32730-2-edmund.nadolski@intel.com>
 <20191128073015.GA27403@infradead.org>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <4cc7d687-fbd5-45a4-61c8-91aa97728f63@intel.com>
Date: Mon, 16 Dec 2019 08:39:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191128073015.GA27403@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191216_073910_416993_5A5015A3 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/28/2019 12:30 AM, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Keith, all... any further feedback/comment?

Thanks,
Ed


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
