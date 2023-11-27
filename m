Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0EFC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=; b=FAxqNWD0T8HOOW2Ffw32YIYGjV
	k8tHkv5uE7/OLQIHoQLmECtcINuoBabZGrhSHNcQ8bVACUfA0OWBsFyebX+pMthXfIU9kfaQzXWiT
	I6QW97zdKdH50g2wWP459qShUPgzt0pLxk/hO2sT8FrqFWN0icZlLJO1RSYUy/Rz4MdVACN2LSHO6
	bQwjxna4AGINd/+NDZgsHVIdcGLZ6yj9L9QQZA8uLvn0/LRDT1c6lqIJk+gZLYRbklCZwD3IgGaka
	7Zr0y2ezltwsddTgWqpgWIzDL7J7/huWSik9gqB+f34xo0xVkfRQcZkfWCziAw2N4QsRFYvE0LOFY
	0C+1fw8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Xa8-001vLF-1m;
	Mon, 27 Nov 2023 09:07:08 +0000
Received: from mail.thrivehub.pl ([164.132.48.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Xa6-001vJm-0Q
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 09:07:07 +0000
Received: by mail.thrivehub.pl (Postfix, from userid 1002)
	id 157C625085; Mon, 27 Nov 2023 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thrivehub.pl; s=mail;
	t=1701075977; bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=;
	h=Date:From:To:Subject:From;
	b=Ztgk8VT3+637kJSrWYDA3uqrKBXzxQSq0PYzU5zER+gYCExoFjh8EQ8bV2pVkDRJv
	 fZ7xTZ0w20xw9hOYYLHDY9uhUgqhmZw5mlsqsP9VM3qcF5HL+ivT1KUYmbY0Br4bjQ
	 bwwKRDpxz4/vhZQ5NFq5ivpjUmMZrJwR7dlj5MZhwAgFgoSWypgPNnYBJfWW9/inNp
	 xt804zk5IvON+W1DLKLhyOaQG5FKyiv0M+svyF3395YLuEb+X47GJMCzBwE5pS6Z7d
	 xLCMNTmCSV3rdNlvUpxIFroD5jyQjLWtN6QM2/XHaHmSxbYym1o9p+U7/7e2+ITCIz
	 6FePA9SCyINXA==
Received: by mail.thrivehub.pl for <linux-nvme@lists.infradead.org>; Mon, 27 Nov 2023 09:05:02 GMT
Message-ID: <20231127074500-0.1.35.1bpff.0.per6ihaklo@thrivehub.pl>
Date: Mon, 27 Nov 2023 09:05:02 GMT
From: "Szymon Jankowski" <szymon.jankowski@thrivehub.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.thrivehub.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_010706_315890_C45DA124 
X-CRM114-Status: UNSURE (   2.35  )
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

Pozwoli=C5=82em sobie na kontakt, poniewa=C5=BC jestem zainteresowany wer=
yfikacj=C4=85 mo=C5=BCliwo=C5=9Bci nawi=C4=85zania wsp=C3=B3=C5=82pracy.

Wspieramy firmy w pozyskiwaniu nowych klient=C3=B3w biznesowych.

Czy mo=C5=BCemy porozmawia=C4=87 w celu przedstawienia szczeg=C3=B3=C5=82=
owych informacji?=20


Pozdrawiam
Szymon Jankowski

