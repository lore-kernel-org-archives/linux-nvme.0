Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177AFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JAEkA4FCBmQ7T7M+WVau75EdqeDf4MEEr9hE2/l61BA=; b=pV9L1JtLYrpUREPx1fcpRIr7Oj
	dskZjncuUk/Xbr8zxtdTLOCY28bQH9g92JHR+bE7tlvlEIerInfMRYkaPVtEFwwvG3ha4kyTS8760
	Np2yPYwj8BZHq0FWmZDcdb/bb1tpAXpEiOFW9fj7js1NvEyKswCK+Sg+nVkfJRZEvMekoAc0qkKWl
	QxxUkzZD60tl2QgavY/tAnm7ZSFPHpjNUJ7teCv9T5XhYdQRuOhZZe2fW6vd4VUT9iOzHZ3Tmrx94
	fCnjbw6VVXVMIi+jAHumg7hnfD6OzqgAKnnrgXtNyPNbWEX8m+t4O6laFfeJKTMd8dO+zOGHjzyE1
	kqQON7TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCHxx-0074gK-Ob; Tue, 25 Jan 2022 09:18:17 +0000
Received: from mail.belongsenergy.pl ([185.45.112.191])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCHli-006yeC-Gr
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 09:05:40 +0000
Received: by mail.belongsenergy.pl (Postfix, from userid 1001)
 id 9CA6D2665D; Tue, 25 Jan 2022 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=belongsenergy.pl;
 s=mail; t=1643101522;
 bh=JAEkA4FCBmQ7T7M+WVau75EdqeDf4MEEr9hE2/l61BA=;
 h=Date:From:To:Subject:From;
 b=lbMLB4V4+cpmWNfLaSviskk5MrcY52waOnNxwzjhLT6o3Wrq3H5pzs9mr7YZERBOr
 30B9VKbfHMIrWNa3acOw4Rv25aNKlr0cl5QdnZebDC65zrq+0Kuz0ySYEVSckA9qF4
 q9UNCXkd9qWh2iKlMTJFlB9GAqT5T1En6iz4UhKTXL3V3OTXfwJEdl6709oQqJxQgf
 3Spzr2O8Qv6tvJ2kvmKfzUIkdXwrxSHzhnqncrMVe/ZLuSBkwcXZTOeDnPBqLT7m72
 sdfoMTlfbNZ/iZ24zSilAdkT1tdJ8TB7b0KKvuXfQmKbMNcKP7Mtsjy1ZBHK6mwBaq
 SJs8iZRhEIEeQ==
Received: by mail.belongsenergy.pl for <linux-nvme@lists.infradead.org>;
 Tue, 25 Jan 2022 09:05:20 GMT
Message-ID: <20220125074500-0.1.7.26m.0.ta64wj8og2@belongsenergy.pl>
Date: Tue, 25 Jan 2022 09:05:20 GMT
From: "Maciej Nitycz" <maciej.nitycz@belongsenergy.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.belongsenergy.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_010538_803073_F11D59D5 
X-CRM114-Status: UNSURE (   2.58  )
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
Maciej Nitycz

