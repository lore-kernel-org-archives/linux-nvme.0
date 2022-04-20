Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30550C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=; b=XONtOPj/i/tV0bVt6+dg0PmVii
	3BitODi4pZX7djFbQnYtVlOwB1ezmkXow2LYGJtwzg8oqVekO0tC3781cf9NCGUXww1ad/uDNdvea
	m9gLeDj3MwF+xmbcOBePCTuqNLYfpwPK675NfnlN8xwqeNlPWysY1uA0g3p36YYtM9sCf6Qyo9FVF
	pMZKaL+0XbHK8i0txYjQNQSGIxWMpotRyyIJXxeu84qRaYxstxClz0cfjS7FzRIGiQvhS5BHeRonK
	oGd+WyC/nmIRnty6M2ROHIveydgw+2NEzXgwFJZuTOjSM5E/X0qa3yqXEc75a6VhkeYr+x/RMNihl
	KmxzbLcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh4zs-007qVd-R1; Wed, 20 Apr 2022 07:43:32 +0000
Received: from mail.fixingbiz.pl ([217.61.22.139])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh4zU-007qJV-Gl
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 07:43:12 +0000
Received: by mail.fixingbiz.pl (Postfix, from userid 1001)
 id 7F766A2AD4; Wed, 20 Apr 2022 08:41:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixingbiz.pl; s=mail;
 t=1650440557; bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=;
 h=Date:From:To:Subject:From;
 b=YTfuoAleBS0dwdt2Jjd7JeOSk2G9cOb2aNTDsUsD5inePdDP8f+QKZIid5ZIWYBsD
 +ishd43Y+dgKnyMPsbJl63dmmYRZOfzysO00w3Km7c+NPoYhme7CljRnEx30JbfYY0
 pR57qL+r/w/rhVtxpMtE0bAyfwPnO50zE7/KusPOfu4mjUF3hcClL3uehfi1KGVlfD
 h3Gx2kjZQA/VWfUXG4kabcXNg2gEtpr9+b0jnxnZ3vl4qHN83Cdy30U8vfeuXU0NRz
 20nN5PGyDWdQE9dPIZc/1JNvVHpOOUWOHF1IcWf80Nvs/wuxIRU9xfwUSEodIdzd5T
 /lUOtRXyhxsRA==
Received: by mail.fixingbiz.pl for <linux-nvme@lists.infradead.org>;
 Wed, 20 Apr 2022 07:40:53 GMT
Message-ID: <20220420074501-0.1.1x.6tna.0.1v1m9emtbw@fixingbiz.pl>
Date: Wed, 20 Apr 2022 07:40:53 GMT
From: =?UTF-8?Q?"Przemys=C5=82aw_Wr=C3=B3blewski"?=
 <przemyslaw.wroblewski@fixingbiz.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.fixingbiz.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_004308_742567_5E1B0E82 
X-CRM114-Status: UNSURE (   3.01  )
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
Przemys=C5=82aw Wr=C3=B3blewski

