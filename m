Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2BBC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 03:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d7lelOyaghHCGHT5Hdiu5y3UeqylUZluyrjfLETc/UU=; b=1KMFE99ew2+iuHOVbuzMUo1Ief
	qxm71OqWcbQCNxmAca6Pnrxt/08mdO1+ttYM8RWKujEPsrPxRjYbNCXBhNtWsq1yLCU+QAMIlN8Di
	+zpwFGexkQyI6j0hmZ17ePic5ZqQxUIfqG3/FeLPaJNRbq4oOQMs7GmhrZBfITpWKI0yF8ikUOonj
	J4FeSvxsSm2f8JGc2KESScFHD9xdT0mn9f3FDjfd9JY85ZBtDBmxSHBq/H3KW/2MjteLuCrqYoEl3
	/piM++719J5uHvsyqsZU0YF5jMQlGbPNkbOtlhBnQgZbXINaUpODIH2q5DWBbZGcTmptKiCATmm5n
	wNx7pL1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0all-0013n7-0P; Mon, 13 Jun 2022 03:29:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0ale-0013lQ-Tk
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 03:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655090968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7lelOyaghHCGHT5Hdiu5y3UeqylUZluyrjfLETc/UU=;
	b=LsWL12i2FSSkLKpRSJaT+wq00UFZva+KFC5Hm2xKqVBRyzVA1MFf9RWeBxmNHL8VIBmiBq
	JBGAf/pBV+QyUT3sLZhnyT6ACUK1o4pT4A4bX7sQN8Bxn+yNgqUmRiADH0zI014XtYFy/f
	3EktMxZtoLRaZajIRLMZSeRa6GiQiEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-9GWpwyEyMrmQztOWcRU11A-1; Sun, 12 Jun 2022 23:29:24 -0400
X-MC-Unique: 9GWpwyEyMrmQztOWcRU11A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F4EE801755;
	Mon, 13 Jun 2022 03:29:24 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E78CB1410F34;
	Mon, 13 Jun 2022 03:29:20 +0000 (UTC)
Date: Mon, 13 Jun 2022 11:29:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed from blktests on latest
 linux-block/for-next
Message-ID: <YqavC8hwLXwPVnor@T590>
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220612_202931_082787_89D3799E 
X-CRM114-Status: UNSURE (   9.34  )
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

On Sun, Jun 12, 2022 at 03:23:36PM +0800, Yi Zhang wrote:
> Hello
> I found below kmemleak with the latest linux-block/for-next[1], pls
> help check it, thanks.
> 
> [1]
> 75d6654eb3ab (origin/for-next) Merge branch 'for-5.19/block' into for-next

Hi Yi,

for-5.19/block should be stale, and seems not see such issue when running blktests
on v5.19-rc2.


Thanks,
Ming


