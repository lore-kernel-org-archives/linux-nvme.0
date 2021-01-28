Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AD9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:16:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7551964DF5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7551964DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vOeo3n9oVYxctA4MUeZrbQH7xENzxWvUFEDNa+mtv64=; b=qyL3wi0Id+vkGq64r3IvfobuH
	5lCZjlsUmojjlT+k1u55r7tB+mL555/VlwP6n5USm9bC7EJihkuHsTl5tzbfRZ3xPJtSVEFp09LCW
	Xst3P3owJHghnHi9iyWpmO4AbSwdtUXyufs9HDmmQL2P8sNN6/gY/VybSGd/q68tmHy2oWIOAcc/z
	yh+gwGtzcoHBF9CIUCLwQCUXH68vVvQCu0yi+xwlK8l4SDVvMejz6hW4nciD3ewkFztEr8OO8VGnf
	Cpbdo6qNbRaW2OsxJQargGMTC89cPyCVcLUf/gp6zM74AYdq6ekwVDGGUbX55OZ5Ipc5nlfYMYKck
	Jqo22IKbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Bpx-000076-Q7; Thu, 28 Jan 2021 18:16:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Bpu-00006f-Dt
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 18:16:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B320468B02; Thu, 28 Jan 2021 19:15:58 +0100 (CET)
Date: Thu, 28 Jan 2021 19:15:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
Message-ID: <20210128181557.GA11790@lst.de>
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-2-jxgao@google.com>
 <2863b6d2-47f6-51fa-f60c-ba24904818e9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2863b6d2-47f6-51fa-f60c-ba24904818e9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_131606_609141_0529060D 
X-CRM114-Status: GOOD (  19.07  )
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
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
 kbusch@kernel.org, bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 jroedel@suse.de, linux-nvme@lists.infradead.org, erdemaktas@google.com,
 dan.j.williams@intel.com, Jianxiong Gao <jxgao@google.com>, hch@lst.de,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 05:27:25PM +0000, Robin Murphy wrote:
> On 2021-01-28 00:38, Jianxiong Gao wrote:
>> Some devices rely on the address offset in a page to function
>> correctly (NVMe driver as an example). These devices may use
>> a different page size than the Linux kernel. The address offset
>> has to be preserved upon mapping, and in order to do so, we
>> need to record the page_offset_mask first.
>>
>> Signed-off-by: Jianxiong Gao <jxgao@google.com>
>> ---
>>   include/linux/device.h      |  1 +
>>   include/linux/dma-mapping.h | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 1779f90eeb4c..f44e0659fc66 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -292,6 +292,7 @@ struct device_dma_parameters {
>>   	 */
>>   	unsigned int max_segment_size;
>>   	unsigned long segment_boundary_mask;
>> +	unsigned int page_offset_mask;
>
> Could we call this something more like "min_align_mask" (sorry, I can't 
> think of a name that's actually good and descriptive right now). 
> Essentially I worry that having "page" in there is going to be too easy to 
> misinterpret as having anything to do what "page" means almost everywhere 
> else (even before you throw IOMMU pages into the mix).
>
> Also note that of all the possible ways to pack two ints and a long, this 
> one is the worst ;)

The block layer uses virt_boundary for the related concept, but that
is pretty horrible too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
