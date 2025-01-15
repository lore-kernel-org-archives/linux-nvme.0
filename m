Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52BBC02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RltW2sS2ZYMoz6QtuOL8V8aRWEPd79GUWtcQFb6H7tI=; b=EGq4Ldy0cK68V5LGboONMkVwSk
	4kauK76XOypmJXvT68awaqSoIJFBFAg6GIfrmlf8f8VS3w3+Z+cHSEoOLPQWmqAxVmRZ4Z7mY/mzm
	yoTEqBq0ulfW9zaPxHwaqcVXp5NFaz75cxiG5vxgW8Hluki3NJH2t+TGpbs8C51yAiw1rjVfZamsA
	+Fw7W99TthRnKC83uaqAALAeG5cdS/HhLknhPafDXBRDwbesxMhEiWtDhxkKICbD2G2g80RJdTO6Q
	W5DSxpdDRbb+r2oK8cAF6tsfgxL0UZiMCJEBQZ2pj5u4Jf72IbKwMcKLWWeGNRyEChuAOaCRcSVaW
	sG+vyOlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY6Du-0000000CRJF-0CFS;
	Wed, 15 Jan 2025 16:26:30 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY6Dr-0000000CRIF-1yjO
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 16:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1736958375; x=1737563175; i=linux-kernel@simg.de;
	bh=RltW2sS2ZYMoz6QtuOL8V8aRWEPd79GUWtcQFb6H7tI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YWsVxS4XUviVD6iRL/DAP5GU43rw1YNHdSrhkJ8cBjso6aWLoXdYMWOMp3BRTlXY
	 gdxROmotnfqln9Xn9241J0pZkMOOSmyxGZdZ3dNApNpZSDkzqngxWWSMZO9/U2W2X
	 lI+0W/ZMzu9n0GrG8uQIfeqMYGg5ydrRY9UNA2eazGxRu7dZ/ulEgZM5XDCChrOaX
	 bPdZj2EoMgL7uAEht1D+zFef8teiG7zd/Q7RmaVfBWDfSSYEqFhfKOv1u6aB/9pDb
	 aCyLux2u/3NWUAO+m+Rydk8k2td3JTWn3TZyWvYSgNKWu4BJ11DO4l2ebVpoJ8q1s
	 RSYqbHBH5nI+lKex9A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([93.217.99.181]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPowd-1ttDsK2rlj-00SSnq; Wed, 15 Jan 2025 17:26:15 +0100
Message-ID: <7e5b72e9-7f7f-4e68-a42a-4411cc5778b1@simg.de>
Date: Wed, 15 Jan 2025 17:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Bruno Gravato <bgravato@gmail.com>, bugzilla-daemon@kernel.org
Cc: bugzilla-daemon@kernel.org, Keith Busch <kbusch@kernel.org>,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
 <CAOBLbT9LrqdHQ4-gGkRyB+vU3WnGo8f7X7m2=qK29+x=3QpzPw@mail.gmail.com>
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <CAOBLbT9LrqdHQ4-gGkRyB+vU3WnGo8f7X7m2=qK29+x=3QpzPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s6m+XZFkNT4XqeH9ZJr2u+oy+7X2xp4vVEBn5fsWllVwF3JOyUU
 GJ5KAyZxl0py8rBIkROyWGo4qucHklto2Cq8exPWuYx1T1wP+n2eJBZczG2IaYAqBLl3bxl
 as7rUiIibF09qncBYdfUM6zLxbrYDbA1zuIAf+U/H9xzI2pSqwRQ/loUN6h9q+ZjdibKQ/X
 ltj6/mI14UKIJOm1cDGhg==
UI-OutboundReport: notjunk:1;M01:P0:kKnzRXl7azo=;TFVJ7dn1EfZPsiykdqQCXIRgMV3
 iYE7wBSQ7tzcgf11PLvSox2WYT2fSzMwl74uQYIb+fenOrprLQES6IeILrBDhDNmCLjFAdosw
 ZXVzJCns+DAIpSX+jFJJqpu760nRvR+JFO1LXtpO7ZDd3EzlxpyPgwULeK9e7wOLr/3tuStcS
 Mn9fzB5IdM1yTi3sBgRbH5AdwChPQr+Ip7NaAyZvPH5u+iAo+lgsI++d33/m1VZ/pvhoCsyoT
 gd9gyWeUjOJ7vSW1uKwo7/OeLIb3SVZvg2qrHnzkeZ9VTbjVVexoyEA5B/TpW6eUXmQgG7hMW
 GDvlqxKipG2sdt8q+lrqZrPjt4eV0mUpnMo/T+MRP9/LerM7zzZvYecRrBeUmOk2oTDq4EmMe
 blu+B3gdGImBCfkEGTjWO1Yk2JceguDKNchqpfp0Sxd25qEssLk8Lk+HI3QasTast6iodYA9r
 faQ/gMtk4alJAZXpgDhoecU3CYnlVluEq6XjmgvP4u2j8dG6QpsivKPTNKe9Hpql+PbhWJW23
 RT516kfCuZ+3AWBGYjDyPmxgVWWnv3FKfZduFcO+m03H3T56rdZRztKq0ypVhkOfDUUkrMK6o
 0Qcbwp1z5Wp8vZUc5JH7zbG3yvbQXDUrlUbLrW/YvhwScNOatyMJZFnecb+h4O7AH3VgSiMWR
 sXuMQB00End/OEri+A+w9lMTAjfmRH9KsGvakCFVl2tsEYvxHMAQn6H9NgRoKpRhMr/8M7Txs
 JhR+NB+NKZa5igiUy94SmYQ6f8RqMWLEDRQsJYDwTx/l4Ao75CvzRNNy9RpXBm/QYWuiF+8x2
 jF+OhXFKnBJC+B/EFdrRplZkgXpgWGo51rOdjWBxhXn6Aj9HeIxZpE4b+7uUGXFhANT4J/FDX
 Ghh+iDJAmNTe92Zf1K14UziqqTTPcCQtvfFaNsRRy+EiNDZmVrkLHs7JceWyd1ulXkMAal2BI
 6HJ4MLMYdXtRWyAcoZlfnTKWk6IhYIvoix/O6ap7/lwLXyQRFJXeQXYW063CakMC9DK4GdRoI
 h5YllOImqm3FZDjTTzlQNtO8pXG68JPbeiwQyofkIPK1kr397DLkQRE/CdQ1CkhxIfDf/fnPA
 3151QV0ylu9BIGYszbJyg09aQApEdln/4jDdywCKA/w6hkGQNYmFAjshNkzFrUfcVH1EUOC+o
 =
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_082627_946954_731A99C1 
X-CRM114-Status: GOOD (  11.21  )
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


Hi,

Am 15.01.25 um 14:14 schrieb Bruno Gravato:
> If yours behaves like mine, I'd expect that if you swap the disks in
> config 2, that you won't have any errors as well...

yeah, I would just need to plug something into the 2nd M.2 socket. But
that can't be done remotely. I will do that on weekend or in next week.

BTW, is there a kernel parameter to ignore a NVME/PCI device? If the
corruptions appear again after disabling the 2nd SSD, it is more likely
that it is a kernel problem, e.g. a driver writing to memory reserved
for some other driver/component. Such a bug may only occur under rare
conditions. AFAIU, the patch "nvme-pci: place descriptor addresses in
iod" form 6.3-rc1 attempts to use some space which is otherwise unused.
Unfortunately I was not able to revert that patch because later changes
depend on it.

So, I now only tried out whether just `NVME_MAX_SEGS 127` helps (see
message from Matthias). Answer is no. This only seem to by an upper
limit, because `/sys/class/block/nvme0n1/queue/max_segments` reports 33
with unmodified kernels >=3D 6.3.7. With older kernels or kernels with
reversed patch "nvme-pci: clamp max_hw_sectors based on DMA optimized
limitation" (introduced in 6.3.7) this value is 127 and corruptions
disappear.

I guess, this value somehow has to be 127. In my case it is sufficient
to revert the patch form 6.3.7. In Matthias's case, the values then
becomes 128 and has to be limited additionally using `NVME_MAX_SEGS 127`

Regards Stefan



