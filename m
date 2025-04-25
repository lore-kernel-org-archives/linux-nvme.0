Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10EDC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtuBNXsyqeoWh2PS9vUeqlnJUhOTo/N04Dtmq7F8BBM=; b=O6gjaLpkyUx9OEV7c4Ab7SX5B+
	2UXENpBq0Y7tgCX0scR5PSYV67qftKEO8kQdV1VvCYGayRtxGO6A4AalNnhZIChj164dJLL3av/z0
	kZaOXSrDfpkdi+7o7h+LsQ7qMT2dyIWhDjQPSrZGC+C08Yx8GP9IOrbNxU0de+KCpjsMLv9YNMusQ
	JrHMF12LEV06ZRoezGTSjIAQ0RgZFIBg0cp2Uh6TGjtA0+aBx5z76ncL5a+DCAs/FThpBB3QHANf7
	5E72aIJdpGBELFeXIqPwlM8zptUcY0U4pAwKDd5MNjwvYKXT+RAXIAAJoxpt/a4qxzAKT3ybwbARG
	39CB4OkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8MzV-00000000PVb-1CUh;
	Fri, 25 Apr 2025 17:37:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KiS-0000000HauU-2wnV
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Apr 2025 15:11:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jtuBNXsyqeoWh2PS9vUeqlnJUhOTo/N04Dtmq7F8BBM=; b=K/ANJfSW6d0PPuMcLgfBP8LNlg
	yeplzzh1CCo+s+80HU/GurY/KWsMK8gA6FdfupohQAd0ntQ1piuHU1O2Aq+FF9Jx5n7L+wraNSRIj
	eoQGyqnjThdG/v9ol3bs1uEodnl5Yo0KsZ47sssl3jISoPd/settuU7gAR7OXSUUYNq1n4Tqt9C/a
	qySQlheWfoDsy20k+IAoNOQVuierchuC2ISFsd6T/8F7V5jX44+3os/HciEyYv6GCZMibMstWCLY/
	afGcJ2kKOgrfMVEOWVaWYIsSlwNcmfrB4+E/IxSdKpuivDgwVWq4HGCJ1bcoRR/jKXFY4mHqKqVTd
	M1uykYrw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8KiP-0000000C5xC-3GCo
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 15:11:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3DDB68BEB; Fri, 25 Apr 2025 17:11:40 +0200 (CEST)
Date: Fri, 25 Apr 2025 17:11:40 +0200
From: hch <hch@lst.de>
To: Waiman Long <llong@redhat.com>
Cc: hch <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Message-ID: <20250425151140.GA14859@lst.de>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com> <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com> <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com> <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com> <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <20250425145450.GA12664@lst.de> <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_161145_928748_3AD0C08A 
X-CRM114-Status: GOOD (  12.52  )
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

On Fri, Apr 25, 2025 at 11:04:58AM -0400, Waiman Long wrote:
>
> On 4/25/25 10:54 AM, hch wrote:
>> On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
>>>> It should also be in v6.15-rc1 branch but is missing in the nvme branch
>>>> that you are using. So you need to use a more updated nvme, when
>>>> available, to avoid this problem.
>>>>
>>> Thank you for finding that commit. I'll look for it.
>>>
>>> Christoph, Sagi, Keith, Others,
>>> Can this commit be merged into the nvme-6.15 branch please?
>> What commit?
>>
> commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with 
> cgroup_rstat_lock")

I don't see how that is relevant for the nvme tree?


