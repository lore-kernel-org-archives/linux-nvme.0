Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4789ACA9ED0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 05:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NtEiZGP3nMgzq02ILqM9aETC1DhkWkgIpNHRZCHjG4c=; b=20dr/u5292kb+bS4KpEiVFOnpn
	nL1uzTyYvzzexQIlI82vB0BQjh76RMKvtXAD3pOmYNFiwM/ctsy/UrFAqVvqi4RBVtcyJ4JHvlTcb
	QZO+KbaGoDnfFstoiO+QV1DSpP8n7EZ6wyEAi4xUE04rBIKms3i0+1rOxZ0KQIZJBfUX8Cfm084VA
	Y6q3TWJHHeAckdoh4tJZ1jTTUJ51cqW15KXgaHqLwJAx03ahX87L4vCO/dMICb1pnmewADTG9iqPo
	sQM9ZezN3ouIh5uTL39RORo9gI/yz6ADPiXNcJDp9sBpdZgEVspBFetOJJvubmBGuV4ioysdbczi3
	g6knh+WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGVQl-0000000C3bB-1w8Z;
	Tue, 13 Oct 2026 05:52:07 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGVQf-0000000C3aH-2fFJ
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 05:52:06 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261013055153epoutp04979adcb77bb73e1858946b54ed3a5de3~eAOt2lie90467604676epoutp04S
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 05:51:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261013055153epoutp04979adcb77bb73e1858946b54ed3a5de3~eAOt2lie90467604676epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791870713;
	bh=NtEiZGP3nMgzq02ILqM9aETC1DhkWkgIpNHRZCHjG4c=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=cepUQcZcN2BExhq+kjuVztMXdN4vYHRUVp0KwE7vYF8pXjgHIIvamLBE+8S+NLrwr
	 PlUPXYTsI9nF81Q2wQlqf4CQEqprTYuQ9CC0QliaofMOHop36aXLQiRfQY9Ge2p+Kc
	 xIhhFnB9SXXYtw6g+Ce4pzq2MPE/KOVCGD0YWy2c=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261013055152epcas5p1913b4f9644bd178c2bdcd4ed4f790bb0~eAOtiru7b2620126201epcas5p1l;
	Tue, 13 Oct 2026 05:51:52 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4j3k473zB9z2SSKr; Tue, 13 Oct
	2026 05:51:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261013055151epcas5p168c8fa589b57341a60133c1ef9fc3787~eAOsA9r363100831008epcas5p1N;
	Tue, 13 Oct 2026 05:51:51 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261013055150epsmtip2ed7100ae284f25d0efb348b3afc0731e~eAOrJ08At1477914779epsmtip2t;
	Tue, 13 Oct 2026 05:51:50 +0000 (GMT)
Message-ID: <159074f4-b29e-434b-8634-5e15ba623b4e@samsung.com>
Date: Tue, 13 Oct 2026 11:21:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme: pass partition flags to passthrough checks
To: Yao Sang <sangyao@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20261012072847.406548-1-sangyao@kylinos.cn>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013055151epcas5p168c8fa589b57341a60133c1ef9fc3787
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261012092736epcas5p14d1c7db3fc7f257acf67884d2a284fdb
References: <CGME20261012092736epcas5p14d1c7db3fc7f257acf67884d2a284fdb@epcas5p1.samsung.com>
	<20261012072847.406548-1-sangyao@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_225202_974617_9584EB15 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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

On 10/12/2026 12:58 PM, Yao Sang wrote:
> nvme_user_cmd() handles NVME_IOCTL_IO_CMD on namespace block devices,
> including partitions. It receives flags identifying a partition, but
> passes 0 to nvme_cmd_allowed(), bypassing the partition guard and
> allowing unprivileged passthrough commands to access sectors outside
> the partition.
> 
> Pass flags to the permission check, rejecting unprivileged commands on
> partitions.
> 
> Fixes: 1161be71d1ec ("nvme: reject passthrough of driver-managed Set Features")

The fix looks correct, but tag seems misplaced. It should rather be

313c08c72ee7 ("nvme: don't allow unprivileged passthrough on partitions")

With that
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

