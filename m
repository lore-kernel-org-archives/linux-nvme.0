Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E85C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 09:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q8rYVmzeb0BIhBpMFUreKtfVcFEbEBQ1myveAe1Z1DY=; b=uSKBrXu7xqy8K6FECLLGJlJi8v
	DrfF89oMOIopA5Pzcp6BVNeuE0he/0k2dRZa5F6cFBrYXegfa3SeenGfiIJye2GMw03IZhL8Kd9l2
	j5tl0EqcqqaApJhO2lhQTk6VaWxg8RPXoSA5Zg2wyM7kTvxjIfq0ipQvbGvHPpcAC3o6BwSoP/eoU
	Us+xdtsDOwIylhrp9hKGmF0guttSC2MPUcvKgHnhIw7JWhR3SEhHMx3msa7q1H0pxZ/vusrwpjLRH
	tUZxUWTdpBgu+jnrt3bPcfCXdcMXNUP7iMfYLyDwpzrMlkTNMrfQTThJ9Nl2KGZcXR5op7UhUS2pu
	x1i+Xztw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viUKV-00000005Abb-2coX;
	Wed, 21 Jan 2026 09:16:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viUKV-00000005AbL-1NGr
	for linux-nvme@bombadil.infradead.org;
	Wed, 21 Jan 2026 09:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Q8rYVmzeb0BIhBpMFUreKtfVcFEbEBQ1myveAe1Z1DY=; b=ABENtx6SqJiSkxknRsokKvFBdQ
	1dVuq+4u+PzontiJ0HDoarTNiJ8nWID2Mfi1A/IwSdGyQeC7Yp/ULLjoyTN5UT4CIwyMzSPCTQyvU
	P2crLpqx9f5mKq9Sjr5oTxEgPsD1oEQMFRrcfh2S0/DJ/0Ii5t8TA5rIlZ90vr0oCjKybTiYwCLaz
	si4uZpszJIrHcc2fxtcqWFN5xW0epyIV2pT/4oVdTF1HheswQoYRaTs/fW/DY1hWc6PQaFsVHUm8N
	ZHIjeil5fmcFv7Udg0fJpOGjJoliNcYGXtOKuqHRn4b3LfOItRRlOQWca8E17tZ8tNZHTbBHzpKvj
	3E8IqMdA==;
Received: from mail.vexro.pl ([141.94.250.70])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viUKO-0000000FgDV-3h5E
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 09:16:46 +0000
Received: by mail.vexro.pl (Postfix, from userid 1002)
	id 0197FA742D; Wed, 21 Jan 2026 10:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexro.pl; s=mail;
	t=1768986763; bh=Q8rYVmzeb0BIhBpMFUreKtfVcFEbEBQ1myveAe1Z1DY=;
	h=Date:From:To:Subject:From;
	b=DvqRIrOeRY33/ggkW2r4kkBrSm36JiVgxSyxv9oXrMYatPPyw2BVwjxzpcIkNxS/7
	 tz/omqpQ9v2AGods5WwQHNV9uZFsW9/9fg3lIgMpKJNPeKXTVo53o2fZ2pYrrZv43+
	 wydH6Si5dGUPZpaLCVsWz/kb5u0uNJ74QOGIuDqqKPRLNOwjrqKRlLmUfAZ075tbj9
	 rYZbiT+C4HcBoc9lKPnYx93TTzHZzD+Ctytg8oWKQBHiVBv1HfoDuxQKNwk5ndjpCu
	 PCaIJ8xZnoXeyD02VC9qDtCWF45P3tP9egcqgX/lFzLhv07oMBCCjISKAyFF9yBlt9
	 KLIM9aq8EPf2A==
Received: by mail.vexro.pl for <linux-nvme@lists.infradead.org>; Wed, 21 Jan 2026 09:10:50 GMT
Message-ID: <20260121084500-0.1.pt.4z27g.0.ce2va0gq41@vexro.pl>
Date: Wed, 21 Jan 2026 09:10:50 GMT
From: "Adam Drzewiecki" <adam.drzewiecki@vexro.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.vexro.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_091641_396146_491C0623 
X-CRM114-Status: UNSURE (   2.62  )
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

Szanowni Pa=C5=84stwo,

zajmujemy si=C4=99 wdra=C5=BCaniem systemu, kt=C3=B3ry zapewnia pe=C5=82n=
y nadz=C3=B3r nad pojazdami w czasie rzeczywistym, usprawnia planowanie t=
ras i redukuje koszty operacyjne.

Platforma automatycznie generuje raporty, wysy=C5=82a powiadomienia o sta=
nie technicznym aut i dostarcza danych wspieraj=C4=85cych decyzje zarz=C4=
=85dcze.

Czy byliby Pa=C5=84stwo zainteresowani kr=C3=B3tk=C4=85 prezentacj=C4=85 =
lub bezp=C5=82atnym testem systemu?


Pozdrawiam
Adam Drzewiecki

