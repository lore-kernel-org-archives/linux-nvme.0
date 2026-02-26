Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E82FD460B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 03:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkLc+GDTQrnsggrpWJFZMbOK/80PHJQs/QIq3lF3I4w=; b=Vo2sqllEclvf7pkBU761OSiudH
	u0LqbPjdxr3z4Q6ij5hoTYIn9qhSj777F8SNOibqvXcM9eihbFoBsbHw6I4WNioDhDWY9Gnac0qUE
	xUKdlFyXc4c4zIuc1rLKRovb1jNH0qjiPXirc5ulMpaZnFAeDPxur8Xis/TLjBlMHOEkyV3CwUydr
	cGCpImjd+XPhXG4puSFZuDznutG6Akze2rTTV3MTnMX/z0bLSvvGsjPKYlSAm5aFGGc8DoSs9304R
	YoodBc0Vu5G2tjssuy9TSo8B3SasSMA7ewMwyaKvA50UoaHH8AFLJyjdHrQIhsWkTiVx6wVdy2PN7
	6rVW+etg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvSBl-00000005KDO-44vO;
	Thu, 26 Feb 2026 03:37:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvSBe-00000005KCB-1bNe
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 03:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772077033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkLc+GDTQrnsggrpWJFZMbOK/80PHJQs/QIq3lF3I4w=;
	b=Js00sw4fef6sg7jEVkaHQPxIl54HgfxWfJxFFdAYqFkhdVtadgOY7ReEbjp+0387Hl0m7u
	hW+4ePiWPdpCfVIzws1QfPK5uunXuojDRzs5ZTsWbwI9SQ55p4tfbDKZG3Uu6kvC+yX0dt
	8NME8lbqV/TR6I4YWL+j10cbcBXk4y8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-st2cy_XBNqSdjq7AuUSX_w-1; Wed,
 25 Feb 2026 22:37:09 -0500
X-MC-Unique: st2cy_XBNqSdjq7AuUSX_w-1
X-Mimecast-MFC-AGG-ID: st2cy_XBNqSdjq7AuUSX_w_1772077027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 304EC19560A3;
	Thu, 26 Feb 2026 03:37:06 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE9641800465;
	Thu, 26 Feb 2026 03:37:04 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 61Q3b3hQ1680267
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 22:37:03 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 61Q3b33W1680266;
	Wed, 25 Feb 2026 22:37:03 -0500
Date: Wed, 25 Feb 2026 22:37:03 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] libmultipath: Add path selection support
Message-ID: <aZ-_3_hXEkFEClhs@redhat.com>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-4-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153225.1031169-4-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: N_UYMJQ5W2LWJDDUkV4wcPf5v1kVm6M8ImtlwkZ_yDw_1772077027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_193714_491372_63337D0E 
X-CRM114-Status: GOOD (  10.91  )
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

On Wed, Feb 25, 2026 at 03:32:15PM +0000, John Garry wrote:
> +__maybe_unused
> +static struct mpath_device *mpath_find_path(struct mpath_head *mpath_head)
> +{
> +	enum mpath_iopolicy_e iopolicy =
> +			mpath_head->mpdt->get_iopolicy(mpath_head);
> +
> +	switch (iopolicy) {
> +	case MPATH_IOPOLICY_QD:
> +		return mpath_queue_depth_path(mpath_head);
> +	case MPATH_IOPOLICY_RR:
> +		return mpath_round_robin_path(mpath_head, iopolicy);
> +	default:
> +		return mpath_numa_path(mpath_head, iopolicy);

When we're in mpath_round_robin_path() and mpath_numa_path(), we know the
iopolicy, so we don't really need to pass it in.

-Ben

> +	}
> +}
> +


