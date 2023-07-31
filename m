Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688C6C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lVLcZTXcl+LT1xB5JKh70mgOl4t/pfMP6F2K3RX3WCA=; b=sP5/q8UyAVh42K9dMRrheBFsMK
	tO2fIfXBib7wDRGrcuJA/q9n6+wOOn2FaeceEkToHrEyUJeNH9UMfjv+mgtpTuH+xi7nS5XEldkDp
	sBnbVc9aBDYXJ2iTwKbbFkQOQHd8PZ3wI5zHu6LxloLsU2OUO27jDuApj9DIEW4emBMh0XPG1FbKY
	oYVpjRyb2XyPvfftjmklPx54ZgNw8fgjYXVNMMnJpu/5Ildi6QJ85d/odhh2w0PYX0Q0RU8C2E3K9
	GwDFJjgx3Qf6UhukoEoxyzC0rn6rbLn3yD0j5uNA2X9wI99YdFsHKTAgWoFCkl4gIjB7dZzgzl48d
	4guwjpJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWyc-00Gt5K-2W;
	Mon, 31 Jul 2023 17:46:38 +0000
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWyZ-00Gt4h-2F
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 17:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690825586; x=1691430386; i=markus.elfring@web.de;
 bh=lVLcZTXcl+LT1xB5JKh70mgOl4t/pfMP6F2K3RX3WCA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kgwU/sc6qZw/X8h1EVFWwL6YiWchkro2Xy0QYUXQIK1JGwN4GeKzK+W6K2yQ6n92VgTXXln
 WHzVOkzZA6QXftzg9pvcDINWEKi/o28BSiDuYVuqohP1iw8DDjopsgDHCEb64RBlAZXk90PmF
 fH2RrwsNzXRQcfAVC6z4DFV/w+b8DAhKBEhQpZvTcpJVKwFr6tDi/BmuYbF9KfTecCk0xlVrg
 En8O8/7PgT2x0BiOhBRdmWugRhTvT13U0ymYnDHyoqbZpbAXeLa5AUK+fO+n1K+vwAwmbGnG1
 gEAr/M+aBS//V11GdSqeZRw0xd77lMnfVq0l7CESxhvgHOl3+k6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1qBb7M2IXW-00NuIl; Mon, 31
 Jul 2023 19:46:26 +0200
Message-ID: <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de>
Date: Mon, 31 Jul 2023 19:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>, Hannes Reinecke <hare@suse.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, LKML <linux-kernel@vger.kernel.org>
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de> <20230731135152.GA6016@lst.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230731135152.GA6016@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kq34+iH/MWqKQfoawGm9S655bIDAVa0wk/hvLgaCvzf2wqBdPzT
 qL9mnBhglKEA+vQ2OKGQtxu4M3TaVToXf1zt9pSvdKFXmBF+Eb/4y1kSaXfNMLiNn5Jn5kd
 xA8svzbClCj4fkMaamCYpLgUR9b4aHj38smqYyr/Sf3zrFUVax4zkcpVmxhN87Hp8LgEhpQ
 ALRfYHBAt7IuQ3m7OOWQg==
UI-OutboundReport: notjunk:1;M01:P0:5IEirzbBHkg=;tVjA9wxDFDZ6LMhVXYochVtkk4F
 CczrRHXKO7EI47ebIrtueCQFztUJYSAjd0/c182vpOuXa95LBoOMcaiZtxJQneWtYm6xrTxZd
 wiv3xUQV+ZInp7ww0z0cS/dP6VyGLzyGyIoknV9yl4jX/MLKLbDwe2Tf7dBlYFK2wSSTBlZe3
 Gnseza0VUsVlPCS8hFoS2ev7ltNrX6lpdGMkHs79mJyf9fMYTV01Wg52P22IrF5LFrOwJVPry
 ZVkgJnd1JiIVzAbIyfUso6ZQOdhxD/FKgstU9Ie+s7rvdxIFtVlZ7+1pNcNF3vGUrrrXQ1QnY
 WAZkP4TgjYviL6r0Bh/1JkBSGoPEBAdy9kf6ACqGFfNxXCNL841b1DmZz5mZsv6n4ZTUVj8LK
 sWxhXkV9IfhU1TXw/dJ0GTCU5l0cZgyeUsi2I2znV/FB3+S5LDq1E3QQVIRxKc9si1Z++rgcd
 1PfyfX73neqCMrKP1LEZcVcMdkc+hPEiBvTfmfcG5fCiGaE0KIJMRcJsWvg7rgcN0jxZcrZrc
 wrSwTiHcYJYUXYxqfDjumGsyXfAWiTiOsp8yihBJjpeCcc30qyMT4x8CwpRtIYW2peGe8IzmK
 I4uzH3DgIH4YIUVZ+D15b/jwPrJISb51qNE5al4ufsUsLJB5x63KQx/Zc92169XRy4eAVo9R+
 p+h9bukp50va8rkKE3dLR3c7cGDIlP1VN0sQ2K1Bj27bBZMtAGprOGfLsw0S/keWS4ZpvPl7V
 o5UsmvLiXF/G7PM0gplxNcv368i1WtzBhrvxby1c4K6moEmdSGElageC0RtfFlZVt3XrtE8j0
 gsEn0Q7NUNKGoqnxxx+RBAll2Z8mfU7UQpPEcI0biwSBCYI4ajFOO3JAGZg/02oFk34lQDoHw
 XJCC9UQ8IcbfcmOrxsBxYbjJjDFyHTv4LfUSqS7KP3pGgzRa3cXWZy+0qqdOTceLMmTRd1wzf
 Zq/qNHm8HThSQ6aNfKQAUwgMBoU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_104636_179271_07D5CD23 
X-CRM114-Status: UNSURE (   7.25  )
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

>> Are imperative change descriptions still preferred?
>
> It doesn't fucking matter.

Do you exaggerate here?

If not:
Does such a feedback really indicate that you would intentionally like to
disagree with specific requirements from the Linux development documentati=
on
(for a discussed patch)?


> Please stop spamming nvme contributors.
Why do you interpret a few change suggestions in this direction?

Regards,
Markus

