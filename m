Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03E606A337
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bj9JO5SC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9NMENC4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iv8Bt4PNiniH/Ck/gotMmnbuIcouH8T5AQxjqoDvLHY=; b=bj9JO5SCcsn+Re
	6tUX1E2riVuasWjPNnSBRJW645n87K1QWVJtBJIeFGMzLpce5YXMs0hZJIHQg3RwAdY7zmrjQy0pW
	hlfUfHiEKuc2E4ZfKDTIkYX6wwDf/D9uv1N3nbOd3mjCp/6L8VG9JG0Obxh4dRNpJJqDy4XTlN6nJ
	tWmdx6Q/G6CIxa1tcv9mYrDobPrnT3puFQJmDPaRzOPRtibkqSElLGyFeUrT5Gmx991jVr7V6x5P/
	4QwWSElLu6pnJvnB6IRZDBz+F4ZH3IZ95GoG0e8KpUFLTXA8XezkkxOt2DDFLglZpyf1wNu2QaO/3
	+tgCPDGJ/dEyEVZ78M7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM59v-00000007Hro-10Cu;
	Wed, 28 Oct 2026 15:01:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM59t-00000007HrJ-3oeW
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:01:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C0B243857;
	Wed, 28 Oct 2026 15:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D681F031E6;
	Wed, 28 Oct 2026 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199705;
	bh=iv8Bt4PNiniH/Ck/gotMmnbuIcouH8T5AQxjqoDvLHY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=I9NMENC4QHj8Hp/zxXWZEW7S1Q5B6307GpE9jC1kyvbTMXZBBqjZvnEuhg9nhQF7F
	 oTrPuJht8MfUSWTLPQMZhXhRqsq8PyEJxJtFL6UKvLJiOeCzQH3xIO+zPlGj98swzN
	 tX9w7QF5eupBbCbfMZvR3U68DETFDMs0y3L60OiTLJLdA6dIKzH/t8J6SmnnqtRT/m
	 TxzFXdw1ZdmQlpXPDwnLdAIcskv+qkc++BPQny+nm15Pe/79q5PzXRRlLBdQd1jndP
	 2FS6U/B7LsRtKm64b1r1HQmXyv6CYe3jLam1XjBAVJ0Ax8peboKxG5q/bQR/maOEP+
	 omhCOr7gbyrHw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E00F1F40066;
	Wed, 28 Oct 2026 11:01:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 28 Oct 2026 11:01:43 -0400
X-ME-Sender: <xms:Vw7iao-ppO7ONFM2Y-RXQOhFAx1gmiBWlpZgjLE16S3av8SiR1tFJw>
    <xme:Vw7iarh_1blI6OIc057K-pzkHR9IWNjd95871_Ld0x6Gflln5bvQ_S0GOKeq-2WBA
    Zq38uXtUkc3XPcEHVpHkxS8b5CXl536d7_Lyoyna-3LaV5WztLovCvthw>
X-ME-Proxy-Cause: dmFkZTFHW0LzfJAQ3PuYMAMPTg1dBdg1MgkjCAkuUubpJCx1P7JA5mGeAT1UOP7m9/8b0f
    N7XX+x9Mf3qUMsnP0qr1YSyVQPZ4CvSbzvC7ZS0ZKXkjlISC7JKc2LN5yxfmw3EEM5euhL
    gEkMXX8rZWMCyg8wCTsAlIED2fdqjVPEnwWndbg49r2MPb/peyMV76jMNVSME3kHrfU4Xo
    nGpABU7pgLMbFuEqhzAY6VYTCRtjg+OzUy6nSqfFLlrDMrPw+yJDDbfKsVHE5beUKu8vfc
    7lVKq//Ffe9uYjpyVvzoZp0RPg/iYchl88Psk3UD3Fxafkn847VcXTJwhVhdOw0te9O5r2
    6K2jC1UJk+7znKK1aoE8ILp/sV6KC/a8nruZpLphWh0yXGxcIWCuOmZgLhTdHYgj/DAajY
    Nyr0USnC3AWYAst2VpEiG//3oe0Vlunl1aHqm+GCw1xz5cARHLKhDOvocAIJTiHTlNRKFf
    iUSHF6py6PmXuv7tOOw2eDA8sfGE7EOhpn92guNJrvMvR55g3WXStl3pzj0WoZ6R5vsZHo
    0cMhRdpK1QSGauQkNNL6iur+yxgFZlg0zheUu02ulufm5G4OGd0h2A6wVOwk3kauSxWYbU
    mI7it/zmv4wrwfq+4QZtl0/oEuStJJGliFGncQeXoUW2jxd1i0LAQzIOsmxQ
