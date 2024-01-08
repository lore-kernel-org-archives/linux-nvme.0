Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mKeZigzJZ3CSuMjPE+ZfJxsqPzvIsLU2siesdsnIcg=; b=skoszS9pgvbxmp3uVIMZXYW4K0
	ngLppPo/0j4j2vQX6aXHZks01PPyJmA3bxPQOaCeyG23Dl9zVqIRB+gv4HjkEDI4mW3tNOzvZRxBI
	/Ia3m6bZkuEtweNk/FJUJl6XWEglxLALADT/aoTjGrPiTPZSdoSW7jF9hjYhRKt/HtYNPr9izC6rw
	3KOfHuiziIoTULsqZlCKw5TXPitxW9SPpWSWtAGR5WPAsaGIpslQdxfigSU2YohcYNfFFI6Ln9XcE
	ueofuL7Y69zx0io57mndAeVNk+adEHP5egmMWRXl3Bh2QqqG3mYaD6NSZ2mkG3RCQ5B14dXLSrNsZ
	KOL/GVaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMuYx-005vxl-0T;
	Mon, 08 Jan 2024 18:41:27 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMuYt-005vvM-1U
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 18:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=3mKeZigzJZ3CSuMjPE+ZfJxsqPzvIsLU2siesdsnIcg=; b=lbx3S6QOnSojzDFGLQoSRHLcXN
	x5xifHrQdcY9o9vR7s1IG1EFDAQecNiAsP8Cm7P2h/qb575neqitmMCQobx4kaL0LpE6c6Bxek5+L
	72cOsxUSwJvFmUujCIMVHovlsmUPO3OB/kT2ApGeimUs3TqaP9Ilmd64Rtt4EM+dc7a9CcXTMDfLN
	fTO+jzwPlGFR74l9RpiROSu4gQZUqN8nG/FiOFjC2ZiAV1WyMIJchxQ1pLG98IuA2BNw0YDUoIU2r
	1nBmXYKQWdkTI4InowgK1SVzmK/4UWsMmwb1DkQTDfNLKBytCZpW4VhzkfhjsREgETpcyVKg/wxbx
	ffisYA4yLZMVuZPp73yVlUkeEVkxnL0BbXDglXbSv+jEZcel9aO6pinceGfscOWtAS9bnwARzPk+3
	IjVDHN2cDn0POOcNCRgREQlLjyhu1ZnDSiuh4y8xPVGLahDnxtx7IF0UXBIcTR5xUQeeaNunZTmrj
	ck7PzmXvAF/xTSIX+z/bOK+o;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rMuYk-00738E-06;
	Mon, 08 Jan 2024 18:41:14 +0000
Date: Mon, 8 Jan 2024 10:41:10 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum
 shutdown_type.
Message-ID: <ZZxBxiCt/7/+49zl@jeremy-HP-Z840-Workstation>
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-4-jallison@ciq.com>
 <4486c671-af66-4466-bfca-e184584d884b@grimberg.me>
 <ZZbuQsCg6jXMjl2u@jeremy-HP-Z840-Workstation>
 <ZZb8lvXz0sEiy6Dz@jeremy-HP-Z840-Workstation>
 <989ca551-865c-44fc-87b0-1401b43afcb3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <989ca551-865c-44fc-87b0-1401b43afcb3@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_104123_515718_BA68A323 
X-CRM114-Status: GOOD (  12.42  )
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

On Mon, Jan 08, 2024 at 07:42:09PM +0200, Sagi Grimberg wrote:
>On 1/4/24 20:44, Jeremy Allison wrote:
>>
>>There needs to be some way to pass a use
>>"two-pass" flag down from nvme_shutdown()
>>into nvme_dev_disable()
>Ideally nvme_dev_disable can be broken in a way that
>nvme_shutdown can have 2-3 helpers and the rest of the
>code can remain intact calling nvme_dev_disable (internally
>calling these helpers).

I think the safest way to do this is to leave
nvme_dev_disable() alone as much as possible,
and just have it call a nvme_shutdown_ctrl_nowait()
function when the bool/enum tells it it's in a
two-pass situation.

I have code that does this, I'm just waiting
for the 'bool or enum' decision.

>>I guess I could add a second bool flag passed
>>down from nvme_shutdown() all the way to
>>nvme_dev_disable(), which then calls the
>>nvme_shutdown_ctrl_nowait() varient instead
>>of nvme_disable_ctrl() if both "bool shutdown"
>>and "bool twopass" are set but that seems kind
>>of ugly and confusing to me.
>
>Probably.. Maybe call it dontwait (bool).
>And yes, it is ugly, but better than moving the
>ugliness to the core.

No arguments from me :-).

>>How about keeping the enum internal to
>>drivers/nvme/host/pci.c
>>and making it:
>>
>>enum shutdown_type {
>>     NVME_DISABLE_RESET,
>>     NVME_DISABLE_SHUTDOWN,
>>     NVME_DISABLE_SHUTDOWN_TWOPASS
>>};
>
>NVME_PCI_

Got it !

>>and changing 'bool shutdown' to enum shutdown_type
>>inside the static functions nvme_disable_prepare_reset()
>>and nvme_dev_disable() only ?
>>
>>That way we don't have to have the confusing
>>double bool:
>
>Neither are great. I'll defer to Keith and Christoph on this one.

OK, I'll use whatever Keith and Christoph agree on.

