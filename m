Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F33CC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:10:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC0D6134F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC0D6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8FERuW6MB/GzLOXnBzAvAdQUqUIcPk9JtO8E5qzbApY=; b=GeFYFAnfxw7rDy3yolWO9L0nh
	awXZ+vlU3hP9s3vHEtIkN2HxkZN9TP/bKtcxp21XyRjtxD+jBZ7kKA4PjexChCdt8+YRtwb/6aWVf
	T+ofeUZCQXi+fqtN+GZw0JFyMLUKCnabffAPupBzDMXtxnDK1l4h2BxIl/h2qWl97qXzgHDO5a+2U
	h2SOwUUtEg22i58TS1DQeuOW3GTonLdtdWKYGCn8KkZlTjHmW4mjWUwAEjNqLJFPJouJFZZvjkB6d
	BbijJpGdSVmcjmJPwVb6wXJ3TAY1XQhuNdppW9yNamC+HaONHH4eRL249R3Zxo3F2skv9AtAbJKNP
	aIubfoo8Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgUxh-000gHn-RD; Tue, 11 May 2021 16:10:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUv4-000fhV-5A
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=VZKhZh9rreTRPd4zpdyIwtNRUh5ttKTpBqZ0LlHmIQ0=; b=KlUvs3wgbRsCqE/llnjChDQnwU
 t+TLTQ3n5lK53RQ2rpafzR0MIgsJMcERlgnTQYzNOGEk/ksaTuaFGn9xax+ESx6PmvclHTfgfx4qN
 DiNZ+JmiLP8HAU+SNV7EQJtO25bYw8NVsOWZjWpjPWXKv3Ve3BDjUWgGveCasawOnY1AzAnMRJl8s
 UZrznWuD8K8rrzBGasTIWoTPjWYIzjuyx4YaSJkc91pRaKsGTclzp1h8csZHAx0BGmoLBn8wtXTI3
 p0GiwazgvGT+AzKT66UTwC7i9VAeL4Csf53g8sTJen8oIO31rWKE2fLyYRRJtuZQ+61OH/FqlFP0x
 BTQgrE5g==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUuK-007QvZ-L1
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZKhZh9rreTRPd4zpdyIwtNRUh5ttKTpBqZ0LlHmIQ0=;
 b=WsW3jFQoJG2aTEkICNi6n+7ai10mZ4p+J810RUKNpD4qQs3ZlceVNswGuqoA3ax71N9LdX
 jE21BRw1xqjvn/Zys1xPfTfiEFDO2/d9DJ5BxKXZv2gaIm7LrWPNg7UUW2Ysj8IuxeuRFl
 T9chFw2l8ml6TlgmzX/djqjCWUbNUbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZKhZh9rreTRPd4zpdyIwtNRUh5ttKTpBqZ0LlHmIQ0=;
 b=Hn6HjECb8vEZrgO4uqG2uL+pDD2rNj7TQD5BVvorK1W/uMmy0KYkHe8ETLuMkJWFCfgcr0
 jCy0A3K9yLE/CKIJR9icbPi9cWs9qjnPKK7wBt574ZtsQ84o3B0p/TvHs8Q8iEIuPb5NZT
 QkUaLNhihoLJLekTVfJjOLVBEHUKECA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZKhZh9rreTRPd4zpdyIwtNRUh5ttKTpBqZ0LlHmIQ0=;
 b=HFA4umIoIe1oao5j5rn4FPgiLj2JdujvkfRPzJ8PbIS5JZkc3XYfuT7sx66f7YGnwD9PZV
 3ydyyRAZlbNNMUXgWnZR2DKU7NNFjXKE54qkBPXGhOnEVYm6RtjadyxczVuAgfiraI2mtj
 BwNvVnRxHHAWgMnmpPHKJmfpNZDbUiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-bChFT7ESMtyqf2dZFYH_2g-1; Tue, 11 May 2021 12:05:40 -0400
X-MC-Unique: bChFT7ESMtyqf2dZFYH_2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC08F80EDB9;
 Tue, 11 May 2021 16:05:37 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 471751037F29;
 Tue, 11 May 2021 16:05:35 +0000 (UTC)
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <09f6c713-5ae6-035c-c0ab-a8bd0fac7a79@redhat.com>
Date: Tue, 11 May 2021 12:05:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-3-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_170712_844033_E293BC90 
X-CRM114-Status: GOOD (  28.01  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> In order to use upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
> might sleep.
>
> In order to avoid this, try to get the host bridge's device from
> bus->self, and if that is not set, just get the first element in the
> device list. It should be impossible for the host bridge's device to
> go away while references are held on child devices, so the first element
> should not be able to change and, thus, this should be safe.
Bjorn:
Why wouldn't (shouldn't?) the bus->self field be set for a host bridge device?
Should this situation be repaired in the host-brige config/setup code elsewhere in the kernel.
... and here, a check-and-fail with info of what doesn't have it setup (another new pci function to do the check & prinfo), so it can point to the offending host-bridge, and thus, the code that needs to be updated?


> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bd89437faf06..473a08940fbc 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>   				    bool same_host_bridge)
>   {
> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>   	const struct pci_p2pdma_whitelist_entry *entry;
> +	struct pci_dev *root = host->bus->self;
>   	unsigned short vendor, device;
>   
> +	/*
> +	 * This makes the assumption that the first device on the bus is the
> +	 * bridge itself and it has the devfn of 00.0. This assumption should
> +	 * hold for the devices in the white list above, and if there are cases
> +	 * where this isn't true they will have to be dealt with when such a
> +	 * case is added to the whitelist.
> +	 */
>   	if (!root)
> +		root = list_first_entry_or_null(&host->bus->devices,
> +						struct pci_dev, bus_list);
> +
> +	if (!root || root->devfn)
>   		return false;
>   
>   	vendor = root->vendor;
>   	device = root->device;
> -	pci_dev_put(root);
>   
>   	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>   		if (vendor != entry->vendor || device != entry->device)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
