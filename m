Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B79C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=07NAgW1e0WiNB9zqagiM2BnwZfWBCpNa2E4+ccxBPgw=; b=CpDRlarQGLHY4iDQTGLPqoy8WH
	l8BK8QgAWvGk717A0fN0j0r0cvNoR09rUETlmm61Bxk6J8e4RlKFgq0j7fa29OjwR1f5z/UnOSSFg
	x5kgMj8adOfXWP+9Ow5SFn0QmE5S4LzaPGTAknYT8xexEF6xJcX2Tcl/JZ+3Ltj/4grAKbVmWlIXj
	9+izb+YvmL1I+EEBaUQTzsvtA7B7EpsHUlf01u3fAOqJFIKjU8MFMaIBTFmjRtS8FjPuxOEMn7SMP
	D6gItTsQmdRVaV1f0QLszqCmvo3842qQURpTqWQqZW/HcvmypLLNFkR29NxLGsW1niqIYiWLJHXrL
	kZLiIS0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNVhW-003rYY-9I; Fri, 25 Feb 2022 08:11:42 +0000
Received: from mail.powerangels.com.pl ([45.86.209.159])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNVQO-003isP-0p
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 07:54:02 +0000
Received: by mail.powerangels.com.pl (Postfix, from userid 1001)
 id A1C0E8372B; Fri, 25 Feb 2022 02:45:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=powerangels.com.pl;
 s=mail; t=1645775182;
 bh=07NAgW1e0WiNB9zqagiM2BnwZfWBCpNa2E4+ccxBPgw=;
 h=Date:From:To:Subject:From;
 b=mTzGvhAQ96yqGsidV+yono6ltPXqaoiZTzwCMxS73kTpR6KphbXOwV4nN3X2D27M+
 Kdu9WH3cGJFH0DQveK/a8RKuRumGbDng+U8ngZjkn25Yo8L7aN506EHa5HJ5kxM6JI
 he4CMAaVMmRWsxsDDX4XHxFfBvnUSvPspFY10cr+z9gxYcpaHZEQASnScC+2c9jGpi
 Fa+rpaQkbCbLQRreH/TSkpDRrVBuFUTYqOHROOM2MSxSQSKQc5zYGxfcLSmoTV9awK
 t9YxKZ/J1AGQO7/0/EDUuAJPElDUjZ5kU9oWvLiUEfoMwphn+TEoKn+0kpPpz/jpl1
 pAGtAysKpuaEg==
Received: by mail.powerangels.com.pl for <linux-nvme@lists.infradead.org>;
 Fri, 25 Feb 2022 07:45:21 GMT
Message-ID: <20220225024500-0.1.j.20g0.0.hlqqmapigo@powerangels.com.pl>
Date: Fri, 25 Feb 2022 07:45:21 GMT
From: "Jakub Daroch" <jakub.daroch@powerangels.com.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.powerangels.com.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_235400_153373_4CA219A7 
X-CRM114-Status: UNSURE (   2.23  )
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
Jakub Daroch

