Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84608C77B70
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=35qx/FNMkg4I1r9XDzODsf87ZLez41ivp7LFvV23swg=; b=CkqTtSy0Qhb2H0QSE2y52JZz5Z
	jRSQjrj/hqSbVBV9LSyWbOb9jYEsDxOlyhpRN76hM7NVH2Bpnu/DISXUuAVyChnAxXlBBCPBtBwkP
	P6mG8nr+9aXB04jaNCMV6z0XHayIPgjxYSXR92n+Ju2A4wVHSjCJPI4sKB4zT9onNdnYMjS9AiIHJ
	+bu9Q4v9etZn6JvN+St5PZl+Ke0eQDNdDRtL/uOfeJYDuEFbnLw6dVdD7raUKjDfmeeXcOm6gohYD
	mrSI06hHQGsilb6OCJ1SFIBceM+g/OLxrnCRi8iWEgDqp+RF8gv8yv2xeQllSXLunO/7kAqnDrOr+
	x1i3cFaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm3lq-00GGL8-37;
	Tue, 11 Apr 2023 02:30:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm3lo-00GGKD-1D
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 02:30:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681180205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=35qx/FNMkg4I1r9XDzODsf87ZLez41ivp7LFvV23swg=;
	b=VVzgUOgu2bCfnKU0wgkSQol/X8PL8ldyjSwoV8Lpe5uMAkBSJkOJevZutL5F1NHSATGp3p
	b6qvQRqxzEfZuFbN9QI4f0O28nab2Weye8pi3A23M4IKKS7Oy/SMUJAdeDkV/RqUSgcF5K
	S+1amvBaJbUFsOeXYmGxIaIqIKwikHQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-fgulkMvIMO2JyCiGyNXpaA-1; Mon, 10 Apr 2023 22:30:02 -0400
X-MC-Unique: fgulkMvIMO2JyCiGyNXpaA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-513c5614ed7so280609a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 10 Apr 2023 19:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681180201;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35qx/FNMkg4I1r9XDzODsf87ZLez41ivp7LFvV23swg=;
        b=Zdppu7+Rm5ets7W7zbRG7LEZ2MxfYudW6LkuGv/ZJfdkyIhObZvw9ErQlPJMCAIF5p
         dpUjluCHcixM6HVSaxTVtNRbAkyFYB4RLupsBb+s//aPKLKAvSnXfgDEEJ3lhADp2qVC
         GCKeR8qNFwbR746qptvnRpHnA6ScTXppWHG5rT1/7DppEYhuDan4ac5GCNv47EG7JBAr
         INLK0+uXjd8VH2ASNIdgGyWSRkxahoyDkAJW0ypUbfTkDR0SkjEWQYK21qbTDnWeElWY
         9HWMCf/mNdrsyi+M4eyGKTkqtvJBo8tK9afYcy4sz/u2vF/T9uIfu1fhC5gwyzmNSBhB
         4PFw==
X-Gm-Message-State: AAQBX9crmPsoI/sm8JOX/3YCbXgJ9zH+RcJmGxmNv+VlxV1dG9COSsP7
	7137L6W9BO697XagLP4R3cOGEcCZcBglbOHX7UUILN3O/rG+XVfYGyruhnVtrxM0u8q1ZoOpVJe
	dEHMaOl7+LSSUUQUPd+rHtIMuuxv6tKgcUufKQ0cgfxisGlr5NSG7R5bI
X-Received: by 2002:a05:6a00:2e8c:b0:5e6:f9a1:e224 with SMTP id fd12-20020a056a002e8c00b005e6f9a1e224mr6128614pfb.6.1681180201207;
        Mon, 10 Apr 2023 19:30:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmBfUO+1891FM4uk0GfxcbPSSOrwRxKUv3cdLClKGoG5vKBqwYevNceSnDpihn0FR63FV308+QTzOkfrN17Gw=
X-Received: by 2002:a05:6a00:2e8c:b0:5e6:f9a1:e224 with SMTP id
 fd12-20020a056a002e8c00b005e6f9a1e224mr6128606pfb.6.1681180200896; Mon, 10
 Apr 2023 19:30:00 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 11 Apr 2023 10:29:49 +0800
Message-ID: <CAHj4cs8z+sqEcpWXzXUrWEyR3uE=3wgg2TvCJePXb4QaLkE=Kw@mail.gmail.com>
Subject: [bug report] flood log about "nvme_fcloop: fcloop_exit: Failed
 deleting remote/target port"
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, james.smart@broadcom.com
Cc: shinichiro@fastmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_193008_517273_74AF7E2D 
X-CRM114-Status: UNSURE (   3.49  )
X-CRM114-Notice: Please train this message.
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

Hello

Remove nvme-fcloop module during blktests nvme-fc nvme/003 will lead
below flood logs, and it's 100% reproduced, pls help check it, thanks.

Steps to reproduce:
1. nvme_trtype=fc ./check nvme/003
2. remove nvme-fcloop module at another terminal

[  448.274204] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.280307] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.286406] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.292511] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.298608] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.304711] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.310811] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.316916] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.323024] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.329124] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.335225] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.341329] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.347438] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.353540] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.359647] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.365750] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.371850] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.377951] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.384054] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.390162] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.396264] nvme_fcloop: fcloop_exit: Failed deleting remote port
[  448.402363] nvme_fcloop: fcloop_exit: Failed deleting target port
[  448.408465] nvme_fcloop: fcloop_exit: Failed deleting remote port


--
Best Regards,
  Yi Zhang


