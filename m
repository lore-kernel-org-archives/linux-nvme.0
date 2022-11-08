Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6062CC43217
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:To:From:Date:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uLZD3MU4Xw7Q4NESw8rwTa4cKxm0Ot6hUu127r1IHFU=; b=PeluPq8rhwFpsqU+SjezLYF5NY
	ahGSvxLfBEhbK5RcHn0QUVcoqQEna1TigUVa5+hppdVJFK/7Cd2//9frszQ7BkH3dsufzMMVXGH47
	C0UYfBjVsBqlVef1TDhAGUB89aID4S+v7wzBEXMP3R7Hk1SLkC/quTJ59GPcSdt4QyNdp+UYx9OgV
	uyrpgoiC28+xOCM6bmz1fbOLO6Zb+vKSeaIglIl44eQt+EjQxCvy+VzIA723Xs0C5d8G7sLfwWXHF
	BzHGjijjOF5JoQowcSAj8cjDe5OJMgDZsQDQKDzqYohYSt/727thlYb/tH4ZvtVnFQBWMnCMPg4Pk
	o4mLZNRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osW2W-008LSz-B2; Tue, 08 Nov 2022 21:21:48 +0000
Received: from mxout.security-mail.net ([85.31.212.42] helo=fx302.security-mail.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osW2O-008LRS-9g
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 21:21:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id D67481C40FAF
	for <linux-nvme@lists.infradead.org>; Tue,  8 Nov 2022 22:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1667942489;
	bh=uLZD3MU4Xw7Q4NESw8rwTa4cKxm0Ot6hUu127r1IHFU=;
	h=Date:From:To:Subject;
	b=CHsU6jMrooZ5BQsjUcLV9NzokCzY6qfPZSgpoNrbtYTIaHWdhMFZGvMDRhCHfZHFy
	 AKauDAKAQr8MccAUVdRsUjG8nu+zcLDe3Un75+7cR4obw5LgyKRsWH+aFN3CszMm6C
	 Jxtw63yQmpBJZPWhWApni8RMMUaW6XbUD9EaO2tw=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id BEB961C40B8F for <linux-nvme@lists.infradead.org>;
 Tue,  8 Nov 2022 22:21:29 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 54C1C1C3E718 for
 <linux-nvme@lists.infradead.org>; Tue,  8 Nov 2022 22:21:29 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3C46C27E02F0 for
 <linux-nvme@lists.infradead.org>; Tue,  8 Nov 2022 22:21:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 2173E27E02F3 for <linux-nvme@lists.infradead.org>;
 Tue,  8 Nov 2022 22:21:29 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 X4h9JWwRvXIL for <linux-nvme@lists.infradead.org>; Tue,  8 Nov 2022 22:21:29
 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id 0B55327E02F0 for
 <linux-nvme@lists.infradead.org>; Tue,  8 Nov 2022 22:21:29 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1758.636ac859.53883.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 2173E27E02F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1667942489;
 bh=7rt4YRV2hmfT+N/mVzltANEBkYQkuZuCbyVUrlosyEo=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=GktOW4gRrPzEYpyLyugozQkpe4eOaKX0RZz82PWlDodqDp1wsRIbhxkbnAdwrlP0J
 vMZywqOi6Ykw/vPPjWk/I4IJaIfKNrmfNJZalr3RRvJklUHA0yrZjMQu/YNvHplUOT
 m0WDLWO9uMVyesxpQ6l4sgytGoZt7BhCFXRatQhGXT+ASX9FnbXlKSapFkJZHfS0w8
 WS/4FgigRtV/zNud0pp4USMHlAFN7R4l+uRrU+Pcl59lEjkbEDYM7kC6dNX2Q4gIRD
 0uramMNA15sJiq7On600DEFTuUbZNfw8NtXwpKXON6Cul1BIOqz6kRwWlYHUT/51Qs
 WNg7pTvO1hOyw==
Date: Tue, 8 Nov 2022 22:21:28 +0100 (CET)
From: Samuel Jones <sjones@kalrayinc.com>
To: linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <1381318913.1358507.1667942488939.JavaMail.zimbra@kalray.eu>
Subject: nvme-rdma: Unexpected IB/RoCE End to End Flow Control credit
 behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_4373 (ZimbraWebClient - FF106
 (Linux)/9.0.0_GA_4373)
Thread-Index: PZjJsVWCB+hPS5OTxlXDp+20V02g0g==
Thread-Topic: nvme-rdma: Unexpected IB/RoCE End to End Flow Control credit
 behaviour
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_132140_790319_C6D4F916 
X-CRM114-Status: GOOD (  14.25  )
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

Hi all,=20

I'm=20doing some performance analysis on an NVMeoF setup using the kernel n=
vme-rdma driver and a Mellanox board. I'm seeing some unexpected behaviour =
with respect to the End to End flow control credits in the IB/RoCE standard=
, and I am reaching out in case anyone has an explanation for this. I'm not=
 sure it's a real problem, but I can't seem to make it make sense.=20

My=20issue can be reproduced using two x86 servers with Mellanox NiCs and s=
tock Linux nvme-rdma stack. I'm using 5.4 and 5.14, but I have seen it with=
 other versions too. My understanding is that the IB credits reflect the nu=
mber of available buffers in the receiver's receive queue. nvme-rdma fills =
this queue up to the NVMe queue depth at connection establishment and each =
time it receives a completion entry for a recv queue entry it immediately p=
osts another recv queue entry.=20

As=20such, when I observe the credit values between both partners, I would =
expect the credits to remain at a "high" value, relatively close to the NVM=
e queue depth. Obviously a little variance is to be expected as the respond=
er may not handle completion queue entries as fast as they arrive. However,=
 what I observe is rather different: the initial credit value is high (clos=
e to queue depth): it then decreases as the sender sends more datagrams unt=
il it is close to zero and then reaches zero. Once it reaches zero, the sen=
der sends another datagram, and somehow, the next ACK sent by the receiver =
contains a credit value that is once again high (close to queue depth). Thi=
s saw-tooth credit pattern repeats continuously over the life of the connec=
tion.=20

I=20can't make sense of this: given that the system is limited by the NVMe =
queue depth, I can't see how it is possible for a sender to saturate the re=
ceiver's recv queue, even if the receiver goes AWOL for a *long* time. This=
 credit behaviour could imply that the receiver is not actually handling th=
e completion queue entries promptly, but I find that very difficult to beli=
eve. I don't understand the intricacies of how the ib-core handles completi=
on queue entries, but I think the performance impact would be catastrophic =
if this were the case. It could also imply that new recv buffers are not be=
ing committed to the card promptly, but as far as I can tell ib_post_recv i=
n the mlx5 driver is pretty straightforward. I even started wondering if th=
is could be a Mellanox driver or firmware issue, but I ran an SPDK-based be=
nch on the exact same setup and the credit behaviour was exactly what I wou=
ld expect: the credits stay high throughout the duration of the bench. The =
SPDK code follows the same approach as the kernel driver in terms of recv q=
ueue usage, except of course it goes through libibverbs instead of ib-core.=
=20

Anyone=20have any insight to share on this stuff?=20
Hopefully=20yours=20

Samuel=20Jones=20
Datacenter=20SW Development Manager =E2=80=A2 Kalray=20
Phone:=20
sjones@kalrayinc.com =E2=80=A2 [ https://www.kalrayinc.com/ | www.kalrayinc=
.com ]=20







