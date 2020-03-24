Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D0DC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 18:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FC320714
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 18:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dcrJ2S2t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIbyYmfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FC320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:
	Subject:From:To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fF91+1UwVgXMqV5YIgIsR0fnthDJ6s+Zu2HJqUDYh9Y=; b=dcrJ2S2tvADf5M
	+XHfJKGa/fTmS4cOZ6ETK4eGalIxY8513j3Sknay4DwIYwtCpWikJJvye55RDAhKSm5kQpcL7SOBs
	kwXoeHAAAo8G6EkY3hC+3TE5SghmzhNzGllfn8FNky9dIegS1iFn8X6vU2o4fNSVZs9/lwGuZdeTW
	i4Xt6PRAGhpCyylkJIbE1bgZbppdy+j7fCZZ+Ps46Y/yg1iWTenYCa9badea9cVkUUUn80a24ISqZ
	rXXzBzJEeQDKuOPQ4VzS1JkhwCAE4Wlt4UBYel+61cDHZ6sYa1LDirAMO7FJrcUvW7BjDMNo8kVHE
	eIyqtGojLa8kP0cl63Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGo5j-0005A1-Fw; Tue, 24 Mar 2020 18:15:55 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGo5g-00059T-OQ
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 18:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585073750;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=MoP25aDlrJ2QCWYbM5B25jb4lNBN6wOWoA+fE5dRXiI=;
 b=UIbyYmfkzEgiXUZEHgDm+ukXLl9vjEMvmRRXdub4GDCqNLjwguH4G3ybV0doXLX9fZW8Wn
 NRV5FsKDP7Ix/9fUTmexCP5BDf3TTLwTPMH31n5ieW5jeIs4qutNhGcLbrJs0NS9Ie+4WC
 ZQFM126uu43OUr/VaFuIPVyP/CFctiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-tyCi_Tt-MQyXTcEtNzMp0Q-1; Tue, 24 Mar 2020 14:15:46 -0400
X-MC-Unique: tyCi_Tt-MQyXTcEtNzMp0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E880685EE85
 for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2020 18:15:40 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A50B9F4B
 for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2020 18:15:40 +0000 (UTC)
To: linux-nvme@lists.infradead.org
From: Tony Asleson <tasleson@redhat.com>
Subject: nvmet and stable API
Organization: Red Hat
Message-ID: <d4060208-ec69-3211-277c-d151be302555@redhat.com>
Date: Tue, 24 Mar 2020 13:15:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_111552_872254_3B0F299D 
X-CRM114-Status: UNSURE (   7.25  )
X-CRM114-Notice: Please train this message.
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the existing functionality of nvmetcli in that you can
save/restore/clear/ls and use interactively seems to indicate that if
you want to programmaticlly change the state of targets that you need to
use the python code that is available in nvmet which is used by the CLI.
 Is this a correct assumption, that nvmet is an API for external python
programs to use?

The block tests in https://github.com/osandov/blktests.git seem to
indicate that going straight to configfs is the API?

Thanks,
Tony


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
