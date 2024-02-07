Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83889C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ov0GWsbYd3iC0V6qn3T3YJAMWGSihVSOrpMKMCWdN+s=; b=beoXEZXgQtrAtiIQq3rdD3ry3Y
	u1Rsvc67y55v3gmDb9jtI+PMTBa9UQ28dte5x2I9faAq/nFRZ8sv3Vk2ytAD0ItX8/O/911FM93Rz
	tcAHXrzjJ9syLLWvSxwnSu8kAVDfwnT0sD26CMd/Y3817y3HjMenYA9FuGQXFZXqNfoqia6BIG/Fe
	AXwXv1gd/HFDBRPwXRaCzTSV8jOPnK6nbVVk4FJQTOXS4Zo9o7JlxWnHv5dwUK7Of3ws5kODw7A97
	JckXB3WxqOCbt0sBTXRmmX2JPH5LpNsTw5EHJBN9ljbHmcfFoIrTkSI0cbvkexc+YG2CfaIghBa+y
	6K8yGtqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXq0q-0000000C2og-3pJa;
	Wed, 07 Feb 2024 22:03:24 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXq0n-0000000C2no-2tnk
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 22:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=ov0GWsbYd3iC0V6qn3T3YJAMWGSihVSOrpMKMCWdN+s=; b=eeXzEx53wjFYZfBeNH0L8Y6sIj
	YmYXF9MziFaGETENrofewQ500L6CUrBqO/5Mdx+TQyG1ny2F0BVl1d+0fhGrS3T3HYzVa932xg4Mr
	jgzCD1OITItaLPXtdmuT7lVjaEmVMwtpozNWTBUzNWoBgApnj70JPYkNzGOu+IpsgxwFAa8j7fqhv
	K3c8RgXoR9iC02kN1vwTo6zvh5NQDy1KhV+WDUaNF5q+OZ4ExXwC7wMGXafJf3vibYanycS8m49ml
	aMw9Z+A2DyZgeZvO5i1XeWuMur8a3ocrSqpIQorZcbHARGLgnTh7TU+DAkxZgzp/PEX1aKmYRoEyN
	H+9HGBXlrKt6zb0jsJ/IkmVc6CQetp/vEt9bEx0DIsto1PSq7rwbYOkleTZK6hUZ733a5KXGavoVE
	+Bu0wmoE2v2EkOtZ8rV4VDhaGpqjGNvAC1RaFMT6WphekviJssIifcmZuH2Yxa7Q2il1Bz8KiuWzA
	mZpT8q5QG1VchDdhYHejtGOY;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rXq0l-00C1cM-2d;
	Wed, 07 Feb 2024 22:03:20 +0000
Date: Wed, 7 Feb 2024 14:03:15 -0800
From: Jeremy Allison <jra@samba.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: Make NVME shutdown two-pass - Version 6
Message-ID: <ZcP+I1iflY77Sh3W@jeremy-HP-Z840-Workstation>
References: <20240207214044.2374295-1-jallison@ciq.com>
 <20240207220048.GA919889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240207220048.GA919889@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_140321_751398_1E4B52D6 
X-CRM114-Status: UNSURE (   7.89  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 07, 2024 at 04:00:48PM -0600, Bjorn Helgaas wrote:
>On Wed, Feb 07, 2024 at 01:40:39PM -0800, Jeremy Allison wrote:
>> This is version 6 of a patchset originally written by
>> Tanjore Suresh <tansuresh@google.com> to make shutdown
>> of nvme devices two-pass.
>>
>> Changes from Version 5:
>>
>> 1). Function nvme_request_shutdown() name changed to
>> nvme_ctrl_shutdown_start() as requested by Sagi Grimberg.
>> 2). Git commit message reformatting to 75 columns
>> as requested by Bjorn Helgaas <bhelgaas@google.com>.
>>
>> NB. An alternate patchset from David Jeffery <djeffery@redhat.com>
>> has been proposed that covers much of the same ground.
>
>Would be useful to have a link to David's patchset for comparison.

Sorry, here it is:

https://lore.kernel.org/linux-nvme/20240207184100.18066-1-djeffery@redhat.com/

