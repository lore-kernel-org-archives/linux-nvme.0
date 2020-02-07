Return-Path: <SRS0=sB0J=33=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1BC352A2
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2020 12:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1CF20715
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2020 12:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ks9cqKKA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Qe1Vi1x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1CF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4Hm3tSfoM2tevi9QPSCShvJAY87LXtPcuMrZvYjPLnc=; b=ks9cqKKAI9Do0o
	MqU58erO1UHYK3JC7bA7W9dGX+V2QCD/nyhfhyxeKFBFKU9uFMBFZX95AFYPix5+yAJI323ylyoHl
	x9lbqErJruyj3CTUsc+gz/dx9cC002YoeU7cUWpQVoI0xm8YWfoFsQnNTiB99oB0DWt2tnquNbk+X
	hufVNJDa/dqtZ8XGZoaQ8U1+OTnA4haCiolfnZmSaY3/mAlfDq304z2XHChHdR/AXAqjrAxHXOXs4
	E63vjbJYd9Zzfes99kPAOb3rQpj7CAgAotdKlelS26+QfzzrhSYYjXjOBq/WajxGBdc7Ds8KBRejp
	7MdVM2XMGuGeG61F/zIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j02yt-0002zA-Gg; Fri, 07 Feb 2020 12:43:35 +0000
Received: from forward104j.mail.yandex.net ([5.45.198.247])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j02yp-0002yd-AY
 for linux-nvme@lists.infradead.org; Fri, 07 Feb 2020 12:43:34 +0000
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
 by forward104j.mail.yandex.net (Yandex) with ESMTP id C1BD44A0295
 for <linux-nvme@lists.infradead.org>; Fri,  7 Feb 2020 15:43:22 +0300 (MSK)
Received: from mxback5q.mail.yandex.net (mxback5q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:1ba:0:640:b716:ad89])
 by forward102q.mail.yandex.net (Yandex) with ESMTP id BB32D7F20015
 for <linux-nvme@lists.infradead.org>; Fri,  7 Feb 2020 15:43:22 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback5q.mail.yandex.net (mxback/Yandex) with ESMTP id 2W5cjNcdkq-hMtO2EDo; 
 Fri, 07 Feb 2020 15:43:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1581079402; bh=Gc0IQXvVVktZ0OANqtpwv+BZpgzp1rGayfa1jGe6u5E=;
 h=Message-Id:Date:Subject:To:From;
 b=Qe1Vi1x+zJ/rxB0hdjQTa6iHBsmlIB19HcORWAk0crSDOtmoxYfTKDdd5bHAwKqUk
 QgPnDz3+31kZwMZCpeWK3W0N9RNpCAMT4yXPiztnjpOj8RWNM9q0teeAl8CSNiNxDt
 8H+dluQLuGyH1MUAJ9Il2zmBeJbZIn2qevlO9zHA=
Authentication-Results: mxback5q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-9d01d86ae0b7.qloud-c.yandex.net with HTTP;
 Fri, 07 Feb 2020 15:43:22 +0300
From: Talker Alex <alextalker@yandex.ru>
Envelope-From: alextalker@yandex.ru
To: linux-nvme@lists.infradead.org
Subject: NVMe/IB support
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 07 Feb 2020 15:43:22 +0300
Message-Id: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200207_044331_725362_9218B100 
X-CRM114-Status: UNSURE (   3.07  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

is there really exist NVMe/IB solutions?
I noticed that ConfigFS in target driver permit InfiniBand address type
but it's no use for any driver, except maybe as a referral.

Does anyone has an use-case for it or this one can be safely ignored for now?
And if you have a production referral example, please be so kind as to share it(the ConfigFS values).

------------------
Best regards,
Alex

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
