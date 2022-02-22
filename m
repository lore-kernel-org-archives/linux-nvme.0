Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054DFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 09:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VIYV9SxAq1yx2B364/zuufx4snCFUhPiNJo6sdC/qKM=; b=B/satsVk6oP4Py+MYygKOUdnf/
	mXPUu8KULgAQVxTgywjD2jp5IZunUYWmHsmwLVoXOCJJK6s+UFqsBgXn2K8PZ+do4IEKHo7/aXPVN
	psFSvvh2JJ7d8vRhJn3Du9KKloNVzuz3xvB+J6F8rydH84e9/aMh4DjN33YSPdX8GPdqgCqB1NGjX
	y0OdW5bQQwW8J9eUsrkIAj/B0I7tVgqe/ni8qOncPSMsifcHOKNYz245ijv/u4SwXv+h3EMP+5gnp
	y1yVTsOeWKRp52jzXO6V47RMe/dt/foIyBKop1jtfkc7/nrQzCaNj97qpTcZYdo/GWvYwH2iHbmLz
	Saec3MZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMR6L-008fBB-MD; Tue, 22 Feb 2022 09:04:53 +0000
Received: from forward501j.mail.yandex.net ([5.45.198.251])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMR6G-008f8v-54
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 09:04:50 +0000
Received: from sas2-bcc9105f7ecc.qloud-c.yandex.net
 (sas2-bcc9105f7ecc.qloud-c.yandex.net
 [IPv6:2a02:6b8:c08:b7ac:0:640:bcc9:105f])
 by forward501j.mail.yandex.net (Yandex) with ESMTP id E10666239A0;
 Tue, 22 Feb 2022 12:04:39 +0300 (MSK)
Received: from sas1-7a2c1d25dbfc.qloud-c.yandex.net
 (sas1-7a2c1d25dbfc.qloud-c.yandex.net [2a02:6b8:c08:c9f:0:640:7a2c:1d25])
 by sas2-bcc9105f7ecc.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 hMAd5FfERe-4dcmCf0v; Tue, 22 Feb 2022 12:04:39 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1645520679; bh=VIYV9SxAq1yx2B364/zuufx4snCFUhPiNJo6sdC/qKM=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=vhxq+xQVUt9r8BFfqk+CasIKJKzXw0gqactjoXvgc90oFbuGNcIDKkbBh47phFJfO
 oDDCWvEDGNoWk3RqrI5gG9C41YOtzKmtZcJ52IaO9IpcDLfo/OCuX9Nau9GRM1vImb
 vR3KS7oU5AyjMJv0E3+N1TPAuhkn0IOcCWN+ziC8=
Authentication-Results: sas2-bcc9105f7ecc.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas1-7a2c1d25dbfc.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id tiZULnQPqo-4cHeJ185; Tue, 22 Feb 2022 12:04:38 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Message-ID: <99b55cd5-5113-19f6-654f-d81519ea570e@yandex.ru>
Date: Tue, 22 Feb 2022 12:04:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
 <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
 <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
 <3de626e3-4d03-50a8-9bd2-c974227add02@yandex.ru>
 <4cd1f9c1-e31a-2a41-1f96-ba54103cc3a2@suse.de>
 <DM8PR06MB7704D092EEAE68C75EE33CDEF1339@DM8PR06MB7704.namprd06.prod.outlook.com>
From: Alex Talker <alextalker@yandex.ru>
In-Reply-To: <DM8PR06MB7704D092EEAE68C75EE33CDEF1339@DM8PR06MB7704.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_010448_572786_B489309C 
X-CRM114-Status: UNSURE (   8.00  )
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

Apologies for the long delay in reply, it has been a rough week :)

Okay, I see your point. I think this discussion was quite helpful for me,
so I submitted patches regarding parametrize  of maximum number of ANA 
groups (and also namespaces),
signed off under something that ain't an alias of course (if one can't 
tell by my rambling that I do fit the pseudonym. hehe).

I checked both changes on mainline and it worked fine, i could allocate 
1024 namespace and assign each one a separate ANA group without much of 
an issue
but I noticed that disconnecting from such large configuration was 
somewhat buggy perhaps, so this might be something to investigate in the 
future.

In any case, thanks for your time and expertise!
I hope that you all would have a nice day and definitely accept my patches,
so that they could spread-out and remove need of manual code patching to 
fix my issue with it :)

Best regards,
Alex

