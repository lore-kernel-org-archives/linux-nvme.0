Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6ACCCFA03
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kb7u+lszG/nXqIAGpk/hByhDC/8HGhmWaIRwB9KIYkQ=; b=J59WVSRlH3JCM6S52YcjoKWNcD
	/ifoUy6NBTbbXS6B9WRj2knYcvQImHuPxWaG68gjH46WZlGaj2DdslIKqZi45Cupyq6WixcbI9bNh
	a22HkIBA3h02joEO/JvABEWn/Fan70Y4RPYPg4XYcWt3oKtE2XeRJlB9qQQvyQO9aHOf9imwVm/tL
	s6bCPX/FNkXh/6q62jDXFFp+q2Wl3l8xcmiFhQDHmpgst0uTqGZmEKhk4VyMOjV/eZixp7xGqH1sn
	KBXPExF7l2b+L7oS/4UvugWfFz/IRhSjx2R/12PmorhYvH/wPJqwbemrMAwiECwF0yK3oqZlFlOjS
	mJlY4iIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGw00-0000000F8J4-3JLd;
	Thu, 06 Nov 2025 09:09:44 +0000
Received: from mail.fontri.pl ([51.195.90.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGvzx-0000000F8Id-3ksa
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 09:09:43 +0000
Received: by mail.fontri.pl (Postfix, from userid 1002)
	id B832EA993F; Thu,  6 Nov 2025 10:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fontri.pl; s=mail;
	t=1762420030; bh=Kb7u+lszG/nXqIAGpk/hByhDC/8HGhmWaIRwB9KIYkQ=;
	h=Date:From:To:Subject:From;
	b=mDlE1hO8YbmWXUQLvTdm7JGEJtBddZz4LVZbPJIZKKLYfFAata2Nd6QY49VhZ73mF
	 gYDW0VsatIZG9c1wYXOafL5bOjEsGnj2wIkH6+58p28LbC241oz6vIsVy2eyTakXv0
	 KSmnTuldqdZKbQvjbZr21+uAkhDNSZREMOKEz3xuffC778KxgmG8nUYhEFBqfWg7ox
	 faFQd63xeqXDhJME0rCyJyl544UwvJBtEx01yhkF8HULBjCEBFJzt7czU9lFtZP+8s
	 9BChJvrqNL35p4WaT3G0Ab+buZkwmlQgF0FGw+wDzdB+nwByoCWfOgSbOuk9sI9Bo5
	 b+V5xQYW8j8Gg==
Received: by mail.fontri.pl for <linux-nvme@lists.infradead.org>; Thu,  6 Nov 2025 09:05:31 GMT
Message-ID: <20251106082630-0.1.s9.5xw8w.0.ag82rpno5h@fontri.pl>
Date: Thu,  6 Nov 2025 09:05:31 GMT
From: =?UTF-8?Q?"=C5=BBaneta_K=C4=99dzierska"?= <zaneta.kedzierska@fontri.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Odbi=C3=B3r_w_paczkomacie_?=
X-Mailer: mail.fontri.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_010942_085267_281CDB60 
X-CRM114-Status: UNSURE (   2.60  )
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

