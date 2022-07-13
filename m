Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3A0C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u2XSFpn55uW6F73toBAkMHZPqNPuTplT41NmuH82PQ4=; b=CtNvs/5XCVL/7Rwyxhv6xYH1yS
	6/pFRVEQ/OUoXxFInGkhI+BGqt2V2EsF2LgiSVjn/j+ToBbi71at4sGxhdl20tnTtnBKXGU/wCr0o
	tCQHMfjKd2PdJ3Q03qzP9EjoS9A+bp9RfUGmIuRLEHE6SWOaM5iw/+s7FhpC52UbLrwxyDgf2iH+U
	Bu8xchm0hdSfligEkxy1vf9Wroz4PBjp6rGeAzUYABmgUc2bT6Mp1wKabewwqhAp5zMryIezjPODt
	X/BpIvYZLEI7MvoI7f7FaD1f8ND/kj84XZpzJP3eiyNM6rgWscJm110XDS+z15I844kq3c/raA26b
	ggpx+uJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZT1-002f34-Jp; Wed, 13 Jul 2022 10:19:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZSz-002f1J-Fs
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:19:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E14F767373; Wed, 13 Jul 2022 12:19:33 +0200 (CEST)
Date: Wed, 13 Jul 2022 12:19:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH 5/5] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220713101933.GB27936@lst.de>
References: <20220713054914.1888305-1-hch@lst.de> <20220713054914.1888305-6-hch@lst.de> <7ca70ac5-db80-eb0d-5678-18bc1902a072@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca70ac5-db80-eb0d-5678-18bc1902a072@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_031937_698068_07D5F39B 
X-CRM114-Status: GOOD (  12.32  )
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

On Wed, Jul 13, 2022 at 12:25:38PM +0300, Sagi Grimberg wrote:
>>   	default:
>> -		dev_warn(ns->ctrl->device, "unknown csi %u for nsid %u\n",
>> -			info->ids.csi, info->nsid);
>> -		return -ENODEV;
>
> Maybe we want to keep the log? can be converted to dev_info/dev_dbg, but
> seems useful to have.

As-is I think it is more suitable for a dev_dbg as it sound like
gibberish to a user..

