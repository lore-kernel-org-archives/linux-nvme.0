Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54CACD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 06:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39QUOq9DLQ98d/L3BJKn7BT42RQyrSqp/nbGy8Q1AZY=; b=cU6wN2WBTREMJcRzpWbdwHE3S+
	mNNjIblbnGLyiUsFPGm6HQcLeHqQIa0AmgAIchzsdkJrpBbZKv0pQx8m8ssdWfa5fH83f+kO0UzcP
	IsRd7ufqN7mAqrpFMqBBxvP5huoRuekFR6jgLs6LiDiIU4mcgFjudxCnJqw9l+PIyWRBmcRzOGoNb
	Pgck+KkE3wkjT51edBj8UkkF+cF0GzyOlxtJqzibRMPKw4Fcg9eW2IpOmQtIYmq6mTd8FhmtKMkcj
	yF0cB6V7s/jEKrfR8fAItBsywW5GR1cI5I5fCsiVW9l3My01+TujqMw1VVUIxBqwkG1bTaSel9BWp
	J6jIU8Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSmV-00EzGd-1J;
	Wed, 11 Oct 2023 06:33:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSmQ-00EzDo-0C
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 06:33:18 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231011063305epoutp011fb3e78e623dd10837ee6f1a72bb9da2~M_fPLHAif0807708077epoutp01S
	for <linux-nvme@lists.infradead.org>; Wed, 11 Oct 2023 06:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231011063305epoutp011fb3e78e623dd10837ee6f1a72bb9da2~M_fPLHAif0807708077epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697005985;
	bh=39QUOq9DLQ98d/L3BJKn7BT42RQyrSqp/nbGy8Q1AZY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Yu1G2oLLiThvRBU9vaMAQYxnNWN0ZavVW41H5TSqeCbG7lWJdPpImr9IAzhLhlFXD
	 xPWKN2hM4Va+/BrN/g4rKD/da8IjydxiDLQWbi8n+DPGSdFMwNHmZXAnWdTfCDpLkn
	 TPr2H7uCQZExyDh+57LYBGtJk8KfUGZeZt3Fyg7E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231011063304epcas5p485b2132bae666b71d842403795246940~M_fOd_UWV2758527585epcas5p4U;
	Wed, 11 Oct 2023 06:33:04 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4S52yS27j1z4x9Px; Wed, 11 Oct 2023 06:33:04 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231011052647epcas5p3397e527e1f558363c68439abd69a5fde~M9lWURS432356923569epcas5p3t;
	Wed, 11 Oct 2023 05:26:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231011052647epsmtrp274729fca33ca3ea48e27ee13395994f5~M9lWTc_Cn2667626676epsmtrp2U;
	Wed, 11 Oct 2023 05:26:47 +0000 (GMT)
X-AuditID: b6c32a52-205ff700000049e4-6e-65263216c589
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.21.18916.61236256; Wed, 11 Oct 2023 14:26:46 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231011052645epsmtip28508b1e1a1962790a367d95f29f3164f~M9lUwLVFP1964119641epsmtip2u;
	Wed, 11 Oct 2023 05:26:45 +0000 (GMT)
Message-ID: <1296674576.21697005984297.JavaMail.epsvc@epcpadp4>
Date: Wed, 11 Oct 2023 10:56:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org, Vincent
	Fu <vincent.fu@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231011050254.GA32444@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK6YkVqqwYO3lhZrrvxmt1h9t5/N
	4uUhTYuVq48yWZx/e5jJYtKha4wW85c9ZbdY9/o9i8WCjY8YLR53dzBabGgTdOD22DnrLrvH
	+XsbWTwuny312LSqk81j85J6j903G9g8+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK6N56jLG
	gkWcFS9bF7A2MPaxdzFyckgImEhMOvgQzBYS2M4o8WiPHURcXKL52g+oGmGJlf+eA9lcQDWv
	GSWOt/wHS/AK2Enc29wFZrMIqErM+byVCSIuKHFy5hMWEFtUIEliz/1GsLiwgI/E4kWzGEFs
	ZqAFt57MB4uLCLhL7L64nBlkAbPAbaAjnsxmhdg2l0li5S2QSRwcbAKaEhcml4I0cAroSEze
	v5AVYpCZRNfWLqih8hLb385hnsAoNAvJHbOQ7JuFpGUWkpYFjCyrGEVTC4pz03OTCwz1ihNz
	i0vz0vWS83M3MYKjTStoB+Oy9X/1DjEycTAeYpTgYFYS4X2UqZIqxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwKTven+p3gp5Hpt9rz+ePSa4yu+ehjND
	Wf7ioG+iVz8uWeQ0xehC7wlf/7gshl/m4ZGXpkcvEY/8cKVEesOemig5F49cpWd8u159MOJ/
	EDkna35Zg4zes8mmTZ/U/m/9+7u9lqVmughXZONbo11P8mK1zRao5OrqvHt38b/lIdl5EwJC
	TvMYVNz+mVky551Hzur35n5CB5a825U4Z+KEqGvholbds25NdTL4kL66mu/vyR3Fdq++31ma
	xNG3XFve40NEL0d6t0rt/WPbWL4EV5t1S656kpe0pr9l3rJNHPHf/7rFfPv50N21j2Fimvil
	3EOPG0xPFZ3248i/tyGe5224gsH/nN+5ThIFQcv8tyixFGckGmoxFxUnAgA3PgqyJQMAAA==
X-CMS-MailID: 20231011052647epcas5p3397e527e1f558363c68439abd69a5fde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20231006135322epcas5p1c9acf38b04f35017181c715c706281dc
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
	<1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
	<20231010074634.GA6514@lst.de>
	<CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
	<20231011050254.GA32444@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_233314_705412_78E51135 
X-CRM114-Status: GOOD (  18.96  )
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

On 10/11/2023 10:32 AM, Christoph Hellwig wrote:
>> Just that I was not sure on (i) whether to go back that far in
>> history, and (ii) what patch to tag.
> 
> I think the one that adds the original problem is:
> 
> 63263d60e0f9f37bfd5e6a1e83a62f0e62fc459f
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Tue Aug 29 17:46:04 2017 -0400
> 
>      nvme: Use metadata for passthrough commands

Thanks.

> 
>>>> +     /* Exclude commands that do not have nlb in cdw12 */
>>>> +     if (!nvme_nlb_in_cdw12(c->common.opcode))
>>>> +             return true;
>>>
>>> So we can still get exactly the same corruption for all commands that
>>> are not known?  That's not a very safe way to deal with the issue..
>>
>> Given the way things are in NVMe, I do not find a better way.
>> Maybe another day for commands that do (or can do) things very
>> differently for nlb and PI representation.
> 
> Fixing just a subset of these problems is pointless.  If people want
> to use metadata on vendor specific commands they need to work with
> NVMe to figure out a generic way to pass the length.

Do you suggest that vendor specific opcodes should be blocked here?



