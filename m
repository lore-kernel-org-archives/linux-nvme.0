Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E7C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42004207DF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wBf8TGgN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZVidWwBA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Op031GQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42004207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:In-Reply-To:Subject:To:From:Reply-To:Cc
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=T1BuVTh+CHZPD4leS3y6oKlmqL83qVOxbp44afrZrCw=; b=wBf8TGgNG8c2cusMW1Uy+wIbfX
	Vw22VdHHJ5sLNPrXvzonSNFHQyn2xWNXFGVGjgqohR1ZBzc+Uxd9OnSRXR+pOTx/9RYpkq7Avqut3
	nHZrOwu7Qa+3XJ4bY/m4HMBwHucMdIsKEjWkE0wJt6XE23HEClHnVwlUxv9+tTrqI+wk1uR9nqONS
	b1pIb0TrjsgvbijBIUoiB/zmczVzULKzzzJ9WecDmpiEXyszJpQwjglpqUiljxgztVPV5cXT2xg2u
	6QPz4YsMqIFzZ8bESww2fTMv198IDfIBsTsP++Xj9v8SpoVjPGoX5SvMQotXQLvy1b8fiuIY0hVnp
	ok+UWFxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtqus-00038I-1J; Fri, 10 Jul 2020 11:10:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtquq-000382-5R
 for linux-nvme@merlin.infradead.org; Fri, 10 Jul 2020 11:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:In-Reply-To:Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding
 :Content-ID:Content-Description:References;
 bh=5oxxYjfESdtW5aLg5nJ+0P8ge58Urpmv4s0OIYFfoWU=; b=ZVidWwBAXkQxOFSW2MKoHX0nrO
 n4lCpkxXuJAboK9SV2mAyzg1qgsZ3yX7k3u1u5BAh69oXRG0lA/kVYNaejvvm33LD9GCGg1dSqZLz
 hnByNRVyujqo2q7/TVCUNAlL7RNmbnxMeeiqJPuo3zRzMsgKqGF05iWaRpLdKI54ZOYX35b/6+JFM
 JwiZjYn2bDfhAynmYUpsSrEQI3UtfHHz2vSgLu/49lm/6fY/j73WnsNlBH3WIux+zAypYqOh24AUK
 EH0BZjhnWYlc1W0/KwAeheAIZn90yzqElNXpgpjKGZDEUow/+RZuvVpW74ehSbEwwbhORjL8bhFI1
 4phiac0A==;
