Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00757C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XZfyU6p6ZQajFzXv+WZ3ckOOh4R514SxxTkuJgSMAU=; b=4lVtvgKoBtdoSbXSm0/i3NWgWL
	3a4OBy+HUVrDOgB6/OsrYyoV3aM5mu0t+A8VEuTpUDbPUSqgr6RiaWAkvKaDsrn0IOYuVhfjmF23w
	OAo0PLMIJLREktet45SlBv9WTNk2HP0yz9iUy3gdM+YXhhLv206rFcCi+dF+nyh7+Z1UKdUtInIGu
	i28oYYfIdTQLvPXi0EwC1mqkNWVpcnAfJgntTStBQ7pvDjxnP/IIT/KCM0g/aBq/FVhjSKRK+IMTO
	9SxY1LS2/7KdMKpASldJd/s+ro7TCYssEBPP/YfMD7AWbkzoLT1YawmspLfQ2s3CZeeXCYaZ2KIVI
	+Fq6qNkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXlj-00H0Mj-10;
	Mon, 31 Jul 2023 18:37:23 +0000
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXlf-00H0M5-38
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 18:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690828633; x=1691433433; i=markus.elfring@web.de;
 bh=+XZfyU6p6ZQajFzXv+WZ3ckOOh4R514SxxTkuJgSMAU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FZgRPIhQnpK6BexfcNiGDcVEFiM9rwmb7+vkzuN4YxU+oE83SFnF/8QnGxdaXPWYAnVKvGW
 +kuuTkJQubAC+D2CTBfiYPWLleYUo9aWn2hH07RqMHUJMDo2WGJlUkoVNexgieaLS52Thu5Ts
 nnk+BpZMf+YYjUQl6KcYtLTEiAdVrNMiNZ37Uu6dBYW2nO8e7EYQ+JfKd2rCntkqjVo+nCYlq
 eV5VQw5K3ts6R0g8dss6u+N+l5zcSrmHV/PFbwUFU91Kgf6D0vnVs4so62xOwGreSq3feenIs
 chuZQmDSchNMEB8noFyHURVo7/OHgTnQvRVYqyptGzr+8FZfK+hw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1pd5yM0UYV-00w9VF; Mon, 31
 Jul 2023 20:37:13 +0200
Message-ID: <f551a681-7893-b2a2-9565-8a4c1bd01e33@web.de>
Date: Mon, 31 Jul 2023 20:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-GB
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Mark O'Donovan <shiftee@posteo.net>,
 Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, LKML <linux-kernel@vger.kernel.org>
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de> <20230731135152.GA6016@lst.de>
 <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de> <ZMf7BUH3ZD+GA7TA@kbusch-mbp>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZMf7BUH3ZD+GA7TA@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ITnbAvIpqu/mBCKZj/QnM5tBIsoYeCO8TTsZnirAZkYkD48Ok5p
 hiz8aDiGL4+a/CGIiOxIoe9fK30uBZ5Qj2Ietg8Jys7vYXajyxM8taceEQKzsdLyBIifuYY
 FLmpRZ2fdW4WHyWh/vxlVIgfBEf2Q9sHwE2oOlfkH0vcXBQG5o1ikP9KHO6GJObinWl1XhJ
 0SA+ZlBzDJT23I/SLyhZQ==
UI-OutboundReport: notjunk:1;M01:P0:zFToEx6HTQ8=;wzEvJta1dA/vDtQVPNJERXJUm5C
 PtzpzPE/Ahxcj5TVhz4dIhR8tuTToau9nTS7lej14kpNho/pepUgQuwano1wmDhF9dEmk4750
 PEGNjuk7qLJ1MQGxVvWH0zDkp/3W9DF6EcxVAhISJmJctyxXuLhGjPU6cpH8209kluCELg8RM
 n3OycJlslh9RcrQVrb2UNlCS4spLWgZRP3b80E5BY3PbDRgbKBoPM7zu7EKEP3yhnSWO4iEcy
 knOr4g9sS2EM7qu3rwnZ91bHmIY8PuGd14du9ZmKABCaQ5wdguxYehFzcFrnQh+cxjaOXa3vg
 4BuqOhhZDpsNEYnc/Fp+zo9Nw8u6tKqUufdacT0QjDr32MdCE0Q33A5Es/JMIQs5QNkLUNR2p
 akv7ln+Vu1JSB3y5+u7ar2y9y9aP2fq7qh5dpLG55Kb22sjvFkLZcbhjHKQOR2nv9ZCzNdgpq
 CCNwFfbKB78xb/vVysEKcoykm3L1CT4Kq4tjywTsNMTgIGvaPlnLwgiN8JSZP5ntSKKFlhrq0
 zGn/e/o/Kt73Eci2SxKQ2qlEuKVdJFlu+XTAPKRcfh0KPGCLvTC/pofC0yGjoqPxX5nxE5EmG
 M4O0RpAxsAx3DyTClseOqLVVPzWkPGtQAJHV24DP9kI3YPLb+1SoyBwPZkVLtWQwlixEhTg6G
 4uSPDH3l+hSryNYCEGMo5KotjHu+WbYxU9BqNzhFJmaLjdHTuxfUlPfRwge/5pt0XZ3tl04ar
 /maPnb9uODwosl4nIX6dkpGc73U8Y6EtH6g0mUFEMNeWtYbVuT8spoWK9CAYdpo46ANEbadJ7
 eIjlViayJERDK9e5W1udpYtZpnzLp7aazhqJhCpqH6ToKFhpqhDatzQdWGDvu+sPSY9+docnA
 WRYWuwBKAI9egeEllGc6rNaQ8v3xeGNpra8fMDz8YOnjEoHaD2rKlqGU/GY4VL9dQ1rLXY+FN
 MwuhUQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_113720_301675_F39BB85C 
X-CRM114-Status: UNSURE (   8.59  )
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

> The subject is already in the imperative voice, and there's really
> nothing furthur to elaborate that would help justify this patch's
> inclusion. I'm not sure what point you're trying to make here.

Does the concrete requirement for the usage of =E2=80=9Cimperative mood=E2=
=80=9D
mean also that a reasonable subject would be insufficient alone
without a corresponding description (or =E2=80=9Cchange log=E2=80=9D)?

Regards,
Markus

