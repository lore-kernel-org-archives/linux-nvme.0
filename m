Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E083C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqLxJFH9O9G7EGONJdF7zaPGDT+Gp5Rj4MUtQs90Rw8=; b=kOqtKOlpCIum2WNolaK03z0Sz+
	BQ1fi8EhhyJKMwBvN2gTMvFoMcLDVDvwkdLXcGS9sLp087gE5rF8SRRDi+3plRKQRaRb0+hr2CS2a
	Gy3YHS7Lbs3MYDYX1BREqP2SpIiJDoTwxfNshuH1nbPEGGZjvhN6qpDwHgBPT0HTAqbZyoNdssASo
	FyzYxC9WGY2KFHJ7Z6ekurZsbFs7ZOfFZWh+11dBVNseYYtVR3nYXVzmxjR+Eo6fC0LeLuYQdDEwY
	cwZT3nS4FE7SsOzeKcKu9yQqSohCJZ0b2bCm/FHeh0kD7USfGWVWHl4+w78rKl9mxKYzb8UL3cCVO
	HP2f7qeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njMiL-00F5Jv-Rc; Tue, 26 Apr 2022 15:02:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njMiI-00F5JA-RV
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 15:02:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 31ADF610A2;
 Tue, 26 Apr 2022 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A504C385AC;
 Tue, 26 Apr 2022 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650985369;
 bh=UqLxJFH9O9G7EGONJdF7zaPGDT+Gp5Rj4MUtQs90Rw8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AffRiqDdE3sz/LCauzO5r2DR1u8X3ZBhcg7XT7VKTU3vrSH6dNifdcC9oPMhnaaRD
 tooa/9C3ApCFhD//EgeHVZ82iVkKzlYd2B6UqG57bnBNJ0fPNqq6OhT/hX0c5vDWeh
 rgfmRxorcK/qZvO1uhoIRGxhWmZumkGnIeQXAV1Tf0QSVEqf9IVRlvkmQOcSCXdhy8
 0J9ZWL6F67+N2w8N8QWxhosFSa49dwqVNg3/FVKrcvf/IpkP/UKcxgzgEYl7pzBJwa
 ++gNj9yu0l2OoOLlPC4pNJ0y7KuGlv4TJ5jfpzGVJ/jrYBuytNv8GWIdigaG0WTmsx
 eQ7dmMOvblH/w==
Date: Tue, 26 Apr 2022 08:02:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220426080247.19bbb64e@kernel.org>
In-Reply-To: <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
 <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_080250_969522_C2A6908C 
X-CRM114-Status: GOOD (  15.96  )
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

On Tue, 26 Apr 2022 17:29:03 +0300 Sagi Grimberg wrote:
> >> Create the socket in user space, do all the handshakes you need there
> >> and then pass it to the kernel.=C2=A0 This is how NBD + TLS works.=C2=
=A0 Scales
> >> better and requires much less kernel code.
> >> =20
> > But we can't, as the existing mechanisms (at least for NVMe) creates th=
e=20
> > socket in-kernel.
> > Having to create the socket in userspace would require a completely new=
=20
> > interface for nvme and will not be backwards compatible. =20
>=20
> And we will still need the upcall anyways when we reconnect=20
> (re-establish the socket)

That totally flew over my head, I have zero familiarity with in-kernel
storage network users :S

In all honesty the tls code in the kernel is a bit of a dumping ground.
People come, dump a bunch of code and disappear. Nobody seems to care
that the result is still (years in) not ready for production use :/
Until a month ago it'd break connections even under moderate memory
pressure. This set does not even have selftests.

Plus there are more protocols being actively worked on (QUIC, PSP etc.)
Having per ULP special sauce to invoke a user space helper is not the
paradigm we chose, and the time as inopportune as ever to change that.

