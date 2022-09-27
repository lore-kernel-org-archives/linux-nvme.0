Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26889C07E9D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 08:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=qNRmIj0jMGVu+7H9ZdgdFBynVi
	VJwl3DIFRJYjerDXcfdm2FdNwqCtFiV81AENp64lnzV1SMjahJfEgTSO3HJ+/sprl/3loHvfMcOKu
	ZS6xIRzDzPd3OrklX8v39pkZWNS4y8umOUiibsQ6SpQp9/fzELylAetKaWs1KkQ6GpykAw6560PDB
	TuJtxoufe+Gz3AoAlPxlr/ubPlYNYK1t2v/SSI624O8kW+oH86hgKB+ifDF89qEDpTtEA6dldiQDK
	JDWf8qr+xPnyCP76CeCdl3FYiLEIJaxbgANtaJ0d4fUla3iu8EocKKpzYlY+TtyupVPLuyOEXcLia
	Y4ZhXL9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5sD-0097D0-Ix; Tue, 27 Sep 2022 08:23:25 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5lL-0094IF-L6
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 08:16:22 +0000
Received: by mail-pj1-x1036.google.com with SMTP id lx7so2136409pjb.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=5FZ3qxKBWvUe9EbPfpHcK2ylhyOyAUr58Xuay+tWsxINMACZYmKTUsQ85fQsGdQwfv
         LHADium9iYXbOKKf/NYvYtkypFtsfXqUZ2ssme5Hgu5xlRZWq+eftEJcbyfzhNjmTZNj
         uncATUfExTUzff4eSUejZp9ckiOZm8rN6sn1PZSMNoEIa5JcXof5MaV70Vov/BFvGklj
         47IFq/FkhR8ZEOwQ8yYib+1XluTd4hPFBWhtJTht0aCeM8Y0PH/Slg6zgnMRFRL8vk9a
         tykgClw9TDcVF75P5wD0Tdgh5MjfYB7gsic0snsrFuA9l0WAUnbOnMmG2XXHe3LGlqol
         E2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pYeg0b3kaB3M8asrce6iRy+asyRAMcCD0qGXq7mkWAcyGpJsXZrqjGlrtGFfnqVUn9
         F1UE5M13RJvvaPopdpr/efx8A2RoRIdT7Y167nRMm0uIayYCmD0com+vkOTUB4Xxukeu
         F+dDWas6FYvD6F8N3AjHRZO4+Hmag/R+7eF9bDUcQKlD3k6UgW5yFYA5SPGh4XHHUmvR
         tLX2xyfN4mMCsaEQUkzDI3xavondexshpacgAiNr7NVV2qKGIvkiKRd63bSA8h7z05Ln
         yEgwuHHmXeKYhMHSo9iMTHJyFDPUtGWrmtxecG1Jc5tym0H4Tk8cq7kn2mSxBguMHo0L
         jOXA==
X-Gm-Message-State: ACrzQf31d3uYimXXMqRxxU5LGJWBjH5oUaY0ySEpp5wZaDmqxaTLRSXS
	ypkfMB42zsJmYNG55olhwQdK+dWRJERLAg==
X-Google-Smtp-Source: AMsMyM7myUWX0EVP5PnHB1uCvidQ9t2qhu8IZM4P3n5dSJhjxAqggl/8yteqrDjDAZdSHzNR89FBCA==
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id om14-20020a17090b3a8e00b0020055854099mr3341878pjb.70.1664266576159;
        Tue, 27 Sep 2022 01:16:16 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b00172f6726d8esm837225plf.277.2022.09.27.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:16:15 -0700 (PDT)
From: Sean Hong <sean.hong@quanta.corp-partner.google.com>
To: sean.hong@quanta.corp-partner.google.com
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Test: check open list email
Date: Tue, 27 Sep 2022 16:16:06 +0800
Message-Id: <20220927081606.499539-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
References: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_011620_086424_8FA21587 
X-CRM114-Status: UNSURE (   5.31  )
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


