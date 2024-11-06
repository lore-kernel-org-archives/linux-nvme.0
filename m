Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF7D3E781
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LsLLc8OXECka2t06IwT5J1dpYVA9nmZysMJGMXn5pi8=; b=QLpMIDdVW5syBRtNcHzkTlZONK
	P1NzEeS2tc73eiBgix/sXK+L8HR+K/2cfidyN+IBIKqtJyG6pCVZQv1Zjche9PGOURwdp1ZUVyPYG
	JpIgCNc9+PBMiNDAw2EqIPCXl1TdZffgYX10uM3mK808yv59KhohPCiH1QnXG/bsA+GzrEc9VdX1w
	sbpHiZxFvjeZHmUUC+0H9DOG5O/5kZH14ym1rcmx1f6ARzvK1vlfpdtWCzzSr3guNxfD+r6Pw4dZo
	ggTVTKRzFdl5GZ+c0KUQ5UeR4rz3/b+dK9nX1kRfBu2px24El+3xh+4ZGX5IH2od9xox7Hwdmjg4S
	/e3GwdHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8VDk-00000001Mdp-1RtO;
	Wed, 06 Nov 2024 01:52:32 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8VDh-00000001Mce-0l7M
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 01:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730857946; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LsLLc8OXECka2t06IwT5J1dpYVA9nmZysMJGMXn5pi8=;
	b=drH1ePY7ZTPbNg3uVK8NdE+46T+utvUdMMyYGGvmi2+63dK/KBVlRDloEE/u/7nrkn07STP5PBXD9fdi5MDpnVdvmPHceygtgeFcDCq9aGvNAYoem0KKLC/DDw0dAidMDA/8e+iecPypHoz6ZlONZjwqCY6690Jqy/sysC1sAkA=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIoIr6H_1730857943 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 09:52:24 +0800
Message-ID: <5af7ec6b-9534-4a19-be58-d64f68a3472f@linux.alibaba.com>
Date: Wed, 6 Nov 2024 09:52:23 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH RFC 2/3] nvme: query independent identify ns by default
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20241104085524.118221-1-kanie@linux.alibaba.com>
 <20241104085524.118221-3-kanie@linux.alibaba.com>
 <20241105111106.GA1993@lst.de>
 <Zyp6K5XER535YZRt@kbusch-mbp.dhcp.thefacebook.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <Zyp6K5XER535YZRt@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_175229_596761_A8243F34 
X-CRM114-Status: GOOD (  12.19  )
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


在 2024/11/6 04:03, Keith Busch 写道:
> On Tue, Nov 05, 2024 at 12:11:06PM +0100, Christoph Hellwig wrote:
>> On Mon, Nov 04, 2024 at 04:55:01PM +0800, Guixin Liu wrote:
>>> Query independent identify ns by default, if returning fail,
>>> go back to sending the "identify namespace data structure for the
>>> specified NSID or the namespace capabilities for the NVM Command
>>> Set(cns = 0)".
>> How is this related to the rest of the series?
> Patch 3 provides target support for the VWCNP flag, but the host driver
> wouldn't check it without this patch. I'm assuming that's why this patch
> is included here: so both sides can be tested.
Yes.
> But if you have the time to review a different patchset, I would prefer
> we get nvmet up to 2.1 compliance and restrict this identification to
> 2.0 and above where it's required.

Yeah sure, I see the Matias's patchset too, you could apply my number 
one patch

first, when the nvmet's version increased to 2.1 and Matia's patchset 
applied,

I will continue to working on nvme target's ns respective vwcnp.

Best Regards,

Guixin Liu


