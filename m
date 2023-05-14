Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CE7C77B7F
	for <linux-nvme@archiver.kernel.org>; Sun, 14 May 2023 11:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dM0REp/aFlq5rTBVepN8+Kk3O3vNuraV4e8TpGqBFL4=; b=z1WSUbHk5GVkdLMDo6wQ25YtI6
	ZaiCdfB0wkuetodzn00SkVg4dfQi+V+tTjpC0Zw2CCEJ/+b0kXLjtqvdZPg/N1GtX/kMwc06VVUJS
	24u/TdcEBhqHfpsJtgRJcGuhFf5pOOFl8l0MrYaYfVXSX3vGn6tf+rPzHeBl4RxuhbQTb+FvcOku8
	hCXYuRCPkvX7zW/afWwnjYKZPp3zh6klxn3jNPB7NEFfA0ejZfDlA+V9HKV87Ne6vvYn+Bcatz5t2
	CeMcc0Cw1k58PT3vXYw9RXn2Ui5AwEEow9rredySCxbMVOMSdaYdy/6tbXxkqtEWnNsl58OTxPYTK
	n+pI4VNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1py9df-00H6kV-0W;
	Sun, 14 May 2023 11:11:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1py9db-00H6hj-1B
	for linux-nvme@lists.infradead.org;
	Sun, 14 May 2023 11:11:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB3BE1F74D;
	Sun, 14 May 2023 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1684062693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM0REp/aFlq5rTBVepN8+Kk3O3vNuraV4e8TpGqBFL4=;
	b=gBPNLMuc3BF6yBxDPS8Wzgy8h+ANWDw6OeqEzaS+qRxIuohBemUxdcFO/+x2hIaMASlsuR
	wKkahhrtXaqpE7PQ492kC8NMZ3k7mG9zL+R1iO9KdcK1hZCHknZrjrE3jQjhThIatI1eY6
	7GUNras4PZK9b7ETA3emStacyYqOUPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1684062693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM0REp/aFlq5rTBVepN8+Kk3O3vNuraV4e8TpGqBFL4=;
	b=Fg1ST3WguJ4yGLEEswDgOIepQGzhgcsXipk+7Tnj7Zi/iQt1FxkTm3+M9/gGKZfWmUCtQZ
	VneuZNCaMIU1qxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF8E1138F5;
	Sun, 14 May 2023 11:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OFSlNeTBYGStdAAAMHmgww
	(envelope-from <colyli@suse.de>); Sun, 14 May 2023 11:11:32 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [RFC PATCH] block: add meaningful macro for flush op flags
From: Coly Li <colyli@suse.de>
In-Reply-To: <20230512080757.387523-1-kch@nvidia.com>
Date: Sun, 14 May 2023 13:11:22 +0200
Cc: linux-block@vger.kernel.org,
 Bcache Linux <linux-bcache@vger.kernel.org>,
 linux-raid <linux-raid@vger.kernel.org>,
 linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org,
 axboe@kernel.dk,
 kent.overstreet@gmail.com,
 agk@redhat.com,
 snitzer@kernel.org,
 dm-devel@redhat.com,
 song@kernel.org,
 hch@lst.de,
 sagi@grimberg.me,
 martin.petersen@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <08DD3B6F-0A2D-4725-847F-BACF40D07310@suse.de>
References: <20230512080757.387523-1-kch@nvidia.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230514_041139_550130_2FD1F63E 
X-CRM114-Status: GOOD (  13.52  )
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



> 2023=E5=B9=B45=E6=9C=8812=E6=97=A5 10:07=EF=BC=8CChaitanya Kulkarni =
<kch@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Flush requests are implemented as REQ_OP_WRITE + REQ_OP_PREFLUSH
> combination and not REQ_OP_FLUSH + REQ_PREFLUSH combination.
>=20
> This unclear nature has lead to the confusion and bugs in the code for
> block drivers causing more work for testing, reviews and fixes :-
>=20
> 1. https://lore.kernel.org/all/ZFHgefWofVt24tRl@infradead.org/
> 2. https://marc.info/?l=3Dlinux-block&m=3D168386364026498&w=3D2
>=20
> Add a macro (name can me more meaningful) with a meaningful comment
> clearing the confusion and replace the REQ_OP_WRITE | REQ_PREFLUSH =
with
> the new macro name that also saves code repetation.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -455,6 +455,13 @@ enum req_flag_bits {
> #define REQ_NOMERGE_FLAGS \
> (REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
>=20
> +/*
> + * Flush requests are implemented as REQ_OP_WRITE + REQ_OP_PREFLUSH =
combination
> + * and not REQ_OP_FLUSH + REQ_PREFLUSH combination.
> + */
> +
> +#define REQ_FLUSH_OPF (REQ_OP_WRITE | REQ_PREFLUSH)
> +
> enum stat_group {
> STAT_READ,
> STAT_WRITE,
> --=20

Personally I like current explicit way, it is simpler than an extra =
macro. This is just my own points, FYI.

Thanks.

Coly Li


