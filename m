Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB2DC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N1067cOhOJ5NVn4AleLhLFYR/IVIQqj54Jss9IVwBqg=; b=0FWUYCsgSAfex5KFMp1KNbEu1Q
	sIHewziMf/jGoBzILeGMjH9NMmlevrcd9u0acfnP3q9DQweFGxtgWcJluCTUjbiiMpHxUwCK5oge1
	mTfBqcEPW9HnV+TZG6QL2Tdai7KDB2QxQ3lWjt6jNr+sDshFE10G104pPSibJ5nuBL6rUwVfGkEE6
	e9Q7Qnx/OC204n8QRmZesws8woogR37YJbfaNdC7QDJMCp2J1V4Na1p0wPyEAPyQL9D8fhXaNGsmj
	OS5dAB+7qegtzO61OzAQoX8aG7mwxWubO0YcywLO5m0+UTZ9ekl8/g3w8p2iLlCS/mqjAVbxVrCVW
	D2Pub3iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2UDs-00000007634-0dfQ;
	Wed, 09 Apr 2025 12:08:04 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2UDo-0000000762E-3nPY
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 12:08:02 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 77674eae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Apr 2025 14:07:58 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 14:07:56 +0200
Message-Id: <D923GTAHHEPQ.5IHH65JKAMFC@bsdbackstore.eu>
Subject: Re: nvmetcli creates tilde directories
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Richard Weinberger" <richard@nod.at>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>, "Daniel Wagner"
 <wagi@monom.org>
X-Mailer: aerc
References: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
 <D91YFPG2AMZG.1QFEKLMBO5J9Q@bsdbackstore.eu>
 <821291480.260286905.1744188830524.JavaMail.zimbra@nod.at>
 <D91ZEKL37IT1.1KQCRPYZJ6J16@bsdbackstore.eu>
 <1089727754.260822789.1744198333874.JavaMail.zimbra@nod.at>
In-Reply-To: <1089727754.260822789.1744198333874.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_050801_277159_9307AE84 
X-CRM114-Status: UNSURE (   5.42  )
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

On Wed Apr 9, 2025 at 1:32 PM CEST, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
>> A patch is gonna be pushed soon.
>
> Where is your git tree located?
> I'm a but puzzled where to look for the most recent nvmetcli sources.

The official nvmetcli repository should be the following one:
http://git.infradead.org/users/hch/nvmetcli.git

But the patch I am talking about will have to be pushed to
configshell (it's on Github):

https://github.com/open-iscsi/configshell-fb

Maurizio

