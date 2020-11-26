Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D13BC63697
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 13:23:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203EA21D40
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 13:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wkwW3Dnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203EA21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9/ne7HR5u+Pr3iep2NPdCunhl0wKaPDrAGRrcWElgjw=; b=wkwW3DnrxDvAcq2H9FvdVRmRa
	ITjaLRgI7rocwSfWLeaEyEjKP2c4CzJx2eCt08+acsXuyK4kTKujBQeYmBwIcKCceD2+td3pSr1yM
	KhYkvwB8W3WNencBXIkwsoaIT4kvKTBXtsjmw+rHG/h8YtD9M4FU9/+GcnNaCXQZyqhX7HzzfC1T7
	2/YNaI2kDFjGXxuiaNojZ4Nme/Hmi/RMy+x3k17eetV2PR7b7/aP65vplIreBPysgSmcmxs3dwykd
	p6+YJgHJdnMIKtW7ysGu7QOmwgI/m4IjOb0dfJl0pSqTHh87P0YWvobDoHn5hRpx5kcePHCO5yC5A
	Q7O4H7rrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiHEc-000573-L5; Thu, 26 Nov 2020 13:22:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiHCY-0003wE-IE
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 13:20:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CCB6068B05; Thu, 26 Nov 2020 14:20:42 +0100 (CET)
Date: Thu, 26 Nov 2020 14:20:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v11] nvme-fabrics: reject I/O to offline device
Message-ID: <20201126132042.GC5350@lst.de>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
 <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
 <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_082046_776461_44F29ACE 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, "Ewan D. Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 25, 2020 at 05:56:08PM -0800, Sagi Grimberg wrote:
>> Looks good. It might be better to add fast_io_fail_tmo to nvme_dev_attrs
>> so that it can be viewed and modified dynamically.
>
> I thought it was added, I recall asking this in the past...

Yes, lets add this as an incremental patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
