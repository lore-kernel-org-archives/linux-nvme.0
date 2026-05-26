Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC2CCD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jjaxy3vPb3Iq0OfsTFhVODUECJM4OU1Hc8Vi+5XFf3E=; b=qFAzm19H5KSnG6H+ekM8kCTc85
	qpEBt1FZiC2LIH3h25fyTOXPtLYRE2UmYdYN7ck1s4GgF+p7E+DNVYQlDoejPYtSGKI9Iy7fMs6QD
	kzgLHszJj7ys+YtBs1s8BTmN06A4C+Sv1fF9VtL5MeI3IHFeLH4JN+M5venmnxLUhSImqDIumCq9f
	jiqvz+1cNFz6OYMHKQ+bpN64thV/1Hsyxkf2ozp6gMMubkHo7tNI8YvKOs+JnCM/pkNwPx4AuryqF
	ov9kRvhiOBf8MpEGakCeH4AONX3sPzsL9s8r2onZBiMjuEp4DuV196zvdFvzbg6OdtjE/taLvp/Rs
	PjmUAurA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRh1Y-00000000oTL-0Xrt;
	Tue, 26 May 2026 01:56:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRh1W-00000000oT8-1t1G
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 01:56:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4AC7F600AB;
	Tue, 26 May 2026 01:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCA61F000E9;
	Tue, 26 May 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779760560;
	bh=Jjaxy3vPb3Iq0OfsTFhVODUECJM4OU1Hc8Vi+5XFf3E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JrDDNp8JfycFbJ3a+MnTil4yhOmh1BsqhYFxVFOpQCSVX26YCDkz6b8qLAGxVqla+
	 B9FGfa9MuV9/8jFiz5fJiTO3JSii4hkuyioB1k374jZSxlvZxWIwq7bZDhv4XArqgV
	 GKhq1mSK6ZcWZ1b1bDe8H6rCKWVyf1kVHRtC/AChsmTA0VahwASduKzxB1v6WMcpDP
	 sIJJss4nCD0ArSQd+wp0n+baKfOkUuSqWWPn0ZKDYWxFivE/hacB5MTvIrdEUcOHbx
	 SpL+yLSic6DJMTh5hk2LnAougnvfxV9hMRLQ6d5oovGWHr/Wh0vQblN9qSHx2/MLt0
	 cJCejMkaN13UA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C0E83F40070;
	Mon, 25 May 2026 21:55:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 25 May 2026 21:55:58 -0400
X-ME-Sender: <xms:rv0UakhIEp1UNd3GE6bVzjXuI7KBQN-kN-hv7URAP9TWLkKoh8U_Bw>
    <xme:rv0Uan1KqDsTaFCUzTRDPmntBf9YjHcQgDJZkB0RWEHFGVsBOIGQ9_YYiI37gfwrh
    OGuXDhwb614nwTKSYR4ryWSLSHuXDAna1NDB8zrDK5eI6mX1hmuVA>
X-ME-Proxy-Cause: dmFkZTGXsvjcirJAQreEsH50lgfnh9IpoZLP114BrPQUZNXxaqSPq+f513h0UYwF8aVf11
    VMXwH/tS5V9kixZmjUn5S1rbgJRYgGwsPwtUiwHQJMRk5HF+MmmZ9ZlfqFPuMzX67RbeA8
    aaBPTONFldqn+HnYtbV7GKS77P275ZRiHZPC9xMHR586n2on9uDoZVzwqVfjm39DN1ty8f
    PGW/OpeK6NaEe3At+fcVXYwSPadYXROvOJxgEuPt0+5SN3uCla/tQKOwQAge9bVFfflPu3
    7iMYAWTOt5UQZp6SzJsR/PZWzi8wc+DPqP3QokILfOGQeBOvADTj5/9DvCiD4BVwDFFehh
    bbox9RZvW0g2KBkMHLrBdd8Plm8AlFNyCzsnNkvtgk/lty0zvKjSi6WpOCX82bSasJgSQf
    MqX4EeUEPICzilTCqauFaJEpYgdCbG2vl73CTtkVDU4aaci6tOwYtMEx3kXzAeGQqfb+eF
    KuuYvjJokwFx5SKDd6dpnLGymJlAuC6rnYonmMuyXJ2CgBQSIt2lzYZbvnhXUwEkEF4we7
    sP5XGvQo2Z7/qAtFzmlZdiCGdHOnQC2bnohrdlYuSYCc1ix5GFZfDs2jOrpsgMP8FJ+Ou9
    GMssxbyF9Gq35VyctIHo/MXqUqm73i2D/NAC/q9uqOUGAKoxd25CH4zRLGAA
X-ME-Proxy: <xmx:rv0UatS8R7Hg0zIMAVWWzide51QsjwSsQxL1hXH17YhJiA1g2QD9Tw>
    <xmx:rv0UaqfRZ3i6JEl5zco1PUiq-b4aBvuGoBYuQtfhM2xSlnYicggyPg>
    <xmx:rv0Uareb-2kyh6Pu9ezpjgnkqwQIhtYHdT5UwJeByMjw-GnmN-bPzw>
    <xmx:rv0Uamb-O53YBad3ufcnxoNeZfMkC_aTZpn5WS4EMwNFXSDEPgkt_g>
    <xmx:rv0Uan59jfLVG1K-5oWxsWQd3LMsuv0xQPHsXI2YYZzPd_P0qjRvAM7Y>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C44478007B; Mon, 25 May 2026 21:55:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 25 May 2026 21:55:38 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Chris Mason" <clm@meta.com>,
 "Christian Brauner" <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Hannes Reinecke" <hare@kernel.org>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <f7aaa5b3-5447-4f32-89e7-4e9e9ce01c6d@app.fastmail.com>
In-Reply-To: <20260525113533.6405efa0@kernel.org>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
 <20260525113533.6405efa0@kernel.org>
Subject: Re: [PATCH net v2 0/7] net/handshake: anchor request lifetime to a pinned file
 reference
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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


On Mon, May 25, 2026, at 2:35 PM, Jakub Kicinski wrote:
> On Thu, 21 May 2026 10:47:06 -0400 Chuck Lever wrote:
>> Three things in this restructuring want a careful look.  In
>> handshake_complete(), the fput() of the request's file
>> reference has to come after hp_done() -- fput() can transitively
>> run handshake_sk_destruct() and free the request, so the patch
>> stashes hr_file in a local first.  handshake_sk_destruct()
>> itself is kept on purpose: it owns rhashtable removal and
>> kfree, and remains the backstop if a consumer path bypasses
>> handshake_complete() entirely.  Third, handshake_req_next() now
>> returns its request with an extra get_file() held under
>> hn_lock; accept_doit must consume that reference (FD_PREPARE on
>> success, explicit fput on the fdf.err path), and any future
>> caller has to honor the same contract.
>
> Sashiko indicates races with handshake_req_cancel() remain,
> and impact the code re-written by this series. What's your take?

I examined the v2 reviews over the weekend and reworked the series
to address those concerns. v3 was posted earlier today, but sashiko
has it marked embargoed at the moment.

I=E2=80=99m aware of a couple of pre-existing issues that are not addres=
sed,
as they are a bit out of scope.


--=20
Chuck Lever

