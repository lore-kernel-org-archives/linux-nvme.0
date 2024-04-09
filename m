Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDD9CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=; b=huv3J+eBy2jGGfoCYWVRt35xSV
	UKI0ReBLYVT67EsHZxxWZOKg76kV2QnnVOmJZgeDB/LVOheIE2fi2Ql6CsTn8MMm6Y637z8RsmqWp
	0hGLUxZgT3DgbyhJfN3gUQ/nbP7DEwzi/lLDPQ843wG/DwTxAW1Q2+tDg0d+5Uh2H5CBJwDUcKIaZ
	0ZuU8Ponjp+iI1ysokE/O12IItFhah0wgFvH3mJWfskFF1/kBRMfWGfwv5f7nBKPavPn3hyasVTVH
	v46XGRrXTxtucPkj6XHd8Srwpmhc0067wTYI8O81MZT/6rBNZogBHLF2KpCjx2TuJCCiJgWPpUe8K
	ASVV785Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru6fu-00000000uvL-1U8O;
	Tue, 09 Apr 2024 08:17:50 +0000
Received: from mail.haughton.pl ([195.231.81.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru6fn-00000000utA-3dJa
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 08:17:46 +0000
Received: by mail.haughton.pl (Postfix, from userid 1002)
	id D698C8317F; Tue,  9 Apr 2024 09:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haughton.pl; s=mail;
	t=1712648181; bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=;
	h=Date:From:To:Subject:From;
	b=cscDWkxlBS79CYUtgk0Wj8No0iq7F958hHRg9iV8Ty3ESchsIpqgGT8I8ULW0LqIf
	 K7IabIhlY48EXBbiEDsL/vdFW/RcNmRuqeFmeozXe5QsfXLa/ljnp6uUyANP/oA7zz
	 P1HZtcZnfs/Hc1w1xe3Ka9H8u1nWCu1/YyX/3onE58Rn1uNmv168BEPgLEB9n44iuF
	 0T0gHj7p52nIusvN7JXSnVgMBrlz1w5UQq/6yqcIqGRkoqfrbGYZ2gB8yTFHNJ7zzg
	 LoOS/fY5r+56Pix73c6AmvMSufnTR/RsaYgb9FLN35APdqJmr0NDJ8uQ9dazTXMl8G
	 jXYnxvi0k+Gmw==
Received: by mail.haughton.pl for <linux-nvme@lists.infradead.org>; Tue,  9 Apr 2024 07:35:50 GMT
Message-ID: <20240409084500-0.1.1i.ixdj.0.jpamco2f6o@haughton.pl>
Date: Tue,  9 Apr 2024 07:35:50 GMT
From: "Patryk Wysocki" <patryk.wysocki@haughton.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.haughton.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_011744_599518_172D19AE 
X-CRM114-Status: UNSURE (   1.26  )
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

Pozwoli=C5=82em sobie na kontakt, poniewa=C5=BC jestem zainteresowany wer=
yfikacj=C4=85 mo=C5=BCliwo=C5=9Bci nawi=C4=85zania wsp=C3=B3=C5=82pracy.

Wspieramy firmy w pozyskiwaniu nowych klient=C3=B3w biznesowych.

Czy mo=C5=BCemy porozmawia=C4=87 w celu przedstawienia szczeg=C3=B3=C5=82=
owych informacji?=20


Pozdrawiam
Patryk Wysocki

