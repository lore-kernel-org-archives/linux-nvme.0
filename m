Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D989ED232FD
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kb7u+lszG/nXqIAGpk/hByhDC/8HGhmWaIRwB9KIYkQ=; b=gZZao+Pt6CUPu+7ulyqWWpc/mg
	k6D8s1nznEWmlmy4lZuA7ovI0XLRQ3LyEjJuTFVrORjFFoZffNeiv7j+QF6dMPVywIQQZE2rd/y5C
	f+603QuUgb/xtlDzobs4Pz29BpdmopaPScQQUMEfV+SRqGp53vDJX1MdbjIyiDmPqip0dFW4pOci5
	4w5UZAZ2DF4cvP9ylfkI5COgoaLjR9SQERDt48cuvs3dWVZSYyT0hYjrqBDRqAQJKK/IOizHp0PxB
	bSDa0qcVjqwTTrVpw3eVc9w7ADtVAZLbJnU8oIm46GB6LQXVohqXuFiaVIjgN9X/FHjoUHBEx6iA/
	GjiXI6og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve8Zu-00000001z83-1HX5;
	Fri, 09 Jan 2026 09:14:42 +0000
Received: from mail.fontri.pl ([51.195.90.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve8Zq-00000001z7K-3pZQ
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 09:14:41 +0000
Received: by mail.fontri.pl (Postfix, from userid 1002)
	id AE888AECC0; Fri,  9 Jan 2026 10:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fontri.pl; s=mail;
	t=1767949947; bh=Kb7u+lszG/nXqIAGpk/hByhDC/8HGhmWaIRwB9KIYkQ=;
	h=Date:From:To:Subject:From;
	b=ga9WChXVzMv7Md9O54xs/VM7LUoGQWfaCeoQzYBngBDs2ywyoLBcwS29qQqtv5StO
	 qG7ZKpYnvVqwXv31HoG9PSOfxeO1dz56aXzfTPFYBrsEuAKAa3TuoRYPlR6sU3YEZ4
	 Vas8q/fYp832xZ4uQrmv+vf9Z+JbqJEr1bEO7SQfHCIvJ1hGn6Z1QDAS9ojhdZPvWQ
	 gvOk1/A3GmPEw0CWdpuQt4EFdCH6uxgf9eVuQty4cuSnBJyczEEwPWV7orlrESASzq
	 SqXT9iCYTgGfks+OCRBJ2RzDkz7P0UruTJxNPFagnpDhe2YVkV7kTt7w7elQ5mCvRi
	 AjvR9vv/mtliQ==
Received: by mail.fontri.pl for <linux-nvme@lists.infradead.org>; Fri,  9 Jan 2026 09:11:18 GMT
Message-ID: <20260109084500-0.1.td.6k9ir.0.qa4ebvfhba@fontri.pl>
Date: Fri,  9 Jan 2026 09:11:18 GMT
From: =?UTF-8?Q?"=C5=BBaneta_K=C4=99dzierska"?= <zaneta.kedzierska@fontri.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Odbi=C3=B3r_w_paczkomacie_?=
X-Mailer: mail.fontri.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_011439_328561_7312DD4A 
X-CRM114-Status: UNSURE (   1.98  )
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

Dzie=C5=84 dobry,

jako lider w us=C5=82ugach kurierskich w Polsce przygotowali=C5=9Bmy elas=
tyczne rozwi=C4=85zanie dla przedsi=C4=99biorc=C3=B3w.

Stworzyli=C5=9Bmy abonament =C5=82=C4=85cz=C4=85cy dostawy do Paczkomat 2=
4/7 oraz obs=C5=82ug=C4=99 kuriersk=C4=85 - jeden dostawca, jedna faktura=
 i przewidywalne, sta=C5=82e koszty.=20

Czy mog=C4=99 przedstawi=C4=87, co mo=C5=BCemy zaproponowa=C4=87 wzgl=C4=99=
dem Pa=C5=84stwa potrzeb?


Pozdrawiam
=C5=BBaneta K=C4=99dzierska

