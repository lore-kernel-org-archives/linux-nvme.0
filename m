Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B26C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jan 2022 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=07NAgW1e0WiNB9zqagiM2BnwZfWBCpNa2E4+ccxBPgw=; b=T4vJS51RSFPPnf7dPVvz6A0YhX
	v7KvOyS24RS6EhaizoDPLtgzMlYTZZDiREEFbnDNv40yBiyxEy33h07Oa/rBru0kGIv00q1q7//t+
	s8krFRrEW2QQzvn+xb7KtK+O5WWyBZ8p48nmOSLhl1SmO3Dz3CQliztpEa6QIbzpv+Sdj07mOWpdH
	pU7Y6OuC65Y2SuUHRwE37JRYI1j0Df7ePSje9vXGpEmrysEF4SvFMax1KvGvclrs9/6BwNc88I4i1
	VkdEHWYByMwBLzgEguc+oRu9YqMlH+wIFqy3fDAf9VeRrufMvmzEm1FohBW5U1lUdk+hjobTXqpRn
	OX5rMOpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7BsF-00FARw-24; Tue, 11 Jan 2022 07:47:19 +0000
Received: from mail.betterbiz.pl ([45.86.209.138])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7Bs6-00FAPi-Jn
 for linux-nvme@lists.infradead.org; Tue, 11 Jan 2022 07:47:11 +0000
Received: by mail.betterbiz.pl (Postfix, from userid 1001)
 id 1D58982DFB; Tue, 11 Jan 2022 02:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=betterbiz.pl; s=mail;
 t=1641887230; bh=07NAgW1e0WiNB9zqagiM2BnwZfWBCpNa2E4+ccxBPgw=;
 h=Date:From:To:Subject:From;
 b=isn8YDwMcZB7+So0LH3jvuVFIwuSgZ6VFigSAR6uLuPiwTfyouRcDQQ2hPIO+uLvQ
 SvZ29pPJzlTVuHfwi+2xJ8c9oKj2/rNfhzTlYyUzJyqZwc2YojD/d+38lFL1TS46pf
 8i2w6EGIf/tRi95IcxPtfkbFG6EjVqNFi2iSVycYQPjTHxNnBGJO32P0c4629KZyI0
 l2tw+EwqyI3G+JbNRNNpjop6FpBcnI11wofbz4lauXCQgJ6otJc58VFYCpcMrQWe0s
 /iDvoalkW4KEocXWTTO/4NnpEC7hbtEt9a3uhNTnYluXqKuhaNEnd2rWKCV9Zlevg+
 rtM19WiGZoESA==
Received: by mail.betterbiz.pl for <linux-nvme@lists.infradead.org>;
 Tue, 11 Jan 2022 07:45:52 GMT
Message-ID: <20220111024500-0.1.o.10dy.0.05q7np58f3@betterbiz.pl>
Date: Tue, 11 Jan 2022 07:45:52 GMT
From: "Jakub Daroch" <jakub.daroch@betterbiz.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.betterbiz.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220110_234710_683016_F7C34CD6 
X-CRM114-Status: UNSURE (   2.25  )
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

dostrzegam mo=C5=BCliwo=C5=9B=C4=87 wsp=C3=B3=C5=82pracy z Pa=C5=84stwa f=
irm=C4=85.

=C5=9Awiadczymy kompleksow=C4=85 obs=C5=82ug=C4=99 inwestycji w fotowolta=
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej nawet o 90%.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Jakub Daroch

