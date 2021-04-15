Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF0C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:19:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E6A60FD7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6A60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LbFIydExhWIHMgflsGiGid6QTZaVy+piq3CXavhVDlE=; b=GJJqAWxaf7OanYunJic8X1FBf
	MXCVIJCBzV6bbo5OzMkPaNpryG6WiuHoTybd03oN8vsHsFC8B27rWxmVUCWh2Wt/sc9u1rzNAj896
	7bJrHZXXw+wnbcQL17EqQseAkkMT6tA2e9th2IK7a/enamPyEE8LUs42Ex64XIy6eP/7ZgvgtNUFv
	mLpjx7kPJCsHZkd7jGyI1BnTQ5WM4CBSb+vh1cAREtUspov6qy1YA67Po152zoGSLKuaDDoO/FVz2
	EiNAq4lZYykaqGMbWQudn/NxfZLCIe/2rzJIj1jpdFiEyJVqINYppw7u71zsjN9ZD0KRl1QdcRiwW
	R8HolvkPw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBFv-0003QE-AZ; Thu, 15 Apr 2021 23:18:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBFs-0003Pm-28
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=S7a+vZdjllcLmwLCMOcXS/rC/C8NhrGVBWb9YpbjGYg=; b=RVkeUEtEULRJzMnlWdlAfHatVe
 r+n8tp/Tft0Fyo+MbAMumm+NMFL9WCOX8zE/REQlEkHWd+dIRzOWxy6QewbEfShQOnRDJwmDD77ro
 3wCLDI+cduxlIzS0E0H3a42NO8EPRVVW+DhbbwMEjD9CaF1SUi0I4NKUPGlXR+q3fZJGn9OvGN2+p
 TfdTorQnsqzeWpQ5lxCrzyOrcrtXYN8ZBG1qG5mK5pUJF9SJQRIlAxauT50g2GJVXXA8TvdMg6IPF
 IucLI40oJuU/MeS3J6u4gc+34C6QU7udRsHEPQ9YXu+ooQkeCe9JuldZkpPYlgr4u5jNSudsiVh6j
 DJtHYv1Q==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBFp-008y53-2F
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618528710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7a+vZdjllcLmwLCMOcXS/rC/C8NhrGVBWb9YpbjGYg=;
 b=bbNe17bRb6fVe4EgaDUugCujnBHoZywbG5PDTUKLWDgkCouhUK0TuOanfbHJYMcwFVcG2A
 dLHlufP7Ki5vv5MILAhK/XvRe4yM3+ADCvZCTZpmWkX/qfY2sgAEi2DXApHM+AuUnHOi0+
 YgzXgCRrdIxrgWzdLSfPx1+gdUcMT8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-FnUT1tQuMHGmEEmrzNQi6A-1; Thu, 15 Apr 2021 19:18:20 -0400
X-MC-Unique: FnUT1tQuMHGmEEmrzNQi6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0A5F1854E27;
 Thu, 15 Apr 2021 23:18:19 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8631E62677;
 Thu, 15 Apr 2021 23:18:16 +0000 (UTC)
Date: Thu, 15 Apr 2021 19:18:15 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: nvme: Return BLK_STS_TARGET if the DNR bit is set
Message-ID: <20210415231815.GA16047@redhat.com>
References: <20210415231126.8746-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415231126.8746-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_161833_212032_F7CB3E59 
X-CRM114-Status: GOOD (  20.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry, emailed from wrong terminal... have since emailed correct v2

On Thu, Apr 15 2021 at  7:11pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> BZ: 1948690
> Upstream Status: RHEL-only
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> 
> rhel-8.git commit ef4ab90c12db5e0e50800ec323736b95be7a6ff5
> Author: Mike Snitzer <snitzer@redhat.com>
> Date:   Tue Aug 25 21:52:45 2020 -0400
> 
>     [nvme] nvme: Return BLK_STS_TARGET if the DNR bit is set
>     
>     Message-id: <20200825215248.2291-8-snitzer@redhat.com>
>     Patchwork-id: 325178
>     Patchwork-instance: patchwork
>     O-Subject: [RHEL8.3 PATCH 07/10] nvme: Return BLK_STS_TARGET if the DNR bit is set
>     Bugzilla: 1843515
>     RH-Acked-by: David Milburn <dmilburn@redhat.com>
>     RH-Acked-by: Gopal Tiwari <gtiwari@redhat.com>
>     RH-Acked-by: Ewan Milne <emilne@redhat.com>
>     
>     BZ: 1843515
>     Upstream Status: RHEL-only
>     
>     If the DNR bit is set we should not retry the command, even if
>     the standard status evaluation indicates so.
>     
>     SUSE is carrying this patch in their kernel:
>     https://lwn.net/Articles/800370/
>     
>     Based on patch posted for upstream inclusion but rejected:
>     v1: https://lore.kernel.org/linux-nvme/20190806111036.113233-1-hare@suse.de/
>     v2: https://lore.kernel.org/linux-nvme/20190807071208.101882-1-hare@suse.de/
>     v2-keith: https://lore.kernel.org/linux-nvme/20190807144725.GB25621@localhost.localdomain/
>     v3: https://lore.kernel.org/linux-nvme/20190812075147.79598-1-hare@suse.de/
>     v3-keith: https://lore.kernel.org/linux-nvme/20190813141510.GB32686@localhost.localdomain/
>     
>     This commit's change is basically "v3-keith".
>     
>     Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>     Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
> 
> ---
>  drivers/nvme/host/core.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-rhel9/drivers/nvme/host/core.c
> ===================================================================
> --- linux-rhel9.orig/drivers/nvme/host/core.c
> +++ linux-rhel9/drivers/nvme/host/core.c
> @@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct
>  
>  static blk_status_t nvme_error_status(u16 status)
>  {
> +	if (unlikely(status & NVME_SC_DNR))
> +		return BLK_STS_TARGET;
> +
>  	switch (status & 0x7ff) {
>  	case NVME_SC_SUCCESS:
>  		return BLK_STS_OK;


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
