Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A3C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 04:45:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC9820737
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 04:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gocj7unw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeKf4O2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC9820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XhARH06Rwr68ZbLt1EgIsSLnHKTi9csio0A360aePMA=; b=gocj7unwhMChuK1TyaIJQoHpmc
	AUbz1TvexlV39ddC5v1aB+7LTBuWaMcvBK/EUCMz1SdI5nloouQ0wGritwuG26xqEafB9OtoKsk5G
	gkp6PeYZQ87hL3oAPrRfKxiV/AREcgD6EhbsRk0yBla6YF1CWWOd00CI2pPqpP/nqc+GJnqLDaD6r
	3A5qQ1xI+5nefeNXZnJZ6WiHD+NXkzGn2yZSZmlBDnTj9kOeL0Uf1g6touLE7xsUM5x5Bo9mwIYhm
	myguYtBL21fz0ZdL0oyUq7jsCJvB4YqdyO2C3dA+cjq9ZXoOwUqT2rzD5Xj1/iNiPKqhPUSVz7RBq
	VPaNrSCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqr6O-00036w-MR; Thu, 02 Jul 2020 04:45:36 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqr6M-00036X-52
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 04:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593665133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8j8Bik+iGh4Zoq+wMMyjUK9XjcqrUD+Xqgx+UYVohE=;
 b=EeKf4O2u4Geiy1EP6mr+u4E+0R5ytJObG10XgsMBMJBwro6nJdTgMYBkGIvSCmelvxXgek
 tT7JyzR/n/MoINbdR5IMEXqjbdE/67/kr4Ellx2ToyVbjuYUt56qCCFV3qiH2zsTAGP9Ob
 7mGUbU3ztORg7lTm3vcrTY45xO286Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-RXCxS65ZN8unR8hMTd3hKw-1; Thu, 02 Jul 2020 00:45:31 -0400
X-MC-Unique: RXCxS65ZN8unR8hMTd3hKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 397E5800C64;
 Thu,  2 Jul 2020 04:45:30 +0000 (UTC)
Received: from ovpn-112-19.phx2.redhat.com (ovpn-112-19.phx2.redhat.com
 [10.3.112.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C546573FDE;
 Thu,  2 Jul 2020 04:45:29 +0000 (UTC)
Message-ID: <22add607f1ebb42a56dfd5a2446c57f0b1d930bc.camel@redhat.com>
Subject: Re: [PATCH v5] nvme-fabrics: reject I/O to offline device
From: "Ewan D. Milne" <emilne@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, Victor Gladkov
 <Victor.Gladkov@kioxia.com>,  "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Date: Thu, 02 Jul 2020 00:45:29 -0400
In-Reply-To: <64fe71ec-6d06-0789-3dfb-4861d2621eb5@grimberg.me>
References: <cde32cd53001412889cea1e1fe28e7f7@kioxia.com>
 <8ddc3564-494a-d32d-cf97-ce7d8174f91c@grimberg.me>
 <b44b1328494628e4e0fdbfb226a7ffffc9a139a8.camel@redhat.com>
 <64fe71ec-6d06-0789-3dfb-4861d2621eb5@grimberg.me>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_004534_302308_B376B7CC 
X-CRM114-Status: GOOD (  12.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

On Wed, 2020-07-01 at 18:26 -0700, Sagi Grimberg wrote:
> > I'm seeing an I/O hang followed by errors returned to userspace on
> > NVMe/FC and NVMe multipath with the v4 patch.  It fails right away.
> > This is with a test that does alternating link bouncing on the
> > target.
> 
> Thanks for the input Ewan, I think that v5 removed the fast_io_fail
> hunk, so maybe that'll be worth a shot.
> 

Yes, I've had it running now for over 6 hours, it doesn't have the
same issue.

-Ewan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
