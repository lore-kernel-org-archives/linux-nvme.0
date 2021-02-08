Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 00:52:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5CB64E5A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 00:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5CB64E5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Message-ID:Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Subject:
	From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=66PrEstY2JylbigENQ7t5qnioKFZ+UQTlDKpyufrwdE=; b=1mjEo5t/ioG8g+eIMNkmovkM9E
	JsszOwho4noj9mtoYPTPEI2K5WpcgXPD86JkgCJ7eTRzaUAPdGaDaA8ghQ5w6H0hlVBL1oE8WuKKg
	hqlKoBg5CC5BH63PwCAXyLOTNYuHaWCFnJWCJN9SaByIjJP68kjbWJ4Ep8Uh4c8nuZF0snE3GBvVa
	utua7+90tRZFOfluyQzxaoQdZJDMzwpPDGNYZ8TIekSXfVLWTvoEQ8AgfC0rrmYV0guUoi2KmMQjs
	fOhHBuAtHOTM2SueSfRUBBakBlqmMdgHQQhvRPQ3NXXdi5s9/cKbOufPL2WXjuA80J5zj71IFTXMM
	5fRWhS3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8umj-0003O4-CT; Mon, 08 Feb 2021 00:52:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8umg-0003Nh-IS
 for linux-nvme@merlin.infradead.org; Mon, 08 Feb 2021 00:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Date:Reply-To:Content-Type:To:Subject:
 From:Sender:Message-ID:Cc:MIME-Version:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=22PjdP3HY0tZzoW6pHULZs18Ep/qcWy+gXqf0IurJHM=; b=LdiLz1Ws8VlAERB9lK2Jkevmph
 aT8HXslfZ/oLAOyzp2uR+2RKu3ipHs30fsKM7tyvjWWWC1HE2n9eNxV/iWElVNUDqOsnqGejOehB5
 CLkSrBEcxESbxupDyCA0mF6EFe9kMP3nUYcT27+4bibstR2RB+EQRMrZ6Wd+bBcuZf4fBgZRK2rnj
 3er5ejIhyUzlu/bAWYpOk1DaJ0Eaq4D5lHSUJLAkrHDN6lxerCks6ztP73TPGDkrcAPA77sRpd5zV
 zepvNWQf4mUTFnIcK4ottrgLXXXwAgdB0unKBEqBZ4XExRn2Qy8JHKS9lHGfVowmdBqw0asi2sjpp
 h4UvEkQw==;
Received: from [209.141.46.27] (helo=50uj302.com)
 by casper.infradead.org with smtp (Exim 4.94 #2 (Red Hat Linux))
 id 1l8umd-005JEu-AP
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 00:52:08 +0000
From: "Ms. Kim Chan" <mskmchanouk@gmail.com>
Subject: Investment research about your country
To: linux-nvme@lists.infradead.org
Date: Mon, 8 Feb 2021 07:52:07 +0700
X-Priority: 3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_005208_985176_37D56562 
X-CRM114-Status: UNSURE (  -4.11  )
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
Reply-To: "Ms. Kim Chan" <mskmchanouk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Message-ID: <E1l8umj-0003O4-CT@merlin.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

My name is Ms. Kim Chan Ouk, A Thai citizen in Asian Continent but currently
residing in abroad, I trust this email meets you in good health, I just got
your contact today during a research about your country and I will say that
I foresee success of my future investment ventures in your country. I want
to invest in your country and I would like you to assist me in my investment
my investment Please do reply me as soon as possible so
we can discuss more.

I look forward to hear from you soon
mskmchanouk@gmail.com

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
