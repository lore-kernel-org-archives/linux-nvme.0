Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3767C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VrzQKDM3CgdQYr9yThE2xbeXlGdq6FeR/EKXTATuHi8=; b=oVTLB80lqRa5O5XtDvt3hNRERx
	AAi1RngkUiw9leLpIw4qYhYpRKbRk+RIvVHVVtjxoi7qYwsWiF/Il9glnZuqrmytQKCemS4LgvV7X
	pDOpfT8dQ/aJvIG3g1mZLaQzaanuKgeHI13uCLPxMKFSanMjM2bpf/QHwqWDbnuyD4DqQey0jG7mi
	eZIfFs6+gofnS40oRy57Af8XHSp9tOiyS6UAlVa4nLowD0j9DH3UyuAkLxejuay9+WaDgOcBc3jCi
	AMh3X783A0CKgbveQfucdg2B68Ro6iP+B+lBMEL3v/xAJgVPl1rikFPOF7drWq14AdPAYt8YP/OOP
	hj8Q+NOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMSUD-00951I-Jz; Tue, 22 Feb 2022 10:33:37 +0000
Received: from forward500j.mail.yandex.net ([5.45.198.250])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMSMm-0091MB-9P
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 10:25:59 +0000
Received: from sas1-bf48a613a597.qloud-c.yandex.net
 (sas1-bf48a613a597.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:3327:0:640:bf48:a613])
 by forward500j.mail.yandex.net (Yandex) with ESMTP id D1E7C6CB6C85;
 Tue, 22 Feb 2022 13:25:50 +0300 (MSK)
Received: from sas2-e7f6fb703652.qloud-c.yandex.net
 (sas2-e7f6fb703652.qloud-c.yandex.net [2a02:6b8:c14:4fa6:0:640:e7f6:fb70])
 by sas1-bf48a613a597.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 48ExnEqLLS-PodWFaKS; Tue, 22 Feb 2022 13:25:50 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1645525550; bh=VrzQKDM3CgdQYr9yThE2xbeXlGdq6FeR/EKXTATuHi8=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=UeSKcUgmt11T7m2wvH6B7s1gi3zuG1jxTs5V/Sd5OORBCZ/+DvQ49Y+F6hw6grC9j
 UdYfhA7Ksr+3V/a1M1Mi2Zn4QUu+aCthPXk4Oy7Oy4A118nhxqQgXSgJpH+4/9kqTv
 MyZYXIdWKz1iGCzZjhnsspydjzyINXHZRmkUOsHA=
Authentication-Results: sas1-bf48a613a597.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas2-e7f6fb703652.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id uEiekiExrx-PoHOgNa6; Tue, 22 Feb 2022 13:25:50 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Message-ID: <0500b120-4168-4981-0be5-164222a6eeed@yandex.ru>
Date: Tue, 22 Feb 2022 13:25:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvmet: parametrize maximum number of ANA groups
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220222085522.296465-1-alextalker@ya.ru>
 <6aef5693-1ef8-45f1-741e-541cd5fdd98d@nvidia.com>
From: Alex Talker <alextalker@yandex.ru>
In-Reply-To: <6aef5693-1ef8-45f1-741e-541cd5fdd98d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_022556_559633_7E7A9C4F 
X-CRM114-Status: GOOD (  16.73  )
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

 > Please no module param for this, right place is configfs subsys
 > attr.

Did you meant port attribute? Since the value mainly makes sense there.

The main obstacle for me here, since again,
i wanted to keep the change as simple as possible,
is the 'nvmet_ana_group_enabled' "array".
I have a real doubt that I do understand what it is for much
but the main issue would be if maximum number of ANA groups would 
differentiate per-port,
then how does one pre-allocates such an 'array'?
What this should be refactored to then?

 > Also, if you are doing this please make sure to write a block test
 > for these two configfs params, since it definitely adds a code that
 > user input might missuse with invalid numbers.

Could you please give me an example of such a test?

And...

 > We should keep anagrpmax a compile-time default, and have 
'nanagrpids' a per-subsystem configfs setting. That way we can limit the 
memory requirements on the connecting host (as it can/will size the ANA 
log buffer by nanagrpids), and have the value configurable per subsystem.

Would that imply that ANAGRPMAX would be set to less than the maximum 
possible value? If so, which reasonable value do you think will fit? 
2^16 or more?
Again, why 'nanagrpids' would be a subsystem attribute if validation 
comes into play(for creation of ANA group) on the port level at the moment?
And the same issue as before, what to do if the value decreases while 
groups are in use? Deny the change?

Best regards,
Alex


