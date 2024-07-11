Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4690CC3DA45
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tfS97n7AexsVvVkSJ1CGLe2Fc6ABFU7K7eZ6dzCRSF0=; b=w85N3ilbZcjSh3idO7tg6k8/Mz
	EVHVmBgjf3DUtb2mbCXic7skNge3dkrHYe20Io9XwwZvf+FT40IEX2IchsvZA05DUXP6WN4Pqwfi7
	WL2BHgjxbEWWbxHWG1KpezDFwraRuyZygoIcXdO/VZbgOfJQ+NfSGK5M5YN8Xhwfi60qumydzVagH
	0htJ4ViokX0e9VBpuhDazkad0iCDE+oHsjZltGH2xsTa9ShZvIrB42um2yFsaVPX49/1gWUEG0Q3v
	e+de+FTyGocOBw6cAXdMZz9aIt1uffZswhFV1aHXWcFKdF4MFblsvZU8pbsr0WEbQ8qDpxwRz1oK+
	NFMSbtcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRuRM-0000000EGwl-1itO;
	Thu, 11 Jul 2024 14:06:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRuRJ-0000000EGvW-26EI
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 14:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720706787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tfS97n7AexsVvVkSJ1CGLe2Fc6ABFU7K7eZ6dzCRSF0=;
	b=eTwxkunyDsFTnbr3Hd/zUebQnIwMpvem/haTuTN17/dliBaV+/C7EhQojcRK0scuJckKeX
	O/I8h7b+TCiYktdPrx41mnrCx7v/L6Wmg+di1siOkihug/FEPiCIRDlf4DcB+c9+jvkWvU
	oMrMohb/Kd3eXsLQ7dVVUWdBAmuQAoc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ZSDzcnCUNCWixWDspj3CIg-1; Thu,
 11 Jul 2024 10:04:54 -0400
X-MC-Unique: ZSDzcnCUNCWixWDspj3CIg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB5E1944B38;
	Thu, 11 Jul 2024 14:04:51 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 930FB1955F3B;
	Thu, 11 Jul 2024 14:04:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nfs/blocklayout: add support for NVMe
Date: Thu, 11 Jul 2024 10:04:47 -0400
Message-ID: <8B5CD261-CC15-4834-88A9-05C67668279F@redhat.com>
In-Reply-To: <20240705165141.2248305-1-hch@lst.de>
References: <20240705165141.2248305-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_070629_692194_A1AABB6D 
X-CRM114-Status: GOOD (  17.06  )
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

On 5 Jul 2024, at 12:51, Christoph Hellwig wrote:

> Look for the udev generated persistent device name for NVMe devices
> in addition to the SCSI ones and the Redhat-specific device mapper
> name.
>
> This is the client side implementation of RFC 9561 "Using the Parallel
> NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
> Storage Devices".
>
> Note that the udev rules for nvme are a bit of a mess and udev will only
> create a link for the uuid if the NVMe namespace has one, and not the
> NGUID.  As the current RFCs don't support UUID based identifications this
> means the layout can't be used on such namespaces out of the box.  A
> small tweak to the udev rules can work around it, and as the real fix I
> will submit a draft to the IETF NFSv4 working group to support UUID-based
> identifiers for SCSI and NVMe.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Woot!

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>A

Ben


