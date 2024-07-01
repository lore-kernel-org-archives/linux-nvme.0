Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06E5C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=; b=GkEfwCM0A5zQLUR6y6Bgc3OeQJ
	vCarLDnM+m7nzoVeNUdjWwAydrkiZ1Ga6rKONLd9TWcSmCJ3uvKO/j9SKA0rfYl2xHztPWZ3EMiCv
	XF8jnLMJPdD7KNgJvgIxrk4Fc0fZcychUQkM8PwRxYvLZ5hAVro5QcE8E44isjwkGV947vXbvfivo
	sYoa6R7JMCV4KcaoJ201ZlJBLNZY+VxzPoBXy4Lv4eliU2K8C0epMNmkOsLsOBxL91JgQwzltETRI
	Arw4+T5nJmvqpk0jYAzzy70fpMy4Pwts16lLBPz6vEMzCOsuy74TsOrfXZnngBkiUiNSXnXizbVJE
	ZdOyZ9TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBeY-00000002544-17IR;
	Mon, 01 Jul 2024 07:40:46 +0000
Received: from mail.envisioncraftsman.com ([162.19.67.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBeV-0000000251Q-1ZEN
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:40:44 +0000
Received: by mail.envisioncraftsman.com (Postfix, from userid 1002)
	id 193A8218C3; Mon,  1 Jul 2024 09:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=envisioncraftsman.com; s=mail; t=1719819642;
	bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=;
	h=Date:From:To:Subject:From;
	b=DJmMkj4xs873AFDkZivQtqd/MeAV0mWbx4ZsC9Z+mUxsOQC3aqed/oRMz/Zz1tP/o
	 t8iLHnxCXBCUqlvmZgxUpD1Me7cKk8uzHF46KPHrcxLaoNO0WzN3VRYKQSULg0Hovi
	 +ausptnwBIpNBXEY7Po5sXsPCL+5YIb8Oe8/I7YeSiAecYzCRiRnppoKtZtZVbnKi3
	 zbZMxPibaHgGUPFABGbgnBbYOeIo1NJX4foZ1tYZZi4bUukImdr12KFGJsBcKpNztM
	 nSqFf70mUGL8hHkbWZqll4fOaOWkd/Dtcngb2XqbX5rFuowNkhjJlnzWri1JSTv4FE
	 3nkudsSLTgwOA==
Received: by mail.envisioncraftsman.com for <linux-nvme@lists.infradead.org>; Mon,  1 Jul 2024 07:40:29 GMT
Message-ID: <20240701084500-0.1.3j.na26.0.1dg39oe4g3@envisioncraftsman.com>
Date: Mon,  1 Jul 2024 07:40:29 GMT
From: =?UTF-8?Q?"Jan_Pol=C3=A1=C5=A1ek"?= <jan.polasek@envisioncraftsman.com>
To: <linux-nvme@lists.infradead.org>
Subject: Quick Question About Collaboration
X-Mailer: mail.envisioncraftsman.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_004043_606315_6C6B8F54 
X-CRM114-Status: UNSURE (   3.33  )
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

Hello!

I am very impressed with the products and services you offer.

I thought we could help you reach a larger audience with your offerings. =
Would you be interested in collaborating with us in an affiliate marketin=
g campaign?

For example, our program for a company in the e-commerce sector resulted =
in an increase in revenue from 8% to an impressive 19% (on average per qu=
arter).

We achieve up to 13% turnover in GA4, while standard affiliate networks g=
enerate only 3-6%.

Would you have time for a short conversation in the next few days?


Best regards
Jan Pol=C3=A1=C5=A1ek

