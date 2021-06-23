Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CAC4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 14:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46636100B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 14:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46636100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=22Te0OV82G7LU4cr+G23w3MaSBGoOsfScjhKpQbObQ0=; b=FGeia20nJb5wLW
	gaUYR8TGVGPQTmLHvi0s4x1sRvWDWCsd3jXv/dvhi1hlWhE4dK9oZ1FLiioxttMixbYRZ+OA8/AUK
	9AAXNkd00NM6rgHVwxcXcx2xZ94zvKXz0Z4QKBuLHOI1O/jZmVfY4XyJ2Oh3arQcz4KRCRWwoDEwY
	PpIu4CVV5crq5/7i32mocR4VXCMPfy5BFwKCaxx4cot8lEO0UbmWs/BziJpjYn2otwYMQ2JgrqZPs
	lO8lujdhAXR37le69Da546RtL+bKIyA8Wxr34qGsZBVbzF3KLqMBAL4dp/Oq6uSj6n31wq154j2ap
	ao+NfBMkBxnei0lLKgOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw4Ci-00B3vN-4c; Wed, 23 Jun 2021 14:50:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw4Cf-00B3v1-Q7
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 14:50:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F06160041;
 Wed, 23 Jun 2021 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624459809;
 bh=Lg33baFtgREM4QYqVZ242K+cuSV/SD5RdgD3/hk9z0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SuUWAQ/9VwxXaZXE4DeFO75m0diHqdnD6TAy3muqtorOxGn6B/3DryIpLJ/9jf3hs
 i+N5nomcrF9cHdTuS+Hs8QdLW5RZdqZO1tQ777hOyzooSOWgJp3SUPw87GPwkyRS3j
 35OyQmIfSh7MDWd2MRP1UvrqvRPJ0aKcRS3FZDZj8wlv/3DelyW1idT3buvvB5mmXt
 ne2pL7O4g0AOww/pTNZY9uustQWEUl5JsDlR/xOerfL3hQhmpXGT3Fl9KMQG3KydEC
 2snrjsJuK7PkOd9GHvQnzPtjyBeP7opSwXbKiZfG86ATVdJKJPU3EiT5b8nq/8T+se
 /toiTr/XDr6Ow==
Date: Wed, 23 Jun 2021 07:50:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <20210623145007.GC2360166@dhcp-10-100-145-180.wdc.com>
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-2-cachen@purestorage.com>
 <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
 <33919248-6c62-0974-ce88-3c0d0885e837@purestorage.com>
 <20210623015331.GB2360166@dhcp-10-100-145-180.wdc.com>
 <0faf018d-570b-4c26-a093-3d375bd70c26@purestorage.com>
 <9681def7-a751-f4d8-8a92-c5bee027a97a@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9681def7-a751-f4d8-8a92-c5bee027a97a@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_075009_906688_3CE4A8D9 
X-CRM114-Status: GOOD (  10.49  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 22, 2021 at 09:14:21PM -0700, Casey Chen wrote:
> +/*
> + * Try getting shutdown_lock while setting up IO queues.
> + * Caller remember to unlock if success.
> + */
> +static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
> +{
> +=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0 * Lock is being held by nvme_dev_disable(), fail earl=
y.
> +=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (!mutex_trylock(&dev->shutdown_lock))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
> +
> +=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0 * Controller is in wrong state, fail early.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (dev->ctrl.state !=3D NVME_CTRL_CONNECTING) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&dev->shutdown_l=
ock);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 return 0;
> +}
> +

Yes, thank you, this is aligned with what I suggested.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
