Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E986C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:From:Date:Subject:To:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EiUayvCSzHvplsIgOumzmpTACl2FZuRXDiVQZs5k2dc=; b=a7CVPa0H/sG2t62bzGQeprhKQn
	clnzYIelW7Qo8FEi8BiZ0+5eOfzMOrj0WZIMcUZlwuDzBiYHx0Dqw6uXWuS5sefeGb3jhJKXZldib
	NT/XwFH9bYvZ0jOlF9osa3E61vxntj3VzxfKi8dq22WYtvymSd8tH/neC2C3PmytxxN7RQczHlexP
	+zJ8fKnHokK5YxQUeLeDTIezI8i9PGvzyex6RZCrtzB0KflHdVHA/z7IeRFrpy5xiJWkVUCWp1QPq
	ypndbGwEgrebtF5EsUxQNSkmCReYimEm3fEpA3IXNKbsdcYnJ1yDRk4eGb1lZjtJoabxAQbR0pX3u
	BqXP61tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUOL-00BXbE-5h; Tue, 06 Sep 2022 08:57:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUOJ-00BXYQ-3l
	for linux-nvme@bombadil.infradead.org; Tue, 06 Sep 2022 08:57:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:From:Date:Subject:To:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EiUayvCSzHvplsIgOumzmpTACl2FZuRXDiVQZs5k2dc=; b=jjVPoth2nytorEsZz1+WSX2+m8
	94P/0qKARZRyA0p7p3yam/OppRwflynbyTJDYhXrR/1ZA/NCsYFcAlZBdk+Cl82TVQ498TLkxP4+h
	3G/166hEUELGxRe8kBIlKeKsKrhlmE47HtwD84YXPIRfEOm1g6umShG8HPqfcHXS1KGDUaC9eB0Mb
	vZDvI65s7MZm4Vm2H75AN3tbd+IYBvStx+PHrEFpk4OBPfqkn3RThE9ZZnzHKzQow1+JKLvljX3US
	qPy4S6VBxegznXzt9C+tX+NVBk6fdvIw96dwXh6p2oXpnZW4MouHcX9ZiP8aJ3jg3rKvkb8DBfZV5
	IcBpXWDQ==;
Received: from www3079.sakura.ne.jp ([49.212.207.89])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUOF-00AFSS-OX
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 08:57:06 +0000
Received: from www3079.sakura.ne.jp (localhost [127.0.0.1])
	by www3079.sakura.ne.jp (8.16.1/8.16.1) with ESMTP id 2868uDvD034527
	for <linux-nvme@lists.infradead.org>; Tue, 6 Sep 2022 17:56:13 +0900 (JST)
	(envelope-from daycoltd@www3079.sakura.ne.jp)
Received: (from daycoltd@localhost)
	by www3079.sakura.ne.jp (8.16.1/8.16.1/Submit) id 2868uDO4034526;
	Tue, 6 Sep 2022 17:56:13 +0900 (JST)
	(envelope-from daycoltd)
To: linux-nvme@lists.infradead.org
Subject: =?UTF-8?B?44GK5ZWP44GE5ZCI44Gb44GC44KK44GM44Go44GG44GU44GW44GE44G+44GX?=  =?UTF-8?B?44Gf44CC?=
Date: Tue, 6 Sep 2022 08:56:13 +0000
From: Richardkeeve <linux-nvme@lists.infradead.org>
Message-ID: <f5504b6d8200e12985147c1aa4b78f8e@daycoltd.com>
X-Mailer: PHPMailer 5.2.22 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_095704_303868_79675B96 
X-CRM114-Status: UNSURE (   0.82  )
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

 Richardkeeve様

下記の内容にてお問い合せを受け付けましたので、
ご確認をお願いいたします。

メッセージ本文:
Bitcoin Inside App >>>  http://inside-bar-crypto.beautifulghost.com/id-2088   <<<

--
尚、このメールは自動で送信されております、
直接返信されないようお願いいたします。


