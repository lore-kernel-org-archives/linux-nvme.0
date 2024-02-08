Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642C5C4828F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLzK0L1MpTC+gXvMqFR9jksRC9POC9kUt59nZtYp9as=; b=1Mh1KXq+oxxADrLmmBOHuxV830
	3+piy+fhdoEiBB/1JWWrkepDa8J88CmRx0e5euhHKFxpXg6sUggvX7Iw3YXBS5pXznlNuWFYzEoGp
	fhYbn14hA/l2jxQ5FqumXlkwzTKrWqQ+zZH6cgdQoHv1ZKWZdD1LRE7AYKAugQl7mKAjj41tenOay
	uA+RRAyrhIy953dzv+RyAUg7HrdeFT4ZkOan1c17DLaVHho7AU7Rl+zrttuSpFDaSVd7xORYyLXpA
	1892SEDttHFXkMBfQKfJ62XEHaNEgfpiDfquyvjD+NxMjxohj59uvsDfR4uux2+SMSrXh8uM/n6mI
	v0TKvPnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY98u-0000000EcCi-3Z4W;
	Thu, 08 Feb 2024 18:29:00 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY98s-0000000EcCA-0vQN
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 18:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=HLzK0L1MpTC+gXvMqFR9jksRC9POC9kUt59nZtYp9as=; b=a6FPepzUpxL2Kda/V0GIXA77jz
	71I+XZUJZHxz7fN9bWXq3LRyFXa3DJuOfZgHP0Le5zTgLEZUFVDC3VmnCWqIxLLwJU8vCpnFF50KS
	caerobJjCZVcvijZ1vho0NPdNw2hFPdUPoUaZHLw6JlK6dD2+2y20Q/vCh1LFY8JymAC0rxAArPBZ
	fJcYNHbAhkAPzef22DUG6PpflilWiJl0+EyjGmxqTEnmFk3YGUjOrTGiWgj1XiFgysMxFfSLU0qkz
	B1zQbvzil4qtM7FiwCzHVtrWWsjjNH73tejke4DH0ccZJmaEpcQpYkIruJOAbifjRKXAmxAB6y8I1
	HRuLtum1OvsHjJsGvNyE5Ql8VM2VaFRKiSWDvJI9IO8VLvxYSSeIIbxm3a2aIATR12uDToWoqMEgN
	tk5IIhbiTlC3dQU2hk8hwSyhdLneD/zFtDoQp6F8a0Wycoa+EgFTIXIJjlVgrtyPNyJIxV2aRJTrY
	iqllJjki/kapDaR290kHpvms;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rY98n-00CAvk-1d;
	Thu, 08 Feb 2024 18:28:53 +0000
Date: Thu, 8 Feb 2024 10:28:49 -0800
From: Jeremy Allison <jra@samba.org>
To: David Jeffery <djeffery@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeremy Allison <jallison@ciq.com>,
	tansuresh@google.com, hch@lst.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: Make NVME shutdown two-pass - Version 6
Message-ID: <ZcUdYbqq22r1QgP9@jeremy-HP-Z840-Workstation>
References: <20240207214044.2374295-1-jallison@ciq.com>
 <20240207220048.GA919889@bhelgaas>
 <ZcP+I1iflY77Sh3W@jeremy-HP-Z840-Workstation>
 <CA+-xHTGZrQhNULHh4aHG=70Led=RL1amZcRcFtmTWZtjKCtvpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+-xHTGZrQhNULHh4aHG=70Led=RL1amZcRcFtmTWZtjKCtvpA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_102858_289551_10F12218 
X-CRM114-Status: GOOD (  17.46  )
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

On Thu, Feb 08, 2024 at 01:02:37PM -0500, David Jeffery wrote:
>
>Hi Jeremy,
>
>I'm fine with merging our efforts. From reviewing your patch set, the
>main problem I have is with the core patch compared to my initial 2
>patches. Yours runs shutdown_wait calls after shutdown for all
>devices. This design won't work for example with the scsi system sd
>async shutdown. Scsi HBA shutdown calls may stop the HBA or firmware,
>leaving the async flush for sd in an unknowable state as to if the
>command succeeded or even made it to storage. My patches by ensuring
>all shutdown for child devices is finished before a parent device's
>shutdown may be called allows the ordering to work.
>
>I'm not attached to a particular async API. If nvme and core devs are
>fine with the shutdown_wait api, I can alter my core shutdown and
>scsi/sd patches to match.
>
>David Jeffery

Great point David, thanks ! I wasn't testing with the scsi system
shutdown, only PCI nvme. I didn't know the scsi system suffered
=66rom slow shutdown also.

As I've already done the work to get the bus driver and nvme devs
to agree on the shutdown()/shutdown_wait() two-pass interface
(and they have already signed off on that), I'd suggest keeping
that interface.

Looks like the key change is the addition of the ability of
a device to mark its parent as busy to keep the parent-child
ordering.

If you're willing to merge your patches and required fixes
for the scsi system on top of the new agreed on API then I'll
be happy to help review and test any updated patchsets to make
sure my nvme PCI case gets fixed too. It might be easiest to
add in the scsi changes needed on top of my existing working
code for nvme/PCI (I've already had confirmation from an nvme
list user that my patchset improves his shutdown times
significantly) but I'll let you make the decisions on that.
I'm not wedded to any specific code :-).

Thanks for collaborating on this.

Cheers,

	Jeremy.

