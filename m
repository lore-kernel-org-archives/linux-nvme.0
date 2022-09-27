Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A98C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuIF6Z6QO3EsIC3GcK2i56PFsfuQcaugb+5lSNgFP7E=; b=Ft7oF4Mp4EMoZpsVlAeaUvHudl
	lERwcmO7LW7eHwJHIRBZF6LBQ+KNor9xs16Nnib7Yl6kqXv9KjWqw6BJaaeiOoxHhjaibAfD2IBVX
	8WK37AWK681W0J8krilaevhQmIPxyaonf3K6PnOnTpkdpO24+OLZQ9gDnA3a6pgu3+aeVYI2vGe1R
	EeY79qWl4Cji29jBTuiOeYog4B25uLUPoYvsEZp8SKDDYSS3Qb13Dap6zgXqPsvlk2JZ5+bDreGU/
	0J7Bx3TQonaLGv0bgHPwcfExj6H2Ructq8TIpHH4B3eJ7g5gejDHI10C1yy3RHyNUTDSxGn+ipgLB
	qM/VBmPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5yo-009A7w-VZ; Tue, 27 Sep 2022 08:30:15 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5uG-0097xS-Es
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 08:25:33 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d11so8432262pll.8
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PuIF6Z6QO3EsIC3GcK2i56PFsfuQcaugb+5lSNgFP7E=;
        b=se5dEZXoYlMlYUllfOaFNKhG+9xxX07j4pEeAn+m7bRQOuiwDsqzc+4co3h+OBndlP
         0D4DIEK34ahebYA/+i25diJ6I2FJw+5SEPS2AQX3BWEJ7Dkn3jNz8nAAm5aN7EbDlH1p
         g0KOKyQnaPnApKEOx/0XrBWf2n4mrqz44salzOlsMWPiDARgdYTUUdvnGb4Ia24XZngo
         V+ekPwCxx90oLIyB+L2ADj7HkDHwDqAdXYeXImS8Ypcjspw3WU92jSsGprQcrTPXBELL
         kNbRxiOu5QqFxietAvoH9ag1JHI4iK/Y7bW/D1Fk4blN4YUBL+IbsA7374cvELkzo6au
         rlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PuIF6Z6QO3EsIC3GcK2i56PFsfuQcaugb+5lSNgFP7E=;
        b=TupZ+9ru7HJ3oJv6u7uj53DpG8yt7DG5dnMD9Q5y4WfVmMcYviI0QET7a9/gWDieI8
         Vh6FCAPa4g8MrRjahJ6caY4JIN4OPjF38bKO/Y43/B2/D9v5ujeIAL4uB0e7OWLF0Ktb
         /Mr+pS7261mFigsEB3FWRmPVaP16UFcfoeRFlE5qvLNBZ/nv79t/hFWVF/5GrR3epg3j
         3GQRs60YdrIuZrABr+AsI+fSj3+bmhPmNTiuOF4y5SkOi4E+OfYjGcHRiBHPIbA+4Vti
         VFJk//QBa/cAwfgWKfXjcLv4pALAitdtjHVi7pEedOwkmfFZ2eWdLp2nl/5YlX2h4Nbc
         xDOQ==
X-Gm-Message-State: ACrzQf1B1z5SOFAUeIp7vRPMenMfY+/aDQqxUGG/FNHvX97+tiPWG7rY
	usxkU6kfefJvQOXqJ6jkf5vI9woWb/zIYQ==
X-Google-Smtp-Source: AMsMyM529Y8drKv4aIU3V4vLdR0fL8RvLS8vgKmvYaPsdG3367iU92B07qehvrtO/NL+mRtuKpdn2g==
X-Received: by 2002:a17:902:da83:b0:177:f919:9260 with SMTP id j3-20020a170902da8300b00177f9199260mr26517022plx.105.1664267130735;
        Tue, 27 Sep 2022 01:25:30 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id w10-20020a627b0a000000b005386b58c8a3sm982788pfc.100.2022.09.27.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:25:30 -0700 (PDT)
From: Sean Hong <sean.hong@quanta.corp-partner.google.com>
To: sean.hong@quanta.corp-partner.google.com
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Test: check open list email
Date: Tue, 27 Sep 2022 16:25:26 +0800
Message-Id: <20220927082526.499749-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
References: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_012532_538249_79E1735B 
X-CRM114-Status: UNSURE (   5.37  )
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

Hi, try to reply email by send-email.

