Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DE2C35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UcsBgMryk/zjlzotDhNJvSHl8YevXbd8NchUivqcD4=; b=pkXjT/fpnGd/RzMBgGiO+iONS7
	Elr6Zrv2k0+s8+7mrSvXByEQFyybfE/scCu5SFk0tBGjCbYb54+vrx8kG1e6wekmmaz3byFyurmOr
	sTrVJXPt5IfOIRdLZeTZD/xvMXLl+Ok6oHqgzMUEqk3Ehbqh/FPTr/+wCwQU9776QTYfpIN7f8IFn
	DleEi8OawTZgVezYo56W7qqisw94trmd4mxrTi5SNjCiWk2yc5hwpAx9Vv90vTe1A7mLPBioomb8U
	PKkonr0GACStDPy2YnOwOXQFNCg2ct8uXeL7eN7V5+J+kctyXgoeEAFXmj9AusFIBRn9IKkSyFBGk
	bEuIGdIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEC40-0046db-1H;
	Fri, 15 Dec 2023 17:33:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEC3y-0046cl-1x
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 17:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702661605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UcsBgMryk/zjlzotDhNJvSHl8YevXbd8NchUivqcD4=;
	b=da9/3YzmYBBY7AhcisdBpBbY3Zoz+mXBkkYuZFVIhmHlD3/fx/wjH9y1jLy1Y3bzuR/UgR
	gCtgpkPdsw0IAdgDVIs2a1/YW/GruP4JkH44vrfyN4UczDX18Xn0v8lKAK1lugU23rwh4M
	+/qHHTVfcKpxZG4FkpPNI3X9wn/kd5I=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-dDibNihyN8-A1SvtqHyLAw-1; Fri, 15 Dec 2023 12:33:22 -0500
X-MC-Unique: dDibNihyN8-A1SvtqHyLAw-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4b6ae0ad527so60390e0c.3
        for <linux-nvme@lists.infradead.org>; Fri, 15 Dec 2023 09:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661601; x=1703266401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UcsBgMryk/zjlzotDhNJvSHl8YevXbd8NchUivqcD4=;
        b=KKLQDcAKETbQ3S6GXft6zoWmNNqErdL1hZQ7emrt7g3lFLuX6k+Mwy7dtoIOLqyOry
         IVPeYFbJJwX8jRGz/cKB6nXmSF0HAAdIiw/l0jBRGZCO79njYi7ddzbC+EPRLjI81Up1
         Naf5/kSw1Iq1aGumm1unXpKK3taifPRRG5qKVP1v/9xBeoGRM6F9I4hJ7+JIyRjGQzwa
         OmheYZO1HSfHW1/yCroRs+2nGKuTlNXc5J0DSWmMK77M/lpWeenYOfK0D540BOgEgZpC
         D1l75/9DemjBh/iRwxDwIEl3AdyQL4pOs2Tf1Amol7EKCv0Z7PIqkEXX4lQaSdYZYu/W
         BNRw==
X-Gm-Message-State: AOJu0Ywkpw89H8mP8g9w91Yr7zfgRtm9N7+VDmbpdPQkFvPCaixdy2cz
	GPWa7xnyblmZgRjUL59gMOqqBJqAnrw1OTKehn6T68m8C/mwU1K7zyU4Q6Jodh9VSUW1hpgLnDL
	WWXC67nFMaShpPDqvKErFcYlKf16tgpkgHdkjglBGmZo=
X-Received: by 2002:a05:6122:909:b0:496:b3b7:5d4c with SMTP id j9-20020a056122090900b00496b3b75d4cmr5015583vka.16.1702661601721;
        Fri, 15 Dec 2023 09:33:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6PoG/mUq1qgg62bOqJ1mtz6/uZw5+VwqZWlrzCI9tsmpGJn0zAl8rKZZQ7CFDnL3DkvogXbFmXRG5uD+Jx8c=
X-Received: by 2002:a05:6122:909:b0:496:b3b7:5d4c with SMTP id
 j9-20020a056122090900b00496b3b75d4cmr5015574vka.16.1702661601438; Fri, 15 Dec
 2023 09:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20231215143136.252497-1-mlombard@redhat.com> <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
In-Reply-To: <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 15 Dec 2023 18:33:09 +0100
Message-ID: <CAFL455=U3g4QJNYGW76A8nAiTes2BEW9vhtU+ivQOVDK27ZWhA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt context
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_093326_713594_0D22563D 
X-CRM114-Status: UNSURE (   9.91  )
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

p=C3=A1 15. 12. 2023 v 18:25 odes=C3=ADlatel Keith Busch <kbusch@kernel.org=
> napsal:
>
> What async event occured to cause this? It looks like the only AEN
> handling that cancels anything is the FW activation one, but that only
> applies to fabrics, not pci. Still, that AEN hanlder sets the state to
> "RESETTING", but we only cancel work when transitioning to "LIVE" from a
> CONNECTING state.
>

It has been hit by Yi Zhang (added to CC now, if he wants to provide
more details)
during an nvme drive firmware update.
He also said that he is able to reproduce it reliably.

Maurizio


