Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBF7C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fClkhHu/p6gIm8tbpvFwCqGX3kXIMdqjiuDdSiYGEkk=; b=ATG2G7CpTsXJBfZwwyKNPyGowM
	VSl5HLo0uXh9nJsfrj/zhZPUyjU1QqF7xgYV0Fz/hAm6yJAUd3Z7YY8I71lUXjkJB3+RAm/o8zVNG
	4bs1NFDGvGNF8RUxp1eDtLoeNgaXzAFmJ+89O/cbK8l64VRmg0Uz7Wx3xUzsDMziTlnQnAUlzUfLp
	yVxAmygiXiVHeNS93bmOkst0yV8mAgDojY6N40DGNeoBxYMwT4OJ+dsQmY0DFY25zexQyUWTwVQxt
	/tKEh06jr5rUwtIOuPp1GaEzU2O8BhREmoE9jxhAqUG/uDuQHP6ipQzCR+dpJrr+suInxtvMZG9ZK
	hAKLOg6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvCV9-0099jT-2S;
	Tue, 24 Oct 2023 08:10:59 +0000
Received: from mail.citycodes.pl ([158.255.215.195])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvCV7-0099iV-2T
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 08:10:59 +0000
Received: by mail.citycodes.pl (Postfix, from userid 1001)
	id 604F021584; Tue, 24 Oct 2023 10:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=citycodes.pl; s=mail;
	t=1698135056; bh=fClkhHu/p6gIm8tbpvFwCqGX3kXIMdqjiuDdSiYGEkk=;
	h=Date:From:To:Subject:From;
	b=V7U0P0tGlTMK/+hBW1yS0LqNtujdmgUfUjQOOX6dGYQ0lWAAcTvl9/gZPUWJvKIzu
	 WbC8Lv+FBMlVWUYKuySJoJuj/wkI1Ktd1kRdH4qtPgUxHpoHP402nS+BYfkT7tpk8J
	 hD/yg8e4Tw/Lh72R8zzvzO5ycZOl9MguKlAV7emG0mZiBZHIBiCYnCJgOc2XAeIbIr
	 /VmwlVUtpvImGcMnH13SEKTNBaDyXslwLd1cl13qQbqQ7CLv7tsRwA/Uru0gSRrj7h
	 YmkgrDgaLwpkGgZD0Q8hdlQkAPob8ar8I0FmdqL6byCFs96uUxMZyP2JiLv0zjGo0x
	 eGYGCQSXgSStA==
Received: by mail.citycodes.pl for <linux-nvme@lists.infradead.org>; Tue, 24 Oct 2023 08:10:35 GMT
Message-ID: <20231024084500-0.1.8a.l85k.0.1hpuexrprg@citycodes.pl>
Date: Tue, 24 Oct 2023 08:10:35 GMT
From: "Kamil Lasek" <kamil.lasek@citycodes.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.citycodes.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_011057_944376_0F8B2B36 
X-CRM114-Status: UNSURE (   1.71  )
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
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Kamil Lasek

