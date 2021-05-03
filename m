Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315B6C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:31:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8901B611AB
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8901B611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9MtDn1FOyrbM7a3pHBaLWXt8a3bt02BwCN+/fjH6xIk=; b=ZroN/q7/xqeztgWTGl2ADgUNd
	2t1MYOJkpiNPLU3NbOy6+d3kKAZPnOLr8y5TnW2/ywJjM2gl9ynMhIilCwEAfgbd9cI5cflD90FzW
	1hJpIKUUo6I1NxlJCFdi0eN8wzK7LKN7aij5qWkKPVvqO7yYn9kL+aI8wlwC+3pZzoRmDCFSXzTh1
	G0f5NxoTeROHlXP1GEEaYahibPI5Nc/9eBgUWns6+ZHVgyMhk6q8wTMaCmeomfxbPCT0i7cltEaLn
	p8MOHJH2J+Xl5H2PIh73MlvR22KUTHYl/XFnbVzgIYe8Y7RWkkdMs2QFxrsmKpnc+P4ScTqRXaRXQ
	YCbFURP0w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldbTB-00ENYn-Fd; Mon, 03 May 2021 16:30:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbSu-00ENWQ-Nh
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 16:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=6WT0OUR3hjtTcavzEdie6Lc7Z9dy98V7OmbCellGUKQ=; b=gVYsOMBedcCUPo7dUbR1Cl5Ayj
 Tb9vzVll7vzRqN44WUkbmS5pHu6zLEiSd+ampHb7vDM4OPVnOIPBZkJxnevGFFUZAMgZjTrIihFbk
 u2TwbAmkXMizHP/vgWzLAjI1cnOdLl2l/a8R0VjRZ6jqdWEzNq9vW5DgM4ea8XjiPRzIu9s/+7OL7
 QE9hcWotdqvMivAeJnBYmsT21Uc5IwJ3VlGCWajLqp4c9FJI3sth4Ndqs185hBbpof3ltQE7OenOq
 yi4RATy7jLjxFw7zi3zyRAD5QP+X2wUbcp2dwxK8cYl40ceG/9mIz5SLHR8n95aaf6VRvGtZ0nkCP
 0YUaq/Fw==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbSs-003FC0-5E
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 16:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=6WT0OUR3hjtTcavzEdie6Lc7Z9dy98V7OmbCellGUKQ=; b=iSoi3m2KmtK1HP7gIRg1noBzhL
 NtSADOj0t1i5+64Ao6MTgqBy53Oi5hySB1oaSupB48LrYAe6WSHgX3sRePeOmRSBeOalLwq3PjLPe
 o7VWjNhWg9bzTER3go24x5rY4NvcXrNHSG27dPCq8FaviCpfTy6oAmfGHttkYx1zLPVHclNk+ZT3v
 hOI/J3t/5Sqbz+qntMkChEOhBBbxyjMtkPXUOkK/z1Y3q/JFHcnBDRIwMPc/9kvijxshC5QTCuOyS
 SxxEAdJQLddlRqnk0FBt+k4stxyPW+VkbiUafpJFRXjJC94bHUQiCofxZEm+6s4anxL6tsme1AtkS
 LKE4otqA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldbSh-00043Q-48; Mon, 03 May 2021 10:30:24 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
 <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
Date: Mon, 3 May 2021 10:30:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_093034_217971_3FAD6633 
X-CRM114-Status: GOOD (  22.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-05-02 2:41 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
>> struct device (of the client doing the DMA transfer). Thus move the
>> conversion to struct pci_devs for the provider and client into this
>> function.
> 
> Actually, this is the wrong direction to go! All of these pre-existing
> pci_*() functions have a small problem already: they are dealing with
> struct device, instead of struct pci_dev. And so refactoring should be
> pushing the conversion to pci_dev *up* the calling stack, not lower as
> the patch here proposes.
> 
> Also, there is no improvement in clarity by passing in (pgmap, dev)
> instead of the previous (provider, client). Now you have to do more type
> checking in the leaf function, which is another indication of a problem.
> 
> Let's go that direction, please? Just convert to pci_dev much higher in
> the calling stack, and you'll find that everything fits together better.
> And it's OK to pass in extra params if that turns out to be necessary,
> after all.

No, I disagree with this and it seems a bit confused. This change is
allowing callers to call the function with what they have and doing more
checks inside the called function. This allows for *less* checks in the
leaf function, not more checks. (I mean, look at the patch itself, it
puts a bunch of checks in both call sites into the callee and makes the
code a lot cleaner -- it's removing more lines than it adds).

Similar argument can be made with the pci_p2pdma_distance_many() (which
I assume you are referring to). If the function took struct pci_dev
instead of struct device, every caller would need to do all checks and
conversions to struct pci_dev. That is not an improvement.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
