Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04474C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWoeJ1CjPoJt96h4eLMWqdTk9yFlWakBAEpC46UOYJo=; b=Wbz8ITiutHvZH5ae1mqTv5ft5s
	vwwjpsmpK1FObL+b2CvL5thKToKGByk59e1GrVt82HFC7HfyqZgy1oOwNZbldT2P6+LHPhyLMLvU4
	/Ckdpye586JG4TFSA9Jigv93IKIBDt86n/rfJiE4iPik6gzh+Y388FAazo1B6JxNJ/ByYejy7KY0s
	5V1a4gduuYGrcqiuhD/f7iupP95req+py7/Hls6kEqbhZU/IdGEqh0c6W9VcbE9oUzNHOclPG8QOf
	F8dCr5n4fQTU8b/P47rGsbetc+uNmvP+wCh622+v/bOsOD8OFP7v2l+j7aConT4VYXc86j6EuV+HN
	i7ege4wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZok-007uVT-EG; Tue, 07 Jun 2022 14:04:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZoJ-007uI1-IB
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 14:03:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654610632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWoeJ1CjPoJt96h4eLMWqdTk9yFlWakBAEpC46UOYJo=;
	b=Yx4FZFFAJwI2mn55/NSKI1BeUtW9K2Su6Q8bsW/rWtMfr3kFvCVWLa8mLcutBQ1rTwoHQS
	VcYPI0cO3u1x+FvBunzA1g7asydXkTUR257IpiEoCP8xq2zCmgwICgVqmp9KAY2C0Wv7LV
	n0hZS7DQyPIdN1fdHT4fK1x31yBTsCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-KTAA5WdwNBOptCanjpvs8g-1; Tue, 07 Jun 2022 10:03:51 -0400
X-MC-Unique: KTAA5WdwNBOptCanjpvs8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13142801756;
	Tue,  7 Jun 2022 14:03:51 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0177A1121314;
	Tue,  7 Jun 2022 14:03:45 +0000 (UTC)
Date: Tue, 7 Jun 2022 22:03:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ismael Luceno <iluceno@suse.de>
Cc: Enzo Matsumiya <ematsumiya@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 4/5] nvme: quiesce namespace queue in parallel
Message-ID: <Yp9avMfGDsOLIXeG@T590>
References: <20211130073752.3005936-1-ming.lei@redhat.com>
 <20220607132118.0bbb230b@pirotess>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607132118.0bbb230b@pirotess>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_070355_732864_30C20EAF 
X-CRM114-Status: GOOD (  11.48  )
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

On Tue, Jun 07, 2022 at 01:21:18PM +0200, Ismael Luceno wrote:
> Hi Ming,
> 
> Has this patch been dropped/abandoned?

Hi Ismael,

The whole patchset wasn't be accepted if I remember correctly, but
finally we moved srcu out of hctx in another patchset.

If you think the patch of 'nvme: quiesce namespace queue in parallel'
is useful, please provide a bit info about your case, then we may
figure out similar patch if it is necessary.


Thanks,
Ming


