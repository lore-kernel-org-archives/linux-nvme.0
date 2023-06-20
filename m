Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D66EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0bT2hfFvT3DYbX6AVUxz/5ftQYGWxMMCY9qYV4Cko4=; b=DB0SnIWwgtS2Bt+gSorEAWflNp
	wLYRZglA11hwF9NkeDNBg2gOblqCuaf3vFny6j7yeuqK1NzB/U84XyTrE8Xj75n5TLne0NZqSoMtB
	jXaAK8OcSzIPyV/xPU8nTm9w0RDIqLjjlbT1AJEGZPxOzfoWd4go6X3RzdnnmfKMj4H9lBgwUrq1M
	mnW9iH3jUzArWf4DFPF5No9TkDVmOeOJaaKijGMDLi3jLATPGnJQ1LOmp8AQOgyeXJSm7mdYi2vWH
	9rNodGXoj7PCkzX9KTvOP/Y1PGUy6xmF+POFFglXo90H0XYBGNFM1FMYJLr7PEJRRwRAdKM4I6N4j
	AK434uhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBXSp-00AhlP-2e;
	Tue, 20 Jun 2023 09:15:51 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBXSm-00Ahiy-3A
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 09:15:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92E3F218E5;
	Tue, 20 Jun 2023 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1687252541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0bT2hfFvT3DYbX6AVUxz/5ftQYGWxMMCY9qYV4Cko4=;
	b=D+SX7MCoawAkZgIAvGMw/6N0vBQVoDrIMIL+42fv58XhBV7SXgA+WlFTVGk8+DydKJqXvm
	NtQF2jcYC7TB6slL3cpnvtIz3Wh44D4bZDvrO+xLWW2O7kB4HWQIvknN2rkjro9XEsIpTW
	K3o/hXLLccdFp0nfnHLPQJE72w4QZHI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62314133A9;
	Tue, 20 Jun 2023 09:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RPxuFj1ukWSKNQAAMHmgww
	(envelope-from <mwilck@suse.com>); Tue, 20 Jun 2023 09:15:41 +0000
Message-ID: <e9869e4b8bf0854dd9b89bddf3ff8e58bc8933f9.camel@suse.com>
Subject: Re: [PATCH] nvme-mpath: fix I/O failure with EAGAIN when failing
 over I/O
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Daniel
	Wagner <daniel.wagner@suse.com>
Date: Tue, 20 Jun 2023 11:15:40 +0200
In-Reply-To: <20230619141036.1051673-1-sagi@grimberg.me>
References: <20230619141036.1051673-1-sagi@grimberg.me>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_021549_187168_77D83C3A 
X-CRM114-Status: GOOD (  21.89  )
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

Hello Sagi,

On Mon, 2023-06-19 at 17:10 +0300, Sagi Grimberg wrote:
> It is possible that the next available path we failover to, happens
> to
> be frozen (for example if it is during connection establishment). If
> the original I/O was set with NOWAIT, this cause the I/O to
> unnecessarily
> fail because the request queue cannot be entered, hence the I/O fails
> with
> EAGAIN.
>=20
> The NOWAIT restriction that was originally set for the I/O is no
> longer
> relevant or needed because this is the nvme requeue context. Hence we
> clear the REQ_NOWAIT flag when failing over I/O.

Could you please explain this in more detail? We are on the bio level,
thus IIUC a new request will need to be allocated when the bio is
requeued. This means that if the fail-over queue is frozen e.g. during
a NVMe controller reset, IO may be blocked for a possibly very long
time, which is what the NOWAIT flag was initially supposed to avoid.=A0

I am asking because we've seen a similar phenomenon with a 3rd party
multipath implementation recently.


Regards
Martin

> This fix a simple test case of nvme controller reset during I/O when
> the
> multipath device that has only a single path and I/O fails with
> "Resource
> temporarily unavailable" errno. Note that this reproduces with
> io_uring
> which by default sets IOCB_NOWAIT by default.
>=20
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> =A0drivers/nvme/host/multipath.c | 1 +
> =A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/multipath.c
> b/drivers/nvme/host/multipath.c
> index 2bc159a318ff..6425e6ec3932 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -102,6 +102,7 @@ void nvme_failover_req(struct request *req)
> =A0=A0=A0=A0=A0=A0=A0=A0spin_lock_irqsave(&ns->head->requeue_lock, flags)=
;
> =A0=A0=A0=A0=A0=A0=A0=A0for (bio =3D req->bio; bio; bio =3D bio->bi_next)=
 {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bio_set_dev(bio, ns->head=
->disk->part0);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bio->bi_opf &=3D ~REQ_NOWAI=
T;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (bio->bi_opf & REQ_POL=
LED) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0b=
io->bi_opf &=3D ~REQ_POLLED;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0b=
io->bi_cookie =3D BLK_QC_T_NONE;


