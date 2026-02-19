Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729B4E9A048
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hunk2Dv1mebPSEeGUspQczD42feWNf6sRslRoqaD9x4=; b=dWjvRIQChSgYU5mnQwGEkhlrP7
	0/YNgkybejkdC1Zhq8OkbCK0qEAQTj1ML2TValmr68EhjUtf5GtH6XqJhc5FvBjYtdnsLWnkD7ZYv
	nSw/taXYSDp9m1sxhga1cZQf7md9yYZCirUKwJtU9q/orzAKgxclnnJrwSkpJP82V4a3W+Zyf/i25
	c6fWjj/gF6fmVRsIM4lvvWA1mxrWmpdv1cT3HrY3egSaqOqJt20UN6OHX1yMFmoUhPPRXgYrK9/VS
	u2X8ZYSj/PGe3qASNkp1JnpKllSWuD5HGs6T6gEcD4ohZNgS9l2Yb7tztVxcaFtWCGvv7zbYe4FbE
	avBv+ylA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt5PO-0000000BU4p-2s5O;
	Thu, 19 Feb 2026 14:53:38 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt5PK-0000000BU4F-3RPQ
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 14:53:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fGxG53hkfz1XM0nn;
	Thu, 19 Feb 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771512812; x=1774104813; bh=Hunk2Dv1mebPSEeGUspQczD4
	2feWNf6sRslRoqaD9x4=; b=33m25o9OsFO5l3zjvISU1ttAkoFEsdWWD7CgzOx6
	fC4HehvWZSOk3tjy5SD4cMAU8Lt99d8I/f5YC8NmHFO8wz+m75fWLW3TX/tXiN9y
	PPKSBfZmsgmnTuQPOzARa1MGLiCP71c7dT72r5OxKVSYB2UtapBdyfaSqpTvUTaC
	sjaMkrANYElMsbMEIlliiDx/T6lUR5hk6hSlvLoBLSldrGFiTLaV0Af4mfqt6Fe0
	D7AN6/3OzTpCgoCufHH3hLRO1rasGIPT5ndOrNaqobxHy7Pp2mifDFeWHXRVCPke
	gM81OQAepWn2NKRQH5OBSsD/lJyVQFA4vn/TP8BMvtyaNA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yijDWlHsKgO7; Thu, 19 Feb 2026 14:53:32 +0000 (UTC)
Received: from [10.237.57.149] (173-255-98-114.utilitytelephone.net [173.255.98.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fGxG232syz1XM6JF;
	Thu, 19 Feb 2026 14:53:30 +0000 (UTC)
Message-ID: <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
Date: Thu, 19 Feb 2026 06:53:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_065334_908952_09BEDFFF 
X-CRM114-Status: GOOD (  14.20  )
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

On 2/19/26 1:54 AM, Hannes Reinecke wrote:
> I (together with the Czech Technical University) did some experiments=20
> trying to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
>=20
> Doing so raised some challenges:
>=20
> - How do you _generate_ memory fragmentation? The MM subsystem is
>  =C2=A0 precisely geared up to avoid it, so you would need to come up
>  =C2=A0 with some idea how to defeat it. With the help from Willy I man=
aged
>  =C2=A0 to come up with something, but I really would like to discuss
>  =C2=A0 what would be the best option here.
> - What is acceptable memory fragmentation? Are we good enough if the
>  =C2=A0 measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>  =C2=A0 just reading /proc/buddyinfo?

The larger the block size, the higher the write amplification (WAF),
isn't it? Why to increase the block size since there is a solution
available that doesn't increase WAF, namely zoned storage?

Additionally, why is contiguous memory required for block sizes
larger than the page size? Does this perhaps come from the VFS layer?
If so, is this something that can be fixed?

Thanks,

Bart.