Received: from mout.web.de ([212.227.15.14])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtqul-0005UL-NU
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 11:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1594379389;
 bh=5oxxYjfESdtW5aLg5nJ+0P8ge58Urpmv4s0OIYFfoWU=;
 h=X-UI-Sender-Class:From:To:Subject:In-Reply-To:Date;
 b=Op031GQ7ECo8FqlhZt6TqDuDMzOxu8h2dZkE6rbz0KBJWwJnvmmbYW/JNVB3tqNC5
 17kDBJd49l5a58/eU3+h9cmucuI38hE5VUoP5q+WiTecT+0Xl2OvlAi1G68HiPCtVD
 BI446UB7ByA4B0jB2TH9TYGiCb75XU/W1Pwmtaac=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from ingo ([84.143.242.21]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ldmkd-1kcjkn0grb-00j0sQ for
 <linux-nvme@lists.infradead.org>; Fri, 10 Jul 2020 10:22:18 +0200
From: Ingo Brunberg <ingo_brunberg@web.de>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
In-Reply-To: <20191202155611.21549-1-kbusch@kernel.org> (message from Keith
 Busch on Tue,  3 Dec 2019 00:56:11 +0900)
Date: Fri, 10 Jul 2020 10:22:05 +0200
Message-ID: <m3a707rd8y.fsf@web.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:n/SjQ73w9bbuww197G73EQbKVI3KCSCWuI3+rqI4W/qxm60L6ba
 AxaxGTgIWW+ppbD9NTtMKtrdhrjaW8hBw/ukYIXzr/fvHqhqOCRJ8MyCsBdAYAhr6FQ7B4i
 e2zniQdqgvC6CZnZWPUZlvq7Qe2ZOOfyzkGIU6gRLkpWQKOCzahF9m0qNlWtrOMqKbGV6me
 aCOg2Sa+Nek1sLBth/QGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EhFDBtAtViU=:GbsApYg/yvBoDpLMFaPAgu
 U6J5azCc2A8oibVeJZLdrqt2a+nzu1UuWSpF3gfpI61bW7UHOUl61iCLRByFSeRxs/IsPlUoN
 XmMetGKI+e7ocE+NYAW6m4eYSHOYRK6huBOs7ph7I/OdmGqCQcnBLi4J4M+sBD9jbJAADxsra
 q6lonfEsb9H1lCf/2wcfOQWEpcJwSjwIBVlyRUoQw1gScVJTqBuwfm3Xx/f0RX2Hh9aaTaFFs
 eIXF1gwKw3GzfbO1r30SmJQs9f07gMf8ZVxK85RSiiNQ+D7jYFIMYSl6PN/iyEAZlcAuRq7Tb
 Ai30G7E+tmGx/Hn1jjFieng/Ho+D9H6i9h81IPKtGFPiheZDi+nq5sXUaxI2yT4OM+y27MYFk
 rBssuoypPUqGvuiDPj+pO56HL8IQwdb/FNelWdRaW+X9QCORnTZnOEZjt1vQmgzkQA/dbmg/p
 cVuznsTidKenyNO8ODaxW0jYifJrqnDpSbfD7KLjPE6lQZtNt3BYzcbiOpCQZk2KltM4tQc+8
 6fzPZcSvWMrZOVxjvvui63Q9qqSdIqL9dIIcSzgLhrncZx1kV8wxfRS359S2YgrUyDZ+9v1od
 oY2faiqeOSq6Tvo/q1XmjXyK6VTu30Cjz7FyhzteFqPD2hoATcqp57r4xd9Eeec0Mu1cuHurn
 hvdND3BryWTVqRq3ergSq+jnygiQqFuZMmGj9An82ZX1Ejivct0hf0c+fVfVSxjUoU+ywSYJ5
 T2ZVL+flnwZaOqv7tDT80RFEVNb7jAWPbrA/vpdU9ltdqskMOTSQocQ6TnUa427TeqUbo5nch
 jNvxGNAHZY0FOUDrfPpy5mWQC0coeQ6VMMdmuSHlo+TNxF6/OKTjM8Mxqu8R+lSMwlNICu6FP
 KGarnpip6RqjTU3HyGwH1TstBO+ogiMI71WF5qws/S6Yebv9Kt78twhMnJdcMFmD854pYtvkR
 skOYfK42yhcv359nZf+Xpr1mgvPMTwJYv996lb6qqCO2EBhYVYpOa+x0Xl3tzGI6TT4G+zeGn
 W9QWtRc8Aemm1y00N0KKhAB2G+rEFRlnkmFqWG/Hef4HJn9ulcEw09cNdWyLr9Xw7M9CjJJyE
 P8SXq2PBNhGrj8F1uovZHqKQqd7A8PfBOx9iXBdTyPLa3c8gtRMAh8rv6bXB84rqNvmxwTUgt
 8jcrHQUkZItClYOOA6jOvc5+NtLrvZR+TYTjCn7kfFlnPmUxidM+zaE4p+R9o+mckOmaeD5kv
 ftFHTEVNFGN1AwUwHe57FlekTLb6ezvLfaOCpzQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_121000_475325_6E467D70 
X-CRM114-Status: UNSURE (   4.35  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With commit ea43d97, appearing now in kernel 5.7.8, you made my cheap
SSD disfunctional again. For reference, see bug 205679. Maybe you
remember the discussion.

I do not know if this was intentional or not. Maybe you should introduce
a quirk for that particular controller.

Regards
Ingo Brunberg

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
