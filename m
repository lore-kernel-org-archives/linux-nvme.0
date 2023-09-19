Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BBDEE0215
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=; b=qR2A+7V2902IdJ5dW4AH4M9+ru
	GWoncuObKQPFEfGrbfYOar5yppubjAzjvcDKMZ7kEILP3xVx5xCVsjEv3EGnbaKKeKGw1Lg1l9EiR
	PUgPMXraBh44ktbwxlTpWuac3Q8S5D9oi8HTDW/gd2e2lpEblINKGc4X9eXvCNYn417UKNEVeCqmV
	2b8eQ7Jy7LMTXvEh6lYu0JN1oV1cmBhhWNagoC6Px4D56SMzHSLlQTInSVVTOEyI0bd2xHdAcppLC
	QD19jMsndJsICKpM6sUyeCKLY1Yxs2IzS3H6LljplGWdyhHu6u2SHEfllBJ7qoiji3u+gIZ+AdBQ3
	8MRl0mZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiVBw-00HElT-0E;
	Tue, 19 Sep 2023 07:30:40 +0000
Received: from mail.leeswilly.pl ([89.116.26.225])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiVBt-00HEkE-1h
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 07:30:38 +0000
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
	id 4B0577612D5; Tue, 19 Sep 2023 09:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
	t=1695108636; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
	h=Date:From:To:Subject:From;
	b=EHEA0ZCEg4no0zqUj5e7Lj0ZcgtGVKbi9yMswqcTrAUGH6tXOTrAGZBSeMpDfbGKz
	 fKxyh4PeJTIsnT1XkOKhJlSC1A9i6Y7jwu7LTa9OY2q2dypu8DGN0DZybAo8t9iqBD
	 pZLEu8HS2ncrO8Mn6hETQW1PV5FW7jxcUQJ58jglJBiFJ+4pkGV942DkGTivo8nSZq
	 6cEfc02ZgXQwqqKi6NAXwMfgvzdvmMd6KCbo3bS/KMqIR1D3Tr1r592tvRDphwPt5u
	 VaW0eqwevvjH1kDLaP4tXXkg1RCQeZEBvqtDh2OiZwIZfZkG2nD/BgKn2bFFW2W7e2
	 JVgBwJjkB4i8w==
Received: by mail.leeswilly.pl for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 07:30:18 GMT
Message-ID: <20230919084500-0.1.3z.bbgv.0.dsd2obxm21@leeswilly.pl>
Date: Tue, 19 Sep 2023 07:30:18 GMT
From: "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_003037_711510_7E966849 
X-CRM114-Status: UNSURE (   2.33  )
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

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak

