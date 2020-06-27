Return-Path: <SRS0=uo1w=AI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805FFC433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2020 03:43:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A0B20857
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2020 03:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ukpgWJ5o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly8WOcqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:Message-ID:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=/u0M64hHlF+dic+B3C+31C155aSogQfawu41ldM3GGA=; b=ukpgWJ5orBKgqvzpKClVgCfzy
	DcaO/fbENent3/uWv3yp9okYoYywpenNMUR19p3T+OPi86FNQvsq/oem/TLwayx+D2e8qR0SRlD3+
	OG5erQo5a/fI4GbP2DIf55DyLrJOBdVbCggTuZNFM+u6gutCXs+JgSE0QZ5YgtXPJQ/XIqGVM2Ysh
	0U0oKuoGtuvgAwAA1hrWPJRZmzolNZECcbSKqMutGB9RXVScY6PJvecI9GFNnsKRsHD6CIJKMz05e
	9czLDzIedhnXwNYdypLZvt64eRvE20z2nj0IusBjsLTRcaZsEm0qiaVM2iXnmWMq9jeRbVnuI4uV2
	MEHT6+VuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jp1kh-00047X-Cu; Sat, 27 Jun 2020 03:43:39 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jp1ke-00046H-Gh
 for linux-nvme@lists.infradead.org; Sat, 27 Jun 2020 03:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593229415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=ZkxBjRPE38AeQwCFMZn1KK9y+cIXY34Hr12rRhiOUoc=;
 b=Ly8WOcqYLGD7lqYkoTgK5DN/kWJ2aSbqs4gLD8tUDsOM4pHAYvZ48UG36sQt4T0Q6F3vfb
 VqXwhP9u2IJnfujzGfydLPhrW6180uQMVlwJ534fcAQd46Z0URyMCfar0O8IfwUT1oy6mY
 XDpb9n2F7YF1BDsveqo+NVHTjyXi+2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-UziU3K_rMwKLIGFpTrGChw-1; Fri, 26 Jun 2020 23:41:56 -0400
X-MC-Unique: UziU3K_rMwKLIGFpTrGChw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1042800EB6;
 Sat, 27 Jun 2020 03:41:55 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8314E71662;
 Sat, 27 Jun 2020 03:41:55 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 508191CA6;
 Sat, 27 Jun 2020 03:41:55 +0000 (UTC)
Date: Fri, 26 Jun 2020 23:41:55 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Message-ID: <1528690896.32343478.1593229315244.JavaMail.zimbra@redhat.com>
In-Reply-To: <1517012281.32343351.1593228195746.JavaMail.zimbra@redhat.com>
Subject: blktests nvme/004 failed on linux-stable 5.7.y
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.20]
Thread-Topic: blktests nvme/004 failed on linux-stable 5.7.y
Thread-Index: 0H5pMP9dFmzDE4G+SBAO/Vn8Agfufw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
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
Cc: hch@infradead.org, dmilburn@redhat.com, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

commit [1] introduced regression that will lead blktest nvme/004 failed, and commits [2] fixed this issue on latest linux tree.
linux-stable 5.7.y has [1] but still not pick up[2], does anyone know how to start the process to include [2] to linux-stable tree, thanks. 


[1]
64f5e9cdd711 nvmet: fix memory leak when removing namespaces and controllers concurrently

[2]
819f7b88b48f nvmet: fail outstanding host posted AEN req
1cdf9f7670a7 nvmet: cleanups the loop in nvmet_async_events_process



Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
