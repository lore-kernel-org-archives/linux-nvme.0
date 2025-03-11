Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7E0C28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5Ag/W9YjfbFJOGLdiTXWgO7Nle+kHbv1rgCfGcU2GBw=; b=k0cifJl5ZaIlyly+EXLV4MGqG8
	iW+tkr4P0g2dbF1u5hzYZQRAGKBnO8qBjp/LdnPZ9UIonXUc/Pbxi+nUAN9SaMsOTq6MicLYy5V8w
	EZukHSfgbHLQLOMjr3jfUl9LwHrT0d0ZhSyunQAj2bkd+uc3KASYj/cijq5OA4Z4Hf6LCTjlE6qCh
	zHZqs0lbKnMdR8txph57saO3lZPRyWgzBqSVsSEFHJO5c2RJ6fkOqriwAnwg6i4vwgZ2OaD6EXYaB
	Q1qAI82l/ePGBUFfnCHQVv/vRSwzx5TgUixUzlb+ZHT7+BMt/TJyZEZO9NqhZC5g3sAP+bO6QoV18
	gfHl7tGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trvQ0-000000053eB-0YLM;
	Tue, 11 Mar 2025 08:56:56 +0000
Received: from mail.commetrax.com ([141.95.18.165])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trvPw-000000053c1-1Kkg
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 08:56:54 +0000
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id B9DAA23D23; Tue, 11 Mar 2025 09:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1741683351;
	bh=5Ag/W9YjfbFJOGLdiTXWgO7Nle+kHbv1rgCfGcU2GBw=;
	h=Date:From:To:Subject:From;
	b=V4dYFet6wFAs+5AuY3RJr03CtdPdewkgShMmVnCFv5/9bxl68VKlRAMIJI32S3NeF
	 ROBJ1dRXMdQmIUXExYuApqU2Mg4t/CAmAHMcIeC/D8F/zWHMWOIcWTnl7vyakKCQ5v
	 xsNuLYS25fi30bsvrQMW/OQ29rLFTI6ODkGj3JDnPxehLquUdKP72fSLSP6CD7l7O4
	 0kr16+1Tfrpgt2hfJKMHh7Hwib6/Y6HlLGc+gWW5rn6bDkUkNxZb3fS3e+KNmvBouc
	 sSvne/Bj0vLMgfOLY/51HQxSaEK7OIlLrFpkWZkoiVCyNvoZZnO9A/HZlzYUZq9QVl
	 wV96CWrK+HVCg==
Received: by mail.commetrax.com for <linux-nvme@lists.infradead.org>; Tue, 11 Mar 2025 08:55:48 GMT
Message-ID: <20250311084500-0.1.8c.oww5.0.x6xld9oql1@commetrax.com>
Date: Tue, 11 Mar 2025 08:55:48 GMT
From: "Vincenc Turek" <vincenc.turek@commetrax.com>
To: <linux-nvme@lists.infradead.org>
Subject: Message from production
X-Mailer: mail.commetrax.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_015653_045997_6F17F2C1 
X-CRM114-Status: UNSURE (   2.20  )
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

Hello,

We specialize in manufacturing packaging for the food industry, such as t=
hose for ketchup, mustard, and sauces.

We also offer solutions for household and construction chemicals =E2=80=93=
 packaging in various sizes and shapes to meet your requirements.

Our products are durable and resistant to damage, ensuring faster and has=
sle-free transportation of your goods.

How about a short presentation of our offer?


Best regards
Vincenc Turek