X-ME-Proxy: <xmx:Vw7iavZwFa1tsNuRCG5loTb5yE7wZExXr-9lHTIWkiKXam83GiT3zw>
    <xmx:Vw7iap_DdzKvvC8g-vwv7mxx4RyiRRYl4irJOHTPZI8KaISaFANKbg>
    <xmx:Vw7iah_BTR2lu4ILjMpsb3GgvAx960218_bMW2wf7wdnBwoiQlMwqA>
    <xmx:Vw7iaqkHgkKAJTyEtU_V3-U4haJWynBi3QmNPuGdqIduOGDDehBiHA>
    <xmx:Vw7iaskpNxrOSzVIXPrllUnbUOI_acFdZLXF-7VDXSUcMfwdGRHgVj8Q>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2E51782738; Wed, 28 Oct 2026 11:01:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ae7b_N49t5D-
Date: Wed, 28 Oct 2026 11:01:23 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Martin Belanger" <martin.nvme.dev@gmail.com>,
 "Hannes Reinecke" <hare@suse.de>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Sabrina Dubroca" <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Shuah Khan" <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Hannes Reinecke" <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Martin Belanger" <martin.belanger@dell.com>
Message-Id: <097a2d7a-af80-47b0-b800-238396e6e662@app.fastmail.com>
In-Reply-To: <CAPG1HMsnUDa=Q5O4fwZOU=Pd+m7ahzu574Cs+mWoB_9KUT5ASA@mail.gmail.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <76ccd502-f1d1-4135-b92e-d783f259a687@app.fastmail.com>
 <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
 <CAPG1HMsnUDa=Q5O4fwZOU=Pd+m7ahzu574Cs+mWoB_9KUT5ASA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the kernel
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Wed, Oct 28, 2026, at 10:49 AM, Martin Belanger wrote:
> On Wed, Oct 28, 2026 at 10:42=E2=80=AFAM Hannes Reinecke <hare@suse.de=
> wrote:
>
> Thanks, Hannes. Two points to add.
>
> On 10/28/26 3:21 PM, Chuck Lever wrote:

>> >> This applies to TLS libraries in user space as well as kernel user=
s such
>> >> as NVMe/TCP or sunrpc:
>> >>
>> >> - GnuTLS sends a KeyUpdate after 2^24 records when it runs its own
>> >>    record layer. With kTLS, the record layer is handled in the ker=
nel
>> and
>> >>    GnuTLS therefore never runs the check. OpenSSL never sends a
>> KeyUpdate
>> >>    on its own.
>> >> - NVMe/TCP and sunrpc don't have a mechanism to install a new key.=
 A
>> >>    conforming peer that sends a KeyUpdate stalls their connection.
>> >
>
>
>> > The design intention of these consumers is that they are supposed to
>> break
>> > the connection and create a new session, rather than stall. If that=
 is
>> not
>> > happening, that's a bug. KeyUpdate is complicated enough that backp=
orting
>> > to LTS is not really an option, so that bug needs to be addressed f=
irst,
>> > IMHO.
>> >
>
>
> A reconnect is also a valid answer to the record limit: RFC 9846 secti=
on
> 5.5 allows
> closing the connection. The cost is the problem. Depending on the load=
 and
> link
> speed, the 2^24 limit can be reached in less than 10 minutes in many c=
ases.
> Each
> reconnect stops the I/O of the queue and needs a new handshake upcall,=
 for
> every
> queue of every controller. A peer that sends KeyUpdate on its own caus=
es
> the same
> reconnects. With this series, the connection stays up.

I get that dropping the connection is bad; the current weak-ass
implementation is meant to handle KeyUpdate until we have a proper
spec-conformant implementation.

My concern here is if the current design is malfunctioning in LTS
kernels, the only mechanism we have is to fix it upstream and backport
the fix. I don't believe stable@ would be happy absorbing this full
series.

Your commit message claims the connection stalls rather than getting
replaced. If that's true, that needs to be fixed before this series
gets merged. Can you confirm? I don't expect such a fix would be large,
but the ordering matters.


--=20
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

