Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD606606A33C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XIASY7E0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GV39Z3BM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2DFl8D5AbpYniLCVgRy/mQv0p9Nen7WB6MhNchHMoOY=; b=XIASY7E0PAI8hK
	m0bvNpyZwGg5Z0Lafc52qulrCMb4GMOd0nbQqLDBULhOJC6y08QxDJvdFncz22gqqsopvtpjqSXX/
	Q968HWRtOo9j8IeNEAYsTzEVlAL7YJALYk99UT6j8SFlfj/1o6nDhBb8Ge9p4eqAqHMYY3wURyRAL
	4WT0Eqq3JRHN54xHfcRMPzYLCT1JSXdA+5o3YTHCDcwAEJnEDi5idAIoZGuuA2MvHlcJZYIdKjDAw
	bGcsPf0WqdGAklN4MDv7aMZlQiBoBpQiL8iaEWvs7IjVGGdaqjL7np2Qa7IMXShLjQ8FwC5kVOrOW
	2EbKFRXaJYVg6kX29Mdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4XS-00000007Bxn-3oiH;
	Wed, 28 Oct 2026 14:22:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4XR-00000007Bxg-2Bsd
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:22:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ACC6040BE1;
	Wed, 28 Oct 2026 14:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5BB1F01825;
	Wed, 28 Oct 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197320;
	bh=2DFl8D5AbpYniLCVgRy/mQv0p9Nen7WB6MhNchHMoOY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=GV39Z3BMq8guOH1JNEh5l5Ykd0J5SIsg2ewcgDSRWu+Futb2/mbkTZyplVKkgIy7S
	 denrPoKvlnuvGNbYRIa3C1LmYhjR9Toh312qygfMtacXZCv9ZioO3kmFDFGNSeDzFY
	 21gJQLrzZpGgOHU1eBnMoBfgw2UhAmMxlmbbJAdYn+ehZwezDpmbqqaxng3cAWHjR7
	 kO3dUSJM3+nP0n23H/3IE81cCJjblZjitfUyEKfWzR2Hv/zzsZs3lSZb0gE25LZIzH
	 mKHEDfI8y2wMeYD+i4rul3lqLYJmQT21fKUI3R8RwbXn8qqvsZcnAXsblNvOpSDqBc
	 GDDz4IduI64fQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 642FEF40067;
	Wed, 28 Oct 2026 10:21:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 28 Oct 2026 10:21:59 -0400
X-ME-Sender: <xms:BwXiatPXCbP-mp8vFfVEJMQs85u7B0HKspOfkV-WWhxo1jlFOGDYSQ>
    <xme:BwXiaqxKK99o0iUCmiK9H7aiVLnrpQPFHvKbPB6TGwcRRN5Mq7A6bdKSgKSK-m7Me
    D2FEMI-lc3OlmHDzit-D2MJXv0ueoVMlI6u5qtVFzn3qyRO5QAv1u0T>
X-ME-Proxy-Cause: dmFkZTFFPdKSGxXAGU90y/2PmLAq1d3yAok18Viynk+2E9Rp2Jph1WStD7I9eXrOzvN/h4
    61kg/APA9V06T1Kntch14dq3W4Vw66kbX4eOYXTe67S3R3s7oiEQcFyDCzreJ7yGIqragv
    hE9OtMEDbHmYCl3HSJu833sj/zOLrYAD45WtbQ6LkNNHizBVEgtvJT9sjdQnaKYBKOQlfw
    wHBcMT2xtjlZWltOAFGN0MOE0Tiy6kPoqtqyiD/YLFKo+v9KocQX5DyHDK1xJwXTBtdpa3
    OVrn6lPPAZVaD1/onu0X56dz7YRI+G5JUqq3E3cTnQIhz9doi2pLkeB+ba5DY1wKqmhlHA
    diD/2ofebl1gXJ83jFfTDjMJVdlEQ+JzVHweoBegGXd57xbf3sMwHTXNwdLGkyazFNH9xI
    EtXZUzfOP9q2qzYbj0QBefIMUmhThE/MygZdbt/3qNM6pK7u17QZkJ+YLX6Z/Kcg6LX+JS
    lOGXbrbCeyOHrNqNsTSfxSZYHa2YFgOHRhGwddC7Pv/IXS/3EGf8hkAx9ktG6Fv3YQMM/U
    Vi+67yixenT/XoTyvaUUoTPQLwI93Ha9QPAT+zUqZ+e4RixPfStCOnySgh4lKlsEE1bFYk
    OWxIZdhFQZjcx731tdvDm93YNNqub2FsYP26/FXoSyNyRcP0swFtW3uYAAsw
X-ME-Proxy: <xmx:BwXiat9SZVLNiki8y2LvBHRWb8LvWjSZZAVofPW-HHPQm6hy_YDQ1A>
    <xmx:BwXiaiJqmQA2uW4lydBfo3mAkA7JbP44z5pp2oDZXeDu6uXJtGD0rg>
    <xmx:BwXiagcAwz61a4Hy4EMbuCVJ2TSMNQkMHytj2PSHuaTWFKQT57CRvQ>
    <xmx:BwXiavajuRnu-Ta6mF9EPk6Y4IbkqLZ0kXGwkX8FTVlwaOiK03OTCw>
    <xmx:BwXiamBM2S-DzU620tQew_1DvMy718vukuGPXYrKvJAtUK9MZXyQbUBy>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32AC3782738; Wed, 28 Oct 2026 10:21:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ae7b_N49t5D-
Date: Wed, 28 Oct 2026 10:21:38 -0400
From: "Chuck Lever" <cel@kernel.org>
To: martin.nvme.dev@gmail.com, "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Sabrina Dubroca" <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Shuah Khan" <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Hannes Reinecke" <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Martin Belanger" <martin.belanger@dell.com>
Message-Id: <76ccd502-f1d1-4135-b92e-d783f259a687@app.fastmail.com>
In-Reply-To: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
Subject: Re: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the kernel
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Wed, Oct 28, 2026, at 9:52 AM, Martin Belanger via B4 Relay wrote:
> kTLS does not currently handle TLS 1.3 KeyUpdate. It never sends a
> KeyUpdate. And when it receives one, it blocks the socket until the
> application installs the next key. kTLS also does not enforce the key
> usage limit on transmit.

No argument here.


> This applies to TLS libraries in user space as well as kernel users such
> as NVMe/TCP or sunrpc:
>
> - GnuTLS sends a KeyUpdate after 2^24 records when it runs its own
>   record layer. With kTLS, the record layer is handled in the kernel and
>   GnuTLS therefore never runs the check. OpenSSL never sends a KeyUpdate
>   on its own.
> - NVMe/TCP and sunrpc don't have a mechanism to install a new key. A
>   conforming peer that sends a KeyUpdate stalls their connection.

The design intention of these consumers is that they are supposed to break
the connection and create a new session, rather than stall. If that is not
happening, that's a bug. KeyUpdate is complicated enough that backporting
to LTS is not really an option, so that bug needs to be addressed first,
IMHO.

The argument that was made that put tlshd in user space is that we do
not want the kernel to handle something that the libraries are already
good at (IOW, mechanisms that have been soaked in commodity usage by many
consumers).

Is that rationale different for handling TLS KeyUpdate? I see that the
series adds back the HKDF functionality to the kernel. That seems like
an indication that KeyUpdate should be handled via an upcall.

Are there policy decisions that need to be made during KeyUpdate (like,
has the peer's certificate expired, or has it been put on a revocation
list in the meantime) ?


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

