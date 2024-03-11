Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8F5C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EYN951LA1I6x2LqQG9SRvdSsS/DbVhjOvb+nDwRFhwc=; b=iMI6uRvsMnBlShZQBM5VHo/Hw1
	P7ts+m7WPkDAlZH3waO8kJh5lkcgFH9bKhRW9OJAh8oGcgqBRtoaEpEbBHauTzpT5XKfw+QNuLbB8
	AmH3Z1A7hkLvgzg9SMADJ1uhyGqJsWiLgcCOwDBM3YelG5neDxfb+EA2epSQSLORj4QKKFzVfEVYH
	/ecbQwWQGmVj/vzASCDyz4H3P5i/uUBXjAi9h3VokIiO5nY13cLE3NrPXSw80giCoTrhQOlGtLBID
	nsFo1bCFaEBYGTEhlq943V42kRk+iyxVj/62HfYgunWfqjizkPXzGOKucP976HNVB9AUTacSQ0oNU
	qslH0Dlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjbln-00000000n4P-1sq7;
	Mon, 11 Mar 2024 09:16:31 +0000
Received: from mail.buildbrigade.pl ([135.125.238.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjblc-00000000mqX-1JfL
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 09:16:26 +0000
Received: by mail.BuildBrigade.pl (Postfix, from userid 1002)
	id 06794A2AB0; Mon, 11 Mar 2024 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=BuildBrigade.pl;
	s=mail; t=1710148248;
	bh=EYN951LA1I6x2LqQG9SRvdSsS/DbVhjOvb+nDwRFhwc=;
	h=Date:From:To:Subject:From;
	b=Q58br1oIhltRy61TYDetAkcF1kQmZzwdlpEA/t3kN7Qk6wG0pqbqGwfRW3hJH82Nv
	 Dcs3PrahoKFnBOf5w+K201KpbTCnlUdYuYRtfbqK6Xy4+zZHc3Jf0GakuIeHdNll0C
	 Px2k+bggOZasLdnNU1YjgXWOHxruOkJxAWXcsntWV5etQo4SbabviWE0mrQpgNeW0J
	 1Ihtd3usLe5AFMHUVrnceKUcvbgXaYOhwDHkTZAnMAe9ElEGFeo3QhXuaIgEjn/rHG
	 tQc8YfgW/CZjz356luybO/cLdjGcWFImzdL0SkDZDoL7GElZFCWC/S7n4BmTWMxiL9
	 5Zft8aaKBIzcw==
Received: by mail.BuildBrigade.pl for <linux-nvme@lists.infradead.org>; Mon, 11 Mar 2024 09:10:28 GMT
Message-ID: <20240311074500-0.1.c1.1gy2f.0.z4k8rukm45@BuildBrigade.pl>
Date: Mon, 11 Mar 2024 09:10:28 GMT
From: "Tomasz Mrozowski" <tomasz.mrozowski@buildbrigade.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Niskokosztowa_modernizacja_o=C5=9Bwietlenia?=
X-Mailer: mail.BuildBrigade.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_021621_180001_F2DEC953 
X-CRM114-Status: UNSURE (   2.40  )
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

Witam,=20

jeste=C5=9Bmy polskim producentem opraw o=C5=9Bwietleniowych, dostosowany=
ch do potrzeb sektora przemys=C5=82owego.

Naszym celem jest pomaganie firmom przemys=C5=82owym w oszcz=C4=99dzaniu =
energii i zwi=C4=99kszaniu efektywno=C5=9Bci poprzez modernizacj=C4=99 o=C5=
=9Bwietlenia.

Przeprowadzimy niezobowi=C4=85zuj=C4=85cy i bezp=C5=82atny audyt o=C5=9Bw=
ietlenia w Pani/Pana firmie, kt=C3=B3ry pomo=C5=BCe zidentyfikowa=C4=87 p=
otencjalne oszcz=C4=99dno=C5=9Bci, jakie mo=C5=BCna osi=C4=85gn=C4=85=C4=87=
 po zastosowaniu naszych opraw.=20

Dzia=C5=82amy kompleksowo, pocz=C4=85wszy od konsultacji lokalnych, poprz=
ez projektowanie optymalnego nat=C4=99=C5=BCenia =C5=9Bwiat=C5=82a, a=C5=BC=
 po profesjonalny monta=C5=BC naszych produkt=C3=B3w.=20

Opracowali=C5=9Bmy innowacyjny model finansowania inwestycji.

Prosz=C4=99 o odpowied=C5=BA, je=C5=9Bli jeszcze nie wymienili Pa=C5=84st=
wo o=C5=9Bwietlenia na LED i jeste=C5=9Bcie zainteresowani nasz=C4=85 pro=
pozycj=C4=85.


Pozdrawiam
Tomasz Mrozowski

